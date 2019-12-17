//
//  TZEditUserTextFiedldVC.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/1.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZEditUserTextFiedldVC.h"
#import "UserViewModel.h"

@interface TZEditUserTextFiedldVC ()
@property (nonatomic, strong) UITextField *textField;
@end

@implementation TZEditUserTextFiedldVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *viewBg = InsertView(self.view, CGRectMake(0, 10, kScreenWidth, 44), [UIColor whiteColor]);
    
    [viewBg addSubview:self.textField];
    
    self.textField.placeholder = self.placeholderStr;
    self.textField.centerY = viewBg.height/2.0f;
    
    [self setNavBarRightBtn];
    
    if (self.type == TZEditUserTextFiedldVCType_mobile) {
        [self limitInputWithTF:_textField Length:11];
        self.textField.placeholder = @"请输入你的实名验证号码";
    }else{
        self.textField.placeholder = @"选填，填写QQ邮箱审批更快";
    }
    

    
}


- (void)postUserUpdateMailboxUrl{
    kSelfWeak;
   NSString *strName =  [self.textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *name = [NSString stringWithFormat:@"%@%@",userUpdateMailbox,strName];
    [UserViewModel userUpdateMailboxPath:name params:nil target:self success:^(UserModel *model) {
        if (model.code == 200) {
            showMessage(@"修改成功");
            aUser.mailbox = self.textField.text;
            [aUser saveUserData];

            if (self.saveSuccessBlock) {
                weakSelf.saveSuccessBlock(self.textField.text);
            }
            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:KEY_USER_EMail object:nil];
        }else{
            [[ZXAlertView shareView] showMessage:model.msg?:@""];
        }
    } failure:^(NSError *error) {
        
    }];
}



- (void)saveClick{
    
    if (self.type == TZEditUserTextFiedldVCType_mobile) {
        
        
    }else  if (self.type == TZEditUserTextFiedldVCType_eMail) {
        if ([self.textField.text isValidateEmail]) {
            [self postUserUpdateMailboxUrl];
        }else{
            [[ZXAlertView shareView] showMessage:@"请填写正确的邮箱地址"];
        }
    }
    
}


- (void)setNavBarRightBtn{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 24);
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = kFontSize14;
    rightBtn.backgroundColor = Bg_Btn_Colorblue;
    rightBtn.layer.cornerRadius = 2.0f;
    [rightBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = InsertTextField(nil, nil, CGRectMake(16, 0, kScreenWidth - 32, 20), @"请输入",KFont(14), NSTextAlignmentLeft, UIControlContentVerticalAlignmentFill);
        _textField.keyboardType = UIKeyboardTypeDefault;
        _textField.textColor = kColorDeepBlack;
        _textField.tag = 10001;
        _textField.clearsOnBeginEditing = NO;
        _textField.clearButtonMode = UITextFieldViewModeAlways;
        [_textField becomeFirstResponder];
    }
    return _textField;
}

//限制输入框输入长度
- (void)limitInputWithTF:(UITextField *)tf Length:(NSInteger)length
{
    [[tf.rac_textSignal filter:^BOOL(NSString *text) {
        
        if (text.length > length) {
            return YES;
        }
        else
        {
            return NO;
        }
    }]subscribeNext:^(id x) {
        tf.text = [x substringToIndex:length];
    }];
}



@end

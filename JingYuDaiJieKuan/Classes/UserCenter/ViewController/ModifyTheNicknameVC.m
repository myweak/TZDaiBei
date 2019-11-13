//
//  ModifyTheNicknameVC.m
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/7/3.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "ModifyTheNicknameVC.h"
#import "UserViewModel.h"


@interface ModifyTheNicknameVC ()

@property (strong, nonatomic) UITextField *m_modifyField;
@property (strong, nonatomic) UIView *m_lineView;
@property (strong, nonatomic) UILabel *m_limitLabel;

@end

@implementation ModifyTheNicknameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改昵称";
    
    [self initView];
    
    [self addRightButton:nil seletedIamge:nil title:@"保存" target:self action:@selector(saveClick)];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)textDidChanged:(NSNotification *)notifi
{
    UITextField *tf = (UITextField *)[notifi object];
   
    UITextRange *selectedRange = [tf markedTextRange];
    // 获取高亮部分,
    UITextPosition *pos = [tf positionFromPosition:selectedRange.start offset:0];
    if (selectedRange && pos) {//如果存在高亮部分, 就暂时不统计字数
        return;
    }
    NSInteger realLength = tf.text.length;
    if (realLength > 10) {
        tf.text = [tf.text substringToIndex:10];
    }
    
    
}

- (void)saveClick
{
    [self userUpdateNickNameData];
}
///user/update/nick/name/{nickName} 修改昵称接口
- (void)userUpdateNickNameData
{
    kSelfWeak;
   NSString *strName =  [self.m_modifyField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *name = [NSString stringWithFormat:@"%@%@",userUpdateNickName,strName];
    [UserViewModel userUpdateNickNamePath:name params:nil target:self success:^(UserModel *model) {
        if (model.code == 200) {
            [kUserMessageManager setMessageManagerForObjectWithKey:KEY_NICK_NAME value:self.m_modifyField.text];
            if (self.reloadDataBlock) {
                weakSelf.reloadDataBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:MODIFY_NICKNAME object:nil];
        }else{
            [[ZXAlertView shareView] showMessage:model.msg?:@""];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)initView{
    [self.view addSubview:self.m_modifyField];
    
    [self.view addSubview:self.m_lineView];
    
    [self.view addSubview:self.m_limitLabel];
    
    [self.m_modifyField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(14));
        make.top.mas_equalTo(19);
        make.width.mas_equalTo(kScreenWidth - kiP6WidthRace(28));
    }];
    
    [self.m_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(14));
        make.top.mas_equalTo(self.m_modifyField.mas_bottom).offset(kiP6WidthRace(20));
        make.width.mas_equalTo(kScreenWidth - kiP6WidthRace(28));
        make.height.mas_equalTo(kiP6WidthRace(1));
    }];
    
    [self.m_limitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(14));
        make.top.mas_equalTo(self.m_lineView.mas_bottom).offset(kiP6WidthRace(10));
    }];
}
- (UITextField *)m_modifyField
{
    if (!_m_modifyField) {
        _m_modifyField = InsertTextField(nil, nil, CGRectZero, @"请输入您的昵称",KFont(14), NSTextAlignmentLeft, UIControlContentVerticalAlignmentFill);
        _m_modifyField.keyboardType = UIKeyboardTypeDefault;
        _m_modifyField.textColor = kColorDeepBlack;
        _m_modifyField.tag = 10001;
        _m_modifyField.clearsOnBeginEditing = NO;
        _m_modifyField.clearButtonMode = UITextFieldViewModeAlways;
        [_m_modifyField becomeFirstResponder];
//        [self limitInputWithTF:_m_modifyField Length:11];
    }
    return _m_modifyField;
}

- (UIView *)m_lineView
{
    if (!_m_lineView) {
        _m_lineView = InsertView(nil, CGRectZero, UIColorHex(@"#cacaca"));
    }
    return _m_lineView;
}

- (UILabel *)m_limitLabel
{
    if (!_m_limitLabel) {
        _m_limitLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"4-10个字符,可由中英文和字母组合", KFont(12), UIColorHex(@"#b1b1b1"), NO);
    }
    return _m_limitLabel;
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

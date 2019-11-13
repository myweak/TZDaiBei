//
//  FeedbackVC.m
//  JingYuDaiJieKuan
//
//  Created by air on 2018/3/27.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//


#import "FeedbackVC.h"
#import "TransactionRecordsModel.h"
@interface FeedbackVC ()<UITextViewDelegate,UITextFieldDelegate>
{
    NSArray *btnAry ;

}
@property (nonatomic ,strong) UIView *BGView;
@property (nonatomic ,strong) UILabel *feedbackLabel;
@property (nonatomic ,strong) NSMutableArray *feedbackArray;

@property (nonatomic ,strong) UIView *textFieldView;
@property (nonatomic ,strong) UITextView *m_textView;
@property (nonatomic ,strong) UILabel *m_inputNumberLabel;
@property (nonatomic ,strong) UILabel *limitLabel;
@property (nonatomic ,strong) UIButton *submitBtn; // 提交

@property (nonatomic ,strong) UIButton *tempIndexBtn;
@property (nonatomic,assign)BOOL indexBtnFlag;

@property (nonatomic ,assign) NSInteger btnTag;

@end

@implementation FeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = kColorWhite;
    [self.view addSubview:self.BGView];
    [self.BGView addSubview:self.feedbackLabel];
    [self.view addSubview:self.textFieldView];
    [self.textFieldView addSubview:self.m_textView];
    [self.textFieldView addSubview:self.m_inputNumberLabel];
    [self.textFieldView addSubview:self.limitLabel];
    [self.view addSubview:self.submitBtn];
    
    [self bindSignal];
    [self initView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeTextView:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:nil];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextFieldTextDidChangeNotification
                                                  object:nil];
}

- (void)bindSignal{
    self.feedbackArray = [[NSMutableArray alloc] init];

}

- (void)initData{
    kSelfWeak;
    NSMutableDictionary *dic = (NSMutableDictionary *)@{@"token":[kUserMessageManager getUserToken],@"feedback_type":[NSString stringWithFormat:@"%ld", (long)self.btnTag + 1],@"problem":_m_textView.text,@"platform":@"1"};
    [CustomLoadingView showLoadingView:weakSelf.view];

    [TransactionRecordsModel feedbackPath:feedback params:dic target:self success:^(UserModel *model) {
        if (model.code == 200) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [[ZXAlertView shareView] showMessage:model.msg];
        }
        [CustomLoadingView hiddenLoadingView:weakSelf.view];
    } failure:^(NSError *error) {
        [CustomLoadingView hiddenLoadingView:weakSelf.view];

    }];
    
}

- (void)initView{
    
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kiP6WidthRace(0));
        make.top.mas_offset(kiP6WidthRace(0));
        make.width.mas_offset(kScreenWidth);
        make.height.mas_offset(kiP6WidthRace(140));
    }];
    
    [self.feedbackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kiP6WidthRace(26));
        make.top.mas_offset(kiP6WidthRace(15));
    }];
    //标签
    [self theLabel];

    [self.textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kiP6WidthRace(12));
//        make.top.mas_offset(kiP6WidthRace(300));
        make.top.mas_equalTo(self.BGView.mas_bottom).offset(kiP6WidthRace(15));
//        make.top.mas_offset(self.BGView).offset(kiP6WidthRace(15));
        make.width.mas_offset(kScreenWidth - kiP6WidthRace(24));
        make.height.mas_offset(kiP6WidthRace(202));
    }];
    
    [_m_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kiP6WidthRace(15));
        make.top.mas_equalTo(kiP6WidthRace(15));
        make.width.mas_offset(kScreenWidth - kiP6WidthRace(50));
        make.height.mas_offset(kiP6WidthRace(172));
    }];
    
    [_m_inputNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(kiP6WidthRace(23));
    }];

    [self.limitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(kiP6WidthRace(-11));
        make.bottom.mas_equalTo(kiP6WidthRace(-11));
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(40));
        make.right.mas_equalTo(kiP6WidthRace(-40));
        make.top.mas_equalTo(self.textFieldView.mas_bottom).offset(kiP6WidthRace(30));
//        make.width.mas_equalTo(kiP6WidthRace(290));
        make.height.mas_equalTo(kiP6WidthRace(45));
    }];
}

- (void)feedbackBtn:(UIButton *)secton{
    UIButton *btn = [self.view viewWithTag:secton.tag];
    self.btnTag = secton.tag - 100;
    if (self.indexBtnFlag) {
        if (self.tempIndexBtn) {
            [self.tempIndexBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:kColorBlue forState:UIControlStateNormal];

        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }else
    {
        if (self.tempIndexBtn) {
            [self.tempIndexBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:kColorBlue forState:UIControlStateNormal];

        }else{
            [btn setTitleColor:kColorBlue forState:UIControlStateNormal];

        }
    }
    self.tempIndexBtn = btn;
    self.indexBtnFlag = !self.indexBtnFlag;
    
    //    btn.selected = !btn.isSelected;
}
#pragma mark - textViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    self.m_inputNumberLabel.hidden = YES;
    if (textView.text.length>200){
        if (text){
            return  NO;
        }
        else{
            return  YES;
        }
    }
    else{
        if (![self isInputRuleNotBlank:text]) {
            //            [HUD showMessageInView:self.view title:@"不能输入表情"];
            return NO;
            
        }
        return YES;
    }
}

- (BOOL)isInputRuleNotBlank:(NSString *)str {
    NSString *pattern = @"^[➋➌➍➎➏➐➑➒\a-zA-Z\u4E00-\u9FA5\\d]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}
//反馈问题类型  button标签
- (void)theLabel{
    int N = 3;          /** < 每行的最大个数 > **/
    CGFloat XN = 25.0f; /** < 控件之间的距离 > **/
    /** < 两个控件X坐标之间的间距 > **/
    CGFloat widthN = (self.view.frame.size.width)/N;
    /** < widthN -XN 控件的宽度 > **/
    for (NSInteger i = 0; i < 5; i++) {
        CGFloat x = (i % N)* widthN;  //x的坐标
        CGFloat y = (i / N) *60; //y的坐标
        CGRect singleFame = CGRectMake(x + XN/2, 50 + y, widthN - XN, kiP6WidthRace(34));
        UIButton *btn = InsertButtonWithType(nil, singleFame, 100 + i, nil, nil, UIButtonTypeCustom);
        btnAry = @[@"服务",@"活动/运营",@"建议采纳",@"邀请有礼",@"其他"];
        [btn normalTitle:btnAry[i]];
        [btn addTarget:self action:@selector(feedbackBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn normalTitleColor:UIColorRGB(102,102,102)];
//        [btn setBackgroundColor:kColorBlue];
        ViewRadius(btn, 5.0);
        btn.layer.borderColor = UIColorRGB(230,230,230).CGColor;
        btn.layer.borderWidth = 0.5;
        [self.BGView addSubview:btn];
    }
    
}

- (UIView *)BGView
{
    if (!_BGView) {
        _BGView = InsertView(nil, CGRectZero, kColorWhite);
    }
    return _BGView;
}

- (UILabel *)feedbackLabel{
    if (!_feedbackLabel) {
        _feedbackLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"反馈问题类型", kFontSize15, UIColorRGB(102,102,102), NO);
    }
    return _feedbackLabel;
}

- (UIView *)textFieldView{
    if (!_textFieldView) {
        _textFieldView = InsertView(nil, CGRectZero, UIColorRGB(247,247,248));
    }
    return _textFieldView;
}

- (UITextView *)m_textView{
    if (!_m_textView) {
        _m_textView = [[UITextView alloc] init];
        _m_textView.delegate = self;
        _m_textView.backgroundColor =UIColorRGB(247,247,248);
        [_m_textView setFont:KFont(15)];
//        _m_textView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_m_textView];
    }
    return _m_textView;
}

- (UILabel *)m_inputNumberLabel{
    if (!_m_inputNumberLabel) {
        _m_inputNumberLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"写下您的宝贵意见或建议,帮助我们做的更好", KFont(15), UIColorRGB(153,153,153), NO);
    }
    return _m_inputNumberLabel;
}
//还可以输入200字
- (UILabel *)limitLabel{
    if (!_limitLabel) {
        _limitLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentRight, @"0/200", KFont(12), UIColorRGB(153,153,153), NO);
    }
    return _limitLabel;
}

- (UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = InsertButtonWithType(nil, CGRectZero, 1, nil, @selector(submit), UIButtonTypeCustom);
        [_submitBtn normalTitle:@"提交"];
        _submitBtn.titleLabel.font = KFont(19.0);
        [_submitBtn normalTitleColor:UIColorRGB(255, 255, 255)];
        _submitBtn.backgroundColor = kColorSeparatorline;
//        _submitBtn.backgroundColor = UIColorRGB(61,133,255);
        ViewRadius(_submitBtn, 25.0);
        _submitBtn.layer.borderColor = kColorSeparatorline.CGColor;
        _submitBtn.layer.borderWidth = 0.5;

    }
    return _submitBtn;
}

- (void)submit{
    if (_m_textView.text.length > 0) {
        [self initData];
    }else{
        DLog(@"提交");
    }
}

- (void)changeTextView:(NSNotification *)info
{
    UITextView *textView = info.object;
    NSString *lastStr = textView.text;
    if (lastStr.length > 200) {
        lastStr = [lastStr substringToIndex:200];
        _m_textView.text = lastStr;
        _limitLabel.text = [NSString stringWithFormat:@"200/200"];//还可以输入0字
    }else{
//        _limitLabel.text = [NSString stringWithFormat:@"还可以输入%lu字",(200 - lastStr.length) > 0 ? (200 - lastStr.length) : 0];
        _limitLabel.text = [NSString stringWithFormat:@"%lu/200",lastStr.length > 0 ? lastStr.length : 0];
    }
    
    if (_m_textView.text.length > 0) {
        _submitBtn.backgroundColor = UIColorRGB(61,133,255);
        _submitBtn.layer.borderColor = UIColorRGB(61,133,255).CGColor;
    }else{
        _submitBtn.backgroundColor = kColorSeparatorline;
    }
}

@end

//
//  TZLoginVC.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/10/30.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZLoginVC.h"

#import "QHCountDownBtn.h"
#import "CustomButton.h"
#import "LoginKeyInputViewModel.h"
#import "sys/utsname.h"
#import "JingYuDaiJieKuan-Swift.h"
#import "HomePageViewModel.h"
#import "SensorsAnalyticsSDK.h"


@interface TZLoginVC ()<UITextFieldDelegate>{
    NSInteger msgMaxlength;
    UIButton *_btnRegisterWebBtn; // *协议
    UIButton *_btnPrivayWebBtn;  // *隐私

}


@property (strong, nonatomic) UIView *mainContentView;


@property (strong, nonatomic) UIView *bgPhoneView;
@property (strong, nonatomic) UITextField *m_iphoneField;

@property (strong, nonatomic) UIView *bgPasswordView;
@property (strong, nonatomic) UITextField *m_passwordField;
@property (strong, nonatomic) UIImageView *phoneImageView;
@property (strong, nonatomic) UIImageView *passwordImageView;
@property (strong, nonatomic) UIView *topImageViewBg;


@property (nonatomic, strong) QHCountDownBtn *countDownButton;

@property (nonatomic, strong) NextButton *m_nextBtn;

///协议条款
@property (nonatomic, strong) UILabel *protocolLbl;
@property (nonatomic, strong) UITapGestureRecognizer *protocolTapGes;

@property (nonatomic, assign) NSRange protocolRange;
@property (nonatomic, assign) NSRange policyProtocolRange;


@end

@implementation TZLoginVC


- (void)viewDidLoad {
    
    [self setFd_interactivePopDisabled:YES];
    self.protocolRange = NSMakeRange(7, 6);
    self.policyProtocolRange = NSMakeRange(14, 6);
    
    [super viewDidLoad];
    msgMaxlength = 6;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationItem.title = @"登录";
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self initView];
    
    [self userLoginBanner];
    
    [self addNavigationBackButton];
}

-(void)addNavigationBackButton
{
    [self addLeftButton:@"" seletedImage:nil title:nil target:self action:@selector(backClick)];
}

-(void)backClick
{
    return;
}

#pragma initView

- (void)initView
{
    [self addNoTifyView];
    
    [self.view addSubview:self.mainContentView];
    [self.mainContentView addSubview:self.topImageViewBg];
    
    
    // 账号
    [self.mainContentView addSubview:self.bgPhoneView];
    [self.bgPhoneView addSubview:self.m_iphoneField];

    [self.bgPhoneView addSubview:self.phoneImageView];
    
    // 密码
    [self.mainContentView addSubview:self.bgPasswordView];
    [self.bgPasswordView addSubview:self.passwordImageView];
    [self.bgPasswordView addSubview:self.m_passwordField];
    
    [self.bgPasswordView addSubview:self.countDownButton];
    ViewRadius(self.countDownButton, AutoGetHeight(3));

    ViewRadius(self.m_nextBtn, AutoGetHeight(20));

    
    self.countDownButton.m_layer.hidden = YES;
    
//    [self.mainContentView addSubview:self.protocolLbl];
    [self.mainContentView addSubview:self.m_nextBtn];
    [self makeConstraints];
    
    NSLog(@"%lf", CGRectGetMaxY(self.protocolLbl.frame));
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFiledEditChanged:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
    
    
}

// 注册协议。用户隐私
- (void)addNoTifyView{
    
    UIView *viewBg = InsertView(self.mainContentView, CGRectMake(0, 149, kScreenWidth, 60), [UIColor whiteColor]);
    
    CGRect rectA = CGRectMake(19, 0, 11, 11);
    UIButton * btnA = InsertImageButtonWithSelectedImageAndTitle(viewBg, rectA, 1, R_ImageName(@"longin_selcet_n"), nil, nil, NO, @" 查阅并同意", UIEdgeInsetsZero, kFontSize10, kBtnGrayColor, self, @selector(btnClickAction:));
    
    CGRect rectB = CGRectMake(19, 36, 11, 11);

      UIButton * btnB = InsertImageButtonWithSelectedImageAndTitle(viewBg, rectB, 2, R_ImageName(@"longin_selcet_n"), nil, nil, NO, @" 查阅并同意", UIEdgeInsetsZero, kFontSize10, kBtnGrayColor, self, @selector(btnClickAction:));
 
    [btnA setImage:R_ImageName(@"longin_selcet_y") forState:UIControlStateSelected];
    [btnB setImage:R_ImageName(@"longin_selcet_y") forState:UIControlStateSelected];

   
    [btnA sizeToFit];
    [btnB sizeToFit];
    
    BOOL btnSelect = [kUserMessageManager.phone isEqualToString:self.m_iphoneField.text];
    
    CGRect rectAA = CGRectMake(btnA.right, 0, 150, 11);
    UIButton * btnAA = InsertImageButtonWithSelectedImageAndTitle(viewBg, rectAA, 11, nil, nil, nil, btnSelect, @"《注册协议》", UIEdgeInsetsZero, kFontSize10,  UIColorHex(@"#39bae8"), self, @selector(btnClickAction:));
    
    CGRect rectBB = CGRectMake(btnB.right,  36, 150, 11);
    
    UIButton * btnBB = InsertImageButtonWithSelectedImageAndTitle(viewBg, rectBB, 22, nil, nil, nil, btnSelect, @"《客户隐私保护政策》", UIEdgeInsetsZero, kFontSize10,  UIColorHex(@"#39bae8"), self, @selector(btnClickAction:));
    
    [btnAA sizeToFit];
    [btnBB sizeToFit];
    
    CGFloat btn_H = 30;
    btnA.frame = CGRectMake(19, 0, btnA.width, btn_H);
    btnAA.frame = CGRectMake(btnA.right,btnA.top, btnAA.width, btn_H);
    btnB.frame = CGRectMake(19, btnA.bottom, btnB.width, btn_H);
    btnBB.frame = CGRectMake(btnB.right, btnB.top, btnBB.width, btn_H);


    _btnRegisterWebBtn =btnA;
    _btnPrivayWebBtn = btnB;
    _btnRegisterWebBtn.selected = btnSelect;
    _btnPrivayWebBtn.selected = btnSelect;
    
    // 提示信息
    InsertLabel(viewBg, CGRectMake(btnB.left, btnB.bottom+10, kScreenWidth- btnB.left *2, 12), NSTextAlignmentLeft, @"*温馨提示：不协助学生办理贷款业务", kFontSize16, KText_ColorRed, YES);
    
    
}

- (void)btnClickAction:(UIButton *)btn{
    NSInteger tag = btn.tag;
    switch (tag) {
        case 1: // 协议 ☑️
            btn.selected = !btn.selected;
            break;
        case 11: // 协议
        {
            NSString *urlStr = [NSString stringWithFormat:@"%@%@",WAP_PHONEURL,userServiceProtocol];
            BaseWebViewController *targetVC = [[BaseWebViewController alloc]init];
            targetVC.url = urlStr;
            targetVC.title = @"注册协议";
            targetVC.bottomBtnTitleStr = @"我知道了";
            [self.navigationController pushViewController:targetVC animated:YES];
    }
            break;
        case 2: // 协议中 ☑️
            btn.selected = !btn.selected;

            break;
        case 22: // 客户隐私 协议
        {
            NSString *urlStr = [NSString stringWithFormat:@"%@%@",WAP_PHONEURL,customerPrivacyPolicy];

            BaseWebViewController *targetVC = [[BaseWebViewController alloc]init];
            targetVC.url = urlStr;
            targetVC.title = @"客户隐私协议保护政策";
            targetVC.bottomBtnTitleStr = @"我知道了";
            [self.navigationController pushViewController:targetVC animated:YES];
        }
            break;
        default:
            break;
    }
    
    
}



- (void)addPhoneTextFieldView{
    
    
}

- (void)addPasswordTextFieldView{
    
}

- (void)makeConstraints
{
    
    self.mainContentView.frame = CGRectMake(0, 0, kScreenWidth, self.view.height);
    
    self.topImageViewBg.frame = CGRectMake(0, 0, kScreenWidth, 8);
    

    // 手机
    self.bgPhoneView.frame = CGRectMake(23, 29, kScreenWidth - 23*2, 40);
    self.m_iphoneField.frame = CGRectMake(56, 10, self.bgPhoneView.width-56, self.bgPhoneView.height);
    self.phoneImageView.frame = CGRectMake(0, 10, 12, 19);
    self.m_iphoneField.centerY = self.bgPhoneView.height/2.0f;
    
    //。密码
    self.bgPasswordView.frame = CGRectMake(23, self.bgPhoneView.bottom+15, kScreenWidth - 23*2, 40);
    self.passwordImageView.frame = CGRectMake(0, 10, 17, 19);
    self.m_passwordField.frame =CGRectMake(56, 10, self.bgPasswordView.width-self.countDownButton.width-56-100, 33);

    self.countDownButton.frame = CGRectMake(self.bgPasswordView.width -82, 6, 82, 27);
    self.countDownButton.backgroundColor = UIColorRGB(57,186,232);
    
    self.m_passwordField.centerY = self.bgPasswordView.height/2.0f;

  
    
    self.protocolLbl.frame = CGRectMake(10, self.bgPasswordView.bottom +36, 200, 20);
    self.m_nextBtn.frame = CGRectMake(50, self.bgPasswordView.bottom +146, kScreenWidth-100, 54);
    
    [self.bgPasswordView addLine_bottom];
    [self.bgPhoneView addLine_bottom];

    
}
/**
 *  手机型号
 *
 *  @return e.g. iPhone
 */
-(NSString *)phoneModel{
    return [[UIDevice currentDevice] model];
}

//获取背景图接口
- (void)userLoginBanner{
    kSelfWeak;
    
}

//user/login 用户登录接口
- (void)userLoginData
{
    
    kSelfWeak;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *pmodel = [self deviceVersion];
    //    CFUUIDRef cfuuid = CFUUIDCreate(kCFAllocatorDefault);
    //    NSString *cfuuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, cfuuid));
    //
    NSString *identifierStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    
    [params setValue:self.m_iphoneField.text?:@"" forKey:@"mobile"];
    [params setValue:self.m_passwordField.text forKey:@"smsCode"];
    [params setValue:pmodel forKey:@"pmodel"];
    [params setValue:identifierStr forKey:@"deviceNo"];

    [params setValue:[[SensorsAnalyticsSDK sharedInstance]anonymousId] forKey:@"distinctId"];
    [LoginKeyInputViewModel userLoginPath:userLogin params:params target:self success:^(LoginModel *model) {
        if (model.code == 200) {
            [self.m_iphoneField resignFirstResponder];
            [self.m_passwordField resignFirstResponder];

            ///为保持用户的实时数据更新，需要重新赋值缓存和内存
            kUserMessageManager.toKen = model.token;
            [kUserMessageManager setMessageManagerForObjectWithKey:KEY_USER_TOKEN value:model.token];
            kUserMessageManager.userId = model.userId;
            [kUserMessageManager setMessageManagerForObjectWithKey:KEY_USER_ID value:model.userId];
//            [kUserMessageManager setMessageManagerForObjectWithKey:KEY_HEAD_PORTRAIT value:model.headImg];
//            [kUserMessageManager setMessageManagerForObjectWithKey:KEY_NICK_NAME value:model.nickName];
            [kUserMessageManager setMessageManagerForObjectWithKey:USER_MOBILE value:self.m_iphoneField.text];
            

            [kUserMessageManager setMessageManagerForObjectWithKey:KEY_USER_EMail value:model.mailbox];
            [kUserMessageManager setMessageManagerForObjectWithKey:KEY_USER_GENDER value:model.gender];
            [kUserMessageManager setMessageManagerForObjectWithKey:KEY_USER_EDUCATION value:model.education];
            
            //登录的埋点
            [SensorsAnalyticsSDKHelper trackLoginWithDistinctId:model.userId];
            
            [weakSelf dismissViewControllerAnimated:YES completion:^{
                [kAppDelegate enterMainViewIndex:0];
            }];
        }else{
            [[ZXAlertView shareView] showMessage:model.msg?:@""];
        }
    } failure:^(NSError *error) {
        [[ZXAlertView shareView] showMessage:kloadfailedNotNetwork];
    }];
}
///sms/send/code   发送短信验证码接口，开发和测试环境不真实发送，默认为6个6
- (void)smsSendCodeData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.m_iphoneField.text forKey:@"mobile"];
    [params setValue:@"10" forKey:@"type"];
    [LoginKeyInputViewModel smsSendCodePath:smsSendCode params:params target:self success:^(LoginModel *model) {
        if (model.code != 200) {
            [self stop];
        }
        [[ZXAlertView shareView] showMessage:model.msg?:@""];
        
    } failure:^(NSError *error) {
        [self stop];
        [[ZXAlertView shareView] showMessage:kloadfailedNotNetwork];
    }];
}

- (NSString*)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10.4"]) return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([deviceString isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([deviceString isEqualToString:@"iPhone11,4"]) return @"iPhone XS MAX";
    if ([deviceString isEqualToString:@"iPhone11,6"]) return @"iPhone XS MAX";
    
    　return deviceString;
}

- (void)nextStepBtn
{
    if (!_btnRegisterWebBtn.selected) {
        [[ZXAlertView shareView] showMessage:@"请同意注册协议"];
        return;
    }else if (!_btnPrivayWebBtn.selected){
        [[ZXAlertView shareView] showMessage:@"请同意客户隐私保护政策"];
        return;
    }
    [self userLoginData];
}

/// textFiled改变的通知
- (void)textFiledEditChanged:(NSNotification *)obj
{
    BOOL btnSelect = [kUserMessageManager.phone isEqualToString:self.m_iphoneField.text];
    _btnRegisterWebBtn.selected = btnSelect;
    _btnPrivayWebBtn.selected = btnSelect;
    self.m_nextBtn.effective = ([self.m_iphoneField.text length] == 11) && ([self.m_passwordField.text length] >= 4);
}

- (BOOL)checkInfo
{
    if([_m_iphoneField.text isBlank] )
    {
        [[ZXAlertView shareView] showMessage:@"请输入您的手机号码"];
        [self shakeAnimationByView:_m_iphoneField];
        return NO;
    }
    
    if(![[_m_iphoneField.text stringByReplacingOccurrencesOfString:@" " withString:@""] isMobile] )
    {
        [[ZXAlertView shareView] showMessage:@"请输入正确的手机号"];
        [self shakeAnimationByView:_m_iphoneField];
        return NO;
    }
    
    if(![_m_passwordField.text isLegalJHSDemailCharacterRegister])
    {
        [[ZXAlertView shareView] showMessage:@"请输入数字加字母"];
        [self shakeAnimationByView:_m_passwordField];
        return NO;
    }
    return YES;
}

#pragma data

#pragma getter

- (UIImageView *)passwordImageView{
    if (!_passwordImageView) {
        _passwordImageView = InsertImageView(nil, CGRectZero, [UIImage imageNamed:@"icon_vco"]);
        _passwordImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _passwordImageView;
}

- (UIImageView *)phoneImageView{
    if (!_phoneImageView) {
        _phoneImageView = InsertImageView(nil, CGRectZero, [UIImage imageNamed:@"icon_mob"]);
        _phoneImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _phoneImageView;
}

- (UIView *)topImageViewBg{
    if (!_topImageViewBg) {
        _topImageViewBg = [[UIView alloc]init];
        _topImageViewBg.backgroundColor = Bg_ColorGray;
    }
    return _topImageViewBg;
}

- (UIView *)mainContentView{
    if (!_mainContentView) {
        _mainContentView = [[UIView alloc]init];
    }
    return _mainContentView;
}


- (UIView *)bgPhoneView
{
    if (!_bgPhoneView) {
        _bgPhoneView = InsertView(nil, CGRectZero, [UIColor whiteColor]);
        _bgPhoneView.layer.cornerRadius = 2;
        //        _bgPhoneView.layer.masksToBounds = YES;
        //给图层添加一个有色边框
        //        _bgPhoneView.layer.borderWidth = 1;
        //        _bgPhoneView.layer.borderColor = [UIColorHex(@"#e2e2e2") CGColor];
        //        _bgView.layer.borderColor = [[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1] CGColor];
    }
    return _bgPhoneView;
}

- (UITextField *)m_iphoneField
{
    if (!_m_iphoneField) {
        _m_iphoneField = InsertTextField(nil, nil, CGRectZero, @"请输入您的手机号码",KFont(15), NSTextAlignmentLeft, UIControlContentVerticalAlignmentCenter);
        _m_iphoneField.keyboardType = UIKeyboardTypeNamePhonePad;
        _m_iphoneField.textColor = kColorDeepBlack;
        _m_iphoneField.tag = 10001;
        _m_iphoneField.clearsOnBeginEditing = NO;
        _m_iphoneField.clearButtonMode = UITextFieldViewModeAlways;
        //        [_m_iphoneField becomeFirstResponder];
        //获取保存在本地的手机号码
        _m_iphoneField.text = [kUserMessageManager getMessageManagerForObjectWithKey:USER_MOBILE];
        [self limitInputWithTF:_m_iphoneField Length:11];
    }
    return _m_iphoneField;
}

- (UITextField *)m_passwordField
{
    if (!_m_passwordField) {
        _m_passwordField = InsertTextField(nil, nil, CGRectZero, @"请输入验证码",KFont(15), NSTextAlignmentLeft, UIControlContentVerticalAlignmentCenter);
        _m_passwordField.keyboardType = UIKeyboardTypeDecimalPad;
        _m_passwordField.textColor = kColorDeepBlack;
        _m_passwordField.tag = 10002;
        _m_passwordField.clearsOnBeginEditing = NO;
        _m_passwordField.clearButtonMode = UITextFieldViewModeAlways;
        //        [_m_passwordField becomeFirstResponder];
        [self limitInputWithTF:_m_passwordField Length:msgMaxlength];
    }
    return _m_passwordField;
}

- (UIView *)bgPasswordView
{
    if (!_bgPasswordView) {
        _bgPasswordView = InsertView(nil, CGRectZero, [UIColor whiteColor]);
    }
    return _bgPasswordView;
}

- (QHCountDownBtn *)countDownButton
{
    if (!_countDownButton) {
        // 倒计时    //UIColorHex(@"0c72e3")
        _countDownButton = [QHCountDownBtn buttonWithType:UIButtonTypeCustom];
        _countDownButton = [[QHCountDownBtn alloc] initWithFrame:CGRectZero
                                                           title:@"获取验证码"
                                                            font:kFontSize12
                                                      titleColor:[UIColor whiteColor]
                                                 backgroundColor:UIColorHex(@"#39bae8")
                                                      layerWidth:0
                                                      layerColor:[UIColor whiteColor]
                                               layerCornerRadius:15.0
                                                       sendTitle:@""
                                                  sendTitleColor:kColorBlack
                                             sendBackgroundColor:kColorClear
                                                  sendLayerWidth:0
                                                  sendLayerColor:kColorWhite
                                           sendLayerCornerRadius:0.0
                                                      againTitle:@"重新获取"
                                                   isShowSeconds:0
                                                     showhHidden:0
                                                            time:60];
        _countDownButton.hidden = NO;
        _countDownButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        kSelfWeak;
        weakSelf.countDownButton.m_layer.hidden = YES;
        
        _countDownButton.buttonClickedBlock = ^{
            //判断手机11位
            if ([weakSelf.m_iphoneField.text length] == 11){
                [weakSelf.countDownButton start];
                weakSelf.countDownButton.m_layer.hidden = YES;
                [weakSelf smsSendCodeData];
            } else {
                [[ZXAlertView shareView] showMessage:@"请输入11位手机号"];
            }
            
        };
    }
    return _countDownButton;
}


- (NextButton *)m_nextBtn{
    
    if (!_m_nextBtn) {
        _m_nextBtn = [[NextButton alloc]initWithTitle:@"一键登录" effective:NO];
        [_m_nextBtn addTarget:self action:@selector(nextStepBtn) forControlEvents:UIControlEventTouchUpInside];
        _m_nextBtn.tag = 301;
    }
    return _m_nextBtn;
    
}


- (void)stop
{
    [self.countDownButton stop];
    
}

- (void)start
{
    [self.countDownButton start];
}

///手势的点击位置检测
- (BOOL)didTap:(UITapGestureRecognizer *)sender attributedTextInLabel:(UILabel *)label inRange:(NSRange)targetRange{
    // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
    NSLayoutManager *layoutManager = [NSLayoutManager new];
    NSTextContainer *textContainer = [[NSTextContainer alloc]initWithSize:CGSizeZero];
    NSTextStorage *textStorage = [[NSTextStorage alloc]initWithAttributedString:label.attributedText];
    
    // Configure layoutManager and textStorage
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    
    // Configure textContainer
    textContainer.lineFragmentPadding = 0.0;
    textContainer.lineBreakMode = label.lineBreakMode;
    textContainer.maximumNumberOfLines = label.numberOfLines;
    CGSize labelSize = label.bounds.size;
    textContainer.size = labelSize;
    
    // Find the tapped character location and compare it to the specified range
    CGPoint locationOfTouchInLabel = [sender locationInView:label];
    CGRect textBoundingBox = [layoutManager usedRectForTextContainer:textContainer];
    //使用的位置计算和控件的宽度有关,所以如果是左对齐的话,不要设置label的宽度.如果是居中的话,可以设置宽度
    //根据控件的宽度和文字的宽度,算出文字的真实位置
    CGPoint textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
    //根据文字所在的位置判断,计算出点击的位置相对于文字来说的位置
    CGPoint locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x, locationOfTouchInLabel.y - textContainerOffset.y);
    
    //通过计算出的点击文字的位置,计算这个位置在文字中的location
    NSUInteger indexOfCharacter = [layoutManager characterIndexForPoint:locationOfTouchInTextContainer inTextContainer:textContainer fractionOfDistanceBetweenInsertionPoints:nil];
    
    NSLog(@"indexOfCharacter: %ld",indexOfCharacter);
    return NSLocationInRange(indexOfCharacter, targetRange);
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

#pragma mark uitextfieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return NO;
}

@end

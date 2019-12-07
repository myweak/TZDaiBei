//
//  LoginVC.m
//  JingYuDaiJieKuan
//
//  Created by JY on 2018/3/29.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "LoginVC.h"
#import "QHCountDownBtn.h"
#import "CustomButton.h"
#import "LoginKeyInputViewModel.h"
#import "sys/utsname.h"
#import "JingYuDaiJieKuan-Swift.h"
#import "HomePageViewModel.h"
#import "SensorsAnalyticsSDK.h"

@interface LoginVC ()<UITextFieldDelegate>{
    NSInteger msgMaxlength;
}

@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) UIView *mainContentView;

@property (strong, nonatomic) UIImageView *m_bgImageView;

@property (strong, nonatomic) UIView *bgPhoneView;
@property (strong, nonatomic) UIImageView *m_phoneImageView;
@property (strong, nonatomic) UITextField *m_iphoneField;

@property (strong, nonatomic) UIView *bgPasswordView;
@property (strong, nonatomic) UIImageView *m_passwordImageView;
@property (strong, nonatomic) UITextField *m_passwordField;

@property (nonatomic, strong) QHCountDownBtn *countDownButton;

@property (nonatomic, strong) NextButton *m_nextBtn;

///协议条款
@property (nonatomic, strong) UILabel *protocolLbl;
@property (nonatomic, strong) UITapGestureRecognizer *protocolTapGes;

@end

@implementation LoginVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    msgMaxlength = 4;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.fd_prefersNavigationBarHidden = YES;
    self.title = [NSString getMyApplicationName];
    
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
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.mainContentView];
    
    
    [self.mainContentView addSubview:self.m_bgImageView];
    [self.mainContentView addSubview:self.bgPhoneView];
    [self.bgPhoneView addSubview:self.m_phoneImageView];
    [self.bgPhoneView addSubview:self.m_iphoneField];
    
    [self.mainContentView addSubview:self.bgPasswordView];
    [self.bgPasswordView addSubview:self.m_passwordImageView];
    [self.bgPasswordView addSubview:self.m_passwordField];

    [self.bgPasswordView addSubview:self.countDownButton];
    ViewRadius(self.countDownButton, AutoGetHeight(30)/2);
//    [self.countDownButton start];
    self.countDownButton.m_layer.hidden = YES;
   
    [self.mainContentView addSubview:self.protocolLbl];
    [self makeConstraints];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFiledEditChanged:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
    
  
}

- (void)makeConstraints
{
    
    // 对 UIScrollView 添加约束，达到设置 contentSize 的目的
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(self.view);
        // 注意点
        make.bottom.equalTo(self.protocolLbl.mas_bottom).offset(20);
    }];
    
    [self.mainContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainScrollView.mas_top);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.mainScrollView);
    }];
    
    [self.m_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.mainContentView.mas_top).offset(kiP6WidthRace(115/2));
        make.width.mas_equalTo(kiP6WidthRace(553/2));
        make.height.mas_equalTo(kiP6WidthRace(532/2));
    }];
    
    [self.bgPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainContentView).offset(kiP6WidthRace(17));
        make.right.equalTo(self.mainContentView).offset(-kiP6WidthRace(20));
        make.top.mas_equalTo(self.m_bgImageView.mas_bottom).offset(kiP6WidthRace(42));
        make.height.mas_equalTo(kiP6WidthRace(54));
    }];
    
    [self.m_phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(56/2));
        make.centerY.equalTo(self.bgPhoneView.mas_centerY);
        make.width.mas_equalTo(kiP6WidthRace(35/2));
        make.height.mas_equalTo(kiP6WidthRace(50/2));
    }];
    
    [self.m_iphoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.m_phoneImageView.mas_right).offset(kiP6WidthRace(16));
        make.centerY.equalTo(self.m_phoneImageView.mas_centerY);
        make.width.mas_equalTo(kiP6WidthRace(250));
    }];
    
    [self.bgPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bgPhoneView);
        make.top.mas_equalTo(self.bgPhoneView.mas_bottom).offset(kiP6WidthRace(20));
        make.height.mas_equalTo(kiP6WidthRace(54));
    }];
    
    [self.m_passwordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(56/2));
        make.centerY.equalTo(self.bgPasswordView.mas_centerY);
        make.width.mas_equalTo(kiP6WidthRace(35/2));
        make.height.mas_equalTo(kiP6WidthRace(20));
    }];
    
    [self.m_passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.m_passwordImageView.mas_right).offset(kiP6WidthRace(16));
        make.centerY.equalTo(self.m_passwordImageView.mas_centerY);
        make.width.mas_equalTo(kiP6WidthRace(150));
    }];
    
    [self.countDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kiP6WidthRace(8));
        make.centerY.equalTo(self.m_passwordImageView.mas_centerY);
        make.height.mas_equalTo(kiP6WidthRace(57/2));
        make.width.mas_equalTo(kiP6WidthRace(100));
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColorHex(@"#e2e2e2");
    [self.bgPasswordView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.countDownButton.mas_left).offset(-kiP6WidthRace(15));
        make.centerY.equalTo(self.m_passwordImageView.mas_centerY);
        make.width.mas_equalTo(kiP6WidthRace(1));
        make.height.mas_equalTo(kiP6WidthRace(23));
    }];
    
    _m_nextBtn = [[NextButton alloc]initWithTitle:@"立即借钱" effective:NO];
    [_m_nextBtn addTarget:self action:@selector(nextStepBtn) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(self.m_nextBtn,kiP6WidthRace(54/2));
    _m_nextBtn.tag = 301;
    [self.mainContentView addSubview:_m_nextBtn];
    
    [_m_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.m_passwordField.mas_bottom).offset(kiP6WidthRace(50));
        make.left.mas_equalTo(kiP6WidthRace(15));
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(kiP6WidthRace(54));
    }];
    
    [_protocolLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_m_nextBtn.mas_bottom).offset(20);
        make.left.right.equalTo(_m_nextBtn);
    }];
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
    
    [LoginKeyInputViewModel loginBannerPath:userLoginBanner params:nil target:self success:^(LoginBannerModel *model) {
        if (model.code == 200) {
            if (kIsPhoneX){
                //刷新背景图片
                [self.m_bgImageView sd_setImageWithURL:[NSURL URLWithString:model.photoIphonex] placeholderImage:[UIImage imageNamed:@"login_lines"]];
            }else {
                //刷新背景图片
                [self.m_bgImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"login_lines"]];
            }
            
        }
    } failure:nil];


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
            ///为保持用户的实时数据更新，需要重新赋值缓存和内存
            kUserMessageManager.toKen = model.token;
            [kUserMessageManager setMessageManagerForObjectWithKey:KEY_USER_TOKEN value:model.token];
            kUserMessageManager.userId = model.userId;
            [kUserMessageManager setMessageManagerForObjectWithKey:KEY_USER_ID value:model.userId];
            [kUserMessageManager setMessageManagerForObjectWithKey:KEY_HEAD_PORTRAIT value:model.headImg];
            [kUserMessageManager setMessageManagerForObjectWithKey:KEY_NICK_NAME value:model.nickName];
            [kUserMessageManager setMessageManagerForObjectWithKey:USER_MOBILE value:self.m_iphoneField.text];
            
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
    [self userLoginData];
}

/// textFiled改变的通知
- (void)textFiledEditChanged:(NSNotification *)obj
{
    self.m_nextBtn.effective = ([self.m_iphoneField.text length] == 11) && ([self.m_passwordField.text length] == msgMaxlength);
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
- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]init];
    }
    return _mainScrollView;
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
        _bgPhoneView.layer.cornerRadius = 54/2;
        _bgPhoneView.layer.masksToBounds = YES;
        //给图层添加一个有色边框
        _bgPhoneView.layer.borderWidth = 1;
        _bgPhoneView.layer.borderColor = [UIColorHex(@"#e2e2e2") CGColor];
//        _bgView.layer.borderColor = [[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1] CGColor];
    }
    return _bgPhoneView;
}

- (UIImageView *)m_phoneImageView
{
    if (!_m_phoneImageView) {
        _m_phoneImageView = InsertImageView(nil, CGRectZero, [UIImage imageNamed:@"phone_icon"]);
    }
    return _m_phoneImageView;
}

- (UITextField *)m_iphoneField
{
    if (!_m_iphoneField) {
        _m_iphoneField = InsertTextField(nil, nil, CGRectZero, @"请输入您的手机号码",KFont(15), NSTextAlignmentLeft, UIControlContentVerticalAlignmentFill);
        _m_iphoneField.keyboardType = UIKeyboardTypeDecimalPad;
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
        _m_passwordField = InsertTextField(nil, nil, CGRectZero, @"请输入验证码",KFont(15), NSTextAlignmentLeft, UIControlContentVerticalAlignmentFill);
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

- (UIImageView *)m_bgImageView
{
    if (!_m_bgImageView) {
        _m_bgImageView = InsertImageView(nil, CGRectZero, [UIImage imageNamed:@"login_lines"]);
    }
    return _m_bgImageView;
}

- (UIView *)bgPasswordView
{
    if (!_bgPasswordView) {
        _bgPasswordView = InsertView(nil, CGRectZero, [UIColor whiteColor]);
        _bgPasswordView.layer.cornerRadius = 54/2;
        _bgPasswordView.layer.masksToBounds = YES;
        //给图层添加一个有色边框
        _bgPasswordView.layer.borderWidth = 1;
        _bgPasswordView.layer.borderColor = [UIColorHex(@"#e2e2e2") CGColor];

    }
    return _bgPasswordView;
}

- (UIImageView *)m_passwordImageView
{
    if (!_m_passwordImageView) {
        _m_passwordImageView = InsertImageView(nil, CGRectZero, [UIImage imageNamed:@"verification_icon"]);
    }
    return _m_passwordImageView;
}

- (QHCountDownBtn *)countDownButton
{
    if (!_countDownButton) {
        // 倒计时    //UIColorHex(@"0c72e3")
        _countDownButton = [QHCountDownBtn buttonWithType:UIButtonTypeCustom];
        _countDownButton = [[QHCountDownBtn alloc] initWithFrame:CGRectZero title:@"获取验证码" font:kFontSize14 titleColor:UIColorHex(@"468cec") backgroundColor:kColorWhite layerWidth:0.5 layerColor:[UIColor whiteColor] layerCornerRadius:15.0 sendTitle:@"" sendTitleColor:kColorBlack sendBackgroundColor:kColorClear sendLayerWidth:0 sendLayerColor:kColorWhite sendLayerCornerRadius:0.0 againTitle:@"重新获取" isShowSeconds:0 showhHidden:0 time:60];
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

- (UILabel *)protocolLbl{
    if (!_protocolLbl) {
        _protocolLbl = [[UILabel alloc]init];
        _protocolLbl.font = [UIFont systemFontOfSize:12];
        _protocolLbl.textAlignment = NSTextAlignmentLeft;
        _protocolLbl.numberOfLines = 0;
        _protocolLbl.textColor = UIColorHex(@"#a9a9a9");
        [_protocolLbl addGestureRecognizer:self.protocolTapGes];
        [_protocolLbl setUserInteractionEnabled:YES];
         NSMutableAttributedString *mustrAtt = [[NSMutableAttributedString alloc]initWithString:@"点击“获取验证码”即同意《用户服务协议》和《平台隐私政策》"];
        [mustrAtt addAttribute:NSForegroundColorAttributeName value:UIColorHex(@"#333333") range:NSMakeRange(12, 8)];
        [mustrAtt addAttribute:NSForegroundColorAttributeName value:UIColorHex(@"#333333") range:NSMakeRange(21, 8)];
        
        _protocolLbl.attributedText = mustrAtt;
    }
    return _protocolLbl;
}

- (UITapGestureRecognizer *)protocolTapGes{
    if (!_protocolTapGes) {
        _protocolTapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapProtocolLabel:)];
    }
    return _protocolTapGes;
}

- (void)stop
{
    [self.countDownButton stop];
    
}

- (void)start
{
    [self.countDownButton start];
}


#pragma 点击事件
- (void)tapProtocolLabel:(UITapGestureRecognizer *)sender
{
    //////******因为中文的原因,导致了计算的时候一个标点符号只算0.5,所以最后的文字index少了1,这边就直接加1******///////
    if ([self didTap:sender attributedTextInLabel:self.protocolLbl inRange:NSMakeRange(12+1, 8)]){
        NSString *urlStr = [kUserMessageManager getMessageManagerForObjectWithKey:REGURL];
        BaseWebViewController *targetVC = [[BaseWebViewController alloc]init];
        targetVC.url = urlStr;
        [self.navigationController pushViewController:targetVC animated:YES];
    }
    //////******因为中文的原因,导致了计算的时候一个标点符号只算0.5,这里经历了4个符号,所以最后的文字index少了2,这边就直接加2******//////
    if ([self didTap:sender attributedTextInLabel:self.protocolLbl inRange:NSMakeRange(21+2, 8)]){
        NSString *urlStr = [kUserMessageManager getMessageManagerForObjectWithKey:PRIVACYPOLICYURL];
        BaseWebViewController *targetVC = [[BaseWebViewController alloc]init];
        targetVC.url = urlStr;
        [self.navigationController pushViewController:targetVC animated:YES];
    }
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
    CGPoint textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
    CGPoint locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x, locationOfTouchInLabel.y - textContainerOffset.y);
    
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

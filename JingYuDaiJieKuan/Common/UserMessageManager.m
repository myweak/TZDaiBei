//
//  UserMessageManager.m
//  NewJingYuBao
//
//  Created by linshaokai on 16/6/28.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import "UserMessageManager.h"
#import "CustomAlertView.h"
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <AdSupport/AdSupport.h>
#import "TZLoginVC.h"
#import "JingYuDaiJieKuan-Swift.h"

@interface UserMessageManager()

@property (strong ,nonatomic)NSUserDefaults *userDefaults;

@end

@implementation UserMessageManager

@synthesize g_IfComeFromBackgroud;
@synthesize g_IfProductBuyLogin;

@synthesize g_MenuClickItem;
@synthesize g_IfBeginOpenApp;
@synthesize g_StringShareURL;
@synthesize g_IntHongbaoSwith;
@synthesize g_StringIP;
@synthesize g_StateTradePasswordSet;
@synthesize g_State_bankBind;
@synthesize g_PushType;




SYNTHESIZE_SINGLETON_ARC_FOR_CLASS(UserMessageManager);


+  (UserMessageManager *)sharedInstance
{
    static UserMessageManager* share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[super allocWithZone:NULL] init];
    });
    return share;
}
- (void)TimeBegin
{
    self.g_TimeSecond = 60;
    self.g_Timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
}

- (void)TimeBeginWithTel:(NSString *)tel
{
    [self.g_Timer invalidate];
    self.g_TimeTel = tel;
    self.g_TimeSecond = 60;
    self.g_Timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
}

- (void)timerFireMethod:(NSTimer *)theTimer
{
    switch ([[[theTimer userInfo] objectForKey:@"type"] integerValue]) {
        case 0:
        {
            if (self.g_TimeSecond == 0)
            {
                [self.g_Timer invalidate];
            }
            else
            {
                self.g_TimeSecond--;
            }
        }
            break;
        case 1:
        {
            if (self.g_TimeSecond_forgetKey == 0)
            {
                [self.g_Timer_forgetKey invalidate];
            }
            else
            {
                self.g_TimeSecond_forgetKey--;
            }
        }
            break;
        case 2:
        {
            if (self.g_TimeSecond_codeLogin == 0)
            {
                [self.g_Timer_codeLogin invalidate];
            }
            else
            {
                self.g_TimeSecond_codeLogin--;
            }
        }
            break;
            
            
            
        default:
            break;
    }
}

//- (void)TimeBeginWithType:(kTimeSecondType )type WithTel:(NSString *)tel
//{
//    
//    switch (type) {
//        case 0:
//        {
//            [self.g_Timer invalidate];
//            self.g_TimeTel = tel;
//            self.g_TimeSecond = 60;
//            self.g_Timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:@{@"type":@"0"} repeats:YES];
//        }
//            break;
//        case 1:
//        {
//            [self.g_Timer_forgetKey invalidate];
//            self.g_TimeTel_forgetKey = tel;
//            self.g_TimeSecond_forgetKey = 60;
//            self.g_Timer_forgetKey = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:@{@"type":@"1"} repeats:YES];
//        }
//            break;
//        case 2:
//        {
//            [self.g_Timer_codeLogin invalidate];
//            self.g_TimeTel_codeLogin = tel;
//            self.g_TimeSecond_codeLogin = 60;
//            self.g_Timer_codeLogin = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:@{@"type":@"2"} repeats:YES];
//        }
//            break;
//            
//            
//            
//        default:
//            break;
//    }
//}




- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
//        _userId =  ChangeNullData([self getMessageManagerForObjectWithKey:KEY_USER_ID]);
        _toKen =  ChangeNullData([self getMessageManagerForObjectWithKey:KEY_USER_TOKEN]);
        _deviceToken =  ChangeNullData([self getMessageManagerForObjectWithKey:DEVICE_TOKEN]);
        _bank = ChangeNullData([self getMessageManagerForObjectWithKey:KEY_IS_BINDCARD]);
        _phone = ChangeNullData([self getMessageManagerForObjectWithKey:KEY_USER_PHONE]);
        _userId = ChangeNullData([self getMessageManagerForObjectWithKey:KEY_USER_ID]);
        
    }
    return self;
}

-(void)setUserId:(NSString *)userId
{
    _userId = ChangeNullData(userId);
    [self setMessageManagerForObjectWithKey:KEY_USER_ID value:userId];
}

-(void)setToken:(NSString *)toKen
{
    _toKen = ChangeNullData(toKen);
    [self setMessageManagerForObjectWithKey:KEY_USER_TOKEN value:toKen];
}

-(void)setDeviceToken:(NSString *)deviceToken
{
    _deviceToken = ChangeNullData(deviceToken);
    [self setMessageManagerForObjectWithKey:DEVICE_TOKEN value:deviceToken];
}

-(NSString *)getUserId
{
    return ChangeNullData(_userId);
}

-(NSString *)getUserToken
{
    return ChangeNullData(_toKen);
}

- (NSString *)getUserPhone
{
    return ChangeNullData(_phone);
}

- (NSString *)getDeviceToken
{
    return ChangeNullData(_deviceToken);
}

-(BOOL)checkUserLogin
{
    //    return StringHasDataJudge(self.userId) ;
    return StringHasDataJudge(self.toKen);
}

-(BOOL)bankCardAre
{
    //    return StringHasDataJudge(self.userId) ;
    return StringHasDataJudge(self.bank);
}

-(BOOL)checkUserLoginAndLoginWithEventkey:(NSString *)eventkey
{
    if (![kUserMessageManager checkUserLogin])
    {
        [self checkAppLogin];
        return NO;
    }
    return YES;
}

// push App登陆
-(void)checkAppLogin{
    UIViewController *selfVC = [UIViewController visibleViewController];
    selfVC.hidesBottomBarWhenPushed = YES;
    TZLoginVC *view = [[TZLoginVC alloc]init];
    [view addPsuhVCAnimationFromTop];
    [selfVC.navigationController pushViewController:view animated:NO];
}


//    /user/logout   用户退出登录接口
- (void)userLogoutAppData
{
    CustomAlertView *alertView = [CustomAlertView initNewStyleOneContent_TwoBtnPushWithAddInSuper:kAlertwindow Content:@"您确定要退出登录吗?" LeftBtnTitle:@"取消" RightBtnTitle:@"确认" clickBlock:^(NSInteger type) {
        if (type == 1) {

            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            NSString *token = [kUserMessageManager getMessageManagerForObjectWithKey:KEY_USER_TOKEN];
            [params setValue:token?:@"" forKey:@"token"];
            [params setValue:token?:@"" forKey:@"channel"];
            [params setValue:token?:@"" forKey:@"clientType"];
            [params setValue:token?:kApp_Version forKey:@"version"];
            [UserViewModel userLogoutPath:userLogout params:params target:self success:^(UserModel *model) {
                if (model.code == 200) {
                    [kUserMessageManager removeDataWhenLogout];
                    [kUserMessageManager checkUserLoginAndLoginWithEventkey:nil];
                }
            } failure:^(NSError *error) {
                
            }];
        }
    }];
    [alertView showInWindowWithView:[UIViewController visibleViewController].tabBarController.view];
}

/** 更新用户资料信息*/
- (void)updateUserDataUrl{
    
}



- (BOOL)checkUserLoginAndRegisterWithEventkey:(NSString *)eventkey webType:(NSString *)webType
{
    if (![kUserMessageManager checkUserLogin])
    {
    }
    return YES;
}

- (BOOL)customerServiceWithEventkey:(NSString *)eventkey
{
//    WebViewController *web = [[WebViewController alloc] initWithWebURL:eventkey title:@""];
//    UINavigationController *RegisterNav = [[UINavigationController alloc]initWithRootViewController:web];
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:RegisterNav animated:YES completion:^{
//        }];
//    });
    return NO;
    
    
    
}

//存储需要银行卡信息
- (void)saveBankCardInfoWithBankName:(NSString *)bankname CardNo:(NSString *)cardno LastFourNo:(NSString *)lastfourno BankIconUrl:(NSString *)bankiconurl
{
    if (bankname) {
//        [self setMessageManagerForObjectWithKey:KEY_BANK_NAME value:bankname];
    }
    
    if (cardno) {
//        [self setMessageManagerForObjectWithKey:KEY_BANK_NO value:cardno];
    }
    
    if (lastfourno) {
//        [self setMessageManagerForObjectWithKey:KEY_BANK_LASTFOURNO value:lastfourno];
    }
    
    if (bankiconurl) {
//        [self setMessageManagerForObjectWithKey:KEY_BANK_ICONURL value:bankiconurl];
    }
}
- (void)saveBankCardInfoWithBankID:(NSString *)bankId
{
    if (bankId) {
//        [self setMessageManagerForObjectWithKey:KEY_BANK_ID value:bankId];
    }
    
}

//删除存储银行卡信息
- (void)removeBankCardInfo
{
//    [self removeMessageManagerForKey:KEY_BANK_NAME];
//    [self removeMessageManagerForKey:KEY_BANK_NO];
//    [self removeMessageManagerForKey:KEY_BANK_LASTFOURNO];
//    [self removeMessageManagerForKey:KEY_BANK_ICONURL];
//    [self removeMessageManagerForKey:KEY_BANK_ID];
}

- (void)removeHuoDongGongGao
{
//    [self removeMessageManagerForKey:kGongGaoEditionList];
//    [self removeMessageManagerForKey:kActivityEditionList];
//    [self removeMessageManagerForKey:KEY_GONGGAOOFMESSAGECENTEREDITION];
//    [self removeMessageManagerForKey:KEY_HUODONGOFMESSAGECENTEREDITION];
//    [self removeMessageManagerForKey:KEY_GONGGAOOFMESSAGECENTERUNREADCOUNT];
//    [self removeMessageManagerForKey:KEY_HUODONGOFMESSAGECENTERUNREADCOUNT];
}

//每次退出清空数据
- (void)removeDataWhenLogout
{
    //保存退出前手机号
//    [kUserMessageManager setMessageManagerForObjectWithKey:KEY_OLD_TEL value:[kUserMessageManager getMessageManagerForObjectWithKey:KEY_USER_TELPHONE]];
//    [kUserMessageManager removeMessageManagerForKey:KEY_USER_ID];
    _userId = nil;
    _toKen = nil;
    //    _deviceToken = nil
    _bank = nil;

    [kUserMessageManager removeMessageManagerForKey:KEY_USER_TRADEPASSWORD];
    [kUserMessageManager removeMessageManagerForKey:KEY_USER_IDENTITY_ID];
    [kUserMessageManager removeMessageManagerForKey:KEY_IS_BINDCARD];
    [kUserMessageManager removeMessageManagerForKey:KEY_FINGERSCAN_ISOPEN];
    [kUserMessageManager removeMessageManagerForKey:KEY_USER_TOKEN];
    [kUserMessageManager removeMessageManagerForKey:KEY_USER_ID];
    
    [self removeHuoDongGongGao];
    [self removeBankCardInfo];
    
    //退出账户的埋点
    [SensorsAnalyticsSDKHelper trackLogout];
}

//页点击统计
- (void)UMClickCountWithEventID:(NSString *)eventid  EventNumID:(NSString *)eventnumid
{
    
    if ([kUserMessageManager checkUserLogin]) {
        
        NSUserDefaults *userDefaluts = [NSUserDefaults standardUserDefaults];
        
        if ([[userDefaluts objectForKey:[NSString stringWithFormat:@"UM%@%@",kUserMessageManager.userId,eventid]] isEqualToString:@"1"] == NO) {
            
            [userDefaluts setObject:@"1" forKey:[NSString stringWithFormat:@"UM%@%@",kUserMessageManager.userId,eventid]];
            
        }
        
    }
    
}


#pragma mark 存储数据

-(void)setMessageManagerForObjectWithKey:(nonnull NSString *)key value:(id)value
{
    if (value != nil) {
        [_userDefaults setObject:value forKey:key];
    }else
    {
        [_userDefaults removeObjectForKey:key];
    }
    [_userDefaults synchronize];
}

-(id)getMessageManagerForObjectWithKey:(nonnull NSString *)key
{
    return [_userDefaults objectForKey:key];
}

-(void)setMessageManagerForBoolWithKey:(nonnull NSString *)key value:(BOOL)value
{
    [_userDefaults setBool:value forKey:key];
    [_userDefaults synchronize];
}
-(BOOL)getMessageManagerForBoolWithKey:(nonnull NSString *)key
{
    return [_userDefaults boolForKey:key];
}


-(void)setMessageManagerForIntegerWithKey:(nonnull NSString *)key value:(NSInteger)value
{
    [_userDefaults setInteger:value forKey:key];
    [_userDefaults synchronize];
}
-(NSInteger)getMessageManagerForIntegerWithKey:(nonnull NSString *)key
{
    return [_userDefaults integerForKey:key];
}

-(void)setMessageManagerForFloatWithKey:(nonnull NSString *)key value:(CGFloat)value
{
    [_userDefaults setFloat:value forKey:key];
    [_userDefaults synchronize];
}
-(CGFloat)getMessageManagerForFloatWithKey:(nonnull NSString *)key
{
    return [_userDefaults floatForKey:key];
}


-(void)removeMessageManagerForKey:(nonnull NSString *)key
{
    [_userDefaults removeObjectForKey:key];
    [_userDefaults synchronize];
}

//判断密码是否规范
- (BOOL)JudgePasswordCorrect:(NSString *)Password
{
    
    //    NSString * regex = @"^((?![0-9]+$))[0-9A-Za-z]{6,16}$";       密码 6-16且必须为数字与字母组合
    
    //    NSString * regex =@"^[A-Za-z0-9]{6,16}+$";            // 密码6-16位且由数字或者字母组合
    
    NSString * regex =@"^[^\u4e00-\u9fa5]{0,}$";            //非中文
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:Password];
    
}


- (NSString * )macString{
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *macString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return macString;
}

- (NSString *)idfaString {
    
    NSBundle *adSupportBundle = [NSBundle bundleWithPath:@"/System/Library/Frameworks/AdSupport.framework"];
    [adSupportBundle load];
    
    if (adSupportBundle == nil) {
        return @"";
    }
    else{
        
        Class asIdentifierMClass = NSClassFromString(@"ASIdentifierManager");
        
        if(asIdentifierMClass == nil){
            return @"";
        }
        else{
            
            //for no arc
            //ASIdentifierManager *asIM = [[[asIdentifierMClass alloc] init] autorelease];
            //for arc
            ASIdentifierManager *asIM = [[asIdentifierMClass alloc] init];
            
            if (asIM == nil) {
                return @"";
            }
            else{
                
                if(asIM.advertisingTrackingEnabled){
                    return [asIM.advertisingIdentifier UUIDString];
                }
                else{
                    return [asIM.advertisingIdentifier UUIDString];
                }
            }
        }
    }
}

- (NSString *)idfvString
{
    if([[UIDevice currentDevice] respondsToSelector:@selector( identifierForVendor)]) {
        return [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    
    return @"";
}

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}


//UIColor 转 UIImage
- (UIImage*)createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}






//界面上移 or 恢复
- (void)changeViewWithType:(NSInteger )type iphone4Move:(CGFloat)ip4movenum iphoneMove:(CGFloat)ipmovenum moveView:(UIView *)moveview
{
    
    CGFloat moveNum;
    if (iPhone4) {
        moveNum = ip4movenum;
    }
    else
    {
        moveNum = ipmovenum;
    }
    
    if (type==0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = moveview.frame;
            frame.origin.y = frame.origin.y-moveNum;
            moveview.frame = frame;
        }];
    }
    else if (type ==1)
    {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = moveview.frame;
            frame.origin.y = frame.origin.y + moveNum;
            moveview.frame = frame;
        }];
    }
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

- (NSMutableAttributedString *)setAttributeWithText:(NSString *)text Color:(UIColor*)color Range:(NSRange)range
{
    NSMutableAttributedString *AtrString = [[NSMutableAttributedString alloc]initWithString:text];
    [AtrString addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    return AtrString;
}


- (NSMutableAttributedString *)setAttributeWithText:(NSString *)text Font:(UIFont*)font Range:(NSRange)range
{
    NSMutableAttributedString *AtrString = [[NSMutableAttributedString alloc]initWithString:text];
    [AtrString addAttribute:NSFontAttributeName value:font range:range];
    return AtrString;
}

//跳转绑卡
- (void)showAddBankCardNoViewControllerInNavigation:(UINavigationController *)navigationController {
    if (navigationController) {
        
//        if ([[kUserMessageManager getMessageManagerForObjectWithKey:KEY_USER_NAME] length]>0 && [[kUserMessageManager getMessageManagerForObjectWithKey:KEY_USER_IDENTITY_ID] length] > 0) {
//            
////            SecondBindCardViewController *secondAddBankCardVC = [[SecondBindCardViewController alloc]init];
////            [navigationController pushViewController:secondAddBankCardVC animated:YES];
//        }
//        else
//        {
////            NewAddBankNOViewController *addBankcardVC = [[NewAddBankNOViewController alloc]init];
////            [navigationController pushViewController:addBankcardVC animated:YES];
//        }
        
    }
}
//跳转开户城市
- (void)showAddOpenCityViewControllerInNavigation:(UINavigationController *)navigationController
{
    if (navigationController) {
//        NewAddOpenCardCityViewController *addBankcardVC = [[NewAddOpenCardCityViewController alloc]init];
//        [navigationController pushViewController:addBankcardVC animated:YES];
    }
}

- (void)showForgetpwdControllerInNavigation:(UINavigationController *)navigationController{
    if (navigationController) {
//        FindTradeKeyViewController *vc=[[FindTradeKeyViewController alloc]init];
//        [navigationController pushViewController:vc animated:YES];
    }
}

- (void)showSetTradeKeyViewControllerInNavigation:(UINavigationController *)navigationController{
    if (navigationController) {
//        SetTradeKeyViewController *vc=[[SetTradeKeyViewController alloc]init];
//        [navigationController pushViewController:vc animated:YES];
    }
}

- (void)showSpecificSuccessViewControllerInNavigation:(UINavigationController *)navigationController{
    if (navigationController) {
//        SpecificSucessViewController *vc=[[SpecificSucessViewController alloc]init];
//        [navigationController pushViewController:vc animated:YES];
    }
}
@end

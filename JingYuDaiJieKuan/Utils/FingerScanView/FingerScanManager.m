//
//  FingerScanManager.m
//  FingerScanDemo
//
//  Created by linshaokai on 16/9/1.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import "FingerScanManager.h"
#import <LocalAuthentication/LocalAuthentication.h>

#define kFSSuccessTimeSave @"FSSuccessTimeSave_%"
#define kDefault_LocalizedFallbackTitle  @"通过登录密码验证"
@interface FingerScanManager ()<UIAlertViewDelegate>
@property (strong ,nonatomic)  LAContext *m_autoenContext;
@property (assign ,nonatomic)  BOOL m_isShowFS;
@property (assign ,nonatomic)  NSInteger m_isBecomeActiveShow;
@property (assign ,nonatomic)  BOOL m_isCheckUseAuthen;
@property (strong ,nonatomic)  NSUserDefaults *m_userDefault;
@property (assign ,nonatomic)  LAPolicy policy;
@property (assign ,nonatomic)  BOOL isLock;
@property (assign ,nonatomic)  BOOL isAuthenAlertShow;
@end
@implementation FingerScanManager
//实现单利
+  (FingerScanManager *)sharedInstance
{
    static FingerScanManager* share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[super allocWithZone:NULL] init];
    });
    return share;
}
-(instancetype)init
{
    if (self = [super init]) {
        CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
        if (version >= 9) {
            self.policy = LAPolicyDeviceOwnerAuthentication;
        }else if (version >= 8.0)
        {
            self.policy = LAPolicyDeviceOwnerAuthenticationWithBiometrics;
        }
        self.localizedFallbackTitle = kDefault_LocalizedFallbackTitle;
        self.m_isBecomeActiveShow = AppStatusType_Foreground;
        self.intervalTime = 0;
        self.isNeedIntervalTime = YES;
        self.isShowAuthedAlertView = YES;
        self.isAuthenAlertShow = YES;
        
    }
    return self;
}
//授权指纹识别
-(void)authenFingerScan
{
    self.m_isCheckUseAuthen = YES;
    self.isAuthenAlertShow = self.isShowAuthedAlertView;
    if (self.authedlocalizedFallbackTitle) {
        self.m_autoenContext.localizedFallbackTitle = self.authedlocalizedFallbackTitle;
    }else
    {
        self.m_autoenContext.localizedFallbackTitle = @"";
    }
    [self checkAuthentication];
}
//界面的指纹识别
-(void)showAuthenticationView:(AppStatusType)appStatusType
{
    if (self.m_isCheckUseAuthen) return;//授权状态不需要再走界面
    if (![self changeCurrentAppStatus:appStatusType]) return;
    if (![self canAuthedByintervalTime]) return;
    [self setupMainView];
    [self checkAuthenticationClick];
}
#pragma mark 界面指纹解锁调用
-(void)setupMainView
{
    if (self.checkAuthedBlock) {
        self.checkAuthedBlock = nil;
    }
    if (self.authenBackgroundView && !self.authenBackgroundView.superview) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[[UIApplication sharedApplication].windows objectAtIndex:0]addSubview:self.authenBackgroundView];
        });
    }
}

-(BOOL)canAuthedByintervalTime
{
    BOOL isLimit = YES;
    if (self.isNeedIntervalTime && self.intervalTime > 0) {
        NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
        NSTimeInterval saveTime = [self.m_userDefault integerForKey:kFSSuccessTimeSave];
        if (currentTime - saveTime >= self.intervalTime) {
            return YES;
        }else
        {
            return NO;
        }
    }
    return isLimit;
    
}
//保存授权时间
-(void)saveSuccessTime
{
    [self.m_userDefault setInteger:[[NSDate date] timeIntervalSince1970] forKey:kFSSuccessTimeSave];
    [self.m_userDefault synchronize];
}
//用于解决因 重新激活APP带来的多次调用
-(BOOL)changeCurrentAppStatus:(AppStatusType)appStatusType
{
    if (AppStatusType_BecomeActive == appStatusType && self.m_isBecomeActiveShow ==  AppStatusType_BecomeActive) {
        return NO;
    }else if (appStatusType == AppStatusType_BecomeActive){
        self.m_isBecomeActiveShow = AppStatusType_BecomeActive;
    }else
    {
        self.m_isBecomeActiveShow = AppStatusType_Foreground;
    }
    return  YES;
}
-(void)checkAuthenticationClick
{
    if (!self.m_isShowFS) {
        self.m_isShowFS = YES;
        [self checkAuthentication];
    }
}

-(void)removeFSView{
    if (self.authenBackgroundView) {
        [UIView animateWithDuration:0.25 animations:^{
            self.authenBackgroundView.alpha = 0;
        }completion:^(BOOL finished) {
            [self.authenBackgroundView removeFromSuperview];
            self.authenBackgroundView.alpha = 1;
        }];
    }
    
}
-(LAContext *)m_autoenContext
{
    if (!_m_autoenContext) {
        _m_autoenContext = [[LAContext alloc]init];
        _m_autoenContext.localizedFallbackTitle = self.localizedFallbackTitle;
    }
    return _m_autoenContext;
}

#pragma mark 授权和解锁
/**
 *  是否支持指纹
 */
-(BOOL)isAvailableLocalAuthentication
{
    CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
    self.isLock = NO;
    if (version >= 8.0) {
        NSError* error = nil;
        //首先使用canEvaluatePolicy 判断设备支持状态
        
        if ([self.m_autoenContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            return YES;
        } else
        {
            //不支持指纹识别，LOG出错误详情
            switch (error.code) {
                case LAErrorTouchIDNotEnrolled:
                case LAErrorPasscodeNotSet:
                {
                    [self isAvailableFigerScan:FSAvailableError_NotSetPassWord];
                    break;
                }
                default:
                {
                    if (version >= 9.0 && error.code == LAErrorTouchIDLockout) {
                        self.isLock = YES;
                        [self checkFiger];
                    }else
                    {
                        [self isAvailableFigerScan:FSAvailableError_MobileNotSupported];
                    }
                    
                    break;
                }
            }
        }
    }else
    {
        [self isAvailableFigerScan:FSAvailableError_MobileNotSupported];
    }
    return NO;
}

-(BOOL)onlyIsAvailableLocalAuthentication
{
    
    CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
    self.isLock = NO;
    if (version >= 8.0) {
        NSError* error = nil;
        //首先使用canEvaluatePolicy 判断设备支持状态
        
        if ([self.m_autoenContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            return YES;
        }
        else
        {
            return NO;
        }
        
    }
    else
    {
        return NO;
    }
    
    return NO;
    
}


//指纹解锁不支持的失败回调
-(void)isAvailableFigerScan:(FSAvailableError)errorType
{
    NSString *alertString = @"您的手机不支持指纹解锁功能！";
        if (errorType == FSAvailableError_NotSetPassWord) {
            alertString = @"您尚未设置Touch ID,请在手机系统\"设置>Touch ID与密码\"中添加指纹";;
    }
    if (self.isAuthenAlertShow) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alter = [[UIAlertView alloc]initWithTitle:nil message:alertString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        });
        return;
    }
    if (self.fmAvailableBlock) {
        
        self.fmAvailableBlock(errorType,alertString);
        
        __block typeof(self) selfController = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [selfController authenFail:errorType alterString:alertString];;
        });
    }
}

-(void)authenFail:(FSAvailableError)availableErrorType alterString:(NSString *)alertString{
    if (!self.m_isCheckUseAuthen) {
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:nil message:@"您的指纹信息发生变更，请在手机中重新添加指纹后返回解锁或者直接使用密码登录。" delegate:self cancelButtonTitle:@"验证登录密码" otherButtonTitles:@"取消", nil];
        [alter show];
    }else
    {
        if (self.checkAuthedBlock) {
            self.checkAuthedBlock(FSResultError_OtherError);
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self showLoginView];
    }
    self.m_isShowFS = NO;
}
//指纹识别开始
-(void)checkAuthentication
{
    if ([self isAvailableLocalAuthentication]) {
        [self checkFiger];
    }
}

-(void)checkFiger
{
    __block typeof(self) selfController = self;
    [self.m_autoenContext evaluatePolicy:self.isLock?self.policy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"通过Home键验证已有手机指纹 " reply:
     ^(BOOL success, NSError *authenticationError) {
         
         if (success && self.isLock) {
             selfController.isLock = NO;
             selfController.m_autoenContext = nil;
             [selfController checkFiger];
         }else
         {
             [selfController checkResult:success withError:authenticationError];
         }
         
    }];
}
//指纹识别失败
-(void)checkResult:(BOOL)isSuccess withError:(NSError *)error
{
    
        FSResultError errorType = 0;
        if (!isSuccess) {
            switch (error.code) {
                case LAErrorSystemCancel:
                {
                    errorType = FSResultError_LevelAppCancle;
                    //切换到其他APP，系统取消验证Touch ID
                    break;
                }
                case LAErrorUserCancel:
                {
                    errorType = FSResultError_Cancle;
                    //用户取消验证Touch ID
                    break;
                }
                case LAErrorUserFallback:
                {
                    errorType = FSResultError_OtherCheck;
                    break;
                }
                default:
                {
                    errorType = FSResultError_OtherError;
                    break;
                }
            }
        }
        __block typeof(self) selfController = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [selfController canAuthedForResutl:errorType];
        });
}
-(NSUserDefaults *)m_userDefault
{
    if (!_m_userDefault) {
        _m_userDefault = [NSUserDefaults standardUserDefaults];
    }
    return _m_userDefault;
}

-(void)canAuthedForResutl:(FSResultError)errorType
{
    if (self.fmResulBlock) {
        self.fmResulBlock(errorType);
    }
    
    self.m_isShowFS = NO;
    if (self.m_isCheckUseAuthen) {
        self.m_isCheckUseAuthen = NO;
       self.isAuthenAlertShow = NO;
        self.m_isBecomeActiveShow = AppStatusType_BecomeActive;
        if (errorType == 0) {
            self.m_autoenContext = nil;
        }
        if (self.checkAuthedBlock) {
            self.checkAuthedBlock(errorType);
        }
    }else
    {
        if (errorType == 0) {
            self.m_autoenContext = nil;
            [self saveSuccessTime];
            [self removeFSView];
        }else if(errorType == FSResultError_OtherCheck)
        {
            [self showLoginView];
        }
        if (self.fmResulBlock) {
            self.fmResulBlock(errorType);
        }
    }
}
-(void)showLoginView
{
    if (self.loginPasswordBlock) {
        self.loginPasswordBlock();
    }
}

@end

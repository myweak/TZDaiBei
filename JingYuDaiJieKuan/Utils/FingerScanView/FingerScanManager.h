//
//  FingerScanManager.h
//  FingerScanDemo
//
//  Created by linshaokai on 16/9/1.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <LocalAuthentication/LocalAuthentication.h>
typedef  NS_ENUM(NSInteger,FSAvailableError)
{
    FSAvailableError_MobileNotSupported = 0,
    FSAvailableError_NotSetPassWord
};
typedef  NS_ENUM(NSInteger,FSResultError)
{
    FSResultError_Success = 0,
    FSResultError_OtherCheck,
    FSResultError_Cancle,
    FSResultError_LevelAppCancle,
    FSResultError_OtherError,
    
};

typedef NS_ENUM(NSInteger ,AppStatusType) {
    AppStatusType_Foreground = 0,//在前台
    AppStatusType_BecomeActive,//重新激活
    AppStatusType_AppSuspended,//app暂停
    AppStatusType_AppKill,//app暂停
};

typedef void (^FSAvailableBlock) (FSAvailableError availableErrorType,NSString *alertString);
typedef void (^FSResultBlock) (FSResultError resultErrorType);
typedef void (^FSSuccessBlock)(BOOL isFail);
typedef void (^FScanLoginPasswordBlock)();

@interface FingerScanManager : NSObject
@property (copy ,nonatomic) FSAvailableBlock fmAvailableBlock;//不支持指纹解锁的回调

@property (copy ,nonatomic) FSResultBlock fmResulBlock;//指纹解锁结果的回调

//初始化单例

+ (FingerScanManager *)sharedInstance;


@property (strong ,nonatomic) UIView *authenBackgroundView;
/**
 *  //间隔多久会有指纹解锁用于频繁启动App时候调用 以s为单位   默认是 0
 */
@property (assign ,nonatomic) NSTimeInterval intervalTime;
/**
 *  是否需要间隔 默认是  YES
 */
@property (assign ,nonatomic) BOOL isNeedIntervalTime;
/**
 *  //用于授权开启指纹成功失败的回调
 */
@property (copy ,nonatomic) FSSuccessBlock checkAuthedBlock;
/**
 *  用于指纹解锁失败走登录密码验证
 */
@property (copy ,nonatomic) FScanLoginPasswordBlock loginPasswordBlock;
/**
 *  用于界面修改指纹验证失败第2次 选择其他验证的文本
 */
@property (copy ,nonatomic) NSString *localizedFallbackTitle;
/**
 *  单纯授权指纹验证失败第2次 选择其他验证的文本
 */
@property (copy ,nonatomic) NSString *authedlocalizedFallbackTitle;

/**
 *  是否显示指纹识别在授权时候 不支持的提示  默认YES
 */
@property (assign ,nonatomic) BOOL isShowAuthedAlertView;

/**
 *  是否支持指纹
 */
-(BOOL)isAvailableLocalAuthentication;

/**
 *  仅仅是否支持指纹
 */
-(BOOL)onlyIsAvailableLocalAuthentication;

/**
 *  用于授权开启指纹
 */
-(void)authenFingerScan;

/**
 *  授权界面点击授权
 */
-(void)checkAuthenticationClick;
/**
 *  用于启动时候指纹解锁
 
 * 是否已经授权指纹解锁 要先做判断再调用
 
 *  @param appStatusType AppDelegate
 WillEnterForeground :AppStatusType_Foreground
 DidBecomeActive:AppStatusType_BecomeActive
 */
-(void)showAuthenticationView:(AppStatusType)appStatusType;
/**
 *  移除界面
 */
-(void)removeFSView;


@end

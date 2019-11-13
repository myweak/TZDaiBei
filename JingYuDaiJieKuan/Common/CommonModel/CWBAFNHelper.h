//
//  CWBAFNHelper.h
//  CPMerchant
//
//  Created by weibin on 16/9/2.
//  Copyright © 2016年 cwb. All rights reserved.
//

typedef enum : NSUInteger
{
    NetworkHUDBackground=0,         // 不锁屏，不提示
    NetworkHUDMsg=1,                // 不锁屏，只要msg不为空就提示
    NetworkHUDError=2,              // 锁屏，提示错误信息  供部分页面需要加载头部动画
    NetworkHUDLockScreen=3,         // 锁屏
    NetworkHUDLockScreenAndMsg=4,   // 锁屏，只要msg不为空就提示
    NetworkHUDLockScreenAndError=5, // 锁屏，提示错误信息
    NetworkHUDLockScreenButNavWithMsg=6,  // 锁屏, 但是导航栏可以操作, 只要msg不为空就提示
    NetworkHUDLockScreenButNavWithError=7, // 锁屏, 但是导航栏可以操作, 提示错误信息
    NetworkHUDNoNotice = 8 // 弹窗，不提示返回值
} NetworkHUD;

typedef NS_ENUM(NSUInteger, CWBAFNStatus) {
    /** 未知网络*/
    CWBAFNStatusUnknown,
    /** 无网络*/
    CWBAFNStatusNotReachable,
    /** 手机网络*/
    CWBAFNStatusReachableViaWWAN,
    /** WIFI网络*/
    CWBAFNStatusReachableViaWiFi
};

#import <AFNetworking/AFNetworking.h>
#import "CWBAFNCache.h"

/** 缓存的Block */
typedef void(^HttpRequestCache)(id responseCache);

/** 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小*/
typedef void (^HttpProgress)(NSProgress *progress);

/** 网络状态的Block*/
typedef void(^CWBNetworkStatus)(CWBAFNStatus status);

@interface CWBAFNHelper : AFHTTPSessionManager

+ (void)startMonitoringNetwork;

/**
 *  通过Block回调实时获取网络状态
 */
+ (void)checkNetworkStatusWithBlock:(CWBNetworkStatus)status;

/**
 *  获取当前网络状态,有网YES,无网:NO
 */
+ (BOOL)currentNetworkStatus;

#pragma mark - 请求有缓存
+ (AFHTTPSessionManager *)postDataResponsePath:(NSString *)path
                                        params:(NSMutableDictionary *)params
                                        isPost:(BOOL)isPost
                                    networkHUD:(NetworkHUD)networkHUD
                                 responseCache:(HttpRequestCache)responseCache
                                        target:(id)target
                                       success:(void (^)(id responseObject))success
                                       failure:(void (^)(NSError *error))failure;


#pragma mark - 带其他路径 urlHostType:字段串类型 方便扩展 1:正常url 2：深圳url
+ (AFHTTPSessionManager *)postDataResponsePath:(NSString *)path
                                   urlHostType:(NSInteger)urlHostType
                                        params:(NSMutableDictionary *)params
                                        isPost:(BOOL)isPost
                                     isRefresh:(BOOL)isRefresh
                                    networkHUD:(NetworkHUD)networkHUD
                                 responseCache:(HttpRequestCache)responseCache
                                        target:(id)target
                                       success:(void (^)(id responseObject))success
                                       failure:(void (^)(NSError *error))failure;

#pragma mark -- JAVA请求接口
+ (AFHTTPSessionManager *)postJDataResponsePath:(NSString *)path
                                         params:(NSMutableDictionary *)params
                                         isPost:(BOOL)isPost
                                     networkHUD:(NetworkHUD)networkHUD
                                  responseCache:(HttpRequestCache)responseCache
                                         target:(id)target
                                        success:(void (^)(id responseObject))success
                                        failure:(void (^)(NSError *error))failure;
#pragma mark -- JAVA其他路径请求
+ (AFHTTPSessionManager *)postJDataResponsePath:(NSString *)path
                                    urlHostType:(NSInteger)urlHostType
                                         params:(NSMutableDictionary *)params
                                         isPost:(BOOL)isPost
                                      isRefresh:(BOOL)isRefresh
                                     networkHUD:(NetworkHUD)networkHUD
                                  responseCache:(HttpRequestCache)responseCache
                                         target:(id)target
                                        success:(void (^)(id responseObject))success
                                        failure:(void (^)(NSError *error))failure;

@end

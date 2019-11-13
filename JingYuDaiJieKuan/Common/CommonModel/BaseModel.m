//
//  BaseModel.m
//  CarpFinancial
//
//  Created by weibin on 15/12/11.
//  Copyright © 2015年 cwb. All rights reserved.
//

#import "BaseModel.h"


@implementation BaseModel

///是否下拉刷新 isRefresh是否下拉刷新  networkHUD加载动画
#pragma mark - 带其他路径 urlHostType:字段串类型 方便扩展 1:正常url 2：深圳url 100 v2 101 hb  102 ...
//105 调用java 和 PHP的接口
+ (void)postDataResponsePath:(NSString *)path
                 urlHostType:(NSInteger)urlHostType
                      params:(NSMutableDictionary *)params
                      isPost:(BOOL)isPost
                   isRefresh:(BOOL)isRefresh
                  networkHUD:(NetworkHUD)networkHUD
                      target:(id)target
               responseCache:(HttpRequestCache)responseCache
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure
{
    @autoreleasepool
    {
        [CWBAFNHelper postDataResponsePath:path urlHostType:urlHostType params:params isPost:isPost isRefresh:isRefresh networkHUD:networkHUD responseCache:responseCache target:target success:^(id responseObject) {
            
            if (responseObject)
            success(responseObject);
            
        } failure:^(NSError *error) {
            
            if (failure)
            failure(error);
        }];
    }
}

+ (void)postDataResponsePath:(NSString *)path
                      params:(NSMutableDictionary *)params
                      isPost:(BOOL)isPost
                  networkHUD:(NetworkHUD)networkHUD
                      target:(id)target
               responseCache:(HttpRequestCache)responseCache
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure
{
    @autoreleasepool
    {
        [CWBAFNHelper postDataResponsePath:path params:params isPost:isPost networkHUD:networkHUD responseCache:responseCache target:target success:^(id responseObject) {
            
            if (responseObject)
            success(responseObject);
            
        } failure:^(NSError *error) {
            
            if (failure)
            failure(error);
        }];
    }
}

@end

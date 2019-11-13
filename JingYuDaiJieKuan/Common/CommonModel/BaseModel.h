//
//  BaseModel.h
//  CarpFinancial
//
//  Created by weibin on 15/12/11.
//  Copyright © 2015年 cwb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CWBAFNHelper.h"

@interface BaseModel : NSObject

///是否下拉刷新 isRefresh是否下拉刷新  networkHUD加载动画
#pragma mark - 带其他路径 urlHostType:字段串类型 方便扩展 1:正常url 2：深圳url
+ (void)postDataResponsePath:(NSString *)path
                 urlHostType:(NSInteger)urlHostType
                      params:(NSMutableDictionary *)params
                      isPost:(BOOL)isPost
                   isRefresh:(BOOL)isRefresh
                  networkHUD:(NetworkHUD)networkHUD
                      target:(id)target
               responseCache:(HttpRequestCache)responseCache
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;

#pragma mark - 网络请求有缓存
/**
 *  网络请求有缓存
 */
+ (void)postDataResponsePath:(NSString *)path
                      params:(NSMutableDictionary *)params
                      isPost:(BOOL)isPost
                  networkHUD:(NetworkHUD)networkHUD
                      target:(id)target
               responseCache:(HttpRequestCache)responseCache
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;

@end

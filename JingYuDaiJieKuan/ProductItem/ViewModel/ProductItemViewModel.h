//
//  ProductItemViewModel.h
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/2.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductItemModel.h"
#import "TZProductPageModel.h"
#import "TZProductScreenConditionModel.h"
#import "TZProductScreenConditionProvinceModel.h"
#import "TZApplyCreditCardModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductItemViewModel : NSObject

// /market/search贷款大全列表搜索接口
+(void)productItemListPath:(NSString *)path
                    params:(NSMutableDictionary *)params
                    target:(id)target
                   success:(void (^)(ProductItemListModel *model))success
                   failure:(void (^)(NSError *error))failure;


// 搜索字段接口
+(void)filterListPath:(NSString *)path
               params:(NSMutableDictionary *)params
               target:(id)target
              success:(void (^)(sortListModel *model))success
              failure:(void (^)(NSError *error))failure;


/// 随机商户推荐接口
+(void)randomProductPath:(NSString *)path
                  params:(NSMutableDictionary *)params
                  target:(id)target
                 success:(void (^)(randomProductModel *model))success
                 failure:(void (^)(NSError *error))failure;


/// 获取广告弹窗接口
+(void)advertisementDialogPath:(NSString *)path
                        params:(NSMutableDictionary *)params
                        target:(id)target
                       success:(void (^)(advertisementDialogListModel *model))success
                       failure:(void (^)(NSError *error))failure;


/// 热门搜索接口
+(void)productItemHotPath:(NSString *)path
                   params:(NSMutableDictionary *)params
                   target:(id)target
                  success:(void (^)(ProductItemHistoryListModel *model))success
                  failure:(void (^)(NSError *error))failure;


//贷款大全最下方banner接口
+(void)loanDaquanBannerPath:(NSString *)path
                     params:(NSMutableDictionary *)params
                     target:(id)target
                    success:(void (^)(TZProductPageModel *model))success
                    failure:(void (^)(NSError *error))failure;


//精选贷款接口
+(void)careChosenPath:(NSString *)path
               params:(NSMutableDictionary *)params
               target:(id)target
              success:(void (^)(TZProductPageModel *model))success
              failure:(void (^)(NSError *error))failure;

//个人中心-贷款攻略文章列表接口（只返回前三条）
+(void)articleRecommendListPath:(NSString *)path
                         params:(NSMutableDictionary *)params
                         target:(id)target
                        success:(void (^)(TZProductPageModel *model))success
                        failure:(void (^)(NSError *error))failure;
//贷款攻略文章列表接口（所有的
+(void)articleAllListPath:(NSString *)path
                   params:(NSMutableDictionary *)params
                   target:(id)target
                  success:(void (^)(TZProductPageModel *model))success
                  failure:(void (^)(NSError *error))failure;

// 新闻数量统计
+(void)articleAddLikeNumPath:(NSString *)path
                      params:(NSMutableDictionary *)params
                      target:(id)target
                     success:(void (^)(TZProductPageModel *model))success
                     failure:(void (^)(NSError *error))failure;


// 新闻数量统计
+(void)homeLastAllPath:(NSString *)path
                params:(NSDictionary *)params
                target:(id)target
               success:(void (^)(TZProductPageModel *model))success
               failure:(void (^)(NSError *error))failure;

// 线下产品大全
+(void)getOfflineInfoPath:(NSString *)path
                   params:(NSMutableDictionary *)params
                   target:(id)target
                  success:(void (^)(TZProductScreenConditionModel *model))success
                  failure:(void (^)(NSError *error))failure;


// 筛选 集合
+(void)conditionPath:(NSString *)path
              params:(NSMutableDictionary *)params
              target:(id)target
          modelClass:(Class )modelClass
             success:(void (^)(id model))success
             failure:(void (^)(NSError *error))failure;












@end

NS_ASSUME_NONNULL_END

//
//  HomePageViewModel.h
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/4/8.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomePageModel.h"

@interface HomePageViewModel : NSObject

// /app/login/banner   APP初始化数据获取接口
+(void)appLoginBannerPath:(NSString *)path
                   params:(NSMutableDictionary *)params
                   target:(id)target
                  success:(void (^)(HomePageModel  *model))success
                  failure:(void (^)(NSError *error))failure;


// home / banner  首页横幅接口
+(void)homeBannerPath:(NSString *)path
               params:(NSMutableDictionary *)params
               target:(id)target
              success:(void (^)(HomePageModel  *model))success
              failure:(void (^)(NSError *error))failure;

// home / icon / zone  金刚区接口
+(void)homeIconZonePath:(NSString *)path
                 params:(NSMutableDictionary *)params
                 target:(id)target
                success:(void (^)(HomePageModel  *model))success
                failure:(void (^)(NSError *error))failure;

//home / message / notice  滚动消息通知接口
+(void)homeMessageNoticePath:(NSString *)path
                      params:(NSMutableDictionary *)params
                      target:(id)target
                     success:(void (^)(HomeNoticeListModel  *model))success
                     failure:(void (^)(NSError *error))failure;

// home / recommended / zone  推荐专题
+(void)homeTodayRecommendPath:(NSString *)path
                       params:(NSMutableDictionary *)params
                       target:(id)target
                      success:(void (^)(HomePageModel  *model))success
                      failure:(void (^)(NSError *error))failure;

/// home / last / merchant 最新口子接口
+(void)homeLastMerchantPath:(NSString *)path
                     params:(NSMutableDictionary *)params
                     target:(id)target
                    success:(void (^)(HomePageModel  *model))success
                    failure:(void (^)(NSError *error))failure;

// home / bottom / icon  底部瓷片区配置接口
+(void)homeBottomIconPath:(NSString *)path
                   params:(NSMutableDictionary *)params
                   target:(id)target
                  success:(void (^)(HomePageModel  *model))success
                  failure:(void (^)(NSError *error))failure;


// home / care / selected  精选贷款接口
+(void)homeCareSelectedPath:(NSString *)path
                     params:(NSMutableDictionary *)params
                     target:(id)target
                    success:(void (^)(HomePageModel  *model))success
                    failure:(void (^)(NSError *error))failure;

// /home/merchant/click/{merchantId}  商户点击隐藏接口
+(void)merchantClickPath:(NSString *)path
                  params:(NSMutableDictionary *)params
                  target:(id)target
                 success:(void (^)(HomePageModel  *model))success
                 failure:(void (^)(NSError *error))failure;


// streamer/{pos}广告横幅查询接口
+(void)streamerListPath:(NSString *)path
                 params:(NSMutableDictionary *)params
                 target:(id)target
                success:(void (^)(StreamerListModel  *model))success
                failure:(void (^)(NSError *error))failure;


/** home / IntervalDays   首页最下方信息 统计 ：运营时间 交易数量  -->TZTZ*/
+ (void)homeIntervalDaysPath:(NSString *)path
                      params:(NSMutableDictionary *)params
                      target:(id)target
                     success:(void (^)(homeIntervalDaysModel *model))success
                     failure:(void (^)(NSError *error))failure;

@end

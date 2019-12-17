//
//  HomePageViewModel.m
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/4/8.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "HomePageViewModel.h"

@implementation HomePageViewModel

// /app/login/banner   APP初始化数据获取接口
+(void)appLoginBannerPath:(NSString *)path
                   params:(NSMutableDictionary *)params
                   target:(id)target
                  success:(void (^)(HomePageModel  *model))success
                  failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    manage.completionQueue = dispatch_queue_create("completion", DISPATCH_QUEUE_SERIAL);
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [HomePageModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:aUser.token?:@"" forKey:@"token"];
    
    [manage postWithPath:path params:param isNotEncryption:NO customClass:entity success:^(HomePageModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//home / IntervalDays  /** 首页最下方信息 统计 ：运营时间 交易数量 */ -->TZTZ
+ (void)homeIntervalDaysPath:(NSString *)path
                params:(NSMutableDictionary *)params
                target:(id)target
               success:(void (^)(homeIntervalDaysModel *model))success
               failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [homeIntervalDaysModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];

//    [param setObject:[kUserMessageManager getUserToken]?:@"" forKey:@"token"];
    [manage getWithPath:path params:param customClass:entity success:^(id model) {
        success(model);

    } failure:^(NSError *error) {
        failure(error);

    }];

}

//home / banner  首页横幅接口 -->TZTZ
+ (void)homeBannerPath:(NSString *)path
                params:(NSMutableDictionary *)params
                target:(id)target
               success:(void (^)(HomePageModel *model))success
               failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [HomePageModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:aUser.token?:@"" forKey:@"token"];
    
    [manage postWithPath:path params:param isNotEncryption:NO customClass:entity success:^(HomePageModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// home / icon / zone  金刚区接口
+(void)homeIconZonePath:(NSString *)path
                 params:(NSMutableDictionary *)params
                 target:(id)target
                success:(void (^)(HomePageModel  *model))success
                failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [HomePageModel class];
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(HomePageModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//home / message / notice  滚动消息通知接口 -->TZTZ
+(void)homeMessageNoticePath:(NSString *)path
                      params:(NSMutableDictionary *)params
                      target:(id)target
                     success:(void (^)(HomeNoticeListModel *model))success
                     failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [HomeNoticeListModel class];
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(HomeNoticeListModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}
// / home / today /推荐  今日推荐接口
+(void)homeTodayRecommendPath:(NSString *)path
                      params:(NSMutableDictionary *)params
                      target:(id)target
                     success:(void (^)(HomePageModel  *model))success
                     failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [HomePageModel class];
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(HomePageModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/// home / last / merchant 最新口子接口
+(void)homeLastMerchantPath:(NSString *)path
                     params:(NSMutableDictionary *)params
                     target:(id)target
                    success:(void (^)(HomePageModel  *model))success
                    failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [HomePageModel class];
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(HomePageModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// home / bottom / icon  底部瓷片区配置接口
+(void)homeBottomIconPath:(NSString *)path
                   params:(NSMutableDictionary *)params
                   target:(id)target
                  success:(void (^)(HomePageModel  *model))success
                  failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [HomePageModel class];
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(HomePageModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}


// home / care / selected  精选贷款接口
+(void)homeCareSelectedPath:(NSString *)path
                  params:(NSMutableDictionary *)params
                  target:(id)target
                 success:(void (^)(HomePageModel *model))success
                 failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [HomePageModel class];
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(HomePageModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}


// /home/merchant/click/{merchantId} 商户点击隐藏接口
+(void)merchantClickPath:(NSString *)path
                     params:(NSMutableDictionary *)params
                     target:(id)target
                    success:(void (^)(HomePageModel *model))success
                    failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [HomePageModel class];
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(HomePageModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}




// streamer/{pos}广告横幅查询接口
+(void)streamerListPath:(NSString *)path
                  params:(NSMutableDictionary *)params
                  target:(id)target
                 success:(void (^)(StreamerListModel *model))success
                 failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [StreamerListModel class];
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(StreamerListModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}


@end

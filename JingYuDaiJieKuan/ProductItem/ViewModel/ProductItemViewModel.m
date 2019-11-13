//
//  ProductItemViewModel.m
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/2.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "ProductItemViewModel.h"

@implementation ProductItemViewModel

+(void)productItemListPath:(NSString *)path
                    params:(NSMutableDictionary *)params
                    target:(id)target
                   success:(void (^)(ProductItemListModel *model))success
                   failure:(void (^)(NSError *error))failure;
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [ProductItemListModel class];
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(ProductItemListModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//
//+(void)productItemTipPath:(NSString *)path
//                    params:(NSMutableDictionary *)params
//                    target:(id)target
//                   success:(void (^)(ProductItemListModel *model))success
//                   failure:(void (^)(NSError *error))failure;
//{
//    HttpManager *manage = [[HttpManager alloc]init];
//    
//    HttpPropertyEntity *entity = [HttpPropertyEntity new];
//    entity.responseObject = [ProductItemListModel class];
//    
//    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(ProductItemListModel *model) {
//        success(model);
//        
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}

// 搜索字段接口
+(void)filterListPath:(NSString *)path
               params:(NSMutableDictionary *)params
               target:(id)target
              success:(void (^)(sortListModel  *model))success
              failure:(void (^)(NSError *error))failure;{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [sortListModel class];
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(sortListModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 随机推荐商户接口
+(void)randomProductPath:(NSString *)path
               params:(NSMutableDictionary *)params
               target:(id)target
              success:(void (^)(randomProductModel *model))success
              failure:(void (^)(NSError *error))failure{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [randomProductModel class];
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(randomProductModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}



/// 获取广告弹窗接口
+(void)advertisementDialogPath:(NSString *)path
                        params:(NSMutableDictionary *)params
                        target:(id)target
                       success:(void (^)(advertisementDialogListModel *model))success
                       failure:(void (^)(NSError *error))failure{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [advertisementDialogListModel class];
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(advertisementDialogListModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}



/// 热门搜索接口
+(void)productItemHotPath:(NSString *)path
                        params:(NSMutableDictionary *)params
                        target:(id)target
                       success:(void (^)(ProductItemHistoryListModel *model))success
                       failure:(void (^)(NSError *error))failure{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [ProductItemHistoryListModel class];
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(ProductItemHistoryListModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//贷款大全最下方banner接口
+(void)loanDaquanBannerPath:(NSString *)path
                   params:(NSMutableDictionary *)params
                   target:(id)target
                  success:(void (^)(TZProductPageModel *model))success
                  failure:(void (^)(NSError *error))failure{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [TZProductPageModel class];
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(TZProductPageModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//精选贷款接口
+(void)careChosenPath:(NSString *)path
                     params:(NSMutableDictionary *)params
                     target:(id)target
                    success:(void (^)(TZProductPageModel *model))success
                    failure:(void (^)(NSError *error))failure{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [TZProductPageModel class];
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(TZProductPageModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+(void)articleRecommendListPath:(NSString *)path
               params:(NSMutableDictionary *)params
               target:(id)target
              success:(void (^)(TZProductPageModel *model))success
              failure:(void (^)(NSError *error))failure{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [TZProductPageModel class];
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(TZProductPageModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}
+(void)articleAddLikeNumPath:(NSString *)path
                         params:(NSMutableDictionary *)params
                         target:(id)target
                        success:(void (^)(TZProductPageModel *model))success
                        failure:(void (^)(NSError *error))failure{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [TZProductPageModel class];
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(TZProductPageModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+(void)articleAllListPath:(NSString *)path
                   params:(NSMutableDictionary *)params
                   target:(id)target
                  success:(void (^)(TZProductPageModel *model))success
                  failure:(void (^)(NSError *error))failure{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [TZProductPageModel class];
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(TZProductPageModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+(void)homeLastAllPath:(NSString *)path
                   params:(NSMutableDictionary *)params
                   target:(id)target
                  success:(void (^)(TZProductPageModel *model))success
                  failure:(void (^)(NSError *error))failure{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [TZProductPageModel class];
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(TZProductPageModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+(void)getOfflineInfoPath:(NSString *)path
                params:(NSMutableDictionary *)params
                target:(id)target
               success:(void (^)(TZProductScreenConditionModel *model))success
               failure:(void (^)(NSError *error))failure{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [TZProductScreenConditionModel class];
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(TZProductScreenConditionModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}



// 筛选 集合
+(void)conditionPath:(NSString *)path
              params:(NSMutableDictionary *)params
              target:(id)target
          modelClass:(Class )modelClass
             success:(void (^)(id model))success
             failure:(void (^)(NSError *error))failure{
    
    HttpManager *manage = [[HttpManager alloc]init];
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = modelClass;
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(id model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


@end

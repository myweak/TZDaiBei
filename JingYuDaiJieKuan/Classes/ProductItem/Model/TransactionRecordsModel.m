//
//  TransactionRecordsModel.m
//  JingYuDaiJieKuan
//
//  Created by air on 2018/4/3.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

//  交易记录model


#import "TransactionRecordsModel.h"
#import "StatusModel.h"

@implementation TransactionRecordsModel

+ (void)acquisitionRecordPath:(NSString *)path
                       params:(NSMutableDictionary *)params
                       target:(id)target
                      success:(void (^)(TransactionRecordsListModel * model))success
                      failure:(void (^)(NSError *))failure{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [TransactionRecordsListModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:[kUserMessageManager getUserToken]?:@"" forKey:@"token"];
    [manage postWithPath:path
                  params:param
         isNotEncryption:NO
             customClass:entity
                 success:^(TransactionRecordsListModel *model) {
                     
                     if (success) {
                         success(model);
                     }
                 } failure:^(NSError *error) {
                     failure(error);
                 }];
    
}

+ (void)feedbackPath:(NSString *)path
                       params:(NSMutableDictionary *)params
                       target:(id)target
                      success:(void (^)(UserModel *model))success
                      failure:(void (^)(NSError *))failure{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [TransactionRecordsListModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:[kUserMessageManager getUserToken]?:@"" forKey:@"token"];
    [manage postWithPath:path
                  params:param
         isNotEncryption:NO
             customClass:entity
                 success:^(UserModel *model) {
                     if (success) {
                         success(model);
                     }
                 } failure:^(NSError *error) {
                     failure(error);
                 }];
}

+ (void)myInvestmentPath:(NSString *)path
              params:(NSMutableDictionary *)params
              target:(id)target
             success:(void (^)(TransactionRecordsListModel *model))success
             failure:(void (^)(NSError *))failure{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [TransactionRecordsListModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:[kUserMessageManager getUserToken]?:@"" forKey:@"token"];
    [param setObject:[kUserMessageManager getUserToken]?:@"0" forKey:@"pageSize"];
    
    [manage postWithPath:path
                  params:param
         isNotEncryption:NO
             customClass:entity
                 success:^(TransactionRecordsListModel *model) {
                     
                     if (success) {
                         success(model);
                     }
                 } failure:^(NSError *error) {
                     failure(error);
                 }];
}

+ (void)orderGetDetailTypePath:(NSString *)path
                        params:(NSMutableDictionary *)params
                        target:(id)target
                       success:(void (^)(TransactionRecordsListModel * model))success
                       failure:(void (^)(NSError *))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [TransactionRecordsListModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:[kUserMessageManager getUserToken]?:@"" forKey:@"token"];
    [manage postWithPath:path
                  params:param
         isNotEncryption:NO
             customClass:entity
                 success:^(TransactionRecordsListModel *model) {
                     
                     if (success) {
                         success(model);
                     }
                 } failure:^(NSError *error) {
                     failure(error);
                 }];
}

+ (void)listOfItemsPath:(NSString *)path
                        params:(NSMutableDictionary *)params
                        target:(id)target
                       success:(void (^)(TransactionRecordsListModel * model))success
                       failure:(void (^)(NSError *))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [TransactionRecordsListModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:[kUserMessageManager getUserToken]?:@"" forKey:@"token"];
    [manage postWithPath:path
                  params:param
         isNotEncryption:NO
             customClass:entity
                 success:^(TransactionRecordsListModel *model) {
                     
                     if (success) {
                         success(model);
                     }
                 } failure:^(NSError *error) {
                     failure(error);
                 }];
}

+ (void)investmentListDetailsPath:(NSString *)path
                           params:(NSMutableDictionary *)params
                           target:(id)target
                          success:(void (^)(TransactionRecordsListModel * model))success
                          failure:(void (^)(NSError *))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [TransactionRecordsListModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:[kUserMessageManager getUserToken]?:@"" forKey:@"token"];
    [manage postWithPath:path
                  params:param
         isNotEncryption:NO
             customClass:entity
                 success:^(TransactionRecordsListModel *model) {
                     
                     if (success) {
                         success(model);
                     }
                 } failure:^(NSError *error) {
                     failure(error);
                 }];
}

+ (void)checkTheDetailsPath:(NSString *)path
                           params:(NSMutableDictionary *)params
                           target:(id)target
                          success:(void (^)(TransactionRecordsListModel * model))success
                          failure:(void (^)(NSError *))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [TransactionRecordsListModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:[kUserMessageManager getUserToken]?:@"" forKey:@"token"];
    [manage postWithPath:path
                  params:param
         isNotEncryption:NO
             customClass:entity
                 success:^(TransactionRecordsListModel *model) {
                     
                     if (success) {
                         success(model);
                     }
                 } failure:^(NSError *error) {
                     failure(error);
                 }];
}

+ (void)InvestmentRecordPath:(NSString *)path
                      params:(NSMutableDictionary *)params
                      target:(id)target
                     success:(void (^)(TransactionRecordsListModel * model))success
                     failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [TransactionRecordsListModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:[kUserMessageManager getUserToken]?:@"" forKey:@"token"];
    [manage postWithPath:path
                  params:param
         isNotEncryption:NO
             customClass:entity
                 success:^(TransactionRecordsListModel *model) {
                     
                     if (success) {
                         success(model);
                     }
                 } failure:^(NSError *error) {
                     failure(error);
                 }];
}

+ (void)projectGetProductCheckDattumPath:(NSString *)path
                                  params:(NSMutableDictionary *)params
                                  target:(id)target
                                 success:(void (^)(TransactionRecordsListModel * model))success
                                 failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [TransactionRecordsListModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:[kUserMessageManager getUserToken]?:@"" forKey:@"token"];
    [manage postWithPath:path
                  params:param
         isNotEncryption:NO
             customClass:entity
                 success:^(TransactionRecordsListModel *model) {
                     
                     if (success) {
                         success(model);
                     }
                 } failure:^(NSError *error) {
                     failure(error);
                 }];
}

@end

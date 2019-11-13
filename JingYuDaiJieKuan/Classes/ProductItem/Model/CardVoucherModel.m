//
//  CardVoucherModel.m
//  JingYuDaiJieKuan
//
//  Created by air on 2018/4/10.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "CardVoucherModel.h"

@implementation CardVoucherModel


+ (void)cardVoucherListPath:(NSString *)path
                     params:(NSMutableDictionary *)params
                     target:(id)target
                    success:(void (^)(CardVoucherListModel * model))success
                    failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [CardVoucherListModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:[kUserMessageManager getUserToken]?:@"" forKey:@"token"];
    [manage postWithPath:path
                  params:param
         isNotEncryption:NO
             customClass:entity
                 success:^(CardVoucherListModel *model) {
                     
                     if (success) {
                         success(model);
                     }
                 } failure:^(NSError *error) {
                     failure(error);
                 }];
}

+ (void)useTheProductPath:(NSString *)path
                     params:(NSMutableDictionary *)params
                     target:(id)target
                    success:(void (^)(CardVoucherListModel * model))success
                    failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [CardVoucherListModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:[kUserMessageManager getUserToken]?:@"" forKey:@"token"];
    [manage postWithPath:path
                  params:param
         isNotEncryption:NO
             customClass:entity
                 success:^(CardVoucherListModel *model) {
                     
                     if (success) {
                         success(model);
                     }
                 } failure:^(NSError *error) {
                     failure(error);
                 }];
}



@end

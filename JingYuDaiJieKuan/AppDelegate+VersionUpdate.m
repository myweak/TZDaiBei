//
//  AppDelegate+VersionUpdate.m
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/4/2.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "AppDelegate+VersionUpdate.h"

@implementation AppDelegate (VersionUpdate)



-(void)requestUpdateVersionPath:(NSString *)path
                         params:(NSMutableDictionary *)params
                         target:(id)target
                        success:(void (^)(LnitialModel *model))success
                        failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [LnitialModel class];
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(LnitialModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)systemInitPath:(NSString *)path
                params:(NSMutableDictionary *)params
                target:(id)target
               success:(void (^)(LnitialModel *model))success
               failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [LnitialModel class];
    
    [manage postWithPath:path params:params isNotEncryption:NO customClass:entity success:^(LnitialModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}


@end

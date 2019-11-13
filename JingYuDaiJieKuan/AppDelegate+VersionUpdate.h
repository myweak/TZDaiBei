//
//  AppDelegate+VersionUpdate.h
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/4/2.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "AppDelegate.h"
#import "LnitialModel.h"
@interface AppDelegate (VersionUpdate)

- (void)catchCrashLogs;
/**
 *  升级  --
 *  token
 */
-(void)requestUpdateVersionPath:(NSString *)path
                         params:(NSMutableDictionary *)params
                         target:(id)target
                        success:(void (^)(LnitialModel *model))success
                        failure:(void (^)(NSError *error))failure;

/**
 *  初始化  --
 *  token
 */
- (void)systemInitPath:(NSString *)path
                params:(NSMutableDictionary *)params
                target:(id)target
               success:(void (^)(LnitialModel *model))success
               failure:(void (^)(NSError *error))failure;
@end

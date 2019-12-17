//
//  UserViewModel.m
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/7/2.
//  Copyright © 2019 Jincaishen. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "UserViewModel.h"

@implementation UserViewModel

// /personal/center/snatch/gold/  抢金夺宝.明星产品-个人中心banner
+(void)personalCenterSnatchGoldPath:(NSString *)path
               params:(NSMutableDictionary *)params
               target:(id)target
              success:(void (^)(UserModel  *model))success
              failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [UserModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:aUser.token?:@"" forKey:@"token"];
    
    [manage postWithPath:path params:param isNotEncryption:NO customClass:entity success:^(UserModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// personal/center/hot/tools/  热门工具
+(void)personalCenterHotToolsPath:(NSString *)path
                           params:(NSMutableDictionary *)params
                           target:(id)target
                          success:(void (^)(HotToolListModel  *model))success
                          failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [HotToolListModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:aUser.token?:@"" forKey:@"token"];
    
    [manage postWithPath:path params:param isNotEncryption:NO customClass:entity success:^(HotToolListModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// /article/recommend/list  个人中心-贷款攻略文章列表接口(只返回前三条)
+(void)articleRecommendListPath:(NSString *)path
                         params:(NSMutableDictionary *)params
                         target:(id)target
                        success:(void (^)(UserModel  *model))success
                        failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [UserModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:aUser.token?:@"" forKey:@"token"];
    
    [manage postWithPath:path params:param isNotEncryption:NO customClass:entity success:^(UserModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// /user/logout   用户退出登录接口
+(void)userLogoutPath:(NSString *)path
               params:(NSMutableDictionary *)params
               target:(id)target
              success:(void (^)(UserModel  *model))success
              failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [UserModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:aUser.token?:@"" forKey:@"token"];
    
    [manage postWithPath:path params:param isNotEncryption:NO customClass:entity success:^(UserModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 关于我们
+(void)aboutUsInfoPath:(NSString *)path
                params:(NSMutableDictionary *)params
                target:(id)target
               success:(void (^)(UserModel  *model))success
               failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [UserModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:aUser.token?:@"" forKey:@"token"];
    
    [manage postWithPath:path params:param isNotEncryption:NO customClass:entity success:^(UserModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}
// 修改昵称
+(void)userUpdateNickNamePath:(NSString *)path
                       params:(NSMutableDictionary *)params
                       target:(id)target
                      success:(void (^)(UserModel  *model))success
                      failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [UserModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:aUser.token?:@"" forKey:@"token"];
    
    [manage postWithPath:path params:param isNotEncryption:NO customClass:entity success:^(UserModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 点赞
+(void)articleAddLikeNumPath:(NSString *)path
                      params:(NSMutableDictionary *)params
                      target:(id)target
                     success:(void (^)(UserModel  *model))success
                     failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [UserModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:aUser.token?:@"" forKey:@"token"];
    
    [manage postWithPath:path params:param isNotEncryption:NO customClass:entity success:^(UserModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 版本更新
+(void)appUpdatePath:(NSString *)path
            params:(NSMutableDictionary *)params
            target:(id)target
            success:(void (^)(AppUpdateModel  *model))success
            failure:(void (^)(NSError *error))failure;
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    /// 这个请求需要特殊处理,回调的时候在子线程
    manage.completionQueue = dispatch_queue_create("completion", DISPATCH_QUEUE_SERIAL);
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [AppUpdateModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:aUser.token?:@"" forKey:@"token"];
    
    [manage postWithPath:path params:param isNotEncryption:NO customClass:entity success:^(AppUpdateModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 查询商户状态(用于浏览记录)
+(void)checkMchStatusPath:(NSString *)path
              params:(NSMutableDictionary *)params
              target:(id)target
             success:(void (^)(CheckMchStatusModel  *model))success
             failure:(void (^)(NSError *error))failure;
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [CheckMchStatusModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:aUser.token?:@"" forKey:@"token"];
    
    [manage postWithPath:path params:param isNotEncryption:NO customClass:entity success:^(CheckMchStatusModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}


// 修改邮箱
+(void)userUpdateMailboxPath:(NSString *)path
                       params:(NSMutableDictionary *)params
                       target:(id)target
                      success:(void (^)(UserModel  *model))success
                      failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [UserModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:aUser.token?:@"" forKey:@"token"];
    
    [manage postWithPath:path params:param isNotEncryption:NO customClass:entity success:^(UserModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 修改 性别
+(void)userUpdateGenderPath:(NSString *)path
                       params:(NSMutableDictionary *)params
                       target:(id)target
                      success:(void (^)(UserModel  *model))success
                      failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [UserModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:aUser.token?:@"" forKey:@"token"];
    
    [manage postWithPath:path params:param isNotEncryption:NO customClass:entity success:^(UserModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 修改 学历
+(void)userUpdateEducationPath:(NSString *)path
                       params:(NSMutableDictionary *)params
                       target:(id)target
                      success:(void (^)(UserModel  *model))success
                      failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [UserModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:aUser.token?:@"" forKey:@"token"];
    
    [manage postWithPath:path params:param isNotEncryption:NO customClass:entity success:^(UserModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end




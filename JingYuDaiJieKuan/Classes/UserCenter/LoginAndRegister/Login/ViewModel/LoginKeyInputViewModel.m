//
//  LoginKeyInputViewModel.m
//  JingYuDaiJieKuan
//
//  Created by JY on 2019/6/4.
//  Copyright © 2019年 Jincaishen. All rights reserved.
//

#import "LoginKeyInputViewModel.h"

@implementation LoginKeyInputViewModel

// user/login  用户登录接口
+ (void)userLoginPath:(NSString *)path
                params:(NSMutableDictionary *)params
                target:(id)target
               success:(void (^)(LoginModel *model))success
               failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [LoginModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:[kUserMessageManager getUserToken]?:@"" forKey:@"token"];
    
    [manage postWithPath:path params:param isNotEncryption:NO customClass:entity success:^(LoginModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

///sms/send/code  发送短信验证码接口，开发和测试环境不真实发送，默认为6个6
+(void)smsSendCodePath:(NSString *)path
                params:(NSMutableDictionary *)params
                target:(id)target
               success:(void (^)(LoginModel  *model))success
               failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [LoginModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:[kUserMessageManager getUserToken]?:@"" forKey:@"token"];
    
    [manage postWithPath:path params:param isNotEncryption:NO customClass:entity success:^(LoginModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+(void)loginBannerPath:(NSString *)path
                params:(NSMutableDictionary *)params
                target:(id)target
               success:(void (^)(LoginBannerModel  *model))success
               failure:(void (^)(NSError *error))failure
{
    HttpManager *manage = [[HttpManager alloc]init];
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.responseObject = [LoginBannerModel class];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    [param setObject:[kUserMessageManager getUserToken]?:@"" forKey:@"token"];
    
    [manage postWithPath:path params:param isNotEncryption:NO customClass:entity success:^(LoginBannerModel *model) {
        success(model);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end

//
//  UserAPIParameter.m
//  JingYuDaiJieKuan
//
//  Created by JY on 2019/6/4.
//  Copyright © 2019年 Jincaishen. All rights reserved.
//

#import "UserAPIParameter.h"
#import "CheckLoginKeyModel.h"

@implementation UserAPIParameter

+ (HttpPropertyEntity *)checkLoginKeyWithTel:(NSString *)tel password:(NSString *)password loginType:(NSString *)loginType
{    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.requestApi = kNetUser_user_login;
    entity.requestType = 1;
    entity.param = @{@"mobile":tel, @"code":password, @"type":loginType,@"method":kNetUser_user_login,@"login_type":@"1"};
    DLog(@"param===%@",entity.param);
    entity.responseObject = [CheckLoginKeyModel class];
    return entity;
}

+ (HttpPropertyEntity *)SendMessageYzmWithTel:(NSString *)tel kw:(NSString *)kw
{
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.requestApi = kNetUser_sms_send;
    entity.requestType = 1;
    entity.param = @{@"mobile":tel, @"key":kw,@"method":kNetUser_sms_send};
    DLog(@"param===%@",entity.param);
    entity.responseObject = [HttpResultModel class];
    return entity;
    
}

+ (HttpPropertyEntity *)smsVerifyWithTel:(NSString *)tel key:(NSString *)key code:(NSString *)code{
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.requestApi = kNetUser_sms_verify;
    entity.requestType = 1;
    entity.param = @{@"mobile":tel, @"key":key,@"code":code,@"method":kNetUser_sms_verify};
    DLog(@"param===%@",entity.param);
    entity.responseObject = [CheckLoginKeyModel class];
    return entity;
}

+ (HttpPropertyEntity *)userRegisterWithTel:(NSString *)tel password:(NSString *)password code:(NSString *)code{
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.requestApi = kNetUser_register;
    entity.requestType = 1;
    entity.param = @{@"mobile":tel, @"password":password,@"code":code,@"method":kNetUser_register};
    DLog(@"param===%@",entity.param);
    entity.responseObject = [CheckLoginKeyModel class];
    return entity;
}

@end

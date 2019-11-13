//
//  LoginKeyInputViewModel.h
//  JingYuDaiJieKuan
//
//  Created by JY on 2019/6/4.
//  Copyright © 2019年 Jincaishen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"


@interface LoginKeyInputViewModel : NSObject


// /user/login  用户登录接口
+(void)userLoginPath:(NSString *)path
               params:(NSMutableDictionary *)params
               target:(id)target
              success:(void (^)(LoginModel  *model))success
              failure:(void (^)(NSError *error))failure;

///sms/send/code  发送短信验证码接口，开发和测试环境不真实发送，默认为6个6
+(void)smsSendCodePath:(NSString *)path
              params:(NSMutableDictionary *)params
              target:(id)target
             success:(void (^)(LoginModel  *model))success
             failure:(void (^)(NSError *error))failure;


/// 登录页面Banner
+(void)loginBannerPath:(NSString *)path
                params:(NSMutableDictionary *)params
                target:(id)target
               success:(void (^)(LoginBannerModel  *model))success
               failure:(void (^)(NSError *error))failure;


@end



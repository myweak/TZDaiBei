//
//  UserAPIParameter.h
//  JingYuDaiJieKuan
//
//  Created by JY on 2019/6/4.
//  Copyright © 2019年 Jincaishen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserAPIParameter : NSObject
/**
 *  验证登录密码
 *  tel 电话号
 *  password 登录密码
 *  equipment_number
 *  use_terminal  @“ios”
 *  device_token  友盟 token
 */
+ (HttpPropertyEntity *)checkLoginKeyWithTel:(NSString *)tel password:(NSString *)password loginType:(NSString *)loginType;

/**
 *  发送短信验证码
 *  tel 电话号
 *  kw 验证码类型
 */
+ (HttpPropertyEntity *)SendMessageYzmWithTel:(NSString *)tel kw:(NSString *)kw;

/**
 *  短信验证
 *  tel 电话号
 *  key 验证码类型
 *  code 验证码
 */
+ (HttpPropertyEntity *)smsVerifyWithTel:(NSString *)tel key:(NSString *)key code:(NSString *)code;

/**
 *  短信验证
 *  tel 电话号
 *  password 密码
 *  code 验证码
 */
+ (HttpPropertyEntity *)userRegisterWithTel:(NSString *)tel password:(NSString *)password code:(NSString *)code;

/**
 *  登录  UserLoginWithSuccess
 */
+ (HttpPropertyEntity *)UserLoginWithTel:(NSString *)tel password:(NSString *)password code:(NSString *)code;



@end

NS_ASSUME_NONNULL_END

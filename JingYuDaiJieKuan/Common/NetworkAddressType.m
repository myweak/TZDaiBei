//
//  NetworkAddressType.m
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/22.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "NetworkAddressType.h"

@implementation NetworkAddressType

// 请求环境配置
+(NSString *)configureRequestBaseURLType:(NSString *)requestType
{
    NSUserDefaults *userDefault  = [NSUserDefaults standardUserDefaults];
    NSString *baseUrl = [userDefault objectForKey:@"NetworkEnvironmentType"];
    
    if (baseUrl) {
        return baseUrl;
    }else{
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"NetworkEnvironment" ofType:@"plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
        NSString *baseDefaultUrl = [dic objectForKey:requestType];
        [userDefault setObject:baseDefaultUrl?:@"" forKey:requestType];
        [userDefault synchronize];
        return baseDefaultUrl?:@"";
    }
}
@end

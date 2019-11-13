//
//  UserHelper.m
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/20.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "UserHelper.h"
#import <SAMKeychain.h>

#define kJYDSSToolkitServiceName @"JingYuDaiJieKuanUser"

@implementation UserHelper

+ (NSString *)getPasswordWithAccount:(NSString *)account
{
    NSString *pass = [SAMKeychain passwordForService:kJYDSSToolkitServiceName account:account];
    return pass;
}

+ (void)setPassword:(NSString *)password
        withAccount:(NSString *)account
{
    if (!account) {
        return;
    }
    if (!password) {
        [SAMKeychain deletePasswordForService:kJYDSSToolkitServiceName account:account];
    }else{
        [SAMKeychain setPassword:password forService:kJYDSSToolkitServiceName account:account];
    }
}

+(void)fetchPasswordState:(NSString *)account
{
    NSError *error = nil;
    SAMKeychainQuery *query = [[SAMKeychainQuery alloc] init];
    query.service = kJYDSSToolkitServiceName;
    query.account = account;
    [query fetch:&error];
    
    if ([error code] == errSecItemNotFound) {
        DLog(@"Password not found");
    } else if (error != nil) {
        DLog(@"Some other error occurred: %@", [error localizedDescription]);
    }else{
        DLog(@"save success");
    }
}

@end

//
//  UserHelper.h
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/20.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserHelper : NSObject

+ (NSString *)getPasswordWithAccount:(NSString *)account;

+ (void)setPassword:(NSString *)password
        withAccount:(NSString *)account;

+(void)fetchPasswordState:(NSString *)account;

@end

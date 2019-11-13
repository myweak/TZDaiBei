//
//  DataManager.m
//  CarpFinancial
//
//  Created by weibin on 15/12/11.
//  Copyright © 2015年 cwb. All rights reserved.
//

#import "DataManager.h"
#import "UserHelper.h"

@implementation DataManager

+ (DataManager *)sharedManager
{
    static DataManager *sharedManager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [[DataManager alloc] init];
        assert(sharedManager != nil);
    });
    
    return sharedManager;
}

+ (void)load
{
//    [self createListTable];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _myQueue = dispatch_queue_create("myQueue", NULL);
        _modelQueue = dispatch_queue_create("modelQueue", NULL);
        _mainQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _codeLock = [[NSLock alloc] init];
    }

    return self;
}
//登录成功保存密码
- (void)loginSucceed
{
    [DataManager sharedManager].isLogin = YES;
//    [UserHelper setPassword:@"1234567890" withAccount:@"qwert"];
//    NSString *string = [UserHelper getPasswordWithAccount:@"qwert"];
    
}
// 退出帐号
- (void)logOut
{
    [DataManager sharedManager].isLogin = NO;
}
@end

//
//  NetworkReachability.m
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/4/19.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "NetworkReachability.h"
#import "Reachability.h"

@interface NetworkReachability ()
{
    Reachability *_hostReach;
    NetworkStatus _status;
}

@end
@implementation NetworkReachability

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (id)sharedInstance
{
    static Reachability *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (void)startObserve
{
    // 监测网络情况
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    _hostReach = [Reachability reachabilityWithHostName:@"https://www.baidu.com"];
    [_hostReach startNotifier];
}

- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    _status = [curReach currentReachabilityStatus];
    DLog(@"_status = %ld",_status);
}

// Wi-Fi是否可用
+ (BOOL)isEnableWiFi
{
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}

// 3G是否可用
+ (BOOL)isEnable3G
{
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}

// 网络是否能够连接
- (BOOL)isConnectable
{
    return _status != NotReachable;
}

// 是否是Wi-Fi连接
- (BOOL)isWiFi
{
    DLog(@" iswifi _status = %ld",_status);
    return _status == ReachableViaWiFi;
}

// 是否通过3g/gprs网络
- (BOOL)is3G
{
    DLog(@" is3G _status = %ld",_status);
    return _status == ReachableViaWWAN;
}


@end

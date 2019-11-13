//
//  NetworkReachability.h
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/4/19.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NetworkReachability : NSObject

+ (id)sharedInstance;

// Wi-Fi是否可用
+ (BOOL)isEnableWiFi;

// 3G是否可用
+ (BOOL)isEnable3G;

// 启动监听
- (void)startObserve;

// 网络是否能够连接
- (BOOL)isConnectable;

// 是否是Wi-Fi连接
- (BOOL)isWiFi;

// 是否通过3g/gprs网络
- (BOOL)is3G;

@end

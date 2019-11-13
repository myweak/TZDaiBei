//
//  NotificationManager.m
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/19.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "NotificationManager.h"

@implementation NotificationManager

#pragma mark 添加通知
-(void)pushNotificationWithName:(NSString *)name
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:nil];
}
-(void)pushNotificationWithName:(NSString *)name userInfo:(NSDictionary *)userInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:userInfo];
}
//添加一个通知
-(void)addNotificationWithSelector:(SEL)selector name:(NSString *)name
{
    //信息同步返回
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:selector
                                                 name:name
                                               object:nil];
}
//移除一个通知
-(void)removeNotificationWithName:(NSString *)name
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:name
                                                  object:nil];
}


@end

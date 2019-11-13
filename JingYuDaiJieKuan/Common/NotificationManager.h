//
//  NotificationManager.h
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/19.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationManager : NSObject

/**
 *  添加一个通知
 */
-(void)addNotificationWithSelector:(SEL)selector name:(NSString *)name;
/**
 *  移除一个通知
 */
-(void)removeNotificationWithName:(NSString *)name;
/**
 *  发出一个通知
 */

-(void)pushNotificationWithName:(NSString *)name;

-(void)pushNotificationWithName:(NSString *)name userInfo:(NSDictionary *)userInfo;

@end

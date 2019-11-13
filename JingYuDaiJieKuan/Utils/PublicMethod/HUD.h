//
//  HUD.h
//  OhMyBaby
//
//  Created by JPlay on 14-8-22.
//  Copyright (c) 2014年 JPlay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HUD : NSObject
+(HUD *)ShareInstance;
+(void)showHUDInViewPWD:(UIView *)view title:(NSString *)title;
+(void)showHUDInView:(UIView *)view title:(NSString *)title;
+(void)hideHUDInView;
+(void)hideHUDInView:(UIView *)view;

+(void)showNetWorkErrorInView:(UIView *)view;

+(void)showMessageInView:(UIView *)view title:(NSString *)title;

+(void)showMessageInView:(UIView *)view title:(NSString *)title time:(int)time;

+(void)showHUDInViewInView:(UIView *)view title:(NSString *)title;

@end

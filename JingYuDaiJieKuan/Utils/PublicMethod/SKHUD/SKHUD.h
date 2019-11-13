//
//  HUD.h
//  hudDemo
//
//  Created by linshaokai on 2016/9/30.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SKHUD : UIView
//显示消息提示
+ (void)showMessageInView:(UIView *)view  withMessage:(NSString *)message;
+ (void)showMessageInWindowWithMessage:(NSString *)message;
//显示网络失败
+ (void)showNetworkErrorMessageInView:(UIView *)view;
//默认的网络加载框  小菊花
+ (void)showLoadingDefaultInView:(UIView *)view;
+ (void)showLoadingDefaultInWindow;

//图片的网络加载框  注意：图片上的动画要自己➕
+ (void)showLoadingImageInView:(UIView *)view;
+ (void)showLoadingImageInView:(UIView *)view withMessage:(NSString*)message;
+ (void)showLoadingImageInWindow;
+ (void)showLoadingImageInWindowWithMessage:(NSString *)message;
+ (void)showLoadingImageClearBgInView:(UIView *)view withMessage:(NSString*)message;

//gif图片的网络加载框  注意：图片上的动画要自己➕
+ (void)showLoadingGifInView:(UIView *)view;
+ (void)showLoadingGifInWindow;

//点的网络加载框
+ (void)showLoadingDotInView:(UIView *)view;
+ (void)showLoadingDotInWindow;
+(void)showLoadingDotInView:(UIView *)view withMessage:(NSString*)message;
+ (void)showLoadingDotInWindowWithMessage:(NSString *)message;
//取消加载框
+ (void)dismiss;




@end

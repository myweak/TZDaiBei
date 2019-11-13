//
//  ZXShowView.h
//  ZXNews
//
//  Created by HHL on 16/4/19.
//  Copyright © 2016年 PLQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXAlertView : UIView
+ (ZXAlertView *)shareView;
/**
 带有标题的提示框 透明度 0.6
 */
- (void)showTitle:(NSString *)title message:(NSString *)message;

/**
 不带标题的提示框 透明度 0.0f
 */
- (void)showMessage:(NSString *)message;
/**
 标题和内容都在中间展示 两行
 */
- (void)showCenterTitle:(NSString *)title message:(NSString *)message;

- (void)successStatus;
@end

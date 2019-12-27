//
//  TZShowAlertView.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/10/31.
//  Copyright © 2019 Jincaishen. All rights reserved.
//
typedef void (^ButtonActonBlock)(NSInteger buttonIndex);

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TZShowAlertView : UIView
@property (nonatomic ,strong) UILabel  * contentLabel;    // 内容

@property (nonatomic, copy) ButtonActonBlock buttonActonBlock;
@property (nonatomic, assign) BOOL isShowAnimate; // 是否显示动画 ， 默认NO
/**
 *  点击背景消失； 默认NO：不消失
 */
@property (nonatomic, assign) BOOL tapEnadle;

- (instancetype) initWithAlerTitle:(nullable NSString *)title
                       ContentView:(UIView *)contentView;

- (instancetype) showNotNetWorkViewWithBlock:(void(^)(void)) block;

/*!
 @brief     初始化视图  - 常规弹窗
 
 @param     title       标题
 @param     content     内容
 @param     buttonArrays 确定按钮数组
 @param     alertButtonBlock  点击回调事件
 */
- (instancetype) initWithAlerTitle:(nullable NSString *)title
                           Content:(NSString *)content
                       buttonArray:(NSArray *)buttonArrays
                   blueButtonIndex:(NSInteger) buttonIndex
                  alertButtonBlock:(ButtonActonBlock)alertButtonBlock;

/*!
@brief     初始化视图  - View弹窗

@param     title       标题
@param     contentView     内容View
@param     buttonArrays 确定按钮数组
@param     alertButtonBlock  点击回调事件
*/
- (instancetype) initWithAlerTitle:(nullable NSString *)title
                       ContentView:(UIView *)contentView
                       buttonArray:(NSArray *)buttonArrays
                   blueButtonIndex:(NSInteger) buttonIndex
                  alertButtonBlock:(nullable ButtonActonBlock)alertButtonBlock;

- (void)show;
- (void)disMiss;
@end

NS_ASSUME_NONNULL_END

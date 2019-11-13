//
//  SuperVC.h
//  CarpFinancial
//
//  Created by weibin on 15/12/11.
//  Copyright © 2015年 cwb. All rights reserved.
//

//typedef enum : NSUInteger
//{
//    NavDefaultType = 1,              //默认白色类型
//    NavRedType = 2,                  //红色导航栏
//    NavGreenType = 3,                //绿色导航栏
//    NavClearType = 4,                //透明导航栏
//    NavErrorType = 5,                //错误导航栏
//    NavMidClearType = 6,             //半透明导航栏
//}NavType;

#import <UIKit/UIKit.h>
#import "UIBarButtonItem+Extend.h"
#import "UIViewController+Extend.h"
#import <UINavigationController+FDFullscreenPopGesture.h>


@interface SuperVC : UIViewController

@property (nonatomic, strong) NSMutableArray *networkOperations;
@property (nonatomic, assign) BOOL isBackSuperView;
@property (nonatomic, strong) NSString *youMengTitle;
@property (nonatomic, strong) UITapGestureRecognizer  *tap;      //添加手势用于点击空白处收回键盘

/// 设置导航栏样式
//+ (void)setNavigationStyle:(UINavigationController *)nav navType:(NavType)type;


/**
 *  删除导航栏下的1px的线
 *
 *  @param color 要设置的颜色
 */
-(void)deletedNaviUnderLine:(UIColor *)color;
-(void)changeNavigationBackColor;
-(void)changeNaviDefault;

//添加返回按钮事件
-(void)backClick;

-(void)addNavigationBackButton;
//添加返回首页事件
-(void)backPopClick;
-(void)addNavigationFinishButton;
-(void)addNavigationBackButtonForPop;
/**
 *  添加导行条左边按钮
 */
-(void)addLeftButton:(NSString *)imageName seletedImage:(NSString *)seletedImage title:(NSString *)title target:(id)target action:(SEL)action;
/**
 *  添加导行条右边按钮
 *
 */

-(void)addRightButton:(NSString *)imageName seletedIamge:(NSString *)seletedImage title:(NSString *)title target:(id)target action:(SEL)action;

/// 设置导航栏样式
//+ (void)setNavigationStyle:(UINavigationController *)nav navType:(NavType)type;

/** 添加返回按钮 */
- (UIButton *)addBackButton;
// 设置导航栏左按钮
- (UIBarButtonItem *)barBackButton;

- (UIBarButtonItem *)barBackWhiteButton;

/// 设置导航栏右按钮
+ (UIBarButtonItem *)rightBarButtonWithName:(NSString *)name
                                  imageName:(NSString *)imageName
                                     target:(id)target
                                     action:(SEL)action;

// 设置导航栏右按钮
+ (UIBarButtonItem *)rightBarWhiteFontWithName:(NSString *)name
                                     imageName:(NSString *)imageName
                                        target:(id)target
                                        action:(SEL)action;
/// 返回上层视图方法
- (void)backToSuperView;

#pragma mark - 网络

/// 开始加载
-(void)loadingDataStart;

/// 加载成功
-(void)loadingDataSuccess;

/// 加载失败
-(void)loadingDataFail;

/// 没有内容
-(void)loadingDataBlank;

/// 刷新代理方法
-(void)refreshClick;

/// 判断登录
- (void)loginVerifySuccess:(void (^)(void))success;

//创建键盘通知并添加手势（功能：点击空白处键盘收回）
- (void)textFieldReturn;

//销毁键盘弹出通知
- (void)deallocTextFieldNSNotification;

/// 添加网络操作，便于释放
//- (void)addNet:(AFHTTPSessionManager *)net;

/// 释放网络
- (void)releaseNet;

/// 抖动效果
-(void)shakeAnimationByView:(UIView*)view;

/// 加载头部
- (void)loadHeadView;

- (void)keyboardWillShow:(NSNotification*)notification;
//键盘收回移除手势

- (void)keyboardWillHide:(NSNotification*)notification;

//收回键盘
- (void)keyboardHidden;

// 停止加载头部动画
- (void)stopCPHeadAnimation;

/// 抖动效果
-(void)shakeAnimationByView:(UIView*)view;

@end

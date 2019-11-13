//
//  QHCountDownBtn.h
//  Cunpiao
//
//  Created by 陈启航 on 2016/12/6.
//  Copyright © 2016年 cwb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QHCountDownBtn : UIButton

@property (nonatomic, copy) NSString *normalTitle;  // default is @“验证”
@property (nonatomic, assign) NSInteger time;       // 倒计时时间 default is 60s

@property (nonatomic, strong) CAShapeLayer *m_layer;

/// 正在计算
@property (nonatomic,assign)NSInteger isStaring;
@property (nonatomic, copy)NSString * sendTitle;
@property (nonatomic, strong)NSString *againTitle;

@property (nonatomic, copy) void (^buttonClickedBlock)(void);  //点击按钮回调
@property (nonatomic, copy) void (^countdownClickedBlock)(void);  //倒计时

/**
 @brief  构造倒计时按钮       正常（未开始倒计时）  send（开始倒计时）
 @param title           正常时标题
 @param font      字体大小
 @param titleColor    字体颜色
 @param backgroundColor   按钮背景色
 @param layerWidth 正常时 按钮边宽
 @param layerColor    正常时按钮边框颜色
 @param layerCornerRadius  正常时圆角半径
 @param sendTitle           倒计时标题
 @param sendTitleColor    倒计时字体颜色
 @param sendBackgroundColor   倒计时按钮背景色
 @param sendLayerWidth 倒计时按钮边宽
 @param sendLayerColor    倒计时按钮边框颜色
 @param sendLayerCornerRadius 倒计时圆角半径    这个其实可有可无  放着吧 万一哪天产品脑洞大开呢
 @param againTitle 倒计时过期标题
 @param isShowSeconds 是否显示读秒 S
 */
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor layerWidth:(CGFloat )layerWidth layerColor:(UIColor *)layerColor layerCornerRadius:(CGFloat )layerCornerRadius sendTitle:(NSString *)sendTitle sendTitleColor:(UIColor *)sendTitleColor sendBackgroundColor:(UIColor *)sendBackgroundColor sendLayerWidth:(CGFloat)sendLayerWidth sendLayerColor:(UIColor *)sendLayerColor sendLayerCornerRadius:(CGFloat )sendLayerCornerRadius againTitle:(NSString *)againTitle isShowSeconds:(BOOL)isShowSeconds  showhHidden:(BOOL)showHidde time:(NSInteger)time;

// 倒计时一般过程 showActivity(网络请求)->start(请求完成)->stop(停止计时)
- (void)start;
- (void)stop;
- (void)showActivity;

/************** 用法 *************************
 
 // 获取短信验证码
 - (void)getValidateCode
 {
 _reSentButton.time = 10;
 
 // 1 网络请求将要开始，设置网络请求状态
 [_reSentButton showActivity];
 
 // 2 请求网络
 //模拟网络请求 3秒
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 #if 1
 // 2.1 请求成功
 [_reSentButton start];
 #else
 // 2.2 请求失败
 [_reSentButton stop];
 #endif
 });
 }
 **************************************/


@end

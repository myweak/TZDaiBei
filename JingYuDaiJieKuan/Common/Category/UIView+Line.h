//
//  UIView+Line.h
//  MiZi
//
//  Created by Simple on 2018/7/16.
//  Copyright © 2018年 Simple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void (^TapBlock)(CGPoint loc,UIGestureRecognizer *tapGesture);

@interface UIView (Line)
// 上
- (void)addLine_top;
// 下
- (void)addLine_bottom;
// 左
- (void)addLine_left;
// 右
- (void)addLine_right;

//画线
- (void)addLine:(CGRect)frame;
- (void)addLineWithFrame:(CGRect)frame color:(UIColor *)color;

// 添加1pt的边框
-(void)addLindeBorderWithColor:(UIColor *)color andRadius:(CGFloat)Radius;

// tap View -------------------------------------
- (void)handleTap:(TapBlock)tapBlock;

- (void)handleTap:(TapBlock)tapBlock delegate:(id)delegate;

- (void)handleLongTap:(TapBlock)tapBlock;

- (void)removeAllGestures;

- (void)cellSetZeroInsets;

/**
 全方位 切圆角

 @param cornerRadius 圆角
 @param rectCorner 圆角方位
 */
- (void)lx_BezierPathWithCornerRadius:(CGFloat)cornerRadius rectCorner:(UIRectCorner) rectCorner;
@end

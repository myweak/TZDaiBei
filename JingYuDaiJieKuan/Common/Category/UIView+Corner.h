//
//  UIView+Corner.h
//  KinHop
//
//  Created by weibin on 14/11/25.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Corner)

- (void)setRoundingCornerWithCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

/**
 设置边框
 
 @param color 颜色
 @param width 边框宽度
 */
- (void)setBorderColor:(UIColor *)color width:(CGFloat)width;


/**
 设置view的圆角
 
 @param radius 圆角半径
 */
- (void)setCornerRadius:(CGFloat)radius;

// 添加底部按钮
- (UIButton *)addBottomTapButtonTitleStr:(NSString *)title block:(void (^)(UIButton *btn)) block;

@end

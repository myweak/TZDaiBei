//
//  UIView+Corner.m
//  KinHop
//
//  Created by weibin on 14/11/25.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "UIView+Corner.h"

@implementation UIView (Corner)

- (void)setRoundingCornerWithCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)setBorderColor:(UIColor *)color width:(CGFloat)width {
    [self.layer setBorderWidth:width];
    [self.layer setBorderColor:color.CGColor];
    /*****注释:锯齿*****/
    self.layer.allowsEdgeAntialiasing = YES;
}

- (void)setCornerRadius:(CGFloat)radius {
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:radius];
}

- (UIButton *)addBottomTapButtonTitleStr:(NSString *)title block:(void (^)(UIButton *btn)) block
{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, kScreenHeight - 44 - kNavBarH- iPhoneXDiffHeight()*2, kScreenWidth, 44 +iPhoneXDiffHeight()*2);
    btn.backgroundColor = Bg_Btn_Colorblue;
    btn.titleLabel.font = kFontSize18;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn handleTap:^(CGPoint loc, UIGestureRecognizer *tapGesture) {
        !block ?:block(btn);
    }];
    [self addSubview:btn];
    return btn;
}


@end

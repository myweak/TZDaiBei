//
//  ZXShowView.m
//  ZXNews
//
//  Created by HHL on 16/4/19.
//  Copyright © 2016年 PLQ. All rights reserved.
//

#import "ZXAlertView.h"
#import "UILabel+WLAttributedString.h"
@interface ZXAlertView ()
@property (nonatomic, strong) UIView    *showView;
@property (nonatomic, strong) UILabel   *titleLab;
@property (nonatomic, strong) UILabel   *detailLab;
@end

@implementation ZXAlertView
+ (ZXAlertView *)shareView
{
    UIView *window = [UIApplication sharedApplication].keyWindow;
    return [[self alloc] initWithFrame:window.bounds];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    UIView *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
}

- (void)successStatus {
    [self show:0.5];
    [self addSubview:self.showView];
    self.showView.width = AutoWHGetWidth(250);
    self.showView.height = AutoWHGetWidth(120);
    self.showView.center = CGPointMake(kScreenWidth/2, kAllHeight/2);
    [self.showView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.showView.backgroundColor = [UIColor whiteColor];

    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, kAWidth(19), kAWidth(45), kAWidth(45))];
    [self.showView addSubview:icon];
    icon.center = CGPointMake(self.showView.width/2, icon.center.y);
    icon.image = [UIImage imageNamed:@"cpreds"];
    
    [self.showView addSubview:self.titleLab];
    self.titleLab.text = @"分享成功";
    self.titleLab.textColor = UIColorHex(@"757575");
    self.titleLab.font = kFontSize14;
    self.titleLab.center = CGPointMake(self.showView.width/2, self.showView.center.y);
    self.titleLab.mj_y = icon.bottom + kAWidth(22);
    
    [self showAlertAnimation];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:3.0f];
    
}

- (void)showTitle:(NSString *)title message:(NSString *)message
{
    
    [self show:0.0];
    
    [self.showView addSubview:self.titleLab];
    [self.showView addSubview:self.detailLab];
    
    self.titleLab.text = title;
    self.detailLab.text = message;
    self.titleLab.text = title;
    self.detailLab.font = kFontSize13;
    [self.detailLab autoSizeVertical];
    self.showView.height = self.detailLab.bottom +12;
    self.showView.center = self.center;
    [self addSubview:self.showView];
    
    [self showAlertAnimation];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];
    
}
- (void)showCenterTitle:(NSString *)title message:(NSString *)message {
    [self show:0.0];
    
    [self.showView addSubview:self.titleLab];
    [self.showView addSubview:self.detailLab];
    
    self.titleLab.text = title;
    self.detailLab.text = message;
    self.titleLab.text = title;
    self.detailLab.font = kFontSize14;
    self.titleLab.font = kFontSize14;
    [self.detailLab autoSizeHorizontal];
    [self.titleLab autoSizeHorizontal];
    
    self.showView.width = MAX(self.detailLab.width, self.titleLab.width) + 20;
    self.titleLab.center = CGPointMake(self.showView.width/2, 15 + self.titleLab.height/2);
    self.detailLab.center = CGPointMake(self.showView.width/2, 0 );
    self.detailLab.mj_y = self.titleLab.bottom + 4;
    
    self.showView.height = self.detailLab.bottom +12;
    self.showView.center = self.center;
    self.showView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];;
    self.titleLab.textColor = [UIColor whiteColor];
    self.detailLab.textColor = [UIColor whiteColor];
    [self addSubview:self.showView];
    [self showAlertAnimation];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];

}
- (void)showMessage:(NSString *)message
{
     [self.titleLab removeFromSuperview];
    
//    if (![message isValid]) {
//        message = @"请求数据异常";
//    }
    [self show:0.0];
    self.titleLab.font = kFontSize15;
    self.titleLab.text = message;
    [self.titleLab autoSizeVertical];
    self.showView.width = AutoWHGetWidth(150);
    [self.titleLab autoSizeHorizontal];
    
    if (self.titleLab.width > AutoWHGetWidth(270)) {
        self.titleLab.width = AutoWHGetWidth(270);
        self.titleLab.numberOfLines = 0;
        [self.titleLab autoSizeVertical];
        self.showView.height = self.titleLab.height+40;
    }else{
        self.showView.height = AutoGetHeight(60);
    }
    
    self.showView.width = self.titleLab.width + 20;
    
    self.showView.center = self.center;
     self.titleLab.center = self.showView.center;
//    self.titleLab.width = AutoWHGetWidth(150) - 50;
    self.showView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.5];;
    self.titleLab.textColor = [UIColor whiteColor];
   
    [self.showView addSubview:self.titleLab];
    
   
    
    
    self.titleLab.numberOfLines = 2;
    self.titleLab.center = CGPointMake(self.showView.width/2, self.showView.height/2);
    [self addSubview:self.showView];
    [self showAlertAnimation];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:2];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}
//动画效果
- (void)showAlertAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)]];
    animation.keyTimes = @[ @0, @0.5, @1 ];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = .3; //时间
    
    [self.showView.layer addAnimation:animation forKey:@"showAlert"];
}
- (void)dismiss
{
    [self removeFromSuperview];
    [self.showView removeFromSuperview];
}
- (void)show:(CGFloat)alpha
{
    UIView *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
    [window addSubview:self];
}
- (UIView *)showView {
    if (!_showView) {
        _showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 220, 220)];
        _showView.backgroundColor = [UIColor whiteColor];
        _showView.layer.cornerRadius = 5;
        _showView.clipsToBounds = YES;
    }
    return _showView;
}
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, 200, 20)];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}
- (UILabel *)detailLab {
    if (!_detailLab) {
        _detailLab = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleLab.bottom+10, 200, 20)];
        _detailLab.numberOfLines = 0;
        _detailLab.textAlignment = NSTextAlignmentCenter;
    }
    return _detailLab;
}
@end

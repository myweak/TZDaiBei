//
//  LoadingView.m
//  ALLoadingView
//
//  Created by fireflies on 2018/4/11.
//  Copyright © 2018年 asm. All rights reserved.
//

#import "LoadingView.h"


static NSString * const kALAnimationKey = @"kALAnimationKey";

@interface LoadingView ()<CAAnimationDelegate>

@property(nonatomic, strong) CAShapeLayer *asmLayer;

@property(nonatomic, strong)CAGradientLayer *gradientLayer;
@end

@implementation LoadingView


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void) setup {
    self.loadingColor = [UIColor colorWithRed:61/255.0 green:133/255.0 blue:255/255.0 alpha:1.0];
    self.lineWidth = 6;
    self.radius  = 40;
}
#pragma mark - public

- (void)start {
    [self reset];
    [self loading];
}

#pragma mark - reset
- (void)reset {

    [self.layer removeAllAnimations];
}

- (void) loading {
    
    CABasicAnimation * anima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anima.fromValue = [NSNumber numberWithFloat:0.f];
    anima.toValue = [NSNumber numberWithFloat:0.5f];
    anima.duration = 2.0f;
    anima.repeatCount = MAXFLOAT;
    anima.autoreverses = YES;
    anima.removedOnCompletion = NO;
    self.asmLayer.strokeColor = self.loadingColor.CGColor;
    [self.asmLayer addAnimation:anima forKey:@"strokeEndAniamtion"];
    
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*2];
    anima3.duration = 1.0f;
    anima3.repeatCount = MAXFLOAT;
    [self.layer addAnimation:anima3 forKey:@"rotaionAniamtion"];
    
}

- (CAShapeLayer *)asmLayer {
    if (_asmLayer == nil) {
        
        _asmLayer = [CAShapeLayer layer];
        _asmLayer.frame = CGRectMake(0, 0, self.radius * 2 + self.lineWidth, self.radius * 2 + self.lineWidth);
        
        UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) radius:_asmLayer.bounds.size.width/2 startAngle:0 endAngle:2*M_PI clockwise:YES];
        
        //路径
        _asmLayer.path = path.CGPath;
        //填充色
        _asmLayer.fillColor = [UIColor clearColor].CGColor;
        // 设置线的颜色
        _asmLayer.strokeColor = self.loadingColor.CGColor;
        //线的宽度
        _asmLayer.lineWidth = self.lineWidth;
        [self.layer addSublayer:_asmLayer];
        
    }
    return _asmLayer;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

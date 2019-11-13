//
//  QHCountDownBtn.m
//  Cunpiao
//
//  Created by 陈启航 on 2016/12/6.
//  Copyright © 2016年 cwb. All rights reserved.
//

#import "QHCountDownBtn.h"
#define kDefaultTime 60
#define kDefaultNoramlTitle @"重新获取"

@interface QHCountDownBtn()<CAAnimationDelegate>
{
    NSString *_title;
    UIFont *_font;
    UIColor *_titleColor;
    UIColor *_backgroundColor;
    CGFloat _layerWidth;
    UIColor *_layerColor;
    CGFloat _layerCornerRadius;
    //    NSString *_sendTitle;
    UIColor *_sendTitleColor;
    UIColor *_sendBackgroundColor;
    CGFloat _sendLayerWidth;
    UIColor *_sendLayerColor;
    CGFloat _sendLayerCornerRadius;
    //    NSString *_againTitle;
    BOOL _isShowSeconds;
    NSInteger _timeNumber;
    
}
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIActivityIndicatorView *activity;
@property (nonatomic, strong) CABasicAnimation *m_animation;
@end

@implementation QHCountDownBtn

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor layerWidth:(CGFloat )layerWidth layerColor:(UIColor *)layerColor layerCornerRadius:(CGFloat )layerCornerRadius sendTitle:(NSString *)sendTitle sendTitleColor:(UIColor *)sendTitleColor sendBackgroundColor:(UIColor *)sendBackgroundColor sendLayerWidth:(CGFloat)sendLayerWidth sendLayerColor:(UIColor *)sendLayerColor sendLayerCornerRadius:(CGFloat )sendLayerCornerRadius againTitle:(NSString *)againTitle isShowSeconds:(BOOL)isShowSeconds  showhHidden:(BOOL)showHidde time:(NSInteger)time
{
    self = [super initWithFrame:frame];
    if (self) {
        _title = title;
        _font = font;
        _titleColor = titleColor;
        _backgroundColor = backgroundColor;
        _layerWidth = layerWidth;
        _layerColor = layerColor;
        _layerCornerRadius = layerCornerRadius;
        _sendTitle = sendTitle;
        _sendTitleColor = sendTitleColor;
        _sendBackgroundColor = sendBackgroundColor;
        _sendLayerWidth = sendLayerWidth;
        _sendLayerColor = sendLayerColor;
        _sendLayerCornerRadius = sendLayerCornerRadius;
        _againTitle = againTitle;
        _isShowSeconds = isShowSeconds;
        _timeNumber = time;
        
        [self initView];
        
    }
    return self;
}

- (void)initView
{
    self.titleLabel.font = kFontSize13;
    [self setTitleColor:_titleColor forState:UIControlStateNormal];
    [self setTitleColor:_sendTitleColor forState:UIControlStateDisabled];
    self.titleLabel.font = _font;
    [self setTitle:_title forState:UIControlStateNormal];
    [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self setBackgroundColor:_backgroundColor];
    self.layer.borderWidth = _layerWidth;
    self.layer.cornerRadius = _layerCornerRadius;
    self.layer.borderColor = _layerColor.CGColor;
    self.clipsToBounds = YES;
    //    NSString *strTime = [NSString stringWithFormat:@"%d后重试",kDefaultTime];
    //    self.time = [strTime integerValue];
    
    
}

- (void)setNormalTitle:(NSString *)normalTitle
{
    _normalTitle = normalTitle;
    [self setTitle:_normalTitle forState:UIControlStateNormal];
}

- (void)setTime:(NSInteger)time
{
    if (time > 0) {
        _time = time;
    }
}

- (void)buttonClick:(id)button
{
    if (_buttonClickedBlock) {
        _buttonClickedBlock();
    }
}

- (void)start
{
    //先画一个圆
    if (!self.m_layer) {
        CGRect rect = CGRectMake(iPhone5?kiP6WidthRace(4.5):kiP6WidthRace(2), kiP6WidthRace(2), kiP6WidthRace(25), kiP6WidthRace(25));
        
        UIBezierPath *beizPath=[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:kiP6WidthRace(25)];
        self.m_layer=[CAShapeLayer layer];
        _m_layer.path=beizPath.CGPath;
        _m_layer.fillColor=[UIColor clearColor].CGColor;//填充色
        _m_layer.strokeColor=UIColorHex(@"468cec").CGColor;//边框颜色
        _m_layer.lineWidth=1.0f;
        _m_layer.lineCap=kCALineCapRound;//线框类型
        _m_layer.hidden = YES;
        
        [self.layer addSublayer:_m_layer];
        
    }
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animation.fromValue=[NSNumber numberWithFloat:0.0f];
    animation.toValue=[NSNumber numberWithFloat:1];
    animation.duration= _timeNumber;
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [_m_layer addAnimation:animation forKey:@"strokeStartanimation"];
    self.m_animation = animation;
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    if ([_activity isAnimating]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_activity stopAnimating];
            [self setTitle:_normalTitle ? _normalTitle : kDefaultNoramlTitle forState:UIControlStateNormal];
        });
        
    }
    _time = _timeNumber;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_isShowSeconds) {
            [self setTitle:[NSString stringWithFormat:@"%@%lds", _sendTitle,(long)_time] forState:UIControlStateDisabled];
        }else
        {
            [self setTitle:[NSString stringWithFormat:@"%@%lds后重试", _sendTitle,(long)_time] forState:UIControlStateDisabled];//s后重试
        }
        self.backgroundColor = _sendBackgroundColor;
        self.layer.borderColor = _sendLayerColor.CGColor;
    });
    
    
    kSelfWeak;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        assert(weakSelf != nil);
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.enabled = NO;
        });
        
        weakSelf.timer =[NSTimer scheduledTimerWithTimeInterval:1.0
                                                         target:weakSelf
                                                       selector:@selector(timeAction:)
                                                       userInfo:nil
                                                        repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:weakSelf.timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    });
}

- (void)timeAction:(NSTimer *)timer
{
    --_time ;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_isShowSeconds) {
            [self setTitle:[NSString stringWithFormat:@"%@%lds", _sendTitle,(long)_time] forState:UIControlStateDisabled];
        }else
        {
            [self setTitle:[NSString stringWithFormat:@"%@%lds后重试", _sendTitle,(long)_time] forState:UIControlStateDisabled];//s后重试
        }
        
    });
    
    if (_time == 0) {
        self.m_layer.hidden = YES;
        [self stop];
        if (self.countdownClickedBlock) {
            self.countdownClickedBlock();
        }
    }
}

- (void)stop
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    self.m_layer.hidden = YES;
    if ([_activity isAnimating]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_activity stopAnimating];
            [self setTitle:_normalTitle ? _normalTitle : kDefaultNoramlTitle forState:UIControlStateNormal];
        });
        
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.enabled = YES;
        [self setTitle:_againTitle forState:UIControlStateNormal];
        [self setTitleColor:_titleColor forState:UIControlStateNormal];
        self.backgroundColor = _backgroundColor;
        self.layer.borderColor =[UIColor whiteColor].CGColor;// UIColorHex(@"0c72e3").CGColor;
        self.layer.borderWidth = 0.5;
    });
    
}

- (void)showActivity
{
    CGFloat h = 15;
    if (!_activity) {
        _activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((self.width - h)/ 2, (self.height - h)/2, h, h)];
        _activity.color = [UIColor grayColor];
        [self addSubview:_activity];
    }
    [self setTitle:nil forState:UIControlStateNormal];
    [self setTitle:nil forState:UIControlStateDisabled];
    self.enabled = NO;
    [_activity startAnimating];
}

@end

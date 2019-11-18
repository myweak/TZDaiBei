//
//  TZShowAlertView.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/10/31.
//  Copyright © 2019 Jincaishen. All rights reserved.
//
#define KAlphaViewBgColor [UIColor colorWithWhite:0 alpha:.6]
#define KContent_X   40.f
#define Kcontent_Top 123
#define KSelfAlert_W (self.width-KContent_X*2)
#define KAnimateDuration     0.25   //  弹框动画时间
#define Kbutton_H            49.f  //buttonArrays 按钮高度
#define SPACE                15.0f // 左边间隙

#import "TZShowAlertView.h"
#import "TZNotNetworkView.h" // 无网络View

@interface TZShowAlertView ()
@property (nonatomic ,strong) UILabel  * titleLabel;      // 标题
@property (nonatomic, strong) UIView   * alertView;
@property (nonatomic, strong) TZNotNetworkView *notNetWorkView;
@property (nonatomic, strong) UIButton *buttonArrays;     // 按钮数组
@property (nonatomic ,strong) UILabel  * contentLabel;    // 内容

@end
@implementation TZShowAlertView



- (instancetype) initWithAlerTitle:(NSString *)title
                           Content:(NSString *)content
                       buttonArray:(NSArray *)buttonArrays
                   blueButtonIndex:(NSInteger) buttonIndex
                  alertButtonBlock:(ButtonActonBlock)alertButtonBlock{
    
    if (self == [super init]) {
        self.buttonActonBlock = [alertButtonBlock copy];
        self.buttonArrays = [buttonArrays copy];
        self.frame = [[UIScreen mainScreen] bounds];
        self.backgroundColor = KAlphaViewBgColor;
        
        self.titleLabel.text   = title;
        self.contentLabel.text = content;
        
        CGFloat contentLabel_Y ;
        if (checkStrEmty(title)) {
            contentLabel_Y = 25;
            self.contentLabel.textColor = CP_ColorMBlack;
        }else{
            contentLabel_Y = self.titleLabel.bottom+5;
        }
        self.contentLabel.textAlignment = NSTextAlignmentCenter;
        self.contentLabel.numberOfLines = 0;
        CGRect frame = [self.contentLabel getLableHeightWithMaxWidth:self.contentLabel.width];
        self.contentLabel.frame = CGRectMake(SPACE, contentLabel_Y, self.alertView.width - 2*SPACE, frame.size.height);
        
        
        // 按钮布局
        UIView *buttonViewBg = [UIView new];
        buttonViewBg.userInteractionEnabled = YES;
        buttonViewBg.backgroundColor = [UIColor clearColor];
        CGFloat buttonViewBg_y = checkStrEmty(title) ? 20:20;
        buttonViewBg.frame = CGRectMake(0, self.contentLabel.bottom+buttonViewBg_y, self.alertView.width,(buttonArrays.count>=3 ? Kbutton_H *buttonArrays.count:Kbutton_H));
        buttonViewBg.clipsToBounds =YES;
        
        CGFloat Kbutton_W =  buttonViewBg.width /buttonArrays.count;
        for (int i =0; i<buttonArrays.count; i++) {
            
            UIButton *button = [[UIButton alloc] init];
            
            if (buttonArrays.count >=3) {
                [button setFrame:CGRectMake(0, i*(Kbutton_H), self.alertView.width, Kbutton_H)];
            }else{
                [button setFrame:CGRectMake(i*Kbutton_W, 0, Kbutton_W, Kbutton_H)];
            }
            
            [button setBackgroundColor:[UIColor clearColor]];
            [button setTitle:buttonArrays[i] forState:UIControlStateNormal];
            [button.titleLabel setFont:kFontSize17];
            [button setTag:i];
//            button.layer.cornerRadius = 5.0f;
            button.userInteractionEnabled =YES;
            [button addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
            
            UIColor *titleColor = nil;
            if (i == buttonIndex) {
                titleColor = [UIColor whiteColor] ;
                button.backgroundColor = Bg_Btn_Colorblue;
            } else {
                button.backgroundColor = [UIColor whiteColor];
                titleColor =  CP_ColorMBlack ;
            }
            [button setTitleColor:titleColor forState:UIControlStateNormal];
            [button setTitleColor:titleColor forState:UIControlStateHighlighted];
            
            // 加线
            [button addLine_top];
            // 中间线条
            if (buttonArrays.count > 1 && (i<buttonArrays.count-1) && buttonArrays.count < 3) {
                [button addLine_right];
            }
            
            [buttonViewBg addSubview:button];
        }
        
        [self.alertView addSubview:buttonViewBg];
        self.alertView.height = buttonViewBg.bottom;
        [self.alertView addSubview:self.titleLabel];
        [self.alertView addSubview:self.contentLabel];
        
        [self addSubview:self.alertView];
        
    }
    return self;
}


- (instancetype) initWithAlerTitle:(nullable NSString *)title
                       ContentView:(UIView *)contentView
{
    if (self == [super init]) {
        self.frame = [[UIScreen mainScreen] bounds];
        self.backgroundColor = KAlphaViewBgColor;
        
        // 标题设置
        //        CGFloat buttonViewBg_y = checkStrEmty(title) ? 20:10;
        [self.alertView addSubview:self.titleLabel];
        self.titleLabel.text   = title;
        if (checkStrEmty(title)) {
            self.titleLabel.hidden = YES;
            contentView.top = 0;
        }else{
            contentView.top = self.titleLabel.bottom;
        }
        
        // 定义 contentView
        self.alertView.bounds = contentView.bounds;
        self.alertView.height = contentView.bottom;
        [self.alertView addSubview:contentView];
        [self addSubview:self.alertView];
        
        self.titleLabel.width = self.alertView.width;

    }
    return self;
}


- (instancetype) showNotNetWorkViewWithBlock:(void(^)(void)) block{
    if (self == [super init]) {
        self.frame = [[UIScreen mainScreen] bounds];
        self.backgroundColor = KAlphaViewBgColor;
        [self addSubview:self.notNetWorkView];
        self.notNetWorkView.frame = [[UIScreen mainScreen] bounds];
        @weakify(self)
        [self.notNetWorkView.tapViewBg handleTap:^(CGPoint loc, UIGestureRecognizer *tapGesture) {
            @strongify(self)
            !block ? : block();
            [self disMiss];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIViewController visibleViewController].view addSubview:self];
        });
    }
    return self;
}


#pragma mark - 事件监听
- (void)buttonClickedAction:(UIButton *)sender {
    NSLog(@"%ld",sender.tag);
    @try {
        !self.buttonActonBlock ? : self.buttonActonBlock(sender.tag);
    }
    @catch (NSException *exception) {
        // do nothing
    }
    [self disMiss];
}

#pragma mark - UI

- (TZNotNetworkView *)notNetWorkView{
    if(!_notNetWorkView){
        _notNetWorkView = [[TZNotNetworkView alloc] init];
    }
    return _notNetWorkView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.alertView.width, 44)];
        _titleLabel.font = kFontSize15;
        _titleLabel.textColor = CP_ColorMBlack;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(SPACE,self.titleLabel.bottom+SPACE,self.alertView.width-2*SPACE,20)];
        _contentLabel.font = kFontSize12;
        _contentLabel.textColor = CP_ColorMBlack;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}
-(UIView *)alertView{
    if(!_alertView){
        CGFloat alertView_W = kScreenWidth - iPW(63)*2;
        CGFloat alertView_H = 216;
        _alertView = [[UIView alloc]init];
        _alertView.size = CGSizeMake(alertView_W, alertView_H);
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 5;
        _alertView.layer.masksToBounds = YES;
        _alertView.clipsToBounds = YES;
        _alertView.center = CGPointMake(kScreenWidth/2.f, kScreenHeight/2.0f );
    }
    return _alertView;
}


- (void)disMiss
{
    
    @weakify(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self)
        self.alpha = 1;
        self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        
        [UIView animateWithDuration:KAnimateDuration*2 animations:^{
            self.alpha = 0;
            self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.05, 0.01);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    });
}

- (void)show
{
    
     @weakify(self);
//    dispatch_async(dispatch_get_main_queue(), ^{
//        @strongify(self)

        [[UIViewController visibleViewController].tabBarController.view addSubview:self];

    self.alpha = 0;
        self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.01, 0.1);
        
        [UIView animateWithDuration:self.isShowAnimate? KAnimateDuration:0 animations:^{
            @strongify(self)
            self.alpha = 1;
            self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        }];
//    });
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = touches.anyObject;//获取触摸对象
    if ([touch.view isEqual:self.alertView]) {
        return;
    }
    if (self.tapEnadle) {
        [self disMiss];
    }
}
@end

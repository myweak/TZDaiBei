//
//  TZShowAlertView.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/10/31.
//  Copyright © 2019 Jincaishen. All rights reserved.
//
#define KAlphaViewBgColor [UIColor colorWithWhite:0 alpha:.6]
#define KAnimateDuration 0.25

#import "TZShowAlertView.h"
#import "TZNotNetworkView.h" // 无网络View

@interface TZShowAlertView ()
@property (nonatomic ,strong) UILabel  * titleLabel;      // 标题
@property (nonatomic, strong) UIView   * alertView;
@property (nonatomic, strong) TZNotNetworkView *notNetWorkView;

@end
@implementation TZShowAlertView

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


#pragma mark - UI

- (TZNotNetworkView *)notNetWorkView{
    if(!_notNetWorkView){
        _notNetWorkView = [[TZNotNetworkView alloc] init];
    }
    return _notNetWorkView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.alertView.width, 24)];
        _titleLabel.font = kFontSize14;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}
-(UIView *)alertView{
    if(!_alertView){
        CGFloat alertView_W = kScreenWidth - 15*2;
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


@end

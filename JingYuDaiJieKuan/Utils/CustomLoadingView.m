//
//  CustomLoadingView.m
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/4/11.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "CustomLoadingView.h"

@implementation JQDView

#pragma mark - Lifecycle

- (id)init {
    return [self initWithFrame:CGRectMake(0.f, 0.f, 37.f, 37.f)];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIImage *image = [YYImage imageNamed:@"loading.gif"];
        UIImageView *imgView = [[YYAnimatedImageView alloc]initWithFrame:self.bounds];
        imgView.image = image;
        imgView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:imgView];
    }
    return self;
}

#pragma mark - Layout

- (CGSize)intrinsicContentSize {
    return CGSizeMake(37.f, 37.f);
}

@end

@implementation CustomLoadingView

+(void)showLoadingView:(UIView *)baseView
{
    DLog(@"--show---");
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:baseView animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.customView = [[JQDView alloc]init];
    hud.customView.backgroundColor = [UIColor clearColor];
    // 修改 loading 背景图片颜色
//    hud.bezelView.backgroundColor = [UIColor redColor];
    
    // Looks a bit nicer if we make it square.
    hud.square = YES;
    //    hud.label.text = @"加载中...";
}

+(void)showLoadingView:(UIView *)baseView afterDelay:(CGFloat)delay
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:baseView animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.customView = [[JQDView alloc]init];
    hud.customView.backgroundColor = [UIColor clearColor];
    
    // Looks a bit nicer if we make it square.
    hud.square = YES;
//    hud.label.text = @"加载中...";
    
    [hud hideAnimated:YES afterDelay:delay];
}

+(void)hiddenLoadingView:(UIView *)baseView
{
//    for (MBProgressHUD *hud in baseView) {
// 一个 viewController 里面做两个网络请求,显示两个菊花,也调用了 ([MBProgressHUD hideHUDForView:baseView animated:YES];)最后菊花没消失,是咋解决的??
    
//    }
    DLog(@"--hide---");
    [MBProgressHUD hideHUDForView:baseView animated:YES];
}

/*
 AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
 mbProgressHUD = [MBProgressHUD showHUDAddedTo:delegate.window animated:YES];
 */
@end

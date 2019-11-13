//
//  HUDManager.m
//  USGOU
//
//  Created by weibin on 15/7/20.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "HUDManager.h"

// 定义变量
static MBProgressHUD *mbProgressHUD;

@implementation HUDManager

+ (void)showHUDWithMessage:(NSString *)aMessage
{
    [self showHUD:MBProgressHUDModeIndeterminate onTarget:nil hide:NO afterDelay:0 enabled:NO message:aMessage];
}

+ (void)showHUDWithMessage:(NSString *)aMessage onTarget:(UIView *)target
{
    [self showHUD:MBProgressHUDModeIndeterminate onTarget:target hide:NO afterDelay:0 enabled:NO message:aMessage];
}

+ (void)showHUD:(MBProgressHUDMode)mode hide:(BOOL)autoHide afterDelay:(NSTimeInterval)timeDelay enabled:(BOOL)autoEnabled message:(NSString *)aMessage
{
    [self showHUD:mode onTarget:nil hide:autoHide afterDelay:timeDelay enabled:autoHide message:aMessage];
}

/**
 @brief  完善加载视图
 @param mode        加载模式
 @param target      加载视图被添加到该视图上, 如果target=nil,则被添加到window上
 @param autoHide    是否到时间自动隐藏
 @param timeDelay   加载视图持续时间，hide=YES才起作用
 @param autoEnabled 加载视图显示过程中是否允许操作
 @param aMessage    加载视图显示的文字信息
 **/
+ (void)showHUD:(MBProgressHUDMode)mode onTarget:(UIView *)target hide:(BOOL)autoHide afterDelay:(NSTimeInterval)timeDelay enabled:(BOOL )autoEnabled message:(NSString *)aMessage
{
//    kSelfWeak;
    dispatch_main_async_safe((^{
    
        // 如果已存在，则从父视图移除
        if (mbProgressHUD.superview)
        {
            [mbProgressHUD removeFromSuperview];
            mbProgressHUD = nil;
        }
        
        if (target && [target isKindOfClass:[UIView class]]) {
            // 添加到目标视图
            mbProgressHUD = [MBProgressHUD showHUDAddedTo:target animated:YES];
        } else {
            // 创建显示视图
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            mbProgressHUD = [MBProgressHUD showHUDAddedTo:delegate.window animated:YES];
        }
        
        // 设置显示模式
        [mbProgressHUD setMode:mode];
        
        // 如果是自定义图标模式，则显示
        if (mode == MBProgressHUDModeCustomView)
        {
            // 设置自定义图标
            UIImageView *customImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading1"]];
           
            [customImageView setImage:[UIImage imageNamed:@"loading1"]];
            
            NSMutableArray *images = [[NSMutableArray alloc]initWithCapacity:30];
            
            for (NSInteger i = 1; i <= 30; i++)
            {
                [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading%ld",(long)i]]];
            }
            
            customImageView.animationImages = images;
            customImageView.animationDuration = 3;
            customImageView.animationRepeatCount = 0;
            [customImageView startAnimating];
            [mbProgressHUD setCustomView:customImageView];
            
//            [mbProgressHUD showAnimated:YES whileExecutingBlock:^{
//                
//                [weakSelf showProgress];
//                
//            } completionBlock:^{
//                
//                [customImageView stopAnimating];
//            }];
        }
        
        // 如果是填充模式
        else if (mode == MBProgressHUDModeIndeterminate || mode == MBProgressHUDModeAnnularDeterminate || mode == MBProgressHUDModeDeterminateHorizontalBar)
        {
            // 方法2
//            [mbProgressHUD showWhileExecuting:@selector(showProgress) onTarget:self withObject:nil animated:YES];
        }
        
        if(![aMessage isBlank])
        {
            // 设置标示标签
            mbProgressHUD.label.text = aMessage;
        }
    
        // 设置显示类型 出现或消失
        [mbProgressHUD setAnimationType:MBProgressHUDAnimationZoom];
    
        // 显示
        [mbProgressHUD showAnimated:YES];
        // 加上这个属性才能在HUD还没隐藏的时候点击到别的view
        // 取反，即!autoEnabled
        [mbProgressHUD setUserInteractionEnabled:!autoEnabled];
    
        // 隐藏后从父视图移除
        [mbProgressHUD setRemoveFromSuperViewOnHide:YES];
    
        // 设置自动隐藏
        if (autoHide)
        {
            [mbProgressHUD hideAnimated:autoHide afterDelay:timeDelay];
        }
    }));
}

+ (void)hiddenHUD
{
    [mbProgressHUD hideAnimated:YES];
}

+ (void)showProgress
{
    float progress = 0.0f;
    while (progress < 1.0f)
    {
        progress += 0.05f;
        [mbProgressHUD setProgress:progress];
        usleep(50000);
    }
}

@end

//
//  CustomLoadingView.h
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/4/11.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQDView:UIView

@end

@interface CustomLoadingView : NSObject

+(void)showLoadingView:(UIView *)baseView;

+(void)showLoadingView:(UIView *)baseView afterDelay:(CGFloat)delay;

+(void)hiddenLoadingView:(UIView *)baseView;

@end

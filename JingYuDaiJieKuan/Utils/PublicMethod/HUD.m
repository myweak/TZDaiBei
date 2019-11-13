//
//  HUD.m
//  OhMyBaby
//
//  Created by JPlay on 14-8-22.
//  Copyright (c) 2014年 JPlay. All rights reserved.
//

#import "HUD.h"

#import "SKHUD.h"


@implementation HUD
UIView *m_ViewBG;
UIView *m_ViewBlackBG;
UIImageView *m_ImageView;
double angle;
bool m_IfStop;
UILabel *m_LabelShow;
+(HUD *)ShareInstance
{
    static HUD *MainVC = nil;
    static dispatch_once_t OnceToken;
    dispatch_once(&OnceToken, ^{
        MainVC = [[HUD alloc] init];
    });
    return MainVC;
}


+(void)showHUDInViewPWD:(UIView *)view title:(NSString *)title
{
    [SKHUD showLoadingImageClearBgInView:view withMessage:title];
    
}

+(void)hideHUDInView:(UIView *)view{
//    if (!view) {
//        return;
//    }
    [SKHUD dismiss];
}

+(void)hideHUDInView
{
     [SKHUD dismiss];
}

//windows层
+(void)showHUDInView:(UIView *)view title:(NSString *)title{
    if (StringHasDataJudge(title))
    {
        [SKHUD showLoadingDotInWindowWithMessage:title];
    }
    else
    {
        [SKHUD showLoadingDotInWindow];
    }
}


//view层
+(void)showHUDInViewInView:(UIView *)view title:(NSString *)title{
    if (StringHasDataJudge(title))
    {
      [SKHUD showLoadingDotInView:view withMessage:title];
    }
    else
    {
      [SKHUD showLoadingDotInView:view];
    }


}

+(void)showNetWorkErrorInView:(UIView *)view{
    if (!view) {
        return;
    }
    [SKHUD showNetworkErrorMessageInView:view];

}

+(void)showMessageInView:(UIView *)view title:(NSString *)title{
    if (!view) {
        return;
    }
    [SKHUD showMessageInView:view withMessage:title];
}

+(void)showMessageInView:(UIView *)view title:(NSString *)title time:(int)time{
    if (!view) {
        return;
    }
   [SKHUD showMessageInView:view withMessage:title];
}



@end

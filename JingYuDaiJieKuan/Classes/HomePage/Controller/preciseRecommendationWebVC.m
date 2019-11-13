//
//  preciseRecommendationWebVC.m
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/9/5.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "preciseRecommendationWebVC.h"
#import "JingYuDaiJieKuan-Swift.h"

@interface preciseRecommendationWebVC ()

@end

@implementation preciseRecommendationWebVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
}


- (void)backToSuperView {
    
    if ([self.webView canGoBack]) {
        //如果可以回退,那么就是回退页面,没有退出整个控制器,这个时候不弹挽留弹窗
        [super backToSuperView];
    } else {
        [self retentionWindow];
    }
    
}

- (void)retentionWindow {
    TwoButtonAlertView *alert = [[TwoButtonAlertView alloc]initWithTitle:nil detailTitle:@"精准推荐的贷款成功率高达90%\n您真的要放弃吗？" isTwoButton:YES leftAction:^{} rightAction:^{}];
    
    [alert.leftButton setTitle:@"确认放弃" forState:UIControlStateNormal];
    [alert.leftButton setTitleColor:UIColorHex(@"#D2D3D9") forState:UIControlStateNormal];
    alert.leftButtonBlock = ^{
        [SensorsAnalyticsSDKHelper preciseRecommendationRetentionEventWithIfQuite:true];
        [super backToSuperView];
    };
    [alert.rightButton setTitle:@"我再想想" forState:UIControlStateNormal];
    [alert.rightButton setTitleColor:UIColorHex(@"#4363D0") forState:UIControlStateNormal];
    alert.rightButtonBlock = ^{
        [SensorsAnalyticsSDKHelper preciseRecommendationRetentionEventWithIfQuite:false];
    };
    
    alert.layer.cornerRadius = 5;
    alert.layer.masksToBounds = YES;
    
    [alert showAlertViewInViewController:self leftOrRightMargin:52];
    
}


@end

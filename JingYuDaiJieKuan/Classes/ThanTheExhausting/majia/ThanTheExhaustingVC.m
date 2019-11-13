//
//  ThanTheExhaustingVC.m
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/7/1.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "ThanTheExhaustingVC.h"

@interface ThanTheExhaustingVC () {
    BOOL isAlreadyAppear;
}

@end

@implementation ThanTheExhaustingVC

- (void)viewDidLoad {
    isAlreadyAppear = NO;
    self.fd_prefersNavigationBarHidden = YES;
    NSString *m_url = [kUserMessageManager getMessageManagerForObjectWithKey:WILLBEEXHAUSTINGURL];
    self.url =[NSString stringWithFormat:@"%@",[NSURL URLWithString:m_url]?:@""];
    
    [super viewDidLoad];
    
    //必须放在 [super viewDidLoad]后面
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(-kStatusBarH, 0, 0, 0);

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    if (isAlreadyAppear) {
        [self.webView evaluateJavaScript:@"appGetMustloanData()" completionHandler:^(id _Nullable data, NSError * _Nullable error) {
            if (error) {
                NSLog(@"错误:%@", error);
            }
        }];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    isAlreadyAppear = YES;
}

//改变状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end

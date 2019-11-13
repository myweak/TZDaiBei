//
//  AppDelegate.h
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/19.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic)MainViewController *mainVC;

@property (strong,nonatomic) Reachability * hostReach;

-(void)enterMainViewIndex:(NSInteger)index;

@end


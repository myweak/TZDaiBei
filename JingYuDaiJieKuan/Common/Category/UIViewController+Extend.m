//
//  UIViewController+Extend.m
//  NewJingYuBao
//
//  Created by linshaokai on 16/6/24.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import "UIViewController+Extend.h"

@implementation UIViewController (Extend)

- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.leftBarButtonItems=@[negativeSpacer,leftBarButtonItem];
}
- (void)addLeftBarButtonItems:(NSArray *)leftBarButtonItems
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    NSMutableArray *mutableArray = [NSMutableArray array];
    [mutableArray addObject:negativeSpacer];
    [mutableArray addObjectsFromArray:leftBarButtonItems];
    self.navigationItem.leftBarButtonItems = mutableArray;
}

- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems=@[negativeSpacer,rightBarButtonItem];
}
- (void)addRightBarButtonItems:(NSArray *)rightBarButtonItems
{
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    negativeSpacer.width = -10;
//    NSMutableArray *mutableArray = [NSMutableArray array];
//    [mutableArray addObject:negativeSpacer];
//    [mutableArray addObjectsFromArray:rightBarButtonItems];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
}
#pragma 是否开启全屏布局
-(void)FullScreen:(BOOL)FullScreen
{
    if (!FullScreen)
    {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}


#pragma 是否开启滚动UIScrollView或其子类滚动至全屏
-(void)ScrollFullScreen:(BOOL)FullScreen
{
    if (FullScreen)
    {
        self.automaticallyAdjustsScrollViewInsets=YES;
    }
    else
    {
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    
}

// 获取当前的VC
+ (UIViewController *)visibleViewController {
    UIViewController *rootViewController = [kAppDelegate.window rootViewController];
    return [UIViewController getVisibleViewControllerFrom:rootViewController];
}

+ (UIViewController *) getVisibleViewControllerFrom:(UIViewController *) vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [[self class] getVisibleViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [[self class] getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [[self class] getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
}

-(void)addPsuhVCAnimationFromTop{
    @weakify(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self)
        CATransition* transition = [CATransition animation];
        transition.duration = 0.4f;
        transition.type = kCATransitionMoveIn;
        transition.subtype = kCATransitionFromTop;
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    });

}

@end

//
//  UIViewController+Extend.h
//  NewJingYuBao
//
//  Created by linshaokai on 16/6/24.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extend)
/**
 *  @param leftBarButtonItem ""
 */
- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem;

- (void)addLeftBarButtonItems:(NSArray *)leftBarButtonItems;
/**Ø
 *  @param rightBarButtonItem ""
 */
- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem;
- (void)addRightBarButtonItems:(NSArray *)rightBarButtonItems;
/**
 *  是否开启全屏布局
 *
 *  @param FullScreen ""
 */
-(void)FullScreen:(BOOL)FullScreen;

/**
 *  是否开启ScrollView可以滚动整个屏幕
 *
 *  @param FullScreen ""
 */
-(void)ScrollFullScreen:(BOOL)FullScreen;

/** 获取当前的VCv */
+ (UIViewController *)visibleViewController;

@end

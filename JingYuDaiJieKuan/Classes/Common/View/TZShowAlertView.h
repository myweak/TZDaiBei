//
//  TZShowAlertView.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/10/31.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TZShowAlertView : UIView
@property (nonatomic, assign) BOOL isShowAnimate; // 是否显示动画 ， 默认NO

- (instancetype) initWithAlerTitle:(nullable NSString *)title
                       ContentView:(UIView *)contentView;

- (instancetype) showNotNetWorkViewWithBlock:(void(^)(void)) block;
- (void)show;
- (void)disMiss;
@end

NS_ASSUME_NONNULL_END

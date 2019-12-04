//
//  AHSendProgressView.h
//  AntHouse
//
//  Created by Nathan Ou on 2017/8/17.
//  Copyright © 2017年 Nathan Ou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AHSendProgressView : UIView

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, strong) UILabel *bottomTipLabel;

@property (nonatomic, assign) CGFloat totalProgress;

+ (AHSendProgressView *)showProgressView;

- (void)dismiss;

- (void)dismissWithCompletion:(void(^)(void))block;

@end

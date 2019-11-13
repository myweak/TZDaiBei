//
//  TheFourthHomePageSubCell.h
//  FenQiLe
//
//  Created by Dason on 2019/8/20.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class AdBannerModel;
@interface TheFourthHomePageSubCell : UIView

@property (strong, nonatomic) AdBannerModel *model;

/// 分隔符
@property (strong, nonatomic) UIView *line;


@end

NS_ASSUME_NONNULL_END

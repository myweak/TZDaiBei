//
//  TZHomeBodyCell.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/10/29.
//  Copyright © 2019 Jincaishen. All rights reserved.
//
static NSString * const TZHomeBodyCellID = @"TZHomeBodyCellID";

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TZHomeBodyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBg; // 　背景图
@property (weak, nonatomic) IBOutlet UIImageView *imageViewIcon; // 左边图标
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;// 标题

@end

NS_ASSUME_NONNULL_END

//
//  TZProductLineFrontItemCell.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/2.
//  Copyright © 2019 Jincaishen. All rights reserved.
//
static NSString * const TZProductLineFrontItemCell_ID = @"TZProductLineFrontItemCell_ID";

#import <UIKit/UIKit.h>
#import "TZProductPageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TZProductLineFrontItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *maxMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;

@property (nonatomic, copy) void (^backTapBtnActionBlock)(UIButton *btn);
// 数据源
@property (nonatomic, strong) TZProductBankModel *model;

@end

NS_ASSUME_NONNULL_END

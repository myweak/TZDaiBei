//
//  TZProductScreenConditionItemCell.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/5.
//  Copyright © 2019 Jincaishen. All rights reserved.
//
static NSString * const TZProductScreenConditionItemCell_ID = @"TZProductScreenConditionItemCell_ID";

#import <UIKit/UIKit.h>
#import "TZProductScreenConditionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TZProductScreenConditionItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel; // 贷款银行

@property (weak, nonatomic) IBOutlet UILabel *conditonLabel; // f贷款条件
@property (weak, nonatomic) IBOutlet UIView *tagView;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel; // 贷款金额
@property (weak, nonatomic) IBOutlet UILabel *collarLabel;// 利息
@property (weak, nonatomic) IBOutlet UILabel *timeLabel; // 放款时间
@property (weak, nonatomic) IBOutlet UILabel *numberLabel; //申请人数

// 数据源
@property (nonatomic, strong) TZProductOfflineInfoModel *model;

@end

NS_ASSUME_NONNULL_END

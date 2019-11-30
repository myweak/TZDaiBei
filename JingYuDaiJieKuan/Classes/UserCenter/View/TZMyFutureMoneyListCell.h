//
//  TZMyFutureMoneyListCell.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/30.
//  Copyright © 2019 Jincaishen. All rights reserved.
//
static NSString * const TZMyFutureMoneyListCell_ID = @"TZMyFutureMoneyListCellID";

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TZMyFutureMoneyListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *stuatLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end

NS_ASSUME_NONNULL_END

//
//  TZMyFutureMoneyDetailNameCell.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/30.
//  Copyright © 2019 Jincaishen. All rights reserved.
//
static NSString * const TZMyFutureMoneyDetailNameCell_ID = @"TZMyFutureMoneyDetailNameCellID";

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TZMyFutureMoneyDetailNameCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;


@end

NS_ASSUME_NONNULL_END

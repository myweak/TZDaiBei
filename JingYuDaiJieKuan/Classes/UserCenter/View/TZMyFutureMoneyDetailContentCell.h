//
//  TZMyFutureMoneyDetailContentCell.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/30.
//  Copyright © 2019 Jincaishen. All rights reserved.
//
static NSString * const TZMyFutureMoneyDetailContentCell_ID = @"TZMyFutureMoneyDetailContentCellID";

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TZMyFutureMoneyDetailContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeLabel;

@end

NS_ASSUME_NONNULL_END

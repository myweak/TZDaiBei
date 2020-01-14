//
//  TZProductLineFrontDetailSurplusCell.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2020/1/12.
//  Copyright © 2020 Jincaishen. All rights reserved.
//
static NSString * const TZProductLineFrontDetailSurplusCell_ID = @"TZProductLineFrontDetailSurplusCell_ID";

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TZProductLineFrontDetailSurplusCell : UITableViewCell
// 今日申请名额已抢85%
@property (weak, nonatomic) IBOutlet UILabel *surplusNumLabel;
//2天放款
@property (weak, nonatomic) IBOutlet UIButton *getMoneyTimeLabel;
//年化费率36%
@property (weak, nonatomic) IBOutlet UIButton *yearInterestLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *surplusView_W;
@property (weak, nonatomic) IBOutlet UIView *surplusView;
- (void)setSurplusValue;
@end

NS_ASSUME_NONNULL_END

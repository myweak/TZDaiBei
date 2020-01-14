//
//  TZProductLineFrontDetailPostMoneyNumbCell.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2020/1/12.
//  Copyright © 2020 Jincaishen. All rights reserved.
//
static NSString * const TZProductLineFrontDetailPostMoneyNumbCell_ID = @"TZProductLineFrontDetailPostMoneyNumbCell_ID";

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TZProductLineFrontDetailPostMoneyNumbCell : UITableViewCell
//额度:
@property (weak, nonatomic) IBOutlet UILabel *postMoneyLabel;
//期限
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
//月均还款
@property (weak, nonatomic) IBOutlet UILabel *monthMoneyLabel;
//利息和费用
@property (weak, nonatomic) IBOutlet UILabel *interestLaebel;
//到账金额
@property (weak, nonatomic) IBOutlet UILabel *getMoneyLabel;

@end

NS_ASSUME_NONNULL_END

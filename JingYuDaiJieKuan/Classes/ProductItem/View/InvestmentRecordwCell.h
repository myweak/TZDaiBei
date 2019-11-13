//
//  InvestmentRecordwCell.h
//  JingYuDai
//
//  Created by air on 2018/3/30.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransactionRecordsModel.h"

@interface InvestmentRecordwCell : UITableViewCell
+ (instancetype)creatCellWithTableView:(UITableView *)tableView;
//查看明细
- (void)checkTheDetailsModel:(TransactionListDataModel *)model;
//投资记录
- (void)investmentRecordModel:(TransactionListDataModel *)model;


@end

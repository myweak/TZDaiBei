//
//  InvestmentDetailsCell.h
//  JingYuDaiJieKuan
//
//  Created by air on 2018/4/4.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransactionRecordsListModel.h"

@interface InvestmentDetailsCell : UITableViewCell

+ (instancetype)creatCellWithTableView:(UITableView *)tableView;
- (void)setupCellContentWithModel:(TransactionListDataModel *)model;
@end

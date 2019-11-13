//
//  TransactionRecordsCell.h
//  JingYuDaiJieKuan
//
//  Created by air on 2018/3/22.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransactionRecordsModel.h"

@interface TransactionRecordsCell : UITableViewCell

+ (instancetype)creatCellWithTableView:(UITableView *)tableView;

- (void)setupCellContentWithModel:(TransactionDetailsListDataModel *)model;
@end

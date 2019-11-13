//
//  CouponsCell.h
//  JingYuDaiJieKuan
//
//  Created by air on 2018/3/27.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardVoucherListModel.h"
@interface CouponsCell : UITableViewCell

+ (instancetype)creatCellWithTableView:(UITableView *)tableView;
- (void)setupCellContentWithModel:(CardVoucherListDataModel *)model;


@end

//
//  MyLoanCell.h
//  JingYuDaiJieKuan
//
//  Created by air on 2018/3/22.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransactionRecordsModel.h"

@protocol MyLoanCellDelegate;

@interface MyLoanCell : UITableViewCell

+ (instancetype)creatCellWithTableView:(UITableView *)tableView;

- (void)setupCellContentWithModel:(TransactionListDataModel *)model;

@property (nonatomic, strong) id <MyLoanCellDelegate>delegate;

@end

@protocol MyLoanCellDelegate <NSObject>

- (void)myLoanCellClick:(UIButton *)sender;

@end


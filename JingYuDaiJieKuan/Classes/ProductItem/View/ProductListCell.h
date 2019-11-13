//
//  ProductListCell.h
//  JingYuDaiJieKuan
//
//  Created by air on 2018/3/20.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransactionRecordsListModel.h"
#import "CardVoucherListModel.h"
@protocol InvestmentCellDelegate;

@interface ProductListCell : UITableViewCell

@property (nonatomic, strong) UIImageView *m_bgImageView;

@property (nonatomic, strong) UIButton *takeUpBtn; // 已抢完

+ (instancetype)creatCellWithTableView:(UITableView *)tableView;

@property (nonatomic,weak) id <InvestmentCellDelegate>delegte;
//项目列表 详情界面

- (void)setupCellContentWithModel:(TransactionListDataModel *)model;
//  优惠券  使用产品
- (void)useTheProductModel:(CardVoucherListDataModel *)model;


@end

@protocol InvestmentCellDelegate <NSObject>
- (void)investmentCell:(ProductListCell *)cell investmentId:(NSString *)investmentID;

@end

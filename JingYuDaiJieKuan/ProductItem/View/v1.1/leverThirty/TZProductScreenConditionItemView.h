//
//  TZProductScreenConditionItemView.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/12/27.
//  Copyright © 2019 Jincaishen. All rights reserved.
//
#import "TZProductScreenConditionModel.h"

#import "TZXibNibView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TZProductScreenConditionItemView : TZXibNibView
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel; // 贷款银行

@property (weak, nonatomic) IBOutlet UILabel *conditonLabel; // f贷款条件
@property (weak, nonatomic) IBOutlet UIView *tagView;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel; // 贷款金额
@property (weak, nonatomic) IBOutlet UILabel *collarLabel;// 利息
@property (weak, nonatomic) IBOutlet UILabel *timeLabel; // 放款时间

// 数据源
@property (nonatomic, strong) TZProductOfflineInfoModel *model;



@end

@interface TZProductScreenConditionView : UIView
@property (nonatomic, copy) void (^backItemTapAction)( TZProductOfflineInfoModel*model);
// 设置view item 列表
- (void)setTZProductScreenConditionItemViewWithArray:(NSArray <TZProductOfflineInfoModel *>*) arr;
@end
NS_ASSUME_NONNULL_END

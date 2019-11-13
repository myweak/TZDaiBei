//
//  TZProductLinebackBankSpeedItemView.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/4.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZXibNibView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TZProductLinebackBankSpeedItemView : TZXibNibView
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBg;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

// 快速通道 模块
+ (void)addBankSpeedItemViewWithAddSuperView:(UIView *)superView andTapIndexBlock:(void(^)(NSInteger index)) block;

@end

NS_ASSUME_NONNULL_END

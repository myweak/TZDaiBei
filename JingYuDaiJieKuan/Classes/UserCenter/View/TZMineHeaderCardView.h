//
//  TZMineHeaderCardView.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/29.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZXibNibView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TZMineHeaderCardView : TZXibNibView
@property (weak, nonatomic) IBOutlet UIView *cardViewBg;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

NS_ASSUME_NONNULL_END

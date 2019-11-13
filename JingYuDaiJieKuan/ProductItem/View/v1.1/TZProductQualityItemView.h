//
//  TZProductQualityItemView.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/1.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZXibNibView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TZProductQualityItemView : TZXibNibView
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *maxMoneyLabel;

@end

NS_ASSUME_NONNULL_END

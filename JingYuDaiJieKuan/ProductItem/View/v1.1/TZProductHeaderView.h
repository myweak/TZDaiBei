//
//  TZProductHeaderView.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/1.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZXibNibView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TZProductHeaderView : TZXibNibView
@property (weak, nonatomic) IBOutlet UIImageView *viewBg;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end

NS_ASSUME_NONNULL_END

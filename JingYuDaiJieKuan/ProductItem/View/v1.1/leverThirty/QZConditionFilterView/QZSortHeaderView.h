//
//  QZSortHeaderView.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/7.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZXibNibView.h"

NS_ASSUME_NONNULL_BEGIN

@interface QZSortHeaderView : TZXibNibView
@property (weak, nonatomic) IBOutlet UILabel *mianLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UIView *mainBotttomLineView;
@property (nonatomic, copy) void(^backTapBtnActionBlock)(UIButton *btn);
@end

NS_ASSUME_NONNULL_END

//
//  TZMyFutureMoneyDetailContentCell.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/30.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZMyFutureMoneyDetailContentCell.h"

@implementation TZMyFutureMoneyDetailContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.selected = YES;
    [self.numTitleLabel changeAligLeftAndRight];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

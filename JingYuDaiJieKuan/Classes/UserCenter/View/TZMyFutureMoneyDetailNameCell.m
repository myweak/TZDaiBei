//
//  TZMyFutureMoneyDetailNameCell.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/30.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZMyFutureMoneyDetailNameCell.h"

@implementation TZMyFutureMoneyDetailNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.selected = YES;
    self.moneyLabel.keywords = @"借款金额：￥";
    self.moneyLabel.keywordsFont = kFontSize12;
    [self.moneyLabel reloadUIConfig];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

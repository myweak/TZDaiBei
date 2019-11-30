//
//  TZMyFutureMoneyDetailCommentCell.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/30.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZMyFutureMoneyDetailCommentCell.h"

@implementation TZMyFutureMoneyDetailCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.selected = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

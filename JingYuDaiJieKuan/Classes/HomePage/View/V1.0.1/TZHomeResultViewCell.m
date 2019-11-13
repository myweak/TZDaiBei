//
//  TZHomeResultViewCell.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/10/29.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZHomeResultViewCell.h"

@implementation TZHomeResultViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

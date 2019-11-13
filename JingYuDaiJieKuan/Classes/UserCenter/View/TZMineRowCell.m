//
//  TZMineRowCell.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/10/30.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZMineRowCell.h"

@implementation TZMineRowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.selected = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
// 是否显示箭头  默认显示
- (void)showMoreImageView:(BOOL)isShow{
    self.moreImageView.hidden = !isShow;
    if (isShow) { // 显示
        self.rightSubLable_R.constant = 15;
    }else{
        self.rightSubLable_R.constant = -2;
    }
}

// 是否 显示 左边的。icon 默认显示
- (void)showIconImageView:(BOOL)isShow{
    self.iconImageView.hidden = !isShow;
    if (isShow) { // 显示
        self.mainLabel_L.constant = 60;
    }else{
        self.mainLabel_L.constant = 16;
    }
}

@end

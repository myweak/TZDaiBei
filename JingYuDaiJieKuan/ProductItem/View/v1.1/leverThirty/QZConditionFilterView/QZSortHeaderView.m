//
//  QZSortHeaderView.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/7.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "QZSortHeaderView.h"

@implementation QZSortHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
}
- (IBAction)tapBtnAction:(id)sender {
    !self.backTapBtnActionBlock ?:self.backTapBtnActionBlock((UIButton *)sender);
}

@end

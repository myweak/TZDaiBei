//
//  TZApplyCreditCardCell.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/12/17.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZApplyCreditCardCell.h"

@implementation TZApplyCreditCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (IBAction)tapBtnAtion:(id)sender {
    !self.backTapBtnActionBlock ?:self.backTapBtnActionBlock((UIButton *)sender);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

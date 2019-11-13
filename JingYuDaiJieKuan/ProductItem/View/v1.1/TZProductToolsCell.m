//
//  TZProductToolsCell.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/1.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZProductToolsCell.h"

@implementation TZProductToolsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (IBAction)tapBtnAction:(UIButton *)sender {
    !self.backBtnTapAcionBlock ?:self.backBtnTapAcionBlock(sender.tag);

}

@end

//
//  TZProductPToPCell.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/1.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZProductPToPCell.h"

@interface TZProductPToPCell ()

@end

@implementation TZProductPToPCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (IBAction)leftTapAcion:(id)sender {
    !self.backBtnTapAcionBlock ?: self.backBtnTapAcionBlock(0);
}

- (IBAction)rightTapAcion:(id)sender {
    !self.backBtnTapAcionBlock ?: self.backBtnTapAcionBlock(1);

}
- (IBAction)rightBottomTapAcion:(id)sender {
    !self.backBtnTapAcionBlock ?: self.backBtnTapAcionBlock(2);

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

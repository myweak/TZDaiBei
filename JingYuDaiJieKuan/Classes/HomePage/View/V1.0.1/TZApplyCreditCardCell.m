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

- (void)setModel:(TZApplyCreditCardListModel *)model{
    _model = model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.icoUrl] placeholderImage:kplaceImage];
    self.nameLabel.text = model.title;
    self.tagLabelA.text = model.introduceOne;
    self.tagLabelB.text = model.introduceTwo;
    self.tagLabelC.text = model.introduceThree;
    self.tagLabelD.text = model.introduceFour;
    self.tagLabelE.text = model.introduceFive;


    
}




@end

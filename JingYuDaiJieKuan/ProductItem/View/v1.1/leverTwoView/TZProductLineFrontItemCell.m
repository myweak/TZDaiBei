//
//  TZProductLineFrontItemCell.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/2.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZProductLineFrontItemCell.h"

@implementation TZProductLineFrontItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.applyBtn.layer.borderWidth = 1.0f;
//    self.applyBtn.layer.borderColor = KText_ColorSubRed.CGColor;
    self.applyBtn.layer.cornerRadius = 13;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.applyBtn setBackgroundImage:[UIImage imageWithColor:Bg_Btn_Colorblue] forState:UIControlStateNormal];
    [self.applyBtn setBackgroundImage:[UIImage imageWithColor:[@"#f0f0f0" getColor]] forState:UIControlStateDisabled];
    self.applyBtn.clipsToBounds = YES;
}
- (IBAction)tapBtnAtion:(id)sender {
    !self.backTapBtnActionBlock ?:self.backTapBtnActionBlock((UIButton *)sender);
}


- (void)setModel:(TZProductBankModel *)model{
    _model = model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:Kimage_placeholder];
    self.nameLabel.text = model.name;
    self.maxMoneyLabel.text = model.maxAmount;
    self.subTitleLabel.text = model.txtDesc;
    
    self.timeLable.text = [NSString stringWithFormat:@"%@%@放款",model.recvMoneyTime,model.recvMoneyType_str];
    self.yearLabel.text = [NSString stringWithFormat:@"%@：%@%@",model.rateType_str,model.rate,@"%"];
    self.monthLabel.text = [NSString stringWithFormat:@"贷款期限%@",model.period];
    self.applyBtn.enabled = model.productType.integerValue != 2;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

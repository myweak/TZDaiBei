//
//  TZProductScreenConditionItemCell.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/5.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZProductScreenConditionItemCell.h"

@implementation TZProductScreenConditionItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
    self.tagView.layer.masksToBounds = YES;
    self.tagView.layer.cornerRadius = 1.0f;
    self.tagView.layer.borderColor = KText_ColorGreen.CGColor;
    self.tagView.layer.borderWidth = 0.5f;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TZProductOfflineInfoModel *)model{
    _model = model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.proIco] placeholderImage:Kimage_placeholder];
    self.titleLabel.text = model.title;
    NSString *keDai = @"可贷";
    NSString *feiLv = @"月费率";
    self.moneyLabel.text = [NSString stringWithFormat:@"%@ %@-%@万",keDai,model.minAmount,model.maxAmount];
    self.collarLabel.text = [NSString stringWithFormat:@"%@ %@%@",feiLv,model.monthlyRate,@"%"];
    self.timeLabel.text = [NSString stringWithFormat:@"%@ %@%@天",@"放款时长",model.lendingTime,model.lendingType];
    
    self.moneyLabel.keywords = keDai;
    self.collarLabel.keywords = feiLv;
    self.moneyLabel.keywordsColor = kBtnGrayColor;
    self.collarLabel.keywordsColor = kBtnGrayColor;
    [self.moneyLabel reloadUIConfig];
    [self.collarLabel reloadUIConfig];
    
    // 抵押标签
    TZProductOfflineInfoCollasModel *conditionModel = [model.labelInfo firstObject];
    self.tagView.hidden = checkStrEmty(conditionModel.labelName);
    self.tagView.layer.borderColor = [conditionModel.labelColor getColor].CGColor;
    
    self.conditonLabel.text = conditionModel.labelName;
    self.conditonLabel.textColor = [conditionModel.labelColor getColor];
    
    
    
}



@end

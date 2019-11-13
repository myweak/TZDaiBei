//
//  LoanStrategyCell.m
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/6/28.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "LoanStrategyCell.h"

@implementation LoanStrategyCell


+ (instancetype)creatCellWithTableView:(UITableView *)tableView {
    LoanStrategyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        cell = [[LoanStrategyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self)];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (void)loanStrategyModelValue:(LUserModel *)model
{
    self.m_nameLabel.text = model.title;
    [self.m_iconImage sd_setImageWithURL:[NSURL URLWithString:model.photo]];

    self.m_numberLabel.text = model.readNum;
    self.m_praiseLabel.text = model.likesNum;
    //取消点赞的颜色高亮
//    if ([model.canLike isEqualToString:@"0"]) {
//        [self.m_praiseBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
//        self.m_praiseLabel.textColor = UIColorHex(@"#3a80ff");
//
//    }else{
        [self.m_praiseBtn setImage:[UIImage imageNamed:@"giveLike"] forState:UIControlStateNormal];
        self.m_praiseLabel.textColor = UIColorHex(@"#9b9b9b");
//    }
//    if (self.isClick) {
//    }else{
//    }
}

- (void)initView
{
    [self addSubview:self.m_iconImage];
    [self addSubview:self.m_nameLabel];
    [self addSubview:self.m_iconBtn];
    [self addSubview:self.m_numberLabel];
    [self addSubview:self.m_praiseBtn];
    [self addSubview:self.m_praiseLabel];
    
    [self.m_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kiP6WidthRace(14));
        make.top.mas_equalTo(kiP6WidthRace(21));
        make.width.mas_equalTo(kiP6WidthRace(133));
        make.height.mas_equalTo(kiP6WidthRace(75));
    }];
    
    [self.m_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(35/2));
        make.top.mas_equalTo(kiP6WidthRace(21));
        make.right.mas_equalTo(self.m_iconImage.mas_left).offset(-kiP6WidthRace(35/2));
    }];
    
    [self.m_iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(35/2));
        make.bottom.mas_equalTo(self.m_iconImage.mas_bottom);
        make.width.mas_equalTo(kiP6WidthRace(15));
        make.height.mas_equalTo(kiP6WidthRace(10));
    }];
    
    [self.m_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.m_iconBtn.mas_right).offset(kiP6WidthRace(7/2));
        make.centerY.equalTo(self.m_iconBtn.mas_centerY);
    }];
    
    [self.m_praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.m_numberLabel.mas_right).offset(kiP6WidthRace(24));
        make.bottom.mas_equalTo(self.m_iconImage.mas_bottom);
        make.width.mas_equalTo(kiP6WidthRace(15));
        make.height.mas_equalTo(kiP6WidthRace(10));
    }];
    
    [self.m_praiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.m_praiseBtn.mas_right).offset(kiP6WidthRace(7/2));
        make.centerY.equalTo(self.m_iconBtn.mas_centerY);
    }];
}

- (UILabel *)m_nameLabel
{
    if (!_m_nameLabel) {
        _m_nameLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"事故的好时机换手机", KFont(15), UIColorHex(@"#151517"), NO);
        _m_nameLabel.numberOfLines = 0;
    }
    return _m_nameLabel;
}

- (UIButton *)m_iconBtn
{
    if (!_m_iconBtn) {
        _m_iconBtn = InsertImageButton(nil, CGRectZero, 100, [UIImage imageNamed:@"watch"], nil, self, @selector(iconClick:));
    }
    return _m_iconBtn;
}

- (UILabel *)m_numberLabel
{
    if (!_m_numberLabel) {
        _m_numberLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"30", KFont(12), UIColorHex(@"#9b9b9b"), NO);
    }
    return _m_numberLabel;
}

- (UIButton *)m_praiseBtn
{
    if (!_m_praiseBtn) {
        _m_praiseBtn = InsertImageButton(nil, CGRectZero, 101, [UIImage imageNamed:@"giveLike"], nil, self, @selector(iconClick:));
    }
    return _m_praiseBtn;
}

- (UILabel *)m_praiseLabel
{
    if (!_m_praiseLabel) {
        _m_praiseLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"30", KFont(12), UIColorHex(@"#9b9b9b"), NO);
    }
    return _m_praiseLabel;
}

- (UIImageView *)m_iconImage
{
    if (!_m_iconImage) {
        _m_iconImage = InsertImageView(nil, CGRectZero, [UIImage imageNamed:@"totalAssetsHeadBg"]);
        //设置圆角
        _m_iconImage.layer.cornerRadius = 5.0f;
        //将多余的部分切掉
        _m_iconImage.layer.masksToBounds = YES;

    }
    return _m_iconImage;
}

- (void)iconClick:(UIButton *)button
{
    if (button.tag == 100) {
        NSLog(@"11111");
    }else{
        // 点赞
        if (self.giveALikeBlock) {
            self.giveALikeBlock();
            self.isClick = YES;
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

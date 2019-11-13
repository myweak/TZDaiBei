//
//  TheSecondHomePageCell.m
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/6/26.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TheSecondHomePageCell.h"
#import "HomePageModel.h"

@implementation TheSecondHomePageCell

+ (instancetype)creatCellWithTableView:(UITableView *)tableView {
    TheSecondHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        cell = [[TheSecondHomePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self)];
        cell.accessoryType=UITableViewCellAccessoryNone;
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

- (void)initView
{
    
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.m_IconImage];
    [self.bgView addSubview:self.m_nameLabel];
    [self.bgView addSubview:self.m_interestLabel];
    [self.bgView addSubview:self.m_highestLabel];
    [self.bgView addSubview:self.m_moneyLabel];
    [self.bgView addSubview:self.m_immediatelyBtn];
    [self.bgView addSubview:self.firstTagLbl];
    [self.bgView addSubview:self.secondTagLbl];
    [self.bgView addSubview:self.thirdTagLbl];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(15));
        make.width.mas_equalTo(kScreenWidth - kiP6WidthRace(30));
        make.top.equalTo(self.contentView).offset(-1);//因为边框的问题,简易的调整一下,就不会有上下两个边框贴着看起来比较粗的问题
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.m_IconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(25/2));
        make.top.mas_equalTo(kiP6WidthRace(13));
        make.width.mas_equalTo(kiP6WidthRace(48));
        make.height.mas_equalTo(self.m_IconImage.mas_width);
    }];
    
    [self.m_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.m_IconImage.mas_right).offset(kiP6WidthRace(12));
        make.top.equalTo(self.bgView).offset(13);
        make.height.mas_equalTo(17);
    }];
    
    [self.m_interestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.m_nameLabel);
        make.top.equalTo(self.m_nameLabel.mas_bottom).offset(kiP6WidthRace(13/2));
        make.right.equalTo(self.m_moneyLabel.mas_left).offset(-5);
    }];
    
    [self.m_highestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kiP6WidthRace(17));
        make.top.mas_equalTo(kiP6WidthRace(13));
    }];
    
    [self.m_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kiP6WidthRace(17));
        make.top.equalTo(self.m_highestLabel.mas_bottom).offset(kiP6WidthRace(15/2));
    }];
    
    [self.m_immediatelyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kiP6WidthRace(17));
        make.width.mas_equalTo(kiP6WidthRace(156/2));
        make.height.mas_equalTo(kiP6WidthRace(54/2));
        make.bottom.mas_equalTo(self.firstTagLbl);
    }];
    
    [self.firstTagLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.m_interestLabel.mas_bottom).offset(kiP6WidthRace(24));
        make.left.equalTo(self.m_IconImage);
        make.height.mas_equalTo(kiP6WidthRace(18));
        make.bottom.equalTo(self.bgView).offset(-13);
    }];
    
    [self.secondTagLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstTagLbl.mas_right).offset(16);
        make.top.mas_equalTo(self.firstTagLbl);
        make.height.equalTo(self.firstTagLbl);
    }];
    
    [self.thirdTagLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secondTagLbl.mas_right).offset(16);
        make.top.mas_equalTo(self.firstTagLbl);
        make.right.lessThanOrEqualTo(self.m_immediatelyBtn.mas_left).offset(-16);
        make.height.equalTo(self.firstTagLbl);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = InsertView(nil, CGRectZero, UIColorHex(@"#ffffff"));
        _bgView.layer.borderWidth = 1;
        _bgView.layer.borderColor = [UIColor colorWithRed:237/255.0 green:239/255.0 blue:242/255.0 alpha:1.0].CGColor;
    }
    return _bgView;
}

- (UIImageView *)m_IconImage
{
    if (!_m_IconImage) {
        _m_IconImage = [[UIImageView alloc]init];
    }
    return _m_IconImage;
}

- (UILabel *)m_nameLabel
{
    if (!_m_nameLabel) {
        _m_nameLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"", KFont(14), UIColorHex(@"#333333"), NO);
    }
    return _m_nameLabel;
}

- (UILabel *)m_interestLabel
{
    if (!_m_interestLabel) {
        _m_interestLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"", KFont(14), UIColorHex(@"#75829B"), NO);
        _m_interestLabel.numberOfLines = 0;
    }
    return _m_interestLabel;
}

- (UILabel *)m_highestLabel
{
    if (!_m_highestLabel) {
        _m_highestLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"最高可借", KFont(14), UIColorHex(@"#75829B"), NO);
    }
    return _m_highestLabel;
}

- (UILabel *)m_moneyLabel
{
    if (!_m_moneyLabel) {
        _m_moneyLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"", KFont(20), UIColorHex(@"#5177D5"), NO);
        _m_moneyLabel.textAlignment = NSTextAlignmentRight;
        ///抗压缩,这样才不会被推荐说明的label压缩得显示不完金额
        [_m_moneyLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        ///抗拉伸,这样和推荐说明的约束就不会出现width不明确的警告
        [_m_moneyLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _m_moneyLabel;
}

- (UIButton *)m_immediatelyBtn
{
    if (!_m_immediatelyBtn) {
        _m_immediatelyBtn = InsertButtonWithType(nil, CGRectZero, 100, self, nil, UIButtonTypeCustom);
        [_m_immediatelyBtn setUserInteractionEnabled:NO];
        _m_immediatelyBtn.titleLabel.font = KFont(13);
        [_m_immediatelyBtn setTitle:@"立即申请" forState:UIControlStateNormal];
        [_m_immediatelyBtn setTitleColor:UIColorHex(@"#5177D5")
                                forState:UIControlStateNormal];
        _m_immediatelyBtn.layer.cornerRadius = 2.0;//2.0是圆角的弧度，根据需求自己更改
        [_m_immediatelyBtn.layer setBorderColor:UIColorHex(@"#5177D5").CGColor];
        _m_immediatelyBtn.layer.borderWidth = 1.0f;//设置边框颜色
        //设置边框的粗细
        [_m_immediatelyBtn.layer setBorderWidth:1.0];
        //设置圆角的半径
        [_m_immediatelyBtn.layer setCornerRadius:54/4];
    }
    return _m_immediatelyBtn;
}

- (UILabel *)firstTagLbl
{
    if (!_firstTagLbl) {
        _firstTagLbl= [[UILabel alloc] init];
        _firstTagLbl.textAlignment = NSTextAlignmentCenter;
        _firstTagLbl.font = KFont(12);
        _firstTagLbl.tag = 10000;
        _firstTagLbl.textColor = UIColorHex(@"#75829B");
        _firstTagLbl.backgroundColor = UIColorHex(@"#ECF0F5");
        [_firstTagLbl setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_firstTagLbl setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _firstTagLbl;
}

- (UILabel *)secondTagLbl
{
    if (!_secondTagLbl) {
        _secondTagLbl = [[UILabel alloc] init];
        _secondTagLbl.textAlignment = NSTextAlignmentCenter;
        _secondTagLbl.font = KFont(12);
        _secondTagLbl.tag = 10001;
        _secondTagLbl.textColor = UIColorHex(@"#75829B");
        _secondTagLbl.backgroundColor = UIColorHex(@"#ECF0F5");
        [_secondTagLbl setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_secondTagLbl setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _secondTagLbl;
}

- (UILabel *)thirdTagLbl       
{
    if (!_thirdTagLbl) {
        _thirdTagLbl = [[UILabel alloc] init];
        _thirdTagLbl.textAlignment = NSTextAlignmentCenter;
        _thirdTagLbl.font = KFont(12);
        _thirdTagLbl.tag = 10002;
        _thirdTagLbl.textColor = UIColorHex(@"#75829B");
        _thirdTagLbl.backgroundColor = UIColorHex(@"#ECF0F5");
    }
    return _thirdTagLbl;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(AdBannerModel *)model {
    _model = model;
    
    self.m_nameLabel.text = [NSString stringWithFormat:@"%@",model.name];
    [self.m_IconImage sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    // 注意传入参数的数据长度，可用double
    NSString *money = [formatter stringFromNumber:[NSNumber numberWithDouble:[model.maxAmount doubleValue]]];
    
    self.m_moneyLabel.text = [NSString stringWithFormat:@"%@",money];
    self.m_interestLabel.text = [NSString stringWithFormat:@"%@",model.title];
    
////    [self.bgView addSubview:label];
//    for (int i = 0; i<self.bgView.subviews.count; i++){
//        //循环删除添加的特性
//        UIView *view = self.bgView.subviews[i];
//        if (view.tag == 10000) {
//            [view removeFromSuperview];
//        }
//    }
    
    [self.firstTagLbl setHidden:YES];
    [self.secondTagLbl setHidden:YES];
    [self.thirdTagLbl setHidden:YES];
    
    if (![self isBlankString:model.tags]) {
        NSArray *array = [model.tags componentsSeparatedByString:@","];//从字符A中分隔成2个元素的数组
        /// 最多是显示3个特性
        for (int i = 0 ; i < 3; i ++) {
            if (i == array.count) {break;}
            UILabel *label = [self.bgView viewWithTag:10000 + i];
            if (label != nil) {
                label.text = array[i];
                
                [label setHidden:NO];
            }
//            UILabel *label = [[UILabel alloc] init];
//            label.textAlignment = NSTextAlignmentCenter;
//            label.text = array[i];
//            label.font = KFont(11);
//            label.tag = 10000;
//            label.textColor = UIColorHex(@"#999999");
//            label.backgroundColor = UIColorHex(@"#f2f2f2");
//            [self.bgView addSubview:label];
//            [label mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(kiP6WidthRace(25/2) + kiP6WidthRace(48)*i);
//                make.top.mas_equalTo(self.m_IconImage.mas_bottom).offset(kiP6WidthRace(35/2));
//                make.width.mas_equalTo(kiP6WidthRace(41));
//                make.height.mas_equalTo(kiP6WidthRace(18));
//            }];
        }
    }
}

/// 是否空白字符串
- (BOOL)isBlankString:(NSString *)aStr {
    if (!aStr) {
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!aStr.length) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

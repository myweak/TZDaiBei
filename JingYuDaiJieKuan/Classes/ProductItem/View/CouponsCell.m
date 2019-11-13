//
//  CouponsCell.m
//  JingYuDaiJieKuan
//
//  Created by air on 2018/3/27.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "CouponsCell.h"
#import "CouponsCell.h"

@interface CouponsCell()

@property (nonatomic ,strong)UIImageView *BGImageView;
@property (nonatomic, strong)UILabel *moneyLabel;     //金额
@property (nonatomic, strong)UILabel *vouchersLabel; //现金券
@property (nonatomic, strong)UILabel *availableLabel; //投资满多少可以用
@property (nonatomic, strong)UILabel *timeLabel;      //有效时间
@property (nonatomic, strong)UIImageView *markImage;      //有效时间




@end


@implementation CouponsCell



+ (instancetype)creatCellWithTableView:(UITableView *)tableView {
    CouponsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        
        cell = [[CouponsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kColorClear;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.BGImageView];
        [self.BGImageView addSubview:self.moneyLabel];
        [self.BGImageView addSubview:self.vouchersLabel];
        [self.BGImageView addSubview:self.availableLabel];
        [self.BGImageView addSubview:self.timeLabel];
        [self.BGImageView addSubview:self.markImage];
        [self initView];
        
    }
    return self;
}

- (void)initView{
    [self.BGImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@10);
        make.right.mas_equalTo(@(-10));
        make.top.mas_equalTo(@0);
        make.height.mas_equalTo(kiP6WidthRace(100));
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.top.mas_equalTo(kiP6WidthRace(20));
        make.width.mas_equalTo(kiP6WidthRace(101));
    }];
    
    [self.vouchersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.bottom.mas_equalTo(kiP6WidthRace(-23));
//        make.top.mas_equalTo(self.moneyLabel).offset(kiP6WidthRace(9));
        make.width.mas_equalTo(kiP6WidthRace(101));
    }];
    
    [self.availableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.vouchersLabel.mas_right).offset(kiP6WidthRace(28));
        make.right.mas_equalTo(kiP6WidthRace(-50));
        make.top.mas_equalTo(kiP6WidthRace(13));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.moneyLabel.mas_right).offset(kiP6WidthRace(28));
//        make.top.mas_equalTo(self.mas_bottom).offset(kiP6WidthRace(-10));
        make.bottom.mas_equalTo(kiP6WidthRace(-10));
    }];
    
    [self.markImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kiP6WidthRace(32));
        make.right.mas_equalTo(kiP6WidthRace(-10));
        make.width.mas_equalTo(kiP6WidthRace(22));
        make.height.mas_equalTo(kiP6WidthRace(22));
    }];
}


- (UIImageView *)BGImageView{
    if (!_BGImageView) {
        _BGImageView = InsertImageView(nil, CGRectZero, [UIImage imageNamed:@"bgCoupons"]);
    }
    return _BGImageView;
}

- (UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"￥30", KFont(20), kColorWhite, NO);
        [_moneyLabel wl_changeFontWithTextFont:KFont(30)changeText:@"30"];
    }
    return _moneyLabel;
}

- (UILabel *)vouchersLabel
{
    if (!_vouchersLabel) {
        _vouchersLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"现金券", KFont(15), kColorWhite, NO);
    }
    return _vouchersLabel;
}
//投资满100000.00元可用
- (UILabel *)availableLabel
{
    if (!_availableLabel) {
        _availableLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"", KFont(13), kColorBlack, NO);
        _availableLabel.numberOfLines = 0;
    }
    return _availableLabel;
}


- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"有效期至: 2018-10-10", KFont(11), UIColorRGB(61,142,233), NO);
    }
    return _timeLabel;
}

- (UIImageView *)markImage{
    if (!_markImage) {
        _markImage = InsertImageView(nil, CGRectZero, [UIImage imageNamed:@"determine"]);
    }
    return _markImage;
}

- (void)setupCellContentWithModel:(CardVoucherListDataModel *)model
{
    _moneyLabel.text = ChangeNullData(model.coupon_money);
    _timeLabel.text = [NSString stringWithFormat:@"有效期至:%@",model.valid_time_end];
    [_timeLabel wl_changeColorWithTextColor:UIColorRGB(160,160,160) changeText:@"有效期至:"];
    _availableLabel.text = ChangeNullData(model.descriptionStr);
    
}

@end

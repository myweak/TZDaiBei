//
//  InvestmentRecordwCell.m
//  JingYuDai
//
//  Created by air on 2018/3/30.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "InvestmentRecordwCell.h"
@interface InvestmentRecordwCell()
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong)UIImageView *iconImage;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *stateLabel;
@property (nonatomic,strong) UILabel *periodLabel; //第几期
@property (nonatomic,strong) UILabel *paymentLabel; //已付款
@property (nonatomic,strong) UIView *lineView; //线
@property (nonatomic,strong) UILabel *principalLabel; //本金（元）
@property (nonatomic,strong) UILabel *m_principalLabel; //本金
@property (nonatomic,strong) UILabel *interestLabel; //利息（元）
@property (nonatomic,strong) UILabel *m_interestLabel; //利息
@property (nonatomic,strong) UILabel *actualTimeLabel; //时间
@property (nonatomic,strong) UILabel *m_actualTimeLabel; //时间
@property (nonatomic,strong) UILabel *actualMoneyLabel; //时间
@property (nonatomic,strong) UILabel *m_actualMoneyLabel; //时间


@end


@implementation InvestmentRecordwCell

+ (instancetype)creatCellWithTableView:(UITableView *)tableView {
    InvestmentRecordwCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        
        cell = [[InvestmentRecordwCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.height = kiP6WidthRace(180);
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {//kLyBgColor
        self.backgroundColor = kColorWhite;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.bgView];
        [self addSubview:self.iconImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.stateLabel];
        [self addSubview:self.periodLabel];
        [self addSubview:self.paymentLabel];
        [self addSubview:self.lineView];
        
        [self addSubview:self.principalLabel];
        [self addSubview:self.m_principalLabel];
        
        [self addSubview:self.interestLabel];
        [self addSubview:self.m_interestLabel];
        
        [self addSubview:self.actualTimeLabel];
        [self addSubview:self.m_actualTimeLabel];
        
        [self addSubview:self.actualMoneyLabel];
        [self addSubview:self.m_actualMoneyLabel];
        
        
        [self initView];
    }
    return self;
}
#pragma mark - getter
- (void)initView{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(kiP6WidthRace(10));
    }];
    
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(16));
        make.top.mas_equalTo(kiP6WidthRace(16));
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImage.mas_right).offset(kiP6WidthRace(8));
        make.top.mas_equalTo(kiP6WidthRace(16));
    }];
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kiP6WidthRace(16));
        make.top.mas_equalTo(kiP6WidthRace(16));
        make.width.mas_equalTo(kiP6WidthRace(70));
        make.height.mas_equalTo(kiP6WidthRace(20));
    }];
    
    [self.periodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(18));
        make.top.mas_equalTo(self.iconImage.mas_bottom).offset(kiP6WidthRace(16)) ;
    }];
    
    [self.paymentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kiP6WidthRace(18));
        make.top.mas_equalTo(self.iconImage.mas_bottom).offset(kiP6WidthRace(16)) ;
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(@0);
        make.top.mas_equalTo(self.periodLabel.mas_bottom).offset(kiP6WidthRace(10));
        make.height.mas_equalTo(kiP6WidthRace(1));
    }];
    
    [self.principalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(18));
        make.top.mas_equalTo(self.paymentLabel.mas_bottom).offset(kiP6WidthRace(15));
    }];
    
    [self.m_principalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kiP6WidthRace(18));
        make.top.mas_equalTo(self.paymentLabel.mas_bottom).offset(kiP6WidthRace(15));
    }];
    
    [self.interestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(18));
        make.top.mas_equalTo(self.principalLabel.mas_bottom).offset(kiP6WidthRace(15));
    }];
    
    [self.m_interestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kiP6WidthRace(18));
        make.top.mas_equalTo(self.principalLabel.mas_bottom).offset(kiP6WidthRace(15));
    }];
    
    [self.actualTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(18));
        make.top.mas_equalTo(self.interestLabel.mas_bottom).offset(kiP6WidthRace(15));
    }];
    
    [self.m_actualTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kiP6WidthRace(18));
        make.top.mas_equalTo(self.m_interestLabel.mas_bottom).offset(kiP6WidthRace(15));
    }];
    
    [self.actualMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(18));
        make.top.mas_equalTo(self.actualTimeLabel.mas_bottom).offset(kiP6WidthRace(15));
    }];
    
    [self.m_actualMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kiP6WidthRace(18));
        make.top.mas_equalTo(self.m_actualTimeLabel.mas_bottom).offset(kiP6WidthRace(15));
    }];
    
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = UIColorRGB(247, 247, 248);
    }
    return _bgView;
}

- (UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.image = [UIImage imageNamed:@"carLoans"];
    }
    return _iconImage;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"滴滴速借A-2211221212", KFont(15), UIColorHex(@"#333333"), NO);
    }
    return _nameLabel;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        _stateLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"正常待还", KFont(11), UIColorHex(@"#ffffff"), NO);
        _stateLabel.backgroundColor = UIColorHex(@"#70a5ff");
        _stateLabel.layer.cornerRadius = 10.0;
        ViewRadius(_stateLabel, 10);
    }
    return _stateLabel;
}

//第一期/共3期
- (UILabel *)periodLabel{
    if (!_periodLabel) {
        _periodLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"第一期/共3期", KFont(13), UIColorHex(@"#333333"), NO);
        //        _periodLabel.numberOfLines = 0;
    }
    return _periodLabel;
}
//已还款
- (UILabel *)paymentLabel{
    if (!_paymentLabel) {
        _paymentLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"0000", KFont(13), UIColorHex(@"#333333"), NO);
        //        _periodLabel.numberOfLines = 0;
    }
    return _paymentLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = UIColorRGB(234,234,234);
    }
    return _lineView;
}

//本金（元）
- (UILabel *)principalLabel{
    if (!_principalLabel) {
        _principalLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"本金(元)", KFont(13), UIColorHex(@"#999999"), NO);
        //        _periodLabel.numberOfLines = 0;
    }
    return _principalLabel;
}

- (UILabel *)m_principalLabel{
    if (!_m_principalLabel) {
        _m_principalLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"100", KFont(13), UIColorHex(@"#333333"), NO);
        //        _periodLabel.numberOfLines = 0;
    }
    return _m_principalLabel;
}
//利息(元)
- (UILabel *)interestLabel{
    if (!_interestLabel) {
        _interestLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"利息(元)", KFont(13), UIColorHex(@"#999999"), NO);
        //        _periodLabel.numberOfLines = 0;
    }
    return _interestLabel;
}

- (UILabel *)m_interestLabel{
    if (!_m_interestLabel) {
        _m_interestLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"200", KFont(13), UIColorHex(@"#333333"), NO);
        //        _periodLabel.numberOfLines = 0;
    }
    return _m_interestLabel;
}
// 实际回款时间
- (UILabel *)actualTimeLabel{
    if (!_actualTimeLabel) {
        _actualTimeLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"服务时间", KFont(13), UIColorHex(@"#999999"), NO);
        //        _periodLabel.numberOfLines = 0;
    }
    return _actualTimeLabel;
}

- (UILabel *)m_actualTimeLabel{
    if (!_m_actualTimeLabel) {
        _m_actualTimeLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"300", KFont(13), UIColorHex(@"#333333"), NO);
    }
    return _m_actualTimeLabel;
}
//实际回款金额(元)
- (UILabel *)actualMoneyLabel{
    if (!_actualMoneyLabel) {
        _actualMoneyLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"还款方式", KFont(13), UIColorHex(@"#999999"), NO);
    }
    return _actualMoneyLabel;
}

- (UILabel *)m_actualMoneyLabel{
    if (!_m_actualMoneyLabel) {
        _m_actualMoneyLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"400", KFont(13), UIColorHex(@"#333333"), NO);
    }
    return _m_actualMoneyLabel;
}

//查看明细
- (void)checkTheDetailsModel:(TransactionListDataModel *)model
{
//    _periodLabel.text = [NSString stringWithFormat:@"第%@期/共%@期",model.period,model.project_period];
//    if ([model.cur_status integerValue] == 1) {
//        _paymentLabel.text = @"正常待收";
//
//    }else if([model.cur_status integerValue] == 2){
//        _paymentLabel.text = @"逾期待收";
//
//    }else if([model.cur_status integerValue] == 2){
//        _paymentLabel.text = @"正常已收";
//
//    }else if([model.cur_status integerValue] == 2){
//        _paymentLabel.text = @"逾期已收";
//
//    }else{
//        _paymentLabel.text = @"提前收款";
//
//    }
//    _m_receivableLabel.text = ChangeNullData(model.need_time);
//    _m_interestLabel.text = ChangeNullData(model.interest);
//    _m_actualTimeLabel.text = ChangeNullData(model.real_time);
//    _m_actualMoneyLabel.text = ChangeNullData(model.real_money);
//    _m_principalLabel.text = ChangeNullData(model.principal);
    
    
}
//投资记录
- (void)investmentRecordModel:(TransactionListDataModel *)model{
    //    _phoneLabel.text = ChangeNullData(model.mobile);
    //    _moneyLabel.text = ChangeNullData(model.invest_money);
    //    _timeLabel.text = ChangeNullData(model.invest_time);
    
}


@end

//
//  MyLoanCell.m
//  JingYuDaiJieKuan
//  
//  Created by air on 2018/3/22.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//
//  我的投资 cell
#import "MyLoanCell.h"
@interface MyLoanCell()
@property(nonatomic ,strong)UILabel *titleLabel;  //滴滴速借 --180
@property(nonatomic ,strong)UILabel *moneyLabel;  //3500
@property(nonatomic ,strong)UILabel *investmentLabel;  //投资金额(元)
@property(nonatomic ,strong)UILabel *monthLabel;  //一个月
@property(nonatomic ,strong)UILabel *earningsMoneyLabel;  //100
@property(nonatomic ,strong)UILabel *earningsLabel;  //预期收益(元)
@property(nonatomic ,strong)UIView *lineView; //
@property(nonatomic ,strong)UILabel *interestLabel;  //9.5%
@property(nonatomic ,strong)UILabel *m_interestLabel;  //收益年化利率
@property(nonatomic ,strong)UILabel *timeLabel;  //2018-04-19
@property(nonatomic ,strong)UILabel *m_borrowingTime;
@property(nonatomic ,strong)UILabel *m_borrowingContract;
@property(nonatomic ,strong)UIButton *m_borrowingContractBtn;

@end

@implementation MyLoanCell

+ (instancetype)creatCellWithTableView:(UITableView *)tableView{
    MyLoanCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        cell = [[MyLoanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = kColorWhite;

        [self addSubview:self.titleLabel];
        [self addSubview:self.moneyLabel];
        [self addSubview:self.investmentLabel];
        [self addSubview:self.monthLabel];
        [self addSubview:self.earningsMoneyLabel];
        [self addSubview:self.earningsLabel];
        [self addSubview:self.lineView];
        [self addSubview:self.interestLabel];
        [self addSubview:self.m_interestLabel];
//        [self addSubview:self.timeLabel];
        [self addSubview:self.m_borrowingTime];
        [self addSubview:self.m_borrowingContract];
        [self addSubview:self.m_borrowingContractBtn];
        
        [self initView];

    }
    return self;
}

- (void)initView{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(15));
        make.top.mas_equalTo(kiP6WidthRace(16));
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(15));
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kiP6WidthRace(21));
    }];
    
    [self.investmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(15));
        make.top.mas_equalTo(self.moneyLabel.mas_bottom).offset(kiP6WidthRace(10));
    }];
    
    [self.monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenWidth/2 - 20);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kiP6WidthRace(21));
    }];
    
    [self.m_borrowingTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenWidth/2 - 20);
        make.top.mas_equalTo(self.monthLabel.mas_bottom).offset(kiP6WidthRace(10));
    }];
    
    [self.earningsMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(kiP6WidthRace(-15));
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kiP6WidthRace(21));
    }];
    
    [self.earningsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(kiP6WidthRace(-15));
        make.top.mas_equalTo(self.monthLabel.mas_centerY);
        make.height.mas_equalTo(kiP6WidthRace(25));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.top.mas_equalTo(self.investmentLabel.mas_bottom).offset(kiP6WidthRace(15));
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(kiP6WidthRace(1));
    }];
    
//    [self.interestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kiP6WidthRace(15));
//        make.top.mas_equalTo(self.lineView.mas_bottom).offset(kiP6WidthRace(15));
//    }];
    
    [self.m_interestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(15));
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(kiP6WidthRace(14));
    }];
    
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(kiP6WidthRace(-15));
//        make.top.mas_equalTo(self.lineView.mas_bottom).offset(kiP6WidthRace(37));
//    }];
    
    [self.m_borrowingContract mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(kiP6WidthRace(-15));
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(kiP6WidthRace(14));
    }];
    
    [self.m_borrowingContractBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(kiP6WidthRace(-15));
        make.top.mas_equalTo(self.lineView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kiP6WidthRace(100), kiP6WidthRace(44)));
    }];
    
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"鲸鱼宝A-18031226", kFontSize14, UIColorRGB(51,51,51), NO);
    }
    return _titleLabel;
}

- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"3500.00元", kFontSize18, UIColorRGB(255,116,78), NO);
    }
    return _moneyLabel;
}
- (UILabel *)investmentLabel{
    if (!_investmentLabel) {
        _investmentLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"借款金额(元)", kFontSize12, UIColorRGB(165,165,165), NO);
    }
    return _investmentLabel;
}

- (UILabel *)monthLabel{
    if (!_monthLabel) {
        _monthLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"6个月", kFontSize18, UIColorRGB(51,51,51), NO);
    }
    return _monthLabel;
}

- (UILabel *)earningsMoneyLabel{
    if (!_earningsMoneyLabel) {
        _earningsMoneyLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentRight, @"100", kFontSize18, UIColorRGB(255,116,78), NO);
    }
    return _earningsMoneyLabel;
}

- (UILabel *)earningsLabel{
    if (!_earningsLabel) {
        _earningsLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"    立即还款    ", kFontSize12, [UIColor whiteColor], NO);
        _earningsLabel.hidden = YES;
        _earningsLabel.backgroundColor = UIColorHex(@"0c72e3");
        [_earningsLabel setBackgroundColor: UIColorHex(@"0c72e3")];
        ViewRadius(_earningsLabel, kiP6WidthRace(25)/2);
        _earningsLabel.layer.borderColor = UIColorHex(@"0c72e3").CGColor;
    }
    return _earningsLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = InsertView(nil, CGRectZero, UIColorRGB(234,234,234));
    }
    return _lineView;
}

- (UILabel *)interestLabel{
    if (!_interestLabel) {
        _interestLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"9.5%", kFontSize18, UIColorRGB(255, 116, 78), NO);
        [self.interestLabel wl_changeFontWithTextFont:[UIFont systemFontOfSize:14] changeText:@"%"];
    }
    return _interestLabel;
}

- (UILabel *)m_interestLabel{
    if (!_m_interestLabel) {
        _m_interestLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"预期年化收益率", kFontSize12, UIColorRGB(165,165,165), NO);
    }
    return _m_interestLabel;
}


- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentRight, @"2018-04-19", kFontSize12, UIColorRGB(165,165,165), NO);
    }
    return _timeLabel;
}

- (UILabel *)m_borrowingTime{
    if (!_m_borrowingTime) {
        _m_borrowingTime = InsertLabel(nil, CGRectZero, NSTextAlignmentRight, @"借款期限", kFontSize12, UIColorRGB(165,165,165), NO);
    }
    return _m_borrowingTime;
}

- (UILabel *)m_borrowingContract{
    if (!_m_borrowingContract) {
        _m_borrowingContract = InsertLabel(nil, CGRectZero, NSTextAlignmentRight, @"借款合同", kFontSize12,  UIColorHex(@"#3f85ff"), NO);
    }
    return _m_borrowingContract;
}

- (UIButton *)m_borrowingContractBtn
{
    if (!_m_borrowingContractBtn) {
        _m_borrowingContractBtn = InsertImageButton(nil, CGRectZero, 100, nil, nil, self, @selector(borrowingContractBtn:));
    }
    
    return _m_borrowingContractBtn;
}

- (void)borrowingContractBtn:(UIButton *)sender{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(myLoanCellClick:)]) {
        [self.delegate myLoanCellClick:sender];
    }
}

- (void)setupCellContentWithModel:(TransactionListDataModel *)model
{
    self.titleLabel.text = [NSString stringWithFormat:@"%@-%@",ChangeNullData(model.project_name),ChangeNullData(model.contract_no)];
    self.moneyLabel.text = ChangeNullData(model.finance_money);
    self.monthLabel.text = [NSString stringWithFormat:@"%@个月",ChangeNullData(model.project_period)];
    self.earningsMoneyLabel.text = ChangeNullData(model.prospective_yield);
    NSString *left = model.leftRateInit;
    if (![model.rightRateInit isEqualToString:@""]) {
        NSString *right = [NSString stringWithFormat:@"+%@",model.rightRateInit];
        self.interestLabel.text = [NSString stringWithFormat:@"%@%@",left,right];
        [self.interestLabel wl_changeFontWithTextFont:kFontSize14 changeText:@"%"];
        [self.interestLabel wl_changeFontWithTextFont:kFontSize14 changeText:right];
    }else{
        self.interestLabel.text = [NSString stringWithFormat:@"%@",left];
        [self.interestLabel wl_changeFontWithTextFont:kFontSize14 changeText:@"%"];
    }
    
    NSString *title;
    if ([model.statusType isEqualToString:@"1"]) {
        _earningsLabel.hidden = NO;
        title = @"下一次还款时间";
    }else{
        
        if ([model.statusType isEqualToString:@"2"]) {
            title = @"借款时间";
        }else if ([model.statusType isEqualToString:@"3"]){
            title = @"结清时间";
        }
        _earningsLabel.hidden = YES;
        [self.monthLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(kiP6WidthRace(-15));
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kiP6WidthRace(21));
        }];
        
        [self.m_borrowingTime mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(kiP6WidthRace(-15));
            make.top.mas_equalTo(self.monthLabel.mas_bottom).offset(kiP6WidthRace(10));
        }];
    }
    
    
    self.m_interestLabel.text = [NSString stringWithFormat:@"%@  %@",title,ChangeNullData(model.c_time)];

   
    
    
//    self.timeLabel.text = ChangeNullData(model.need_time);

}


@end

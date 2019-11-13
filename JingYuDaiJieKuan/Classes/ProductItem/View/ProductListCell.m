//
//  ProductListCell.m
//  JingYuDaiJieKuan
//
//  Created by air on 2018/3/20.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "ProductListCell.h"

@interface ProductListCell ()
@property (nonatomic, strong) UILabel *titleLabel;  //鲸鱼宝A-18031226
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *theInterestRateLabel; //利率
@property (nonatomic, strong) UILabel *timeLabel; //产品期限
@property (nonatomic, strong) UILabel *earningsLabel; // 预计收益年化利率
@property (nonatomic, strong) UILabel *interestLabel; //先息后本

@property (nonatomic, strong) UILabel *expireLabel; //到期还本付息
@property (nonatomic, strong) UILabel *residueLabel; //剩余2000元
@property (nonatomic, strong) UIView *bgLine;
@property (nonatomic, strong) UILabel *percentageLabel;
@property (nonatomic, strong) UIView *percentageView;




@end
@implementation ProductListCell{

}

+ (instancetype)creatCellWithTableView:(UITableView *)tableView {
    ProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        
        cell = [[ProductListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kColorWhite;
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self.contentView addSubview:self.m_bgImageView];
//        [self addSubview:self.titleLabel];
//        [self addSubview:self.lineView];
//        [self addSubview:self.theInterestRateLabel];
//        [self addSubview:self.timeLabel];
//        [self addSubview:self.earningsLabel];
//        [self addSubview:self.interestLabel];
//        [self addSubview:self.takeUpBtn];
//        [self addSubview:self.expireLabel];
//        [self addSubview:self.residueLabel];
//        [self addSubview:self.bgLine];
//        [self addSubview:self.percentageLabel];
//        [self addSubview:self.percentageView];
        
        
        
        [self initView];
    }
    return self;
}

#pragma mark - getter

- (void)initView{
    
    [self.m_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
//    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kiP6WidthRace(15));
//        make.top.mas_equalTo(kiP6WidthRace(15));
//    }];
//    
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kiP6WidthRace(15));
//        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kiP6WidthRace(15));
//        make.width.mas_equalTo(kScreenWidth);
//        make.height.mas_equalTo(kiP6WidthRace(1));
//    }];
//    
//    [self.theInterestRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kiP6WidthRace(20));
//        make.top.equalTo(self.lineView.mas_bottom).offset(kiP6WidthRace(20));
//    }];
//
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kScreenWidth/2 - 48);
//        make.top.mas_equalTo(self.lineView.mas_bottom).offset(kiP6WidthRace(31));
//    }];
//
//    [self.earningsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kiP6WidthRace(20));
//        make.top.mas_equalTo(self.theInterestRateLabel.mas_bottom).offset(kiP6WidthRace(10));
//    }];
//    
//    [self.interestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kScreenWidth/2 - 75/2);
//        make.top.mas_equalTo(self.theInterestRateLabel.mas_bottom).offset(kiP6WidthRace(10));
//        make.width.mas_equalTo(kiP6WidthRace(75));
//        make.height.mas_equalTo(kiP6WidthRace(20));
//    }];
//    
//    [self.takeUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(kiP6WidthRace(-20));
//        make.top.equalTo(self.lineView.mas_bottom).offset(kiP6WidthRace(33));
////        make.width.mas_equalTo(kiP6WidthRace(70));
//        make.height.mas_equalTo(kiP6WidthRace(28));
//    }];
//    
//    [self.expireLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(-kiP6WidthRace(16));
//        make.left.mas_equalTo(kiP6WidthRace(20));
//    }];
//    
//    [self.residueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-kiP6WidthRace(20));
//        make.bottom.mas_equalTo(-kiP6WidthRace(16));
//    }];
//    
//    [self.bgLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kiP6WidthRace(20));
//        make.bottom.mas_equalTo(-kiP6WidthRace(50));
//        make.width.mas_equalTo(kiP6WidthRace(572/2));
//        make.height.mas_equalTo(kiP6WidthRace(1));
//    }];
//    
//    [self.percentageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.bgLine.mas_right).mas_offset(kiP6WidthRace(10));
//        make.centerY.mas_equalTo(self.bgLine);
//    }];
//    
//    [self.percentageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kiP6WidthRace(20));
//        make.bottom.mas_equalTo(-kiP6WidthRace(50));
//        make.width.mas_equalTo(572/4);
//        make.height.mas_equalTo(kiP6WidthRace(1));
//    }];
}

- (UIImageView *)m_bgImageView
{
    if (!_m_bgImageView) {
        _m_bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _m_bgImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = InsertLabel(self, CGRectZero, NSTextAlignmentLeft, @"鲸鱼宝A-18031226", kFontSize15, UIColorRGB(51, 51, 51), NO);
    }
    return _titleLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = InsertView(nil, CGRectZero, UIColorRGB(234, 234, 234));
    }
    return _lineView;
}
//9.5%
- (UILabel *)theInterestRateLabel{
    if (!_theInterestRateLabel) {
        _theInterestRateLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"", kFontSize21, UIColorRGB(255, 116, 78), NO);
        //UIColorRGB(185, 185, 185)
//        [self.theInterestRateLabel wl_changeFontWithTextFont:[UIFont systemFontOfSize:15] changeText:@"%"];
    }
    return _theInterestRateLabel;
}
//项目期限6个月
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"", kFontSize15, UIColorRGB(255,116,78), NO);
        //UIColorRGB(185, 185, 185)
//        [self.timeLabel wl_changeColorWithTextColor: UIColorRGB(255,116,78) changeText:@"6个月"];

    }
    return _timeLabel;
}

- (UILabel *)earningsLabel{
    if (!_earningsLabel) {
        _earningsLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"预期年化收益率", kFontSize11, UIColorRGB(153,153,153), NO);
    }
    return _earningsLabel;
}

- (UILabel *)interestLabel{
    if (!_interestLabel) {
        _interestLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"先息后本", kFontSize11, UIColorRGB(153,153,153), NO);
        _interestLabel.layer.borderColor = UIColorRGB(223,223,223).CGColor;
        _interestLabel.layer.borderWidth = 0.5f;
        _interestLabel.layer.masksToBounds = YES;
    }
    return _interestLabel;
}

- (UILabel *)expireLabel{
    if (!_expireLabel) {
        _expireLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"到期还本付息", kFontSize11,UIColorHex(@"#999999"), NO);
    }
    return _expireLabel;
}

- (UILabel *)residueLabel{
    if (!_residueLabel) {
        _residueLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"剩余3000.00元", kFontSize11, UIColorHex(@"#999999"), NO);
    }
    return _residueLabel;
}
- (UIButton *)takeUpBtn
{
    if (!_takeUpBtn) {
        _takeUpBtn  = InsertButtonWithType(nil, CGRectZero, 13, nil, nil, UIButtonTypeCustom);
        [_takeUpBtn normalTitle:@"立即投资"];
        [_takeUpBtn addTarget:self action:@selector(investment:) forControlEvents:UIControlEventTouchUpInside];

        //        [_m_loginAndRegisterBtn normalImage:@"cp_arr_right"];
        //字体颜色
        [_takeUpBtn normalTitleColor:UIColorRGB(255,255,255)];
        _takeUpBtn.titleLabel.font = KFont(13);
        //button 背景颜色   //UIColorRGB(185, 185, 185)
        [_takeUpBtn setBackgroundColor:UIColorRGB(61,133,255)];
        ViewRadius(_takeUpBtn, 5.0);
         // button边框颜色
        _takeUpBtn.layer.borderColor = kColorWhite.CGColor;
        _takeUpBtn.layer.borderWidth = 0.5;
    }
    return _takeUpBtn;
}
- (UIView *)bgLine{
    if (!_bgLine) {
        _bgLine = [[UIView alloc]init];
        _bgLine.backgroundColor =UIColorHex(@"#999999");
    }
    return _bgLine;
}

- (UILabel *)percentageLabel{
    if (!_percentageLabel) {
        _percentageLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"100%", kFontSize15, UIColorHex(@"#999999"), NO);
    }
    return _percentageLabel;
}
- (UIView *)percentageView{
    if (!_percentageView) {
        _percentageView = [[UIView alloc] init];
//        _percentageView.backgroundColor = [UIColor redColor];
    }
    return _percentageView;
}

- (void)investment:(UIButton *)sender{

    if (self.delegte && [self.delegte respondsToSelector:@selector(investmentCell:investmentId:)]) {
        [self.delegte investmentCell:self investmentId:nil];
    }
}
//项目列表
- (void)setupCellContentWithModel:(TransactionListDataModel *)model{
    self.titleLabel.text = ChangeNullData(model.project_name);//鲸鱼宝A-18031226
    NSString *left = model.leftRateInit;
    if (![model.rightRateInit isEqualToString:@""]) {
        NSString *right = [NSString stringWithFormat:@"+%@",model.rightRateInit];
        self.theInterestRateLabel.text = [NSString stringWithFormat:@"%@%@",left,right];//利率
        [self.theInterestRateLabel wl_changeFontWithTextFont:[UIFont systemFontOfSize:15] changeText:@"%"];
        [self.theInterestRateLabel wl_changeFontWithTextFont:[UIFont systemFontOfSize:15] changeText:right];
    }else{
        self.theInterestRateLabel.text = [NSString stringWithFormat:@"%@",model.leftRateInit];//利率
        [self.theInterestRateLabel wl_changeFontWithTextFont:[UIFont systemFontOfSize:15] changeText:@"%"];
    }
    self.timeLabel.text = [NSString stringWithFormat:@"项目期限%@个月",model.project_period];//产品期限
    [self.timeLabel wl_changeColorWithTextColor: UIColorRGB(51,51,51) changeText:@"项目期限"];
//    ：1-先息后本|2-到期本息|3-等本等息|4-等额本息|5-等额本金',
    if ([model.repay_way  isEqual: @"1"]) {
        self.interestLabel.text = @"先息后本";
    }else if ([model.repay_way  isEqual: @"2"]){
        self.interestLabel.text = @"到期本息";
    }else if ([model.repay_way  isEqual: @"3"]){
        self.interestLabel.text = @"等本等息";
    }else if ([model.repay_way  isEqual: @"4"]){
        self.interestLabel.text = @"等额本息";
    }else{
        self.interestLabel.text = @"等额本金";
    }
    //4-立即投资 |5-满标|6-满标|7-还款中|8-已结清|
    if ([model.cur_status isEqualToString: @"4"]) {
        if ([model.overplusTime isEqualToString:@"0"]) {
            [_takeUpBtn normalTitle: @"  立即投资  "];
            _takeUpBtn.backgroundColor =UIColorRGB(61, 133, 255);

        }else{
            [_takeUpBtn normalTitle: [NSString stringWithFormat:@" %@ ",model.valid_time_start]];
            _takeUpBtn.backgroundColor =UIColorRGB(255, 116, 78);
        }
        self.timeLabel.textColor = UIColorRGB(255, 116, 78);
        [self.timeLabel wl_changeColorWithTextColor: UIColorRGB(51,51,51) changeText:@"项目期限"];
        self.theInterestRateLabel.textColor = UIColorRGB(255, 116, 78);

    }else if([model.cur_status isEqualToString: @"7"]){
        self.theInterestRateLabel.textColor =UIColorRGB(185, 185, 185);
        self.timeLabel.textColor = UIColorRGB(185, 185, 185);
        [_takeUpBtn setBackgroundColor:UIColorRGB(185, 185, 185)];
        [self.timeLabel wl_changeColorWithTextColor: UIColorRGB(51,51,51) changeText:@"项目期限"];
        [_takeUpBtn normalTitle: @"  还款中  "];
    }else if([model.cur_status isEqualToString: @"8"]) {
        self.theInterestRateLabel.textColor =UIColorRGB(185, 185, 185);
        self.timeLabel.textColor = UIColorRGB(185, 185, 185);
        [_takeUpBtn setBackgroundColor:UIColorRGB(185, 185, 185)];
        [self.timeLabel wl_changeColorWithTextColor: UIColorRGB(51,51,51) changeText:@"项目期限"];
        [_takeUpBtn normalTitle: @"  已结清  "];
    }else{
        self.theInterestRateLabel.textColor =UIColorRGB(185, 185, 185);
        self.timeLabel.textColor = UIColorRGB(185, 185, 185);
        [_takeUpBtn setBackgroundColor:UIColorRGB(185, 185, 185)];
        [self.timeLabel wl_changeColorWithTextColor: UIColorRGB(51,51,51) changeText:@"项目期限"];
        [_takeUpBtn normalTitle: @"  已满标  "];
    }
}
//  优惠券  使用产品
- (void)useTheProductModel:(CardVoucherListDataModel *)model{
    self.titleLabel.text = ChangeNullData(model.project_name);//鲸鱼宝A-18031226
    self.theInterestRateLabel.text = [NSString stringWithFormat:@"%@%%",model.coupon_rate];//利率
    [self.theInterestRateLabel wl_changeFontWithTextFont:[UIFont systemFontOfSize:15] changeText:@"%"];
    self.timeLabel.text = [NSString stringWithFormat:@"项目期限%@个月",model.project_period];//产品期限
    [self.timeLabel wl_changeColorWithTextColor: UIColorRGB(51,51,51) changeText:@"项目期限"];
    [_takeUpBtn normalTitle: @" 立即投资 "];

    if ([model.repay_way  isEqual: @"1"]) {
        self.interestLabel.text = @"先息后本";
    }else if ([model.repay_way  isEqual: @"2"]){
        self.interestLabel.text = @"到期本息";
    }else if ([model.repay_way  isEqual: @"3"]){
        self.interestLabel.text = @"等本等息";
    }else if ([model.repay_way  isEqual: @"4"]){
        self.interestLabel.text = @"等额本息";
    }else{
        self.interestLabel.text = @"等额本金";
    }
}


@end

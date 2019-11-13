//
//  TransactionRecordsCell.m
//  JingYuDaiJieKuan
//
//  Created by air on 2018/3/22.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//
//  交易记录cell

#import "TransactionRecordsCell.h"

@interface TransactionRecordsCell()
@property (nonatomic,strong) UILabel *withdrawLable; // 提现
@property (nonatomic,strong) UILabel *amountLabel; //金额
@property (nonatomic,strong) UILabel *timeLabel; //时间
@property (nonatomic,strong) UILabel *availableBalanceLabel; //可用余额


@end

@implementation TransactionRecordsCell

+ (instancetype)creatCellWithTableView:(UITableView *)tableView {
    TransactionRecordsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        
        cell = [[TransactionRecordsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kLyBgColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    
        [self addSubview:self.withdrawLable];
        [self addSubview:self.amountLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.availableBalanceLabel];
        
        [self initView];
    }
    return self;
}

#pragma mark - getter
- (void)initView{
    [_withdrawLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(15));
        make.top.mas_equalTo(kiP6WidthRace(20));
//        make.height.mas_equalTo(kiP6WidthRace(20));
    }];
    
    [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(kiP6WidthRace(-15));
        make.top.mas_equalTo(self.withdrawLable.mas_bottom).offset(kiP6WidthRace(15));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(15));
        make.top.mas_equalTo(self.withdrawLable.mas_bottom).offset(kiP6WidthRace(15));
    }];
    
    [_availableBalanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(15));
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(kiP6WidthRace(14));
    }];
}

- (UILabel *)withdrawLable{
    if (!_withdrawLable) {
        _withdrawLable = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"提现", kFontSize15, UIColorHex(@"#333333"), NO);
    }
    return _withdrawLable;
}
-(UILabel *)amountLabel{
    if (!_amountLabel) {
        _amountLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentRight, @"", kFontSize12, kColorRoughness, NO);
    }
    return _amountLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"2018-03-21 12:12:12", kFontSize12, UIColorHex(@"#a5a5a5"), NO);
    }
    return _timeLabel;
}

- (UILabel *)availableBalanceLabel{
    if (!_availableBalanceLabel) {
        _availableBalanceLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentRight, @"", kFontSize12, UIColorHex(@"#a5a5a5"), NO);
    }
    return _availableBalanceLabel;
}

- (void)setupCellContentWithModel:(TransactionDetailsListDataModel *)model{
    
    _withdrawLable.text =ChangeNullData(model.name);
    _amountLabel.text = ChangeNullData(model.trade_money);
    _timeLabel.text = ChangeNullData(model.c_time);
    _availableBalanceLabel.text = [NSString stringWithFormat:@"可用余额%@",ChangeNullData(model.residue_money)];
    
    NSString *dasd = [NSString stringWithFormat:@"%@",model.color];
    _amountLabel.textColor = [DataHelper colorWithHexString:dasd];

}

@end

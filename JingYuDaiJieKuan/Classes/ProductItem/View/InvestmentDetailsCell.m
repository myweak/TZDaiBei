//
//  InvestmentDetailsCell.m
//  JingYuDaiJieKuan
//
//  Created by air on 2018/4/4.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "InvestmentDetailsCell.h"


@interface InvestmentDetailsCell()

@property(nonatomic ,strong)UILabel *leftLabel;
@property(nonatomic ,strong)UILabel *rightLabel;
@end

@implementation InvestmentDetailsCell

+ (instancetype)creatCellWithTableView:(UITableView *)tableView{
    InvestmentDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        cell = [[InvestmentDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = kColorWhite;
        
        [self addSubview:self.leftLabel];
        [self addSubview:self.rightLabel];

        [self initView];
        
    }
    return self;
}

- (void)initView{
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(17));
        make.top.mas_equalTo(kiP6WidthRace(10));
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(kiP6WidthRace(-17));
        make.top.mas_equalTo(kiP6WidthRace(10));
    }];
}

- (UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"你好", kFontSize13, UIColorHex(@"#a5a5a5"), NO);
    }
    return _leftLabel;
}
- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentRight, @"你好好", kFontSize13, UIColorHex(@"#a5a5a5"), NO);
    }
    return _rightLabel;
}
- (void)setupCellContentWithModel:(TransactionListDataModel *)model{
    _leftLabel.text = ChangeNullData(model.name);
    _rightLabel.text = ChangeNullData(model.value);
    NSString *dasd = [NSString stringWithFormat:@"%@",model.color];
    _rightLabel.textColor = [DataHelper colorWithHexString:dasd];
}

@end

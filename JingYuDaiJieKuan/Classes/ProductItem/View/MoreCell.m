//
//  MoreCell.m
//  JingYuDaiJieKuan
//
//  Created by air on 2018/3/22.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "MoreCell.h"

@interface MoreCell()
@property (nonatomic, strong)UIView *lineView;
@end
@implementation MoreCell

+ (instancetype)creatCellWithTableView:(UITableView *)tableView{
    MoreCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        cell = [[MoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.leftLabel];
        [self addSubview:self.rightLabel];
        [self addSubview:self.arrowImg];
        [self addSubview:self.lineView];
        [self initView];
        
    }
    return self;
}

- (void)initView{
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(20));
        make.top.mas_equalTo(kiP6WidthRace(20));
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(kiP6WidthRace(-15));
        make.top.mas_equalTo(kiP6WidthRace(20));

    }];
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(kiP6WidthRace(-15));
        make.top.mas_equalTo(kiP6WidthRace(20));
        make.width.mas_equalTo(kiP6WidthRace(7));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(15));
        make.bottom.mas_equalTo(kiP6WidthRace(1));
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(kiP6WidthRace(1));
    }];
    
}
//意见反馈
- (UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"", kFontSize15, UIColorRGB(51,51,51), NO);
    }
    return _leftLabel;
}
//人民鲸鱼公众号
- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentRight, @"", kFontSize14, UIColorRGB(102,102,102), NO);
    }
    return _rightLabel;
}
- (UIImageView *)arrowImg{
    if (!_arrowImg) {
        _arrowImg = InsertImageView(nil, CGRectZero, [UIImage imageNamed:@""]);
    }
    return _arrowImg;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = InsertView(nil, CGRectZero, kColorShortTerm);
    }
    return _lineView;
}
@end

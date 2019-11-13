//
//  MyProfileCell.m
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/7/3.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "MyProfileCell.h"

@implementation MyProfileCell

+ (instancetype)creatCellWithTableView:(UITableView *)tableView {
    MyProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        cell = [[MyProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self)];
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

- (void)initView
{
    [self addSubview:self.m_leftLabel];
    [self addSubview:self.m_rightLabel];
    [self addSubview:self.m_rightImage];
    
    [self.m_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(14));
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.m_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kiP6WidthRace(32));
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.m_rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kiP6WidthRace(32));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(kiP6WidthRace(42));
    }];
}

- (UILabel *)m_leftLabel
{
    if (!_m_leftLabel) {
        _m_leftLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"姓名", KFont(16), UIColorHex(@"#333333"), NO);
    }
    return _m_leftLabel;
}

- (UILabel *)m_rightLabel
{
    if (!_m_rightLabel) {
        _m_rightLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"10290220", KFont(14), UIColorHex(@"#a6a6a6"), NO);
    }
    return _m_rightLabel;
}

- (UIImageView *)m_rightImage
{
    if (!_m_rightImage) {
        _m_rightImage = [[UIImageView alloc]init];
        _m_rightImage.layer.masksToBounds = YES;
        _m_rightImage.layer.cornerRadius = 21;

    }
    return _m_rightImage;
}
@end

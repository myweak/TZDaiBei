//
//  TheFirstHomePageCell.m
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/6/26.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TheFirstHomePageCell.h"

@implementation TheFirstHomePageCell

+ (instancetype)creatCellWithTableView:(UITableView *)tableView {
    TheFirstHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        cell = [[TheFirstHomePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self)];
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
    self.backgroundColor = UIColor.clearColor;
    [self addSubview:self.bgView];
    [self addSubview:self.m_recommendedImage];
    [self.bgView addSubview:self.m_IconImage];
    [self.bgView addSubview:self.m_nameLabel];
    [self.bgView addSubview:self.m_timeLabel];
    [self.bgView addSubview:self.m_immediatelyBtn];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(15));
        make.top.mas_equalTo(kiP6WidthRace(5));
        make.width.mas_equalTo(kScreenWidth - kiP6WidthRace(30));
        make.height.mas_equalTo(kiP6WidthRace(41));
    }];
    
    [self.m_recommendedImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(15));
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-kiP6WidthRace(15));
        make.height.mas_equalTo(kiP6WidthRace(255/2));
    }];
    
    [self.m_IconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(15));
        make.centerY.equalTo(self);
        make.width.mas_equalTo(kiP6WidthRace(54/2));
        make.height.mas_equalTo(kiP6WidthRace(54/2));
    }];
    
    [self.m_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.m_IconImage.mas_right).offset(kiP6WidthRace(15));
        make.centerY.equalTo(self.m_IconImage.mas_centerY);
    }];
    
    [self.m_immediatelyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kiP6WidthRace(15));
        make.centerY.equalTo(self.m_IconImage.mas_centerY);
        make.width.mas_equalTo(kiP6WidthRace(156/2));
        make.height.mas_equalTo(kiP6WidthRace(54/2));
    }];
    
    [self.m_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.m_immediatelyBtn.mas_left).offset(-kiP6WidthRace(10));
        make.centerY.equalTo(self.m_IconImage.mas_centerY);
    }];
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor colorWithRed:236/255.0 green:243/255.0 blue:255/255.0 alpha:1.0];
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;

    }
    return _bgView;
}

- (UIImageView *)m_recommendedImage
{
    if (!_m_recommendedImage) {
        _m_recommendedImage = InsertImageView(nil, CGRectZero, [UIImage imageNamed:@""]);
        _m_recommendedImage.layer.cornerRadius = 8;
        _m_recommendedImage.layer.masksToBounds = YES;
    }
    return _m_recommendedImage;
}

- (UIImageView *)m_IconImage
{
    if (!_m_IconImage) {
        _m_IconImage = InsertImageView(nil, CGRectZero, [UIImage imageNamed:@""]);
        _m_IconImage.layer.cornerRadius = 5;
        _m_IconImage.layer.masksToBounds = YES;
    }
    return _m_IconImage;
}

- (UILabel *)m_nameLabel
{
    if (!_m_nameLabel) {
        _m_nameLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"", KFont(15), UIColorHex(@"#333333"), NO);
    }
    return _m_nameLabel;
}

- (UILabel *)m_timeLabel
{
    if (!_m_timeLabel) {
        _m_timeLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"", KFont(10), UIColorHex(@"#3a80ff"), NO);
    }
    return _m_timeLabel;
}

- (UIButton *)m_immediatelyBtn
{
    if (!_m_immediatelyBtn) {
        _m_immediatelyBtn = InsertButtonWithType(nil, CGRectZero, 100, self, nil, UIButtonTypeCustom);
        [_m_immediatelyBtn setUserInteractionEnabled:NO];
        _m_immediatelyBtn.titleLabel.font = KFont(13);
        [_m_immediatelyBtn setTitle:@"立即申请" forState:UIControlStateNormal];
        [_m_immediatelyBtn setTitleColor:UIColorHex(@"#3a80ff")
                           forState:UIControlStateNormal];
        _m_immediatelyBtn.layer.cornerRadius = 2.0;//2.0是圆角的弧度，根据需求自己更改
        [_m_immediatelyBtn.layer setBorderColor:UIColorHex(@"#3a80ff").CGColor];
        _m_immediatelyBtn.layer.borderWidth = 1.0f;//设置边框颜色
        //设置边框的粗细
        [_m_immediatelyBtn.layer setBorderWidth:1.0];
        //设置圆角的半径
        [_m_immediatelyBtn.layer setCornerRadius:54/4];
    }
    return _m_immediatelyBtn;
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

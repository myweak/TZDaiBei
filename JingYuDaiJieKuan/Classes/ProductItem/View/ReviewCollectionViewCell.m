//
//  ReviewCollectionViewCell.m
//  JingYuDaiJieKuan
//
//  Created by JY on 2018/4/10.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "ReviewCollectionViewCell.h"

@implementation ReviewCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self initWithUI];
    }
    return self;
}

- (void)initWithUI
{
    [self.contentView addSubview:self.m_imageView];
    [self.contentView addSubview:self.m_textLabel];
    
    [self.m_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.top.mas_equalTo(@0);
        make.height.mas_equalTo(kiP6WidthRace(128));
    }];
    
    [self.m_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.top.mas_equalTo(self.m_imageView.mas_bottom).offset(kiP6WidthRace(15));
    }];
}

-(void)getCellData:(TransactionListDataModel *)model
{
    [self.m_imageView sd_setImageWithURL:[NSURL URLWithString:model.value] placeholderImage:[UIImage imageNamed:@"smallPic_fail"]];
    self.m_textLabel.text = ChangeNullData(model.name);
}

-(UIImageView *)m_imageView
{
    if (!_m_imageView) {
        _m_imageView = [[UIImageView alloc]init];
        _m_imageView.backgroundColor = [UIColor clearColor];
        _m_imageView.image = [UIImage imageNamed:@"smallPic_fail"];
    }
    return _m_imageView;
}

-(UILabel *)m_textLabel
{
    if (!_m_textLabel) {
        _m_textLabel = [UIFactory createLabel:CGRectZero
                                      align:NSTextAlignmentCenter
                                       text:@"1111"
                                    textcolor:UIColorHex(@"#333333")
                                       font:kFontSize17];
    }
    return _m_textLabel;
}



@end

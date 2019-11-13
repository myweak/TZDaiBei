//
//  MyProfileUserInfoCell.m
//  FenQiLe
//
//  Created by Dason on 2019/8/21.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "MyProfileUserInfoCell.h"

@implementation MyProfileUserInfoCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (void)initView{
    [self addSubview:self.phoneLbl];
    [self addSubview:self.wellcomeLbl];
    [self addSubview:self.iconImage];
    
    [self.phoneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(33);
        make.height.mas_equalTo(25);
        make.left.equalTo(self.contentView).offset(12);
        make.right.equalTo(self.iconImage.mas_left).offset(-12);
    }];
    
    [self.wellcomeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLbl.mas_bottom).offset(1);
        make.height.mas_equalTo(18);
        make.right.left.equalTo(self.phoneLbl);
    }];
    
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(55);
        make.right.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
}
    
    
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (UILabel *)phoneLbl
{
    if (!_phoneLbl) {
        _phoneLbl = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"", KFont(18), UIColorHex(@"#141B30"), NO);
    }
    return _phoneLbl;
}

- (UILabel *)wellcomeLbl
{
    if (!_wellcomeLbl) {
        _wellcomeLbl = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"", KFont(13), UIColorHex(@"#B3B7C1"), NO);
    }
    return _wellcomeLbl;
}

- (UIImageView *)iconImage
{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]init];
        _iconImage.layer.masksToBounds = YES;
        _iconImage.layer.cornerRadius = 21;
        
    }
    return _iconImage;
}

@end

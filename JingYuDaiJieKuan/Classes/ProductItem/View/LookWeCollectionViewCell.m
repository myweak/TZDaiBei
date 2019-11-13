//
//  LookWeCollectionViewCell.m
//  JingYuDaiJieKuan
//
//  Created by JY on 2018/3/31.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "LookWeCollectionViewCell.h"

@implementation LookWeCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self initWithUI];
    }
    return self;
}

-(void)initWithUI
{
    
    [self addSubview:self.m_titleLb];
    [self.m_titleLb addSubview:self.m_lineView];

    
    [self.m_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.equalTo(self);
        make.width.mas_equalTo(kiP6WidthRace(100));
        make.height.mas_equalTo(kiP6WidthRace(50));

    }];
    
    [self.m_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.equalTo(self.m_titleLb).offset(kiP6WidthRace(41));
        make.width.mas_equalTo(kiP6WidthRace(100));
        make.height.mas_equalTo(kiP6WidthRace(3));
        
    }];
}

#pragma getter

- (UILabel *)m_titleLb
{
    if (!_m_titleLb) {
        _m_titleLb = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"名字", KFont(13) ,kColorBlack, NO);
    }
    
    return _m_titleLb;
}

- (UIView *)m_lineView
{
    if (!_m_lineView) {
        _m_lineView = InsertView(nil, CGRectZero, kColorRed);
    }
    
    return _m_lineView;
}












@end

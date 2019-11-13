//
//  TestCollectionCell.m
//  DKSTableCollcetionView
//
//  Created by aDu on 2017/10/10.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import "RootCollectionCell.h"

@interface RootCollectionCell ()

//@property (nonatomic, strong) UILabel *m_label;
//@property (nonatomic, strong) UIImageView *m_imageView;

@end

@implementation RootCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
//        self.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
        
        [self addSubview:self.m_imageView];
        [self addSubview:self.m_label];
        
        [self.m_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.mas_equalTo(kiP6WidthRace(10));
            make.width.mas_equalTo(kiP6WidthRace(25));
            make.height.mas_equalTo(kiP6WidthRace(25));
        }];
        
        [self.m_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.m_imageView.mas_bottom).offset(kiP6WidthRace(10));
        }];
    }
    return self;
}

- (void)setTextStr:(NSString *)textStr {
    if (_textStr != textStr) {
        _textStr = textStr;
        self.m_label.text = textStr;
    }
}

- (UILabel *)m_label
{
    if (!_m_label) {
        _m_label = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"", KFont(12), UIColorHex(@"#151517"), NO);
    }
    return _m_label;
}

- (UIImageView *)m_imageView
{
    if (!_m_imageView) {
        _m_imageView = InsertImageView(nil, CGRectZero,[UIImage imageNamed:@"m_icon"]);
        _m_imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _m_imageView;
}
@end

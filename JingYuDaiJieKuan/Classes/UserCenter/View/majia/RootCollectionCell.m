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

        [self addSubview:self.m_imageView];
        [self addSubview:self.m_label];
        
        [self.m_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.contentView);
            make.width.mas_equalTo(22);
            make.height.mas_equalTo(22);
        }];
        
        [self.m_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.contentView);
        }];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self);
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
        _m_label = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"", KFont(12), UIColorHex(@"#FFFFFF"), NO);
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

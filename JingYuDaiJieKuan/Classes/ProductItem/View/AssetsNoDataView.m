//
//  AssetsNoDataView.m
//  NewJingYuBao
//
//  Created by air on 16/9/20.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import "AssetsNoDataView.h"
@interface AssetsNoDataView ()
@property (strong ,nonatomic) UIImageView *iconImageV;
@property (strong ,nonatomic) UILabel     *textLabel;
@end
@implementation AssetsNoDataView

- (instancetype)init{
    if (self = [super init]) {
        [self createIconImage];
        [self createLabel];
    }
    return self;
}

- (void)createIconImage{
//    UIImage *image = LoadImage(@"notrade_image");
    UIImage *image = [UIImage imageNamed:@"notrade_image"];
    _iconImageV = [[UIImageView alloc] init];
    _iconImageV.image = image;
    [self addSubview:_iconImageV];
    [_iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(KWidth(70));
        make.width.mas_equalTo(kiP6WidthRace(image.size.width));
        make.height.mas_equalTo(kiP6WidthRace(image.size.height));
    }];
    
}

- (void)createLabel{
//    _textLabel =[DViewManager initLabelWithBackColor:[UIColor clearColor] textColor:UIColorHexSystem(0xcccccc, 1.0) font:UIAutoFontNornal(14) textAlignment:NSTextAlignmentCenter content:@"当前没有收益记录哦"];
    _textLabel = InsertLabel(self, CGRectZero, NSTextAlignmentCenter, @"当前没有收益记录哦", kFontSize14, [UIColor clearColor], NO);
    [self addSubview:_textLabel];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageV.mas_bottom).offset(15);
        make.left.right.equalTo(self);
    }];
}

- (void)changeMessage:(NSString *)msg{
    _textLabel.text = msg;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

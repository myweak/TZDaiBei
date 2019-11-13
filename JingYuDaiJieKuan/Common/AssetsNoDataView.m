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

@property (strong ,nonatomic) UIButton     *refreshButton;
@end
@implementation AssetsNoDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI];
    }
    return self;
}

- (void)initWithUI{
    UIImage *image = [UIImage imageNamed:@"noData_holdmoment"];
    _iconImageV = [[UIImageView alloc] init];
    _iconImageV.image = image;
    [self addSubview:_iconImageV];
    [_iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(-image.size.height/2);
        make.width.mas_equalTo(image.size.width);
        make.height.mas_equalTo(image.size.height);
    }];
    
    
    self.tipsLabel = [[UILabel alloc]init];
    self.tipsLabel.font = KFont(14);
    self.tipsLabel.textColor = UIColorHex(@"#666666");
    self.tipsLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.tipsLabel];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(@0);
        make.top.mas_equalTo(self.iconImageV.mas_bottom).mas_offset(AutoGetHeight(10));
        make.height.mas_equalTo(AutoGetHeight(30));
    }];
    
    self.refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.refreshButton setTitle:@"刷新" forState:UIControlStateNormal];
    [self.refreshButton setTitleColor:UIColorRGB(61, 133, 255) forState:UIControlStateNormal];
    [self.refreshButton addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.refreshButton];
    [self.refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tipsLabel.mas_bottom).mas_offset(AutoGetHeight(10));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(kiP6WidthRace(120));
        make.height.mas_equalTo(AutoGetHeight(40));
    }];
    self.refreshButton.layer.cornerRadius = AutoGetHeight(40)/2;
    self.refreshButton.layer.borderColor = UIColorRGB(61, 133, 255).CGColor;
    self.refreshButton.layer.borderWidth = 1.0f;
}

-(void)refreshAction:(UIButton *)button
{
    if (self.refreshDataBlock) {
        self.refreshDataBlock();
    }
}

- (void)changeMessage:(NSString *)msg{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

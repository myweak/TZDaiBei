//
//  CMTPaoMaView.m
//  NewJingYuBao
//
//  Created by JY on 2019/1/23.
//  Copyright © 2019年 萤火虫. All rights reserved.
//

#import "CMTPaoMaView.h"

@interface CMTPaoMaView()

@property (nonatomic, strong)UIView *bgView;

@property (nonatomic, strong)UIImageView *m_bgImage;

@property (nonatomic, copy) NSString *m_title;

@property (nonatomic, copy) NSMutableArray *m_titleArray;

// 跑马灯左边图片
@property (nonatomic, strong)UIImageView *m_image;

@property (nonatomic, assign)BOOL isShowIcon;

@end

@implementation CMTPaoMaView

//- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.m_title = title;
//        [self initView];
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSMutableArray *)titleArray isShowIcon:(BOOL)isShowIcon
{
    self = [super initWithFrame:frame];
    if (self) {
        self.m_titleArray = titleArray;
        self.isShowIcon = isShowIcon;
        [self initView];
    }
    return self;
}

- (void)initView{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.m_bgImage];
    [self.bgView addSubview:self.m_image];
    [self.m_image setHidden:!self.isShowIcon];
    // 添加 横向 跑马灯
//    [self addHorizontalMarquee];
//    [self.bgView addSubview:self.m_horizontalMarquee];
    
    // 添加 纵向 跑马灯
    [self addVerticalMarquee];
    [self.bgView addSubview:self.verticalMarquee];
    
    
    [self makeConstraints];
    
}

- (void)makeConstraints{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.m_bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.m_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.left.mas_equalTo(kiP6WidthRace(15));
        make.size.mas_equalTo(CGSizeMake(kiP6WidthRace(17), kiP6WidthRace(17)));
    }];

//    [self.m_horizontalMarquee mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.bgView.mas_centerY);
//        make.left.mas_equalTo(self.m_image.mas_right).offset(kiP6WidthRace(6));
//         make.right.mas_equalTo(kiP6WidthRace(-14));
//        make.height.mas_equalTo(kiP6WidthRace(20));
//    }];
    
//    [self.verticalMarquee mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.bgView.mas_centerY);
//        if (self.isShowIcon) {
//            make.left.mas_equalTo(self.m_image.mas_right).offset(kiP6WidthRace(6));
//        } else {
//            make.left.mas_equalTo(kiP6WidthRace(15));
//        }
//        make.right.mas_equalTo(kiP6WidthRace(-15));
//        make.height.mas_equalTo(kiP6WidthRace(20));
//    }];
    
}

#pragma mark 横向 跑马灯
/** 添加 横向 跑马灯 */
- (void)addHorizontalMarquee {
    
    CGFloat Width = [self calculateRowWidth:self.m_title];
    
    if (Width < (kScreenWidth - kiP6WidthRace(30))) {
        // 关闭跑马灯
        [self.m_horizontalMarquee marqueeOfSettingWithState:MarqueeShutDown_H];
    }else{
        // 开启跑马灯
        [self.m_horizontalMarquee marqueeOfSettingWithState:MarqueeStart_H];
    }
    self.m_horizontalMarquee.text = self.m_title;
    self.m_horizontalMarquee.textColor = UIColorHex(@"0x999999");
    self.m_horizontalMarquee.font = KFont(12);
}
#pragma mark 纵向 跑马灯
/** 添加纵向 跑马灯 */
- (void)addVerticalMarquee {
    [self.verticalMarquee scrollWithCallbackBlock:^(JhtVerticalMarquee *view, NSInteger currentIndex) {
//        NSLog(@"滚动到第 %ld 条数据", (long)currentIndex);
    }];
//    NSArray *soureArray = @[@"1. 谁曾从谁的青春里走过，留下了笑靥",
//                            @"2. 谁曾在谁的花季里停留，温暖了想念",
//                            @"3. 谁又从谁的雨季里消失，泛滥了眼泪",
//                            @"4. 人生路，路迢迢，谁道自古英雄多寂寥，若一朝，看透了，一身清风挣多少"
//                            ];
    //    self.verticalMarquee.isCounterclockwise = YES;
    self.verticalMarquee.sourceArray = self.m_titleArray;//self.m_titleArray;
    
    // 开始滚动
    [self.verticalMarquee marqueeOfSettingWithState:MarqueeStart_V];
}

- (CGFloat)calculateRowWidth:(NSString *)string {
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};  //指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, 30)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width;
}

#pragma mark - Get
/** 横向 跑马灯 */
- (JhtHorizontalMarquee *)m_horizontalMarquee {
    if (!_m_horizontalMarquee) {
        _m_horizontalMarquee = [[JhtHorizontalMarquee alloc] initWithFrame:CGRectZero singleScrollDuration:20.0];
        _m_horizontalMarquee.tag = 100;
        _m_horizontalMarquee.backgroundColor = kColorClear;
        // 添加点击手势
        UITapGestureRecognizer *htap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(marqueeTapGes:)];
        [_m_horizontalMarquee addGestureRecognizer:htap];
    }
    
    return _m_horizontalMarquee;
}

/** 纵向 跑马灯 */
- (JhtVerticalMarquee *)verticalMarquee {
    if (!_verticalMarquee) {
        
        if (self.isShowIcon) {
            _verticalMarquee = [[JhtVerticalMarquee alloc] initWithFrame:CGRectMake(kiP6WidthRace(40), kiP6WidthRace(9), kScreenWidth - kiP6WidthRace(80), kiP6WidthRace(20))];
        } else {
            _verticalMarquee = [[JhtVerticalMarquee alloc] initWithFrame:CGRectMake(kiP6WidthRace(15), kiP6WidthRace(9), kScreenWidth - kiP6WidthRace(60), kiP6WidthRace(20))];
        }
        _verticalMarquee.tag = 101;
        //        _verticalMarquee.isCounterclockwise = YES;
        _verticalMarquee.verticalNumberOfLines = 0;
        _verticalMarquee.verticalTextColor = UIColorHex(@"#6f747d");// [UIColor purpleColor];
        // 添加点击手势
        UITapGestureRecognizer *htap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapVertical)];
        [_verticalMarquee addGestureRecognizer:htap];
    }
    
    return _verticalMarquee;
}

- (UIView *)bgView{
    
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor =kColorWhite;// UIColorHex(@"#fff2dc");
    }
    return _bgView;
}

- (UIImageView *)m_image{
    if (!_m_image) {
        _m_image = [[UIImageView alloc] initWithFrame:CGRectZero];
        _m_image.image = [UIImage imageNamed:@"homepage_notice"];
    }
    return _m_image;
}

- (UIImageView *)m_bgImage
{
    if (!_m_bgImage) {
        _m_bgImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _m_bgImage.image = [UIImage imageNamed:@""];
    }
    return _m_bgImage;
}

#pragma mark - Action
/// 点击了垂直滚动视图
- (void)tapVertical {
    if (self.PaoMaDengBlock){
        self.PaoMaDengBlock(self.verticalMarquee.currentIndex);
    }
}

@end

//
//  PigMJRefreshGifHeader.m
//  JingYuDaiJieKuan
//
//  Created by JY on 2018/4/8.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "PigMJRefreshGifHeader.h"
#import <UIImage+GIF.h>


@interface PigMJRefreshGifHeader()
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UISwitch *s;
@property (weak, nonatomic) UIImageView *logo;
@property (nonatomic, strong) UIImage *logoImg;
@property (weak, nonatomic) UIActivityIndicatorView *loading;
@end

@implementation PigMJRefreshGifHeader

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    CGFloat heightY = iPhoneX?kiP6WidthRace(80):KWidth(60);

    self.mj_h = heightY;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image1 = [UIImage  sd_imageWithGIFData:data];
    UIImageView *logo = [[UIImageView alloc] initWithImage:image1];
    _logoImg = [UIImage imageWithContentsOfFile:[[NSUserDefaults standardUserDefaults] objectForKey:@"REFERSHLOGO"]?:@""];
    _logo.image = _logoImg;
    logo.contentMode = UIViewContentModeScaleAspectFill;
    
    [self addSubview:logo];
    logo.clipsToBounds = YES;
    self.logo = logo;
    
    //    // loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
//        self.loading = loading;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
//    //    // 设置普通状态的动画图片
//    NSMutableArray *idleImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=30; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%zd", i]];
//        [idleImages addObject:image];
//    }
//    [self setImages:idleImages forState:MJRefreshStateIdle];
//
//    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=30; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%zd", i]];
//        [refreshingImages addObject:image];
//    }
//    [self setImages:refreshingImages forState:MJRefreshStatePulling];
//
//    // 设置正在刷新状态的动画图片
//    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}
#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.label.frame = CGRectMake(0, self.height - 30, self.width, 16);
    
    CGFloat heightY = iPhoneX?kiP6WidthRace(10):kiP6WidthRace(0);
    self.logo.bounds = CGRectMake(0, heightY, kiP6WidthRace(30), KWidth(30));
    
    self.logo.center = CGPointMake(self.mj_w * 0.5, - self.center.y);
    
    self.loading.center = CGPointMake(self.mj_w*0.5, self.mj_h * 0.5);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.loading startAnimating];
            [self.s setOn:NO animated:YES];
            //            self.label.text = @"赶紧下拉刷新...";
            break;
        case MJRefreshStatePulling:
            [self.loading stopAnimating];
            [self.s setOn:YES animated:YES];
            //            self.label.text = @"可以放开我了...";
            break;
        case MJRefreshStateRefreshing:
            [self.s setOn:YES animated:YES];
            //            self.label.text = @"加载数据中...";
            [self.loading startAnimating];
            break;
        default:
            break;
    }
    
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    
}
#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
    //    CGFloat red = 1.0 - pullingPercent * 0.5;
    //    CGFloat green = 0.5 - 0.5 * pullingPercent;
    //    CGFloat blue = 0.5 * pullingPercent;
    self.label.textColor = kColorRed;
}

@end


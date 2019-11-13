//
//  NewPublicNoticeView.m
//  NewJingYuBao
//
//  Created by JY on 2018/6/4.
//  Copyright © 2018年 萤火虫. All rights reserved.
//
//读取图片
#define LoadImage(B)    [UIImage imageNamed:B]
#import "NewPublicNoticeView.h"

@implementation NewPublicNoticeView
-(instancetype)initWithContent:(NSString *)content
{
    if (self = [super init]) {
        [self customMainView:content];
    }
    return  self;
}

-(void)customMainView:(NSString *)content
{
    self.backgroundColor = UIColorRGBA(0, 0, 0, 0.75);
    UIView *windowView = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [windowView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(windowView);
    }];
    

    UIButton *bgButton = [UIFactory createButton:CGRectZero target:self action:@selector(showDetailClick) buttonType:UIButtonTypeCustom title:nil titleColor:nil font:nil];
    bgButton.layer.cornerRadius = 5.0;
    bgButton.layer.masksToBounds = YES;
    bgButton.userInteractionEnabled = YES;
    [self addSubview:bgButton];
    kSelfWeak;
    CGFloat topHeight = kiP6WidthRace(56);
    if (iPhone4) {
        topHeight = 50;
    }else if (iPhoneX){
        topHeight = 150;
    }
    [bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(topHeight);
        make.centerX.equalTo(weakSelf);
//        if (iPhonex) {
            make.size.mas_equalTo(CGSizeMake(kiP6WidthRace(530)/2, kiP6WidthRace(830)/2));
//        }else{
//        }
    }];
    
    UIImageView *headView = [[UIImageView alloc]init];
    headView.layer.cornerRadius = 5.0;
    headView.layer.masksToBounds = YES;
    [headView sd_setImageWithURL:[NSURL URLWithString:content] placeholderImage:LoadImage(@"publicnoticebg")];
    headView.userInteractionEnabled = YES;
    [bgButton addSubview:headView];
    
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgButton).with.insets(UIEdgeInsetsMake(40, 0, 0, 0));
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDetailClick)];
    [headView addGestureRecognizer:tap];
    
    UIButton *closeButton =  [UIFactory createButton:CGRectZero target:self action:@selector(hidenView) buttonType:UIButtonTypeCustom title:nil titleColor:nil font:nil];
    [closeButton setImage:[UIImage imageNamed:@"ggclose"] forState:UIControlStateNormal];
    [bgButton addSubview:closeButton];
    
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(kiP6WidthRace(31), kiP6WidthRace(31)));
    }];
    
    
}

-(void)showDetailClick
{
    if (self.clickblock) {
        self.clickblock();
    }
    [self removeFromSuperview];
}

-(void)hidenView
{
    if (self.noticeDisappearBlock)
    {
        self.noticeDisappearBlock();
    }
    
    [self removeFromSuperview];
}


@end

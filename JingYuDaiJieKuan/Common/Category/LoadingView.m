//
//  LoadingView.m
//  Cunpiao
//
//  Created by 陈启航 on 16/8/11.
//  Copyright © 2016年 cwb. All rights reserved.
//

#import "LoadingView.h"
#define kLeftDis (kScreenWidth - AutoWHGetWidth(133.0))/2.0

@interface LoadingView ()
{
    UIImageView *_image;
    LoadingType _type;
    NSString *_titleStr;
    
    UILabel *_title;

}

@end
@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame
                         type:(LoadingType)type

{
    self = [super initWithFrame:frame];
    if (self)
    {
        _type = type;

        
        [self initView];
    }
    return self;
}

- (void)initView
{
    
    _image = InsertImageView(self, CGRectMake(kLeftDis, AutoWHGetHeight(133.0), AutoWHGetWidth(133.0), AutoWHGetHeight(118.0)), nil);

    [_image setImage:[UIImage imageNamed:@"refresh1_icon"]];
    
    NSMutableArray *images = [[NSMutableArray alloc]initWithCapacity:3];
    
    for (NSInteger i = 1; i <= 3; i++)
    {
        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"refresh%ld_icon",(long)i]]];
    }
    
    _image.animationImages = images;
    _image.animationDuration = 1.0;
    _image.animationRepeatCount = 0;
    [_image startAnimating];
    
    if( _type == LoadingFromChargeType )
    {
        InsertLabel(_image, CGRectMake(0, AutoWHGetHeight(57.5), _image.width, AutoWHGetHeight(15.0)), NSTextAlignmentCenter , @"支付中...", kFontSize15, kColorWhite, NO);
    }
    else if ( _type == LoadingFromPayType)
    {
        InsertLabel(_image, CGRectMake(0, AutoWHGetHeight(57.5), _image.width, AutoWHGetHeight(15.0)), NSTextAlignmentCenter , @"支付中...", kFontSize15, kColorWhite, NO);
    }
}


@end

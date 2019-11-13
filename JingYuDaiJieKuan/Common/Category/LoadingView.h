//
//  LoadingView.h
//  Cunpiao
//
//  Created by 陈启航 on 16/8/11.
//  Copyright © 2016年 cwb. All rights reserved.
//

typedef enum : NSUInteger
{
    LoadingFromChargeType,     //充值
    LoadingFromPayType,    //付款
}LoadingType;

#import <UIKit/UIKit.h>

@interface LoadingView : UIView


- (instancetype)initWithFrame:(CGRect)frame
                         type:(LoadingType)type;


@end

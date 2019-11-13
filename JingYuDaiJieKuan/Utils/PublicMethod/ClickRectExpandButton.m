//
//  ClickRectExpandButton.m
//  WhaleFinancial
//
//  Created by shine on 15/7/22.
//  Copyright (c) 2015年 JPlay. All rights reserved.
//

#import "ClickRectExpandButton.h"

@implementation ClickRectExpandButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    
//    DLog(@"%f===%f",widthDelta,heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end

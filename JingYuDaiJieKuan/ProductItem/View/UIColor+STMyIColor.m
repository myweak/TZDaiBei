//
//  UIColor+STMyIColor.m
//  my
//
//  Created by soso-mac on 2016/11/28.
//  Copyright © 2016年 soso-mac. All rights reserved.
//

#import "UIColor+STMyIColor.h"

@implementation UIColor (STMyIColor)
+ (UIColor *)fromHexValue:(NSUInteger)hex alpha:(CGFloat)alpha {
    if ( hex == 0xECE8E3 ) {
        
    }
    NSUInteger r = ((hex >> 16) & 0x000000FF);
    NSUInteger g = ((hex >> 8) & 0x000000FF);
    NSUInteger b = ((hex >> 0) & 0x000000FF);
    
    float fr = (r * 1.0f) / 255.0f;
    float fg = (g * 1.0f) / 255.0f;
    float fb = (b * 1.0f) / 255.0f;
    
    return [UIColor colorWithRed:fr green:fg blue:fb alpha:alpha];
}
@end

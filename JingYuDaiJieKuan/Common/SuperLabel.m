//
//  SuperLabel.m
//  Cunpiao
//
//  Created by weibin on 2017/3/13.
//  Copyright © 2017年 cwb. All rights reserved.
//

#import "SuperLabel.h"

@implementation SuperLabel

+ (Class)layerClass
{
    return [CATextLayer class];
}

- (CATextLayer *)textLayer
{
    return (CATextLayer *)self.layer;
}

- (void)setUp
{
    // 提高视图渲染速度
    self.opaque = YES;
    // 异步绘制
    self.layer.drawsAsynchronously = YES;
    self.text = self.text;
    self.textColor = self.textColor;
    self.font = self.font;
    self.numberOfLines = 0;
    [self textLayer].contentsScale = [UIScreen mainScreen].scale;
    [self textLayer].truncationMode = kCATruncationNone;
    [self.layer display];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setUp];
}

- (void)setText:(NSString *)text
{
    super.text = text;
    [self textLayer].string = text;
}

- (void)setTextColor:(UIColor *)textColor
{
    super.textColor = textColor;
    [self textLayer].foregroundColor = textColor.CGColor;
}

- (void)setFont:(UIFont *)font
{
    super.font = font;
    
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    [self textLayer].font = fontRef;
    [self textLayer].fontSize = font.pointSize;
    CGFontRelease(fontRef);
}

- (void)setAlignmentMode:(NSString *)alignmentMode
{
    [self textLayer].alignmentMode = alignmentMode;
}

- (void)setWrapped:(BOOL)wrapped
{
    [self textLayer].wrapped = wrapped;
}

@end

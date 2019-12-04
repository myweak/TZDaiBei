//
//  UILabel+Additions.m
//  AntHouse
//
//  Created by 飞礼科技 on 2017/12/25.
//  Copyright © 2017年 Nathan Ou. All rights reserved.
//

#import "UILabel+Additions.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>

@implementation UILabel (Additions)
-(CGFloat)characterSpace{
    return [objc_getAssociatedObject(self,_cmd) floatValue];
}

-(void)setCharacterSpace:(CGFloat)characterSpace{
    objc_setAssociatedObject(self, @selector(characterSpace), @(characterSpace), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(CGFloat)lineSpace{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}
-(CGFloat)paragraphSpacing{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

-(NSInteger)KNumberLine{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}
-(void)setKNumberLine:(NSInteger)KNumberLine{
    objc_setAssociatedObject(self, @selector(KNumberLine), @(KNumberLine), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setLineSpace:(CGFloat)lineSpace{
    objc_setAssociatedObject(self, @selector(lineSpace), @(lineSpace), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)setParagraphSpacing:(CGFloat)paragraphSpacing{
    objc_setAssociatedObject(self, @selector(paragraphSpacing), @(paragraphSpacing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSInteger)maxNumberLine{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}
-(void)setMaxNumberLine:(NSInteger)maxNumberLine{
    objc_setAssociatedObject(self, @selector(maxNumberLine), @(maxNumberLine), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)keywords{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setKeywords:(NSString *)keywords{
    objc_setAssociatedObject(self, @selector(keywords), keywords, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIFont *)keywordsFont{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setKeywordsFont:(UIFont *)keywordsFont{
    objc_setAssociatedObject(self, @selector(keywordsFont), keywordsFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIColor *)keywordsColor{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setKeywordsColor:(UIColor *)keywordsColor{
    objc_setAssociatedObject(self, @selector(keywordsColor), keywordsColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)underlineStr{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setUnderlineStr:(NSString *)underlineStr{
    objc_setAssociatedObject(self, @selector(underlineStr), underlineStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(UIColor *)underlineColor{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setUnderlineColor:(UIColor *)underlineColor{
    objc_setAssociatedObject(self, @selector(underlineColor), underlineColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(void)setMoneytypeFont:(UIFont *)moneytypeFont{
    objc_setAssociatedObject(self, @selector(moneytypeFont), moneytypeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSInteger)headSpace{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}
-(void)setHeadSpace:(NSInteger)headSpace{
    objc_setAssociatedObject(self, @selector(headSpace), @(headSpace), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 *  根据最大宽度计算label宽，高
 *
 *  @param maxWidth 最大宽度
 *
 *  @return rect
 */
- (CGRect)getLableHeightWithMaxWidth:(CGFloat)maxWidth{
    
    if (self.text.length == 0) {
        return CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0);
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0,self.text.length)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    // 行间距
    if(self.lineSpace > 0){
        [paragraphStyle setLineSpacing:self.lineSpace];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,self.text.length)];
    }
    
    // 字间距
    if(self.characterSpace > 0){
        
        NSNumber *number =  [NSNumber numberWithFloat:self.characterSpace];
        [attributedString addAttribute:(id)kCTKernAttributeName value:number range:NSMakeRange(0,[attributedString length]-1)];
        
    }
    
    // 首行缩进字符
    if(self.headSpace > 0){
        CGFloat emptylen = (self.font.pointSize + self.characterSpace) * self.headSpace;
        [paragraphStyle setHeadIndent:0.0f]; //行首缩进
        [paragraphStyle setFirstLineHeadIndent:emptylen]; //首行缩进
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,self.text.length)];
    }
    
    
    //关键字
    if (self.keywords) {
        NSRange itemRange = [self.text rangeOfString:self.keywords];
        if (self.keywordsFont) {
            [attributedString addAttribute:NSFontAttributeName value:self.keywordsFont range:itemRange];
            
        }
        
        if (self.keywordsColor) {
            [attributedString addAttribute:NSForegroundColorAttributeName value:self.keywordsColor range:itemRange];
            
        }
    }
    
    //下划线
    if (self.underlineStr) {
        NSRange itemRange = [self.text rangeOfString:self.underlineStr];
        [attributedString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:itemRange];
        UIColor *color = self.underlineColor ? self.underlineColor:(self.keywordsColor?self.keywordsColor:self.textColor);
        [attributedString addAttribute:NSUnderlineColorAttributeName value:color range:itemRange];
    }
    
    //段落后面的间距
    if(self.paragraphSpacing > 0){
        [paragraphStyle setParagraphSpacing:self.paragraphSpacing];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,self.text.length)];
    }
    
    self.attributedText = attributedString;
    
    CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    rect.origin.x = self.frame.origin.x;
    rect.origin.y = self.frame.origin.y;
    
    // 限制 行数
    if (self.KNumberLine !=0) {
        //  内容
        self.numberOfLines  = self.KNumberLine;
        CGFloat h =  self.font.lineHeight *self.KNumberLine +self.lineSpace *(self.KNumberLine -1);
        if (rect.size.height > h) {
            CGRect frame = rect;
            frame.size.height = h;
            rect = frame;
        }
    }
    
    return rect;
}
- (void)setAttributedString:(NSString *)string font:(UIFont *)font fontRange:(NSRange)fontRange color:(UIColor *)color colorRange:(NSRange)colorRange{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    if (font) {
        [str addAttribute:NSFontAttributeName value:font range:fontRange];
    }
    if (color) {
        [str addAttribute:NSForegroundColorAttributeName value:color range:colorRange];
    }
    
    self.attributedText = str;
}
- (void)setAttributedString:(NSString *)string lineSpacing:(NSInteger)lineSpacing font:(UIFont *)font fontRange:(NSRange)fontRange color:(UIColor *)color colorRange:(NSRange)colorRange{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    if (font) {
        [str addAttribute:NSFontAttributeName value:font range:fontRange];
    }
    if (color) {
        [str addAttribute:NSForegroundColorAttributeName value:color range:colorRange];
    }
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
    self.attributedText = str;
    
}

- (void)changeAligLeftAndRight{
   CGRect rect = [self getLableHeightWithMaxWidth:self.width];
    CGFloat margin = (self.width -rect.size.width)/(self.text.length -1);
    self.characterSpace = margin;
    [self reloadUIConfig];
    
}

/** 更新设置 */
- (void)reloadUIConfig{
    [self getLableHeightWithMaxWidth:self.width];
}
@end

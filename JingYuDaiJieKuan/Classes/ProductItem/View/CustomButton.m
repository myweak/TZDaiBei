//
//  CustomButton.m
//  NewJingYuBao
//
//  Created by 暴走的狗 on 16/7/12.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//
#define kGrayColor  UIColorRGB(204, 204, 204);
#define kBlueColor  kLightBtnColor;
#import "CustomButton.h"

@implementation CustomButton

- (instancetype)initWithTitle:(NSString *)title titleFont:(UIFont *)font effective:(BOOL)effective{
    if (self = [super init]) {
        if (StringHasDataJudge(title)) {
            [self setTitle:title forState:UIControlStateNormal];
        }
        if (font) {
            self.titleLabel.font = font;
        }
        self.effective = effective;
    }
    return self;
}

- (void)setEffective:(BOOL)effective{
    _effective = effective;
    if (_effective) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = kColorWhite;
    }else{
        self.userInteractionEnabled = NO;
        self.backgroundColor = kGrayColor;
    }
}

@end

@implementation ClickButton

- (instancetype)initWithTitle:(NSString *)title cornerRadius:(CGFloat)cornerRadius{
    if (self = [super init]) {
        if (StringHasDataJudge(title)) {
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitleColor:kColorBlack forState:UIControlStateNormal];
            self.titleLabel.font = KFont(15);
            self.layer.masksToBounds = YES;
            self.layer.cornerRadius = cornerRadius;
        }
    }
    return  self;
}
//label 颜色
- (void)clickState{//
    [self setBackgroundColor:kColorClear];
    [self setTitleColor:kColorBlack forState:UIControlStateNormal];
}

- (void)resignClickState{
    [self setBackgroundColor:[UIColor clearColor]];
    [self setTitleColor:kColorBlack forState:UIControlStateNormal];
}

@end



@implementation NextButton

- (instancetype)initWithTitle:(NSString *)title effective:(BOOL)effective{
    if (self = [super init]) {
        if (StringHasDataJudge(title)) {
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitleColor:kColorWhite forState:UIControlStateNormal];
        }
        if (effective == YES) {
            self.backgroundColor=kColorWhite;
            self.userInteractionEnabled = YES;
        }
        else{
            self.backgroundColor=kColorWhite;
            self.userInteractionEnabled = NO;
        }
        ViewRadius(self, kiP6WidthRace(3));
        self.titleLabel.font = KFont(18);
        
    }
    return self;
}

- (void)setEffective:(BOOL)effective{
    _effective = effective;
    if (_effective) {
        self.backgroundColor=kColorWhite;
        self.userInteractionEnabled = YES;
    }else{
        self.backgroundColor=kColorWhite;
        self.userInteractionEnabled = NO;
    }
}

@end

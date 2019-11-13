//
//  SelectTypeView.m
//  Cunpiao
//
//  Created by weibin on 2016/11/7.
//  Copyright © 2016年 cwb. All rights reserved.
//

#import "SelectTypeView.h"

#define kLeftDis AutoWHGetWidth(20.0)
#define kDis AutoWHGetWidth(10.0)
#define kBtnWidth (kScreenWidth - 2 * kDis - 2 * kLeftDis) / 3.0
#define kBtnHeight AutoWHGetHeight(38.0)

@interface SelectTypeView ()<UIGestureRecognizerDelegate>
{
    NSArray *_titleArray;
    NSUInteger _curBtnTag;
}
@property (nonatomic ,strong) UIButton *tempIndexBtn;
@property (nonatomic,assign)BOOL indexBtnFlag;

@property (nonatomic ,assign) NSInteger btnTag;

@end

@implementation SelectTypeView

- (instancetype)initWithFrame:(CGRect)frame title:(NSArray *)title selectNum:(NSInteger)selectNum
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UITapGestureRecognizer *tapGesture  =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        tapGesture.delegate = self;
        [self addGestureRecognizer:tapGesture];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(tapAction:)];
        panGesture.delegate = self;
        [self addGestureRecognizer:panGesture];
        
        _titleArray = [NSArray arrayWithArray:title];
        
        double height = AutoWHGetHeight(40.0) + kBtnHeight * ceil(title.count / 3.0) + kDis * (ceil(title.count / 3.0) - 1);
        
        UIView *bgView = InsertView(self, CGRectMake(0, 0, kScreenWidth, height), kColorWhite);

        for (NSInteger i = 0; i < title.count; i ++)
        {
            @autoreleasepool
            {
                UIButton *btn = InsertButtonRoundedRect(bgView, CGRectMake(kLeftDis + (kBtnWidth + kDis) * (i % 3) , AutoWHGetHeight(20.0) + (kBtnHeight + (AutoWHGetHeight(9))) * floorf(i / 3.0), kBtnWidth, kBtnHeight), 105 + i, title[i], self, @selector(btnClick:));
                btn.titleLabel.font = kFontSize14;
                btn.layer.cornerRadius = 6.0;
                btn.layer.borderWidth = 0.5;
                btn.layer.borderColor = kLySeparatorColor.CGColor;
                [btn normalTitleColor:UIColorRGB(102,102,102)];
//                [btn setTitleColor:kLyBlackColor forState:UIControlStateNormal];
//                [btn setTitleColor:kColorWhite forState:UIControlStateDisabled];
                
                [btn setBackgroundImage:[UIImage imageWithColor:kColorWhite size:CGSizeMake(btn.width, btn.height)] forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageWithColor:kColorBlue size:CGSizeMake(btn.width, btn.height)] forState:UIControlStateDisabled];
                [btn setBackgroundImage:[UIImage imageWithColor:kColorBlue size:CGSizeMake(btn.width, btn.height)] forState:UIControlStateHighlighted];
                btn.clipsToBounds = YES;
                
            
               
                if (i == selectNum)
                {
                    _curBtnTag = selectNum;
//                    btn.enabled = NO;
//                    btn.userInteractionEnabled = NO;
                }
                else
                {
//                    btn.enabled = YES;
//                    btn.userInteractionEnabled = YES;
                }
                
            }
        }
    }
    
    return self;
}

- (void)colorBtn:(UIButton *)sender
{
    if (sender.tag -105 == 0 ) {
        [sender setTitleColor:kColorBlue forState:UIControlStateNormal];
        sender.layer.borderColor = kColorBlue.CGColor;
    }else
    {
        [sender setTitleColor:kLySeparatorColor forState:UIControlStateNormal];
        sender.layer.borderColor = kLySeparatorColor.CGColor;
    }
}
- (void)btnClick:(UIButton *)sender
{
    UIButton *btn = [self viewWithTag:sender.tag];
    self.btnTag = btn.tag - 105;

    if (self.indexBtnFlag) {
        if (self.tempIndexBtn) {
            [self.tempIndexBtn setTitleColor:UIColorRGB(102,102,102) forState:UIControlStateNormal];
            [btn setTitleColor:kColorBlue forState:UIControlStateNormal];
            btn.layer.borderColor = kColorBlue.CGColor;
             self.tempIndexBtn.layer.borderColor = kLySeparatorColor.CGColor;

        }else{
            [btn setTitleColor:UIColorRGB(102,102,102) forState:UIControlStateNormal];
            btn.layer.borderColor = kLySeparatorColor.CGColor;

        }
    }else
    {
        if (self.tempIndexBtn) {
            [self.tempIndexBtn setTitleColor:UIColorRGB(102,102,102) forState:UIControlStateNormal];
            [btn setTitleColor:kColorBlue forState:UIControlStateNormal];
            self.tempIndexBtn.layer.borderColor = kLySeparatorColor.CGColor;
            btn.layer.borderColor = kColorBlue.CGColor;

        }else{
            [btn setTitleColor:kColorBlue forState:UIControlStateNormal];
            btn.layer.borderColor = kColorBlue.CGColor;
        }
    }
    self.tempIndexBtn = btn;
    self.indexBtnFlag = !self.indexBtnFlag;

    
//    NSInteger index = sender.tag - 105;
//    _curBtnTag = index;
//
//    for (NSInteger i = 0; i < _titleArray.count; i++)
//    {
//        @autoreleasepool
//        {
//            UIButton *btn = (UIButton *)[self viewWithTag:i + 105];
//
//            if (i != _curBtnTag)
//            {
//                btn.enabled = YES;
//                btn.userInteractionEnabled = YES;
//            }
//            else
//            {
//                btn.enabled = NO;
//                btn.userInteractionEnabled = NO;
//            }
//        }
//    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(selectItem:)])
    {
        [_delegate selectItem:self.btnTag];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(dismissView)])
    {
        [_delegate dismissView];
    }
}

@end

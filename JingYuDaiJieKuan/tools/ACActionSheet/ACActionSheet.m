//
//  ACActionSheet.m
//  ACActionSheetDemo
//
//  Created by Zhangziyun on 16/5/3.
//  Copyright © 2016年 章子云. All rights reserved.
//
//  GitHub:     https://github.com/GardenerYun
//  Email:      gardeneryun@foxmail.com
//  简书博客地址: http://www.jianshu.com/users/8489e70e237d/latest_articles
//  如有问题或建议请联系我，我会马上解决问题~ (ง •̀_•́)ง
//

#import "ACActionSheet.h"
#import <Masonry/Masonry.h>

#define ACScreenWidth   [UIScreen mainScreen].bounds.size.width
#define ACScreenHeight  [UIScreen mainScreen].bounds.size.height
#define ACRGB(r,g,b)    [[UIColor alloc] initWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define ACTitleFont    [UIFont systemFontOfSize:16 weight:UIFontWeightMedium]

#define ACTitleHeight 60.0f
#define ACButtonHeight  49.0f

#define ACDarkShadowViewAlpha 0.35f

#define ACShowAnimateDuration 0.3f
#define ACHideAnimateDuration 0.2f

@interface ACActionSheet () {
    
    NSString *_cancelButtonTitle;
    NSString *_destructiveButtonTitle;
    NSArray *_otherButtonTitles;
    
    
    UIView *_buttonBackgroundView;
    UIView *_darkShadowView;
    
    UIScrollView *_buttonScrollView;
}

@property (nonatomic, copy) ACActionSheetBlock actionSheetBlock;

@end

@implementation ACActionSheet

- (instancetype)initWithTitle:(NSString *)title delegate:(id<ACActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {

    self = [super init];
    if(self) {
        _title = title;
        _delegate = delegate;
        _cancelButtonTitle = cancelButtonTitle.length>0 ? cancelButtonTitle : @"取消";
        _destructiveButtonTitle = destructiveButtonTitle;
        
        NSMutableArray *args = [NSMutableArray array];
        
        if(_destructiveButtonTitle.length) {
            [args addObject:_destructiveButtonTitle];
        }
        
        [args addObject:otherButtonTitles];
        
        if (otherButtonTitles) {
            va_list params;
            va_start(params, otherButtonTitles);
            id buttonTitle;
            while ((buttonTitle = va_arg(params, id))) {
                if (buttonTitle) {
                    [args addObject:buttonTitle];
                }
            }
            va_end(params);
        }
        
        _otherButtonTitles = [NSArray arrayWithArray:args];
     
        [self _initSubViews];
    }
    
    return self;
}


- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles actionSheetBlock:(ACActionSheetBlock) actionSheetBlock; {
    
    self = [super init];
    if(self) {
        _title = title;
        _cancelButtonTitle = cancelButtonTitle.length>0 ? cancelButtonTitle : @"取消";
        _destructiveButtonTitle = destructiveButtonTitle;
        
        NSMutableArray *titleArray = [NSMutableArray array];
        if (_destructiveButtonTitle.length) {
            [titleArray addObject:_destructiveButtonTitle];
        }
        [titleArray addObjectsFromArray:otherButtonTitles];
        _otherButtonTitles = [NSArray arrayWithArray:titleArray];
        self.actionSheetBlock = actionSheetBlock;
        
        [self _initSubViews];
    }
    
    return self;
    
}

- (void)setContentsMaxHeight:(CGFloat)height
{

    BOOL canScroll = height<= _buttonBackgroundView.height;
    _buttonScrollView.scrollEnabled = canScroll;
    
    _buttonBackgroundView.height = MIN(height, _buttonBackgroundView.height);
    
    _buttonScrollView.height = _buttonBackgroundView.height - ACTitleHeight;
}

- (void)_initSubViews {

    self.frame = CGRectMake(0, 0, ACScreenWidth, ACScreenHeight);
    self.backgroundColor = [UIColor clearColor];
    self.hidden = YES;
    
    _darkShadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ACScreenWidth, ACScreenHeight)];
    _darkShadowView.backgroundColor = ACRGB(20, 20, 20);
    _darkShadowView.alpha = 0.0f;
    [self addSubview:_darkShadowView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_dismissView:)];
    [_darkShadowView addGestureRecognizer:tap];
    
    _buttonBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    _buttonBackgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_buttonBackgroundView];
    
    CGFloat titleHeight = 0;
    CGFloat maxViewY = 0;
    if (self.title.length) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ACButtonHeight-ACTitleHeight, ACScreenWidth, ACTitleHeight)];
        titleLabel.text = _title;
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = ACRGB(125, 125, 125);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:13.0f];
        titleLabel.backgroundColor = [UIColor whiteColor];
        [_buttonBackgroundView addSubview:titleLabel];
        titleHeight = ACTitleHeight;
        maxViewY = CGRectGetMaxY(titleLabel.frame);
    }
    
    _buttonScrollView = [[UIScrollView alloc]init];
    _buttonScrollView.scrollEnabled = NO;
    _buttonScrollView.bounces = NO;
    [_buttonBackgroundView addSubview:_buttonScrollView];
    
    CGFloat maxBtnY = 0;
    for (int i = 0; i < _otherButtonTitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button setTitle:_otherButtonTitles[i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        button.titleLabel.font = ACTitleFont;
        [button setTitleColor:[@"#626466" getColor] forState:UIControlStateNormal];
        if (i == 0 && _destructiveButtonTitle.length) {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        
        UIImage *image = [UIImage imageNamed:@"ACActionSheet.bundle/wkkeeper_actionSheetHighLighted.png"];
        [button setBackgroundImage:image forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(_didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, maxBtnY, ACScreenWidth, ACButtonHeight);
        [_buttonScrollView addSubview:button];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor = [@"#F7F8F9" getColorWithAlpha:1];
        line.frame = CGRectMake(16, button.frame.size.height -1, ACScreenWidth - 32, 1);
        [button addSubview:line];
        maxBtnY = CGRectGetMaxY(button.frame);
    }
    
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.tag = _otherButtonTitles.count;
    [cancelButton setTitle:_cancelButtonTitle forState:UIControlStateNormal];
    cancelButton.backgroundColor = [UIColor whiteColor];
    cancelButton.titleLabel.font = ACTitleFont;
    [cancelButton setTitleColor:[@"#FF9500" getColor] forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"ACActionSheet.bundle/wkkeeper_actionSheetHighLighted.png"];
    [cancelButton setBackgroundImage:image forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(_didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.frame = CGRectMake(0, maxBtnY + 5, ACScreenWidth, ACButtonHeight);
    [_buttonScrollView addSubview:cancelButton];
    maxBtnY = CGRectGetMaxY(cancelButton.frame) + iPhoneXDiffHeight();
    
    _buttonScrollView.frame = CGRectMake(0, maxViewY, kScreenWidth, maxBtnY);
    _buttonScrollView.contentSize = CGSizeMake(kScreenWidth, maxBtnY);
    maxViewY = CGRectGetMaxY(_buttonScrollView.frame);

    
    _buttonBackgroundView.frame = CGRectMake(0, ACScreenHeight, ACScreenWidth, maxViewY);
    //绘制左上、右上圆角 要设置的圆角 使用“|”来组合
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_buttonBackgroundView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(12, 12)];
    maskLayer.frame = _buttonBackgroundView.bounds;
    maskLayer.path = maskPath.CGPath;
    _buttonBackgroundView.layer.mask = maskLayer;

}

- (void)_didClickButton:(UIButton *)button {

    if (_delegate && [_delegate respondsToSelector:@selector(actionSheet:didClickedButtonAtIndex:)]) {
        [_delegate actionSheet:self didClickedButtonAtIndex:button.tag];
    }
    
    if (self.actionSheetBlock) {
        self.actionSheetBlock(button.tag);
    }
    
    [self _hide];
}

- (void)_dismissView:(UITapGestureRecognizer *)tap {

    if (_delegate && [_delegate respondsToSelector:@selector(actionSheet:didClickedButtonAtIndex:)]) {
        [_delegate actionSheet:self didClickedButtonAtIndex:_otherButtonTitles.count];
    }
    
    if (self.actionSheetBlock) {
        self.actionSheetBlock(_otherButtonTitles.count);
    }
    
    [self _hide];
}

- (void)show {

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    self.hidden = NO;
    
    [UIView animateWithDuration:ACShowAnimateDuration animations:^{
        self->_darkShadowView.alpha = ACDarkShadowViewAlpha;
        self->_buttonBackgroundView.transform = CGAffineTransformMakeTranslation(0, -self->_buttonBackgroundView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showWithBlackBg {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    self.hidden = NO;
    
    [UIView animateWithDuration:ACShowAnimateDuration animations:^{
        self->_darkShadowView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.6];
        self->_darkShadowView.alpha = 1.f;
        self->_buttonBackgroundView.transform = CGAffineTransformMakeTranslation(0, -self->_buttonBackgroundView.frame.size.height);
    } completion:^(BOOL finished) { }];
}

- (void)_hide {
    
    [UIView animateWithDuration:ACHideAnimateDuration animations:^{
        self->_darkShadowView.alpha = 0;
        self->_buttonBackgroundView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

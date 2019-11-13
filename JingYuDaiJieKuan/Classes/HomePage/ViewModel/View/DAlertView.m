//
//  DAlertView.m
//  NewJingYuBao
//
//  Created by linshaokai on 16/7/5.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import "DAlertView.h"
@interface DAlertView ()

@property (strong ,nonatomic) UIView *m_contentView;
@property (strong ,nonatomic) UIButton *m_cancleButton;
@property (strong ,nonatomic) UIButton *m_sureButton;
@property (strong ,nonatomic) UILabel *m_titleLabel;

@property (strong ,nonatomic) UIView *m_lineView;
@property (strong ,nonatomic) UITextView *m_messageView;


@property (copy ,nonatomic) AlertViewBlock alertBlock;

@end
@implementation DAlertView

+(DAlertView *)initAlertViewWithTitle:(NSString *)title message:(NSString *)message  cancleButtonTitle:(NSString *)cancleButtonTitle sureButtonTitle:(NSString *)sureButtonTitle clickBlock:(AlertViewBlock)block
{
    CGFloat heigth ;
    if (iPhoneX) {
        heigth = kiP6WidthRace(44);
    }else
    {
        heigth = kiP6WidthRace(20);
    }
    DAlertView *alertView = [[DAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight + heigth )];
    [alertView customContentViewTitle:title message:message cancleButtonTitle:cancleButtonTitle sureButtonTitle:sureButtonTitle clickBlock:block];
    
    return alertView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    return self;
}


-(void)customContentViewTitle:(NSString *)title message:(NSString *)message  cancleButtonTitle:(NSString *)cancleButtonTitle sureButtonTitle:(NSString *)sureButtonTitle clickBlock:(AlertViewBlock)block
{
    self.alertBlock = block;
    
    self.m_contentView = [[UIView alloc]init];
    self.m_contentView.layer.masksToBounds = YES;
    self.m_contentView.layer.cornerRadius = 5.0f;
    self.m_contentView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.m_contentView];
    
    if (StringHasDataJudge(title)) {
        self.m_titleLabel = InsertLabel(nil, CGRectZero, 1, title, KFont(17), UIColorRGB(12, 114, 227), NO);
        self.m_titleLabel.adjustsFontSizeToFitWidth = YES;
        self.m_lineView = [[UIView alloc]init];
        self.m_lineView.backgroundColor = UIColorHex(@"#e5e5e5");
        [self.m_contentView addSubview:self.m_titleLabel];
        [self.m_contentView addSubview:self.m_lineView];
        
    }
    
    if (StringHasDataJudge(message)) {
        self.m_messageView = [[UITextView alloc]init];
//        self.m_messageView.editable = NO;
        self.m_messageView.textColor = UIColorRGB(128, 128, 128);
        self.m_messageView.font = KFont(14);
        self.m_messageView.selectable = NO;
        self.m_messageView.text = message;
        [self.m_contentView addSubview:self.m_messageView];
    }
    
    if (StringHasDataJudge(cancleButtonTitle)) {
        self.m_cancleButton = InsertButtonWithType(nil, CGRectZero, 101, self, @selector(buttonClick:), UIButtonTypeCustom);
        self.m_cancleButton.backgroundColor =  UIColorRGB(204, 204, 204);
        self.m_cancleButton.titleLabel.font = KFont(14);
        [self.m_cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.m_cancleButton setTitle:cancleButtonTitle forState:UIControlStateNormal];
        
        self.m_cancleButton.layer.cornerRadius = 5.0f;
        
        [self.m_contentView addSubview:self.m_cancleButton];
    }
    
    if (StringHasDataJudge(sureButtonTitle)) {
        self.m_sureButton = InsertButtonWithType(nil, CGRectZero, 101, self, @selector(buttonClick:), UIButtonTypeCustom);
        self.m_sureButton.backgroundColor = UIColorRGB(12, 114, 227);
        self.m_sureButton.titleLabel.font = KFont(14);
        [self.m_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.m_sureButton setTitle:sureButtonTitle forState:UIControlStateNormal];
        self.m_sureButton.layer.cornerRadius = 5.0f;
        
        [self.m_contentView addSubview:self.m_sureButton];
    }
    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewWidth = kScreenWidth - 20 * 2;
    
    CGFloat contentHeight = 10.0;
    if (self.m_titleLabel) {
        self.m_titleLabel.frame = CGRectMake(10, contentHeight, viewWidth - 20, kiP6WidthRace(18));
        contentHeight += 10;
        contentHeight += kiP6WidthRace(18);
    }
    
    
    if (self.m_titleLabel && self.m_messageView) {
        self.m_lineView.frame = CGRectMake(10, contentHeight, viewWidth - 20, 1);
        contentHeight += 12;
    }
    
    if (self.m_messageView) {
        CGFloat messageHeight = [self.m_messageView.text calculateTextHeight:kiP6WidthRace(14) withWidth:viewWidth - 30] + 20;
        if (messageHeight > kiP6WidthRace(280)) {
            messageHeight = kiP6WidthRace(280);
        }
        
        self.m_messageView.frame = CGRectMake(15, contentHeight, viewWidth - 30, messageHeight);
        contentHeight += (messageHeight + 10);
        
    }
    
    CGFloat buttonWidth = (viewWidth - 30) / 2.0;
    if (self.m_cancleButton == nil || self.m_sureButton == nil) {
        buttonWidth = viewWidth - 20;
    }
    CGFloat sureX = 10;
    if (self.m_cancleButton) {
        self.m_cancleButton.frame = CGRectMake(10, contentHeight, buttonWidth, kiP6WidthRace(36));
        sureX = 20 + buttonWidth;
    }
    if (self.m_sureButton) {
        self.m_sureButton.frame = CGRectMake(sureX, contentHeight, buttonWidth, kiP6WidthRace(36));
    }
    if (self.m_cancleButton || self.m_sureButton) {
        contentHeight += 20;
        contentHeight += kiP6WidthRace(36);
    }
    
    self.m_contentView.frame = CGRectMake(20, (kScreenHeight - contentHeight) / 2.0, viewWidth, contentHeight);
    
}


-(void)buttonClick:(UIButton *)button
{
    if (self.alertBlock) {
        if (button == self.m_cancleButton) {
            self.alertBlock(0);
        }else
        {
            self.alertBlock(1);
        }
    }
    [self hidenView];
}

-(void)show
{
    self.alpha = 0;
//    [kAppDelegate.getHomeViewController.navigationController.view addSubview:self];
    UIApplication *ap = [UIApplication sharedApplication];
    [ap.keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1.0;
    }];
}
-(void)hidenView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end

//
//  CustomAlertView.m
//  NewJingYuBao
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import "CustomAlertView.h"

#define kAlertViewWidth             kiP6WidthRace(310)
#define kAlertBtnHeight             kiP6WidthRace(40)
#define kAlertTextToTop             kiP6WidthRace(15)
#define kAlertHaveTitleTextToTop    kiP6WidthRace(10)
#define kAlertTextToBtn             kiP6WidthRace(10)

@interface CustomAlertView ()

@property (nonatomic, strong) UIView *m_contentView;

@property (nonatomic, strong) UIButton *m_BGCloseBtn;

@property (nonatomic, strong) UILabel *m_titleLabel;

@property (nonatomic, strong) UIView *m_lineView;



@property (nonatomic, strong) UIButton *m_btn;

@property (nonatomic, copy) AlertViewBlock alertBlock;

//新风格添加
@property (nonatomic, strong) UIView *m_line2View;

@property (nonatomic, strong) UIView *m_line3View;

@property (nonatomic, strong) UIButton *m_closeBtn;
@property (nonatomic, copy) NSString *typeStr;


@end

@implementation CustomAlertView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    
    return self;
}

#pragma mark 新风格弹窗

+ (CustomAlertView *)initNewStyleOneTitle_OneContent_OneBtnWithAddInSuper:(kAlertSuperView )kalertsuperview Title:(NSString *)title Content:(NSString *)content BtnTitle:(NSString *)btntitle isAutoRemove:(BOOL)isautoremove needDelete:(BOOL)needdelete needBGCloseBtn:(BOOL)needbgclosebtn clickBlock:(AlertViewBlock)block
{
    
    CustomAlertView *alertView;
    if (kalertsuperview == kAlertwindow) {
        alertView= [[CustomAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    else if (kalertsuperview == kAlertview)
    {
        alertView= [[CustomAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    
    [alertView customNewStyleAlertViewOneBtnWithTitle:title Content:content BtnTitle:btntitle isAutoRemove:isautoremove needDelete:needdelete needBGCloseBtn:needbgclosebtn clickBlock:block];
    
    return alertView;
    
}

+ (CustomAlertView *)initNewStyleOneContent_TwoBtnWithAddInSuper:(kAlertSuperView )kalertsuperview Content:(NSString *)content LeftBtnTitle:(NSString *)leftbtntitle RightBtnTitle:(NSString *)rightbtntitle clickBlock:(AlertViewBlock)block
{
    CustomAlertView *alertView;
    if (kalertsuperview == kAlertwindow) {
        alertView= [[CustomAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight +kiP6WidthRace(20))];
    }
    else if (kalertsuperview == kAlertview)
    {
        alertView= [[CustomAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    
    [alertView customNewStyleAlertViewTwoBtnWithContent:content LeftBtnTitle:leftbtntitle RightBtnTitle:rightbtntitle clickBlock:block];
    
    return alertView;
}

+ (CustomAlertView *)initNewStyleOneContent_TwoBtnPushWithAddInSuper:(kAlertSuperView )kalertsuperview Content:(NSString *)content LeftBtnTitle:(NSString *)leftbtntitle RightBtnTitle:(NSString *)rightbtntitle clickBlock:(AlertViewBlock)block
{
    CustomAlertView *alertView;
    if (kalertsuperview == kAlertwindow) {
        alertView= [[CustomAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight +kiP6WidthRace(20))];
    }
    else if (kalertsuperview == kAlertview)
    {
        alertView= [[CustomAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    
    [alertView customNewStyleAlertViewTwoBtnPushWithContent:content LeftBtnTitle:leftbtntitle RightBtnTitle:rightbtntitle clickBlock:block];
    
    return alertView;
}


+ (CustomAlertView *)initNewStyleNoTitle_OneContent_OneBtnWithAddInSuper:(kAlertSuperView )kalertsuperview Content:(NSString *)content BtnTitle:(NSString *)btntitle isAutoRemove:(BOOL)isautoremove  needBGCloseBtn:(BOOL)needbgclosebtn clickBlock:(AlertViewBlock)block
{
    CustomAlertView *alertView;
    if (kalertsuperview == kAlertwindow) {
        alertView= [[CustomAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight +kiP6WidthRace(20))];
    }
    else if (kalertsuperview == kAlertview)
    {
        alertView= [[CustomAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    
    [alertView customNewStyleAlertViewOneBtnWithContent:content BtnTitle:btntitle isAutoRemove:isautoremove needBGCloseBtn:needbgclosebtn clickBlock:block];
    
    return alertView;
}
+ (CustomAlertView *)initNewStyleOneTitle_OneContent_TwoBtnWithAddInSuper:(kAlertSuperView )kalertsuperview Title:(NSString *)title Content:(NSString *)content LeftBtnTitle:(NSString *)leftbtntitle RightBtnTitle:(NSString *)rightbtntitle clickBlock:(AlertViewBlock)block
{
    CustomAlertView *alertView;
    if (kalertsuperview == kAlertwindow) {
        alertView= [[CustomAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight +kiP6WidthRace(20))];
    }
    else if (kalertsuperview == kAlertview)
    {
        alertView= [[CustomAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    
    [alertView customNewStyleAlertViewOneTitleTwoBtnWithTitle:title Content:content LeftBtnTitle:leftbtntitle RightBtnTitle:rightbtntitle clickBlock:block];
    return alertView;
}

//new   标题、文本内容、一个按钮
- (void)customNewStyleAlertViewOneBtnWithTitle:(NSString *)title Content:(NSString *)content BtnTitle:(NSString *)btntitle isAutoRemove:(BOOL)isautoremove needDelete:(BOOL)needdelete needBGCloseBtn:(BOOL)needbgclosebtn clickBlock:(AlertViewBlock)block
{
    
    self.alertBlock = block;
    
    if (needbgclosebtn) {
        [self creatBGCloseBtn];
    }
    
    [self creatContentView];
    
    
    if (StringHasDataJudge(title)) {
        [self creatTitleLabelWithTitle:title Style:NewStyle];
        [self.m_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(kiP6WidthRace(13));
            make.centerX.equalTo(self.m_contentView);
        }];
        
        [self creatLineViewWithStyle:NewStyle];
        [self.m_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.m_titleLabel.mas_bottom).offset(kiP6WidthRace(13));
            make.left.equalTo(self.m_contentView.mas_left).offset(kiP6WidthRace(20));
            make.right.equalTo(self.m_contentView.mas_right).offset(kiP6WidthRace(-20));
            make.height.mas_offset(0.5);
        }];
        
        if (needdelete) {
            [self creatCloseBtn];
            [self.m_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.m_titleLabel);
                make.right.mas_equalTo(-kiP6WidthRace(5));
                make.width.mas_equalTo(kiP6WidthRace(30));
                make.height.mas_equalTo(kiP6WidthRace(30));
            }];
        }
        
    }
    
    if (StringHasDataJudge(content)) {
        
        [self creatContentLabel:content];
        self.m_contentLabel.textColor = kColorDarkgray;
        [self.m_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.m_lineView.mas_bottom).offset(kAlertHaveTitleTextToTop);
            make.centerX.equalTo(self.m_contentView);
            make.width.mas_offset(kAlertViewWidth - kiP6WidthRace(24));
        }];
        
        [self autoJudgetextAlignmentWithContent:content];
    }
    
    if (StringHasDataJudge(btntitle)) {
        
        [self creatLine2ViewWithStyle:NewStyle];
        [self.m_line2View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.m_contentView);
            make.right.equalTo(self.m_contentView);
            make.top.equalTo(self.m_contentLabel.mas_bottom).offset(kAlertTextToBtn);
            make.height.mas_offset(0.5);
        }];
        
        [self creatOneBtnWithTitle:btntitle isHideAlert:isautoremove Style:NewStyle];
        [self.m_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.m_line2View.mas_bottom);
            make.left.right.bottom.equalTo(self.m_contentView);
            make.height.mas_equalTo(kAlertBtnHeight);
        }];

    }

    [self.m_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(kAlertViewWidth);
    }];
    
}

//new   文本内容、两个按钮
- (void)customNewStyleAlertViewTwoBtnWithContent:(NSString *)content LeftBtnTitle:(NSString *)leftbtntitle RightBtnTitle:(NSString *)rightbtntitle clickBlock:(AlertViewBlock)block
{
    self.alertBlock = block;
    
    [self creatContentView];
    
    if (StringHasDataJudge(leftbtntitle)&&StringHasDataJudge(rightbtntitle)) {
        [self creatTwoBtnWithLeftBtnTitle:leftbtntitle RigthBtnTitle:rightbtntitle Style:NewStyle];
        [self.m_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.m_contentView);
            make.bottom.equalTo(self.m_contentView);
            make.height.mas_equalTo(kAlertBtnHeight);
            make.width.mas_equalTo(kAlertViewWidth/2);
        }];
        
        [self.m_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.m_contentView);
            make.bottom.equalTo(self.m_leftBtn);
            make.height.equalTo(self.m_leftBtn);
            make.width.equalTo(self.m_leftBtn);
        }];
        
        
        [self creatLineViewWithStyle:NewStyle];
        [self.m_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.m_contentView);
            make.right.equalTo(self.m_contentView);
            make.bottom.equalTo(self.m_leftBtn.mas_top);
            make.height.mas_equalTo(0.5);
        }];
        
        [self creatLine2ViewWithStyle:NewStyle];
        [self.m_line2View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.m_leftBtn.mas_right);
            make.top.equalTo(self.m_leftBtn.mas_top);
            make.bottom.equalTo(self.m_leftBtn.mas_bottom);
            make.width.mas_equalTo(1);
        }];
        
    }
    
    
    if (StringHasDataJudge(content)) {
        [self creatContentLabel:content];
        
        [self.m_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(kAlertTextToTop);
            make.bottom.equalTo(self.m_leftBtn.mas_top).offset(-kAlertTextToBtn);
            make.centerX.equalTo(self.m_contentView);
            make.width.mas_offset(kAlertViewWidth - kiP6WidthRace(24));
        }];
        
        [self autoJudgetextAlignmentWithContent:content];
    }
    
    [self.m_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(kAlertViewWidth);
    }];
}

//newPush   文本内容、两个按钮
- (void)customNewStyleAlertViewTwoBtnPushWithContent:(NSString *)content LeftBtnTitle:(NSString *)leftbtntitle RightBtnTitle:(NSString *)rightbtntitle clickBlock:(AlertViewBlock)block
{
    self.alertBlock = block;
    
    [self creatContentView];
    
    if (StringHasDataJudge(leftbtntitle)&&StringHasDataJudge(rightbtntitle)) {
        [self creatTwoBtnWithLeftBtnTitle:leftbtntitle RigthBtnTitle:rightbtntitle Style:NewStyle];
        [self.m_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.m_contentView);
            make.bottom.equalTo(self.m_contentView);
            make.height.mas_equalTo(kAlertBtnHeight);
            make.width.mas_equalTo(kAlertViewWidth/2);
        }];
        
        [self.m_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.m_contentView);
            make.bottom.equalTo(self.m_leftBtn);
            make.height.equalTo(self.m_leftBtn);
            make.width.equalTo(self.m_leftBtn);
        }];
        
        
        [self creatLineViewWithStyle:NewStyle];
        [self.m_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.m_contentView);
            make.right.equalTo(self.m_contentView);
            make.bottom.equalTo(self.m_leftBtn.mas_top);
            make.height.mas_equalTo(0.5);
        }];
        
        [self creatLine2ViewWithStyle:NewStyle];
        [self.m_line2View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.m_leftBtn.mas_right);
            make.top.equalTo(self.m_leftBtn.mas_top);
            make.bottom.equalTo(self.m_leftBtn.mas_bottom);
            make.width.mas_equalTo(1);
        }];
        
    }
    
    
    if (StringHasDataJudge(content)) {
        [self creatPushContentLabel:content];
        
        [self.m_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(kAlertTextToTop);
            make.bottom.equalTo(self.m_leftBtn.mas_top).offset(-kAlertTextToBtn);
            make.centerX.equalTo(self.m_contentView);
            make.width.mas_offset(kAlertViewWidth - kiP6WidthRace(24));
            make.height.mas_offset(40);
        }];
        self.typeStr = @"1";
        [self autoJudgetextAlignmentWithContent:content];
    }
    [self.m_leftBtn setTitleColor:kHomeBlueColor forState:UIControlStateNormal];

    [self.m_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(kAlertViewWidth);
    }];
}


//new 文本内容、一个按钮
- (void)customNewStyleAlertViewOneBtnWithContent:(NSString *)content BtnTitle:(NSString *)btntitle isAutoRemove:(BOOL)isautoremove needBGCloseBtn:(BOOL)needbgclosebtn clickBlock:(AlertViewBlock)block
{
    
    self.alertBlock = block;
    
    if (needbgclosebtn) {
        [self creatBGCloseBtn];
    }
    
    [self creatContentView];
    if (StringHasDataJudge(btntitle)) {
        [self creatOneBtnWithTitle:btntitle isHideAlert:isautoremove Style:NewStyle];
        [self.m_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.m_contentView);
            make.right.equalTo(self.m_contentView);
            make.bottom.equalTo(self.m_contentView);
            make.height.mas_equalTo(kAlertBtnHeight);
        }];
        
        [self creatLine2ViewWithStyle:NewStyle];
        [self.m_line2View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.m_contentView);
            make.right.equalTo(self.m_contentView);
            make.bottom.equalTo(self.m_btn.mas_top);
            make.height.mas_offset(0.5);
        }];
    }
    if (StringHasDataJudge(content)) {
        [self creatContentLabel:content];

        [self.m_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(kAlertTextToTop);
            make.bottom.equalTo(self.m_btn.mas_top).offset(-kAlertTextToBtn);
            make.centerX.equalTo(self.m_contentView);
            make.width.mas_offset(kAlertViewWidth - kiP6WidthRace(24));
        }];
        
        [self autoJudgetextAlignmentWithContent:content];
    }
    
    [self.m_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(kAlertViewWidth);
    }];
    
}


//new  1个title、文本内容、2个按钮
- (void)customNewStyleAlertViewOneTitleTwoBtnWithTitle:(NSString *)title Content:(NSString *)content LeftBtnTitle:(NSString *)leftbtntitle RightBtnTitle:(NSString *)rightbtntitle clickBlock:(AlertViewBlock)block
{
    self.alertBlock = block;
    
    [self creatContentView];
    if (StringHasDataJudge(title)) {
        [self creatTitleLabelWithTitle:title Style:NewStyle];
        [self.m_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(kiP6WidthRace(13));
            make.centerX.equalTo(self.m_contentView);
        }];
        
        [self creatLineViewWithStyle:NewStyle];
        [self.m_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.m_titleLabel.mas_bottom).offset(kiP6WidthRace(13));
            make.left.equalTo(self.m_contentView.mas_left).offset(kiP6WidthRace(20));
            make.right.equalTo(self.m_contentView.mas_right).offset(kiP6WidthRace(-20));
            make.height.mas_offset(0.5);
        }];
    }
    
    if (StringHasDataJudge(leftbtntitle)&&StringHasDataJudge(rightbtntitle)) {
        [self creatTwoBtnWithLeftBtnTitle:leftbtntitle RigthBtnTitle:rightbtntitle Style:NewStyle];
        [self.m_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.m_contentView);
            make.bottom.equalTo(self.m_contentView);
            make.height.mas_equalTo(kAlertBtnHeight);
            make.width.mas_equalTo(kAlertViewWidth);
        }];
        
        [self.m_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.m_contentView);
            make.bottom.equalTo(self.m_leftBtn);
            make.height.equalTo(self.m_leftBtn);
            make.width.equalTo(self.m_leftBtn);
        }];
        
        
        [self creatLine2ViewWithStyle:NewStyle];
        [self.m_line2View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.m_contentView);
            make.right.equalTo(self.m_contentView);
            make.bottom.equalTo(self.m_leftBtn.mas_top);
            make.height.mas_equalTo(0.5);
        }];
        
        [self creatLine3ViewWithStyle:NewStyle];
        [self.m_line3View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.m_leftBtn.mas_right);
            make.top.equalTo(self.m_leftBtn.mas_top);
            make.bottom.equalTo(self.m_leftBtn.mas_bottom);
            make.width.mas_equalTo(0.5);
        }];
        
    }
    
    if (StringHasDataJudge(content)) {
        [self creatContentLabel:content];
        self.m_contentLabel.textColor = kColorDarkgray;
        [self.m_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.m_lineView.mas_bottom).offset(kAlertHaveTitleTextToTop);
            make.bottom.equalTo(self.m_leftBtn.mas_top).offset(-kAlertTextToBtn);
            make.centerX.equalTo(self.m_contentView);
            make.width.mas_offset(kAlertViewWidth - kiP6WidthRace(24));
        }];
        
        [self autoJudgetextAlignmentWithContent:content];
    }
    
    [self.m_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(kAlertViewWidth);
    }];
    
}


- (void)autoJudgetextAlignmentWithContent:(NSString *)content
{
    //行数小于1行居中 大于一行居左
    CGFloat h =[self.m_contentLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGFloat h2 = kiP6WidthRace(16);
    int i = h / h2 ;
    if (i > 1) {
        self.m_contentLabel.textAlignment = NSTextAlignmentLeft;
    }
    else
    {
        self.m_contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    if ([self.typeStr isEqualToString:@"1"])
    {
        self.m_contentLabel.font = KFont(15);
        self.m_contentLabel.textAlignment = NSTextAlignmentCenter;

    }
}

- (void)creatContentView
{
    self.m_contentView = [[UIView alloc]init];
    self.m_contentView.layer.masksToBounds = YES;
    ViewRadius(self.m_contentView, kiP6WidthRace(5));
    self.m_contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.m_contentView];
}

- (void)creatTitleLabelWithTitle:(NSString *)title Style:(kAlertStyle)style
{
    self.m_titleLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, title, KFont(17), UIColorRGB(12, 114, 227), NO);
    
    if (style == NewStyle) {
        self.m_titleLabel.textColor = UIColorRGB(51, 51, 51);
        
    }
    [self.m_contentView addSubview:self.m_titleLabel];
}

- (void)creatLineViewWithStyle:(kAlertStyle)style
{
    self.m_lineView = [[UIView alloc]init];
    self.m_lineView.backgroundColor = UIColorHex(@"#e5e5e5");
    [self.m_contentView addSubview:self.m_lineView];
}

- (void)creatLine2ViewWithStyle:(kAlertStyle)style
{
    self.m_line2View = [[UIView alloc]init];
    self.m_line2View.backgroundColor = UIColorHex(@"#e5e5e5");
    [self.m_contentView addSubview:self.m_line2View];
}

- (void)creatLine3ViewWithStyle:(kAlertStyle)style
{
    self.m_line3View = [[UIView alloc]init];
    self.m_line3View.backgroundColor = UIColorHex(@"#e5e5e5");
    [self.m_contentView addSubview:self.m_line3View];
}


- (void)creatPushContentLabel:(NSString *)content
{
    self.m_contentLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, content, KFont(45), kColorBlack, NO);

    self.m_contentLabel.numberOfLines = 0;
    self.m_contentLabel.font = KFont(45);
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[content dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    self.m_contentLabel.attributedText = attrStr;
    [self.m_contentView addSubview:self.m_contentLabel];
    [ self.m_contentLabel wl_changeFontWithTextFont:KFont(45) changeText:content];
}

- (void)creatContentLabel:(NSString *)content
{
    self.m_contentLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, content, KFont(15), kColorBlack, NO);
    
    self.m_contentLabel.numberOfLines = 0;
    
   NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    self.m_contentLabel.attributedText = attributedString;
    [self.m_contentView addSubview:self.m_contentLabel];
}

- (void)creatOneBtnWithTitle:(NSString *)btntitle isHideAlert:(BOOL)ishidealert Style:(kAlertStyle)style
{
    self.ishidealert = ishidealert;
    self.m_btn = InsertButtonRoundedRect(nil, CGRectZero, 101, btntitle, self, @selector(registBtn));
    [self.m_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.m_btn.backgroundColor = UIColorRGB(12, 114, 227);
    self.m_btn.titleLabel.font = KFont(16);
    
    if (style == NewStyle) {
        [self.m_btn setBackgroundColor:[UIColor clearColor]];
        [self.m_btn setTitleColor:kHomeBlueColor forState:UIControlStateNormal];
    }
    
    
    [self.m_contentView addSubview:self.m_btn];
   
}

- (void)registBtn
{
    if (self.alertBlock) {
        
        if (self.ishidealert == YES) {
            self.alertBlock(1);
            
            [self hidenView];
        }
        else
        {
            self.alertBlock(1);
            
        }
    }
}

- (void)creatTwoBtnWithLeftBtnTitle:(NSString *)leftbtntitle RigthBtnTitle:(NSString *)rightbtntitle Style:(kAlertStyle)style
{
    self.m_leftBtn = InsertButtonRoundedRect(nil, CGRectZero, 101, leftbtntitle, self, @selector(leftBtnBtn));
    [self.m_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.m_leftBtn.backgroundColor = UIColorRGB(204, 204, 204);
    self.m_leftBtn.titleLabel.font = KFont(16);
    
    ViewRadius(self.m_leftBtn, kiP6WidthRace(2));
    [self.m_contentView addSubview:self.m_leftBtn];
    
    
    self.m_rightBtn = InsertButtonRoundedRect(nil, CGRectZero, 101, rightbtntitle, self, @selector(rightBtnClick));

    [self.m_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.m_rightBtn.backgroundColor = UIColorRGB(12, 114, 227);
    self.m_rightBtn.titleLabel.font = KFont(16);
    
    ViewRadius(self.m_rightBtn, kiP6WidthRace(2));
    [self.m_contentView addSubview:self.m_rightBtn];

    
    if (style == NewStyle) {
        [self.m_leftBtn setBackgroundColor:[UIColor clearColor]];
        [self.m_rightBtn setBackgroundColor:[UIColor clearColor]];
        [self.m_leftBtn setTitleColor:UIColorHex(@"#999999") forState:UIControlStateNormal];
        [self.m_rightBtn setTitleColor:kHomeBlueColor forState:UIControlStateNormal];
    }
    
    
}

- (void)leftBtnBtn
{
    if (self.alertBlock) {
        
        self.alertBlock(0);
        
        [self hidenView];
    }
}

- (void)rightBtnClick
{
    if (self.alertBlock) {
        
        self.alertBlock(1);
        
        [self hidenView];
    }
}

- (void)setTextAlignment:(NSTextAlignment)textalignment
{
    self.m_contentLabel.textAlignment = textalignment;
}


- (void)showInWindowWithView:(UIView *)view
{
    self.alpha = 0;
    [view addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1.0;
    }];
}

- (void)showInViewWithView:(UIView *)view
{
    self.alpha = 0;
    [view addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1.0;
    }];
}



- (void)hidenView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)creatCloseBtn
{
    self.m_closeBtn = InsertButtonRoundedRect(nil, CGRectZero, 101, nil, self, @selector(closeBtn));
    [self.m_closeBtn setImage:[UIImage imageNamed:@"cancelX"] forState:UIControlStateNormal];
    
    [self.m_contentView addSubview:self.m_closeBtn];
    
}

- (void)closeBtn{
    [self hidenView];

}

- (void)creatBGCloseBtn
{
    self.m_BGCloseBtn = InsertButtonRoundedRect(nil, CGRectZero, 101, nil, self, @selector(BGCloseBtn));

    [self addSubview:self.m_BGCloseBtn];
    
    [self.m_BGCloseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    
    
}

- (void)BGCloseBtn
{
    if (self.alertBlock) {
        self.alertBlock(0);
    }
    [self hidenView];
}




@end

//
//  DViewManager.m
//  NewJingYuBao
//
//  Created by linshaokai on 16/6/24.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import "DViewManager.h"
#import "ClickRectExpandButton.h"

@implementation DViewManager

+(UILabel *)initLabelWithFrame:(CGRect)rect backColor:(UIColor *)backColor textColor:(UIColor *)textColor font:(UIFont*)font textAlignment:(NSTextAlignment)textAlignment content:(NSString *)content
{
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    if (backColor) {
        label.backgroundColor = backColor;
    }else
    {
        label.backgroundColor = [UIColor clearColor];
    }
    if (textColor) {
        label.textColor = textColor;
    }
    if (font) {
        label.font = font;
    }
    if (textAlignment) {
        label.textAlignment = textAlignment;
    }
    label.text = ChangeNullData(content);
    return label ;
}

+(UILabel *)initLabelWithBackColor:(UIColor *)backColor textColor:(UIColor *)textColor font:(UIFont*)font textAlignment:(NSTextAlignment)textAlignment content:(NSString *)content
{
    return [DViewManager initLabelWithFrame:CGRectZero backColor:backColor textColor:textColor font:font textAlignment:textAlignment content:content];
}

+(UIButton *)initButtonWithFrame:(CGRect)rect backColor:(UIColor *)bgColor backgroundImage:(NSString *)bgimage nornalImage:(NSString *)nornalImage selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action  textfont:(UIFont *)font textColor:(UIColor *)textColor title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (bgColor) {
        [button setBackgroundColor:bgColor];
    }
    button.frame = rect;
    
    if (StringHasDataJudge(bgimage)) {
        [button setBackgroundImage:[UIImage imageNamed:bgimage] forState:UIControlStateNormal];
    }
    if (StringHasDataJudge(nornalImage)) {
        [button setImage:[UIImage imageNamed:nornalImage] forState:UIControlStateNormal];
    }
   
    if (StringHasDataJudge(selectedImage)) {
        [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    }
    if (target && action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (title != nil) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (font) {
        button.titleLabel.font = font;
    }
    if (textColor) {
        [button setTitleColor:textColor forState:UIControlStateNormal];
    }
    return button ;
}
+(UIButton *)initButtonWithBackColor:(UIColor *)bgColor backgroundImage:(NSString *)bgimage nornalImage:(NSString *)nornalImage selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action textfont:(UIFont *)font textColor:(UIColor *)textColor title:(NSString *)title
{
    return [DViewManager initButtonWithFrame:CGRectZero backColor:bgColor backgroundImage:bgimage nornalImage:nornalImage selectedImage:selectedImage target:target action:action textfont:font textColor:textColor title:title];
}

+ (ClickRectExpandButton *)initClickRectExpandButtonWithBackColor:(UIColor *)bgColor backgroundImage:(NSString *)bgimage nornalImage:(NSString *)nornalImage selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action  textfont:(UIFont *)font textColor:(UIColor *)textColor title:(NSString *)title
{
    ClickRectExpandButton *button = [ClickRectExpandButton buttonWithType:UIButtonTypeCustom];
    if (bgColor) {
        [button setBackgroundColor:bgColor];
    }
    
    if (StringHasDataJudge(bgimage)) {
        [button setBackgroundImage:[UIImage imageNamed:bgimage] forState:UIControlStateNormal];
    }
    if (StringHasDataJudge(nornalImage)) {
        [button setImage:[UIImage imageNamed:nornalImage] forState:UIControlStateNormal];
    }
    
    if (StringHasDataJudge(selectedImage)) {
        [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    }
    if (target && action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (title != nil) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (font) {
        button.titleLabel.font = font;
    }
    if (textColor) {
        [button setTitleColor:textColor forState:UIControlStateNormal];
    }
    return button ;
}



+(UITextField *)initTextFieldFrame:(CGRect)rect
                              delegate:(id)delegate
                                  content:(NSString *)content
                           placeholder:(NSString *)placeholder
                          borStyle:(UITextBorderStyle)style
                             returnKey:(UIReturnKeyType)keyTyle
                              keyBoard:(UIKeyboardType)keyBoard
                              textFont:(UIFont *)font
                             textColor:(UIColor *)color
                         textAlignment:(NSTextAlignment)alignment
                      cleanButtonModel:(UITextFieldViewMode)cleanMode
{
    UITextField *textField = [[UITextField alloc]initWithFrame:rect];
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    if (delegate != nil) {
        textField.delegate = delegate;
    }
    if (content != nil) {
        textField.text = content;
    }
    if (placeholder !=nil) {
        textField.placeholder = placeholder;
    }
    if (font) {
        textField.font = font;
    }
    if (color) {
        textField.textColor = color;
    }
    
    textField.clearButtonMode =  cleanMode;
    
    textField.textAlignment = alignment;
    
    textField.borderStyle = style;
    
    textField.returnKeyType = keyTyle;

    textField.keyboardType = keyBoard;
    
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    return textField ;
}
+(UITextField *)initTextFieldDelegate:(id)delegate content:(NSString *)content placeholder:(NSString *)placeholder borStyle:(UITextBorderStyle)style returnKey:(UIReturnKeyType)keyTyle keyBoard:(UIKeyboardType)keyBoard textFont:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)alignment cleanButtonModel:(UITextFieldViewMode)cleanMode
{
    return [DViewManager initTextFieldFrame:CGRectZero delegate:delegate content:content placeholder:placeholder borStyle:style returnKey:keyTyle keyBoard:keyBoard textFont:font textColor:color textAlignment:alignment cleanButtonModel:cleanMode];
}

+(UITableView *)initTableViewFrame:(CGRect)rect delegate:(id)delegate type:(UITableViewStyle)style allowsSelection:(BOOL)isAllow separatorStyle:(UITableViewCellSeparatorStyle) separatorStyle separatorColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor headRefreshAction:(SEL)headAction footRefreshAction:(SEL)footAction
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:rect style:style];
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    if (color) {
        tableView.separatorColor = color;
    }
    tableView.separatorStyle = separatorStyle;
    tableView.allowsSelection = isAllow;
    
    if (backgroundColor) {
        tableView.backgroundColor = backgroundColor;
    }
    
    if (headAction) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:delegate refreshingAction:headAction];
        tableView.mj_header = header;
        
    }
    if (footAction) {
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:delegate refreshingAction:footAction];
    }
    
    return tableView ;
}
+(UITableView *)initTableViewDelegate:(id)delegate type:(UITableViewStyle)style allowsSelection:(BOOL)isAllow separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle separatorColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor headRefreshAction:(SEL)headAction footRefreshAction:(SEL)footAction
{
    return [DViewManager initTableViewFrame:CGRectZero delegate:delegate type:style allowsSelection:isAllow separatorStyle:separatorStyle separatorColor:color backgroundColor:backgroundColor headRefreshAction:headAction footRefreshAction:footAction];
}
+(UISegmentedControl *)initSegmentedControl:(NSArray *)titleArray
{
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:titleArray];
    [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorRGB(12, 114, 227),NSFontAttributeName:KFont(15)} forState:UIControlStateNormal];
    segmentedControl.backgroundColor = [UIColor whiteColor];
    [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:KFont(15)} forState:UIControlStateSelected];
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = UIColorRGB(12, 114, 227);
    return segmentedControl;
}
@end

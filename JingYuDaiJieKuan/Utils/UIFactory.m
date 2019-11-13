//
//  UIFactory.m
//  DeepTestDrive
//
//  Created by Macmini on 2017/8/4.
//  Copyright © 2017年 Macmini. All rights reserved.
//

#import "UIFactory.h"


@implementation UIFactory
#pragma mark Label

+ (id)createLabel
{
    return [UIFactory createLabel:CGRectZero];
}

+ (id)createLabel:(CGRect)frame
{
    return [UIFactory createLabel:frame
                            align:NSTextAlignmentCenter];
}

+ (id)createLabel:(CGRect)frame align:(NSTextAlignment)alignment
{
    return [UIFactory createLabel:frame
                            align:alignment
                             text:@""
                        textcolor:[UIColor clearColor]
                             font:nil];
}
+ (id)createLabel:(CGRect)frame
            align:(NSTextAlignment)alignment
             text:(NSString *)text
        textcolor:(UIColor *)textColor
             font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = alignment;
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    return label;
}
#pragma mark Button

+ (id)createButton:(CGRect)frame
{
    return [UIFactory createButton:frame type:UIButtonTypeRoundedRect];
}

+ (id)createButton:(CGRect)frame
              type:(UIButtonType)type
{
    UIButton *btn = [UIButton buttonWithType:type];
    btn.frame = frame;
    return btn;
}

+ (id)createButton:(CGRect)frame
            target:(id)target
            action:(SEL)action
{
    return [UIFactory createButton:frame
                            target:target
                            action:action
                        buttonType:UIButtonTypeRoundedRect];
}

+ (id)createButton:(CGRect)frame
            target:(id)target
            action:(SEL)action
        buttonType:(UIButtonType)type
{
    return [UIFactory createButton:frame
                            target:target
                            action:action
                        buttonType:type
                             title:@""
                        titleColor:[UIColor whiteColor]];
}

+(id)createButton:(CGRect)frame
           target:(id)target
           action:(SEL)action
       buttonType:(UIButtonType)type
            title:(NSString *)title
       titleColor:(UIColor *)titleColor
{
    UIButton *btn = [UIButton buttonWithType:type];
    btn.frame = frame;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    return btn;
}

+(id)createButton:(CGRect)frame
           target:(id)target
           action:(SEL)action
       buttonType:(UIButtonType)type
            title:(NSString *)title
       titleColor:(UIColor *)titleColor
             font:(UIFont *)font
{
    UIButton *btn = [UIButton buttonWithType:type];
    btn.frame = frame;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    return btn;
}

+(id)createCustomButton:(CGRect)frame
                   target:(id)target
                   action:(SEL)action
               buttonType:(UIButtonType)type
                    title:(NSString *)title
               titleColor:(UIColor *)titleColor
         backgroundImageNor:(UIImage *)norImage
    backgroundImageDisable:(UIImage *)disableImage
{
    UIButton *btn = [UIButton buttonWithType:type];
    btn.frame = frame;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setBackgroundImage:norImage forState:UIControlStateNormal];
    [btn setBackgroundImage:disableImage forState:UIControlStateDisabled];
    return btn;
}

+(id)createCustomButton:(CGRect)frame
                  title:(NSString *)title
             titleColor:(UIColor *)titleColor
                  image:(UIImage *)image
                   font:(UIFont *)font
              edgeInset:(UIEdgeInsets)edgeInset
               position:(FSCustomButtonImagePosition)position
                 target:(id)target
                 action:(SEL)action

{
    FSCustomButton *button = [[FSCustomButton alloc] init];
    button.adjustsTitleTintColorAutomatically = YES;
    button.titleLabel.font = font;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    [button setImage:image forState:UIControlStateNormal];
    button.buttonImagePosition = position;
    button.titleEdgeInsets = edgeInset;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark TextField

+ (id)createTextFiled
{
    return [UIFactory createTextFiled:UITextBorderStyleRoundedRect];
}

+ (id)createTextFiled:(UITextBorderStyle)style
{
    return [UIFactory createTextFiled:CGRectZero style:style];
}

+ (id)createTextFiled:(CGRect)frame style:(UITextBorderStyle)style
{
    return [UIFactory createTextFiled:CGRectZero style:style alignment:NSTextAlignmentCenter];
}
+ (id)createTextFiled:(CGRect)frame
                style:(UITextBorderStyle)style
            alignment:(NSTextAlignment )alignment
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.textAlignment = alignment;
    textField.textColor = [UIColor blackColor];
    textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.borderStyle = style;
    
    return textField;
}

#pragma mark TableView

+ (id)createTableView:(id<UITableViewDataSource>)dataSource
             delegete:(id<UITableViewDelegate>)delegate
{
    return [UIFactory createTableView:CGRectZero
                                  dataSource:dataSource
                                    delegete:delegate
                                       style:UITableViewStyleGrouped];
}

+ (id)createTableView:(id<UITableViewDataSource>)dataSource
             delegete:(id<UITableViewDelegate>)delegate
                style:(UITableViewStyle)style
{
    return [UIFactory createTableView:CGRectZero
                                  dataSource:dataSource
                                    delegete:delegate
                                       style:style];
}

+ (id)createTableView:(CGRect)frame
           dataSource:(id<UITableViewDataSource>)dataSource
             delegete:(id<UITableViewDelegate>)delegate
{
    return [UIFactory createTableView:frame
                                  dataSource:dataSource
                                    delegete:delegate
                                       style:UITableViewStyleGrouped];
}


+ (id)createTableView:(CGRect)frame
           dataSource:(id<UITableViewDataSource>)dataSource
             delegete:(id<UITableViewDelegate>)delegate
                style:(UITableViewStyle)style
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:style];
    tableView.delegate = delegate;
    tableView.dataSource = dataSource;
    return tableView;
    
}

@end

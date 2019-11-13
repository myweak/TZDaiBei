//
//  UIFactory.h
//  DeepTestDrive
//
//  Created by Macmini on 2017/8/4.
//  Copyright © 2017年 Macmini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSCustomButton.h"

@interface UIFactory : NSObject
// Label
+ (id)createLabel;
+ (id)createLabel:(CGRect)frame;
+ (id)createLabel:(CGRect)frame align:(NSTextAlignment)alignment;
+ (id)createLabel:(CGRect)frame
            align:(NSTextAlignment)alignment
             text:(NSString *)text
        textcolor:(UIColor *)textColor
             font:(UIFont *)font;

// Button
+ (id)createButton:(CGRect)frame;

+ (id)createButton:(CGRect)frame
              type:(UIButtonType)type;

+ (id)createButton:(CGRect)frame
            target:(id)target
            action:(SEL)action;

+ (id)createButton:(CGRect)frame
            target:(id)target
            action:(SEL)action
        buttonType:(UIButtonType)type;

+(id)createButton:(CGRect)frame
           target:(id)target
           action:(SEL)action
       buttonType:(UIButtonType)type
            title:(NSString *)title
       titleColor:(UIColor *)titleColor;
+(id)createButton:(CGRect)frame
           target:(id)target
           action:(SEL)action
       buttonType:(UIButtonType)type
            title:(NSString *)title
       titleColor:(UIColor *)titleColor
             font:(UIFont *)font;

+(id)createCustomButton:(CGRect)frame
                 target:(id)target
                 action:(SEL)action
             buttonType:(UIButtonType)type
                  title:(NSString *)title
             titleColor:(UIColor *)titleColor
     backgroundImageNor:(UIImage *)norImage
 backgroundImageDisable:(UIImage *)disableImage;

+(id)createCustomButton:(CGRect)frame
                  title:(NSString *)title
             titleColor:(UIColor *)titleColor
                  image:(UIImage *)image
                   font:(UIFont *)font
              edgeInset:(UIEdgeInsets)edgeInset
               position:(FSCustomButtonImagePosition)position
                 target:(id)target
                 action:(SEL)action;
// TextField
+ (id)createTextFiled;
+ (id)createTextFiled:(UITextBorderStyle)style;
+ (id)createTextFiled:(CGRect)frame style:(UITextBorderStyle)style;
+ (id)createTextFiled:(CGRect)frame
                style:(UITextBorderStyle)style
            alignment:(NSTextAlignment )alignment;

// TableView
+ (id)createTableView:(id<UITableViewDataSource>)dataSource
             delegete:(id<UITableViewDelegate>)delegate;

+ (id)createTableView:(id<UITableViewDataSource>)dataSource
             delegete:(id<UITableViewDelegate>)delegate
                style:(UITableViewStyle)style;

+ (id)createTableView:(CGRect)frame
           dataSource:(id<UITableViewDataSource>)dataSource
             delegete:(id<UITableViewDelegate>)delegate;

+ (id)createTableView:(CGRect)frame
           dataSource:(id<UITableViewDataSource>)dataSource
             delegete:(id<UITableViewDelegate>)delegate
                style:(UITableViewStyle)style;

@end

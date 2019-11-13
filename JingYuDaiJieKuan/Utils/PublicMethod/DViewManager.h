//
//  DViewManager.h
//  NewJingYuBao
//
//  Created by linshaokai on 16/6/24.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ClickRectExpandButton;
@interface DViewManager : NSObject
/**
 *  定义UILabel
 *
 *  @param rect          空间
 *  @param backColor     背景颜色
 *  @param textColor     文本颜色
 *  @param font          文本大小
 *  @param textAlignment 对齐方式
 *  @param content       内容
 *
 *  @return
 */

+(UILabel *)initLabelWithFrame:(CGRect)rect backColor:(UIColor *)backColor textColor:(UIColor *)textColor font:(UIFont*)font textAlignment:(NSTextAlignment)textAlignment content:(NSString *)content;
+(UILabel *)initLabelWithBackColor:(UIColor *)backColor textColor:(UIColor *)textColor font:(UIFont*)font textAlignment:(NSTextAlignment)textAlignment content:(NSString *)content;

/**
 *  定义UIButton
 *
 *  @param rect        位置
 *  @param bgColor     背景颜色
 *  @param bgimage     背景图片
 *  @param nornalImage 设置图片
 *  @param lightImage  设置选择图片
 *  @param target      目标对象
 *  @param action      方法
 *  @param font        文本大小
 *  @param textColor    文本颜色
 *  @param title       文本
 *
 *  @return
 */
+(UIButton *)initButtonWithFrame:(CGRect)rect backColor:(UIColor *)bgColor backgroundImage:(NSString *)bgimage nornalImage:(NSString *)nornalImage selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action  textfont:(UIFont *)font textColor:(UIColor *)textColor title:(NSString *)title;
+(UIButton *)initButtonWithBackColor:(UIColor *)bgColor backgroundImage:(NSString *)bgimage nornalImage:(NSString *)nornalImage selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action  textfont:(UIFont *)font textColor:(UIColor *)textColor title:(NSString *)title;

+ (ClickRectExpandButton *)initClickRectExpandButtonWithBackColor:(UIColor *)bgColor backgroundImage:(NSString *)bgimage nornalImage:(NSString *)nornalImage selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action  textfont:(UIFont *)font textColor:(UIColor *)textColor title:(NSString *)title;




/**
 *  定义文本框
 *
 *  @param rect        位子大小
 *  @param delegate    代理
 *  @param content     内容
 *  @param placeholder 默认内容
 *  @param style       边框类型
 *  @param keyTyle     返回按钮
 *  @param keyBoard    键盘类型
 *  @param font        文本大小
 *  @param color       文本颜色
 *  @param alignment   文本对齐
 *  @param cleanMode   清空类型
 *
 *  @return 
 */

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
                  cleanButtonModel:(UITextFieldViewMode)cleanMode;

+(UITextField *)initTextFieldDelegate:(id)delegate
                           content:(NSString *)content
                       placeholder:(NSString *)placeholder
                          borStyle:(UITextBorderStyle)style
                         returnKey:(UIReturnKeyType)keyTyle
                          keyBoard:(UIKeyboardType)keyBoard
                          textFont:(UIFont *)font
                         textColor:(UIColor *)color
                     textAlignment:(NSTextAlignment)alignment
                     cleanButtonModel:(UITextFieldViewMode)cleanMode;
/**
 *  定义tableview
 *
 *  @param rect            大小
 *  @param delegate        delegate
 *  @param style           表类型
 *  @param isAllow         是否允许点击选择
 *  @param separatorStyle  分割线类型
 *  @param color           分割线颜色
 *  @param backgroundColor 背景颜色
 *  @param headAction      下来刷新事件
 *  @param footAction      下拉加载更多事件
 *
 *  @return
 */



+(UITableView *)initTableViewFrame:(CGRect)rect delegate:(id)delegate type:(UITableViewStyle)style allowsSelection:(BOOL)isAllow separatorStyle:(UITableViewCellSeparatorStyle) separatorStyle separatorColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor headRefreshAction:(SEL)headAction footRefreshAction:(SEL)footAction;

+(UITableView *)initTableViewDelegate:(id)delegate type:(UITableViewStyle)style allowsSelection:(BOOL)isAllow separatorStyle:(UITableViewCellSeparatorStyle) separatorStyle separatorColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor headRefreshAction:(SEL)headAction footRefreshAction:(SEL)footAction;


+(UISegmentedControl *)initSegmentedControl:(NSArray *)titleArray;
@end

//
//  CustomAlertView.h
//  NewJingYuBao
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

typedef void (^AlertViewBlock)(NSInteger type);//0 cancle  1 sure

//typedef enum {
//    kAlertwindow,       //添加在window层
//    kAlertview         //添加在view层
//}kAlertSuperView;

typedef enum {
    OldStyle,
    NewStyle
}kAlertStyle;

#import <UIKit/UIKit.h>





@interface CustomAlertView : UIView

@property (nonatomic, strong) UIButton *m_leftBtn;

@property (nonatomic, strong) UIButton *m_rightBtn;

@property (nonatomic, strong) UILabel *m_contentLabel;

@property (nonatomic, assign) BOOL ishidealert;

#pragma mark 新风格弹窗
//**********************************************


/**
 *  初始化（标题、文本内容、一个按钮）
 *
 *  @param superView        弹窗添加所在层
 *  @param title            标题名称
 *  @param content          内容
 *  @param btntitle         按钮名称
 *
 *  @return
 */
+ (CustomAlertView *)initNewStyleOneTitle_OneContent_OneBtnWithAddInSuper:(kAlertSuperView )kalertsuperview Title:(NSString *)title Content:(NSString *)content BtnTitle:(NSString *)btntitle isAutoRemove:(BOOL)isautoremove needDelete:(BOOL)needdelete needBGCloseBtn:(BOOL)needbgclosebtn clickBlock:(AlertViewBlock)block;


/**
 *  初始化（文本内容、两个按钮）
 *
 *  @param superView        弹窗添加所在层
 *  @param content          内容
 *  @param btn1title        按钮1名称
 *  @param btn2title        按钮2名称
 *
 *  @return
 */
+ (CustomAlertView *)initNewStyleOneContent_TwoBtnWithAddInSuper:(kAlertSuperView )kalertsuperview Content:(NSString *)content LeftBtnTitle:(NSString *)leftbtntitle RightBtnTitle:(NSString *)rightbtntitle clickBlock:(AlertViewBlock)block;


/**
 *  初始化（文本内容、两个按钮 ) 推送
 *
 *  @param superView        弹窗添加所在层
 *  @param content          内容
 *  @param btn1title        按钮1名称
 *  @param btn2title        按钮2名称
 *
 *  @return
 */
+ (CustomAlertView *)initNewStyleOneContent_TwoBtnPushWithAddInSuper:(kAlertSuperView )kalertsuperview Content:(NSString *)content LeftBtnTitle:(NSString *)leftbtntitle RightBtnTitle:(NSString *)rightbtntitle clickBlock:(AlertViewBlock)block;
/**
 *  初始化（文本内容、一个按钮）
 *
 *  @param superView        弹窗添加所在层
 *  @param content          内容
 *  @param btntitle         按钮名称
 *  @param isautoremove     点击按钮后自动移除弹窗
 *
 *  @return
 */
+ (CustomAlertView *)initNewStyleNoTitle_OneContent_OneBtnWithAddInSuper:(kAlertSuperView )kalertsuperview Content:(NSString *)content BtnTitle:(NSString *)btntitle isAutoRemove:(BOOL)isautoremove  needBGCloseBtn:(BOOL)needbgclosebtn clickBlock:(AlertViewBlock)block;


/**
 *  初始化（标题、文本内容、两个按钮）
 *
 *  @param superView        弹窗添加所在层
 *  @param title          标题
 *  @param content          内容
 *  @param btn1title        按钮1名称
 *  @param btn2title        按钮2名称
 *
 *  @return
 */
+ (CustomAlertView *)initNewStyleOneTitle_OneContent_TwoBtnWithAddInSuper:(kAlertSuperView )kalertsuperview Title:(NSString *)title Content:(NSString *)content LeftBtnTitle:(NSString *)leftbtntitle RightBtnTitle:(NSString *)rightbtntitle clickBlock:(AlertViewBlock)block;







- (void)setTextAlignment:(NSTextAlignment)textalignment;


- (void)showInWindowWithView:(UIView *)view;

- (void)showInViewWithView:(UIView *)view;

- (void)hidenView;


@end

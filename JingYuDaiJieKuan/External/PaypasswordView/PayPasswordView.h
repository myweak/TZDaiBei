//
//  PayPasswordView.h
//  PayPasswordDemo
//
//  Created by fireflies on 2018/3/31.
//  Copyright © 2018年 高磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLTextField.h"

@protocol InputPasswordDelegate <NSObject>

-(void)inputPasswordContent:(NSString *)password;

@end

@interface PayPasswordView : UIView

//用来装密码圆点的数组
@property (nonatomic,strong) NSMutableArray *passwordDotsArray;

@property (nonatomic,weak)id <InputPasswordDelegate> delegate;
//密码输入文本框
@property (nonatomic,strong) GLTextField *passwordField;

@property (nonatomic,copy)void (^keyboardBeginChangeBlock)(void);
@property (nonatomic,copy)void (^keyboardEndChangeBlock)(void);

//将所有的假密码点设置为隐藏状态
- (void)setDotsViewHidden;

-(void)cleanPassword;

@end

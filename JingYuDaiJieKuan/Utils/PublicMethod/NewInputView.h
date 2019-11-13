//
//  NewInputView.h
//  NewJingYuBao
//
//  Created by 暴走的狗 on 2017/3/3.
//  Copyright © 2017年 厦门吉才神金融信息有限公司. All rights reserved.
//

typedef enum{
    NewInformationInput,
    NewPasswordInput,
    NewVerificaitonCodeInput
}NewInputType;

#import <UIKit/UIKit.h>
@interface NewInputView : UIView


@property (nonatomic, strong)UITextField  *inputTextFiled;
@property (nonatomic, strong)UIButton       *delBtn;
@property (nonatomic, strong)UIButton       *rightBtn;
@property (nonatomic, strong)UILabel        *leftLabel;
@property (nonatomic, copy) NSString *codeType;     //验证码类型必填

/**
 *  初始化
 *
 *  @param type           类型
 *  @param leftLabelStr   左边label字符串
 *  @param leftImageStr   左图
 *  @param placeholderStr 输入框默认字符串
 *  @param spacing        左图和输入框的间距
 *  @param leftSpacing    左图左间距
 *  @param isHidden         是否隐藏删除按钮
 *
 *  @return
 */
- (instancetype)initWithType:(NewInputType )type leftLabelName:(NSString *)leftLabelStr leftLabelFont:(UIFont*)leftFont leftLabelColor:(UIColor*)leftLabelColor leftImageStr:(NSString *)leftImageStr placeholder:(NSString *)placeholderStr tfFont:(UIFont *)tfFont spacing:(CGFloat)spacing leftSpacing:(CGFloat)leftSpacing hiddenDelBtn:(BOOL)isHidden codeObserveKey:(NSString *)codeobservekey;


- (void)deallocObserveWithKey:(NSString *)codeobservekey;


@end

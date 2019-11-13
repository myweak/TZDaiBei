//
//  Util.h
//  CarpFinancial
//
//  Created by weibin on 15/12/11.
//  Copyright © 2015年 cwb. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MBProgressHUD.h" 

typedef NS_ENUM(NSInteger ,CPHPayType) {
    BankCardPay = 1,    //银行卡支付
    WeiXinPay = 2,      //微信支付
    AliPay = 3 ,         //支付宝支付
    RbaoPay = 4         //支付宝支付
};


@interface Util : NSObject

+ (void)ShowHUD:(NSString *)tilte;
//限制RCLabel长度
//+(NSString *)limitRCLabelLength:(NSUInteger)limitLength string:(NSString *)str;

//限制textField不能输入的字符
+(BOOL)limitTextFieldCanNotInputWord:(NSString *)string limitStr:(NSString *)limitStr;

//限制textField输入的文字
+(BOOL)limitTextFieldInputWord:(NSString *)string limitStr:(NSString *)limitStr;

//保留2位小数
+(double)getTwoDecimalsDoubleValue:(double)number;

//判断输入的字符长度 一个汉字算2个字符
+ (NSUInteger)unicodeLengthOfString:(NSString *)text;

//字符串截到对应的长度包括中文 一个汉字算2个字符
+ (NSString *)subStringIncludeChinese:(NSString *)text ToLength:(NSUInteger)length;

//限制UITextField输入的长度，包括汉字  一个汉字算2个字符
+(void)limitIncludeChineseTextField:(UITextField *)textField Length:(NSUInteger)kMaxLength;


//限制UITextField输入的长度，不包括汉字
+(void)limitTextField:(UITextField *)textField Length:(NSUInteger)kMaxLength;

//限制UITextView输入的长度，包括汉字  一个汉字算2个字符
+(void)limitIncludeChineseTextView:(UITextView *)textview Length:(NSUInteger)kMaxLength;

//限制UITextView输入的长度，不包括汉字
+(void)limitTextView:(UITextView *)textview Length:(NSUInteger)kMaxLength;

//电话号码转换
+(NSString *)getConcealPhoneNumber:(NSString *)phoneNum;

//获得应用版本号
+(NSString *)getApplicationVersion;

+(void)limitIncludeChineseTextViewSecond:(UITextView *)textview Length:(NSUInteger)kMaxLength;

+ (NSUInteger)unicodeLengthOfStringSecond:(NSString *)text;

+ (NSString *)subStringIncludeChineseSecond:(NSString *)text ToLength:(NSUInteger)length;

+ (BOOL)containsChinese:(NSString *)string;

/// 刷新列表信息
+ (void)refreshTableView:(NSArray *)dataSource tabelview:(UITableView *)tableview message:(NSString *)message image:(NSString *)image;

+ (void)refreshSearchTableView:(NSArray *)dataSource tabelview:(UITableView *)tableview message:(NSString *)message image:(NSString *)image;

@end

//
//  Util.m
//  CarpFinancial
//
//  Created by weibin on 15/12/11.
//  Copyright © 2015年 cwb. All rights reserved.
//

#import "Util.h"

@implementation Util


+ (void)ShowHUD:(NSString *)title {
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = title;
    hud.animationType = MBProgressHUDAnimationZoom;
    [hud showAnimated:YES];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:hud];
    [self performSelector:@selector(removeHUB:) withObject:hud afterDelay:1.0f];
}
- (void)removeHUB:(MBProgressHUD *)hud
{
    if (hud) {
        [hud  hideAnimated:YES];
        [hud removeFromSuperview];
        hud = nil;
    }
}

/*
 +(NSString *)limitRCLabelLength:(NSUInteger)limitLength string:(NSString *)str
 {
 NSString *text=[NSString stringWithFormat:@"%@",str];
 
 //解析表情
 NSString *regex_emoji = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";//表情的正则表达式
 NSArray *array_emoji = [text componentsMatchedByRegex:regex_emoji];
 
 
 NSMutableArray *allStrArray=[[NSMutableArray alloc] initWithCapacity:2];
 NSDictionary *dic;
 
 if ([array_emoji count]) {
 
 for (int i=0; i<[array_emoji count]; i++) {
 NSString *emojiStr=[array_emoji objectAtIndex:i];
 
 NSRange range = [text rangeOfString:emojiStr];
 NSString *itemStr=[text substringToIndex:range.location];
 
 
 dic=[NSDictionary dictionaryWithObjectsAndKeys:itemStr,@"text",@"word",@"type", nil];
 [allStrArray addObject:dic];
 
 
 dic=[NSDictionary dictionaryWithObjectsAndKeys:emojiStr,@"text",@"emoji",@"type", nil];
 [allStrArray addObject:dic];
 
 text=[text substringFromIndex:range.location+emojiStr.length];
 
 if (i==array_emoji.count-1) {
 dic=[NSDictionary dictionaryWithObjectsAndKeys:text,@"text",@"word",@"type", nil];
 [allStrArray addObject:dic];
 
 }
 }
 
 } else {
 
 dic=[NSDictionary dictionaryWithObjectsAndKeys:text,@"text",@"word",@"type", nil];
 [allStrArray addObject:dic];
 
 }
 
 
 NSInteger allLength=0;
 
 NSMutableString *finalStr=[NSMutableString stringWithCapacity:1];
 
 for (NSDictionary *itemDic in allStrArray) {
 
 NSString *dicText=[itemDic objectForKey:@"text"];
 NSString *dicType=[itemDic objectForKey:@"type"];
 
 
 if ([dicType isEqualToString:@"emoji"]) {
 allLength++;
 [finalStr appendString:dicText];
 
 if (allLength>=limitLength) {
 [finalStr appendString:@"..."];
 break;
 }
 
 
 } else {
 
 for(NSUInteger i = 0; i < dicText.length; i++) {
 unichar uc = [dicText characterAtIndex: i];
 allLength += isascii(uc) ? 1 : 2;
 
 [finalStr appendString:[dicText substringWithRange:NSMakeRange(i, 1)]];
 
 if (allLength>=limitLength) {
 [finalStr appendString:@"..."];
 break;
 }
 }
 
 }
 
 }
 
 return finalStr;
 
 }
 
 */
//限制textField输入的文字
+(BOOL)limitTextFieldInputWord:(NSString *)string limitStr:(NSString *)limitStr
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:limitStr] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    BOOL canChange = [string isEqualToString:filtered];
    return canChange;
}

//限制textField不能输入的字符
+(BOOL)limitTextFieldCanNotInputWord:(NSString *)string limitStr:(NSString *)limitStr
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:limitStr] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    BOOL canChange = [string isEqualToString:filtered];
    return !canChange;
}

//保留2位小数
+(double)getTwoDecimalsDoubleValue:(double)number
{
    return round(number * 100.0)/100.0;
}

+(NSString *)getConcealPhoneNumber:(NSString *)phoneNum
{
    NSString *phoneStr=phoneNum;
    if (phoneStr!=nil && [phoneStr isMobile]) {
        phoneStr = [phoneStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    return phoneStr;
}

//判断输入的字符长度 一个汉字算2个字符
+ (NSUInteger)unicodeLengthOfString:(NSString *)text {
    NSUInteger asciiLength = 0;
    for(NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}

//字符串截到对应的长度包括中文 一个汉字算2个字符
+ (NSString *)subStringIncludeChinese:(NSString *)text ToLength:(NSUInteger)length{
    
    //    NSUInteger allLength=[self unicodeLengthOfString:text];
    //    if (text==nil  || length>allLength) {
    //        return text;
    //    }
    
    
    NSUInteger asciiLength = 0;
    NSUInteger location = 0;
    for(NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
        
        if (asciiLength==length) {
            location=i;
            break;
        }else if (asciiLength>length){
            location=i-1;
            break;
        }
        
    }
    
    NSString *finalStr=[text substringToIndex:location+1];
    
    return finalStr;
}

+(void)limitIncludeChineseTextField:(UITextField *)textField Length:(NSUInteger)kMaxLength
{
    NSString *toBeString = textField.text;
    NSUInteger length = [self unicodeLengthOfString:toBeString];
    
    NSString *lang = [textField.textInputMode primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            
            if (length > kMaxLength) {
                
                textField.text = [self subStringIncludeChinese:toBeString ToLength:kMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        
        if (length > kMaxLength) {
            textField.text = [self subStringIncludeChinese:toBeString ToLength:kMaxLength];
        }
    }
}


//限制UITextField输入的长度，不包括汉字
+(void)limitTextField:(UITextField *)textField Length:(NSUInteger)kMaxLength
{
    NSString *toBeString = textField.text;
    DLog(@"toBeString=%@",toBeString);
    //   NSInteger len = toBeString.length;
    if (toBeString.length > kMaxLength) {
        textField.text = [toBeString substringToIndex:kMaxLength];
    }
    DLog(@"textField.text=%@",textField.text);
}

//用于限制UITextView的输入中英文限制
+(void)limitIncludeChineseTextView:(UITextView *)textview Length:(NSUInteger)kMaxLength
{
    NSString *toBeString = textview.text;
    NSUInteger length = [self unicodeLengthOfString:toBeString];
    
    NSString *lang = [textview.textInputMode primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textview markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textview positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            
            if (length > kMaxLength) {
                
                textview.text = [self subStringIncludeChinese:toBeString ToLength:kMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        
        if (length > kMaxLength) {
            textview.text = [self subStringIncludeChinese:toBeString ToLength:kMaxLength];
        }
    }
}

//限制UITextView输入的长度，不包括汉字
+(void)limitTextView:(UITextView *)textview Length:(NSUInteger)kMaxLength
{
    NSString *toBeString = textview.text;
    if (toBeString.length > kMaxLength) {
        textview.text = [toBeString substringToIndex:kMaxLength];
    }
    
}

//获得应用版本号
+(NSString *)getApplicationVersion
{
    //application version (use short version preferentially)
    NSString *applicationVersion=nil;
    applicationVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    if ([applicationVersion length] == 0)
    {
        applicationVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    }
    return applicationVersion;
}

// (一个汉字一个字符)用于限制UITextView的输入中英文限制
+(void)limitIncludeChineseTextViewSecond:(UITextView *)textview Length:(NSUInteger)kMaxLength
{
    NSString *toBeString = textview.text;
    NSUInteger length = [self unicodeLengthOfStringSecond:toBeString];
    
    NSString *lang = [textview.textInputMode primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textview markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textview positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            
            if (length > kMaxLength) {
                
                textview.text = [self subStringIncludeChineseSecond:toBeString ToLength:kMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        
        if (length > kMaxLength) {
            textview.text = [self subStringIncludeChineseSecond:toBeString ToLength:kMaxLength];
        }
    }
}

//判断输入的字符长度 一个汉字算1个字符
+ (NSUInteger)unicodeLengthOfStringSecond:(NSString *)text {
    NSUInteger asciiLength = 0;
    for(NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 1;
    }
    return asciiLength;
}

//字符串截到对应的长度包括中文 一个汉字算1个字符
+ (NSString *)subStringIncludeChineseSecond:(NSString *)text ToLength:(NSUInteger)length{
    
    NSUInteger asciiLength = 0;
    NSUInteger location = 0;
    for(NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 1;
        
        if (asciiLength==length) {
            location=i;
            break;
        }else if (asciiLength>length){
            location=i-1;
            break;
        }
        
    }
    
    NSString *finalStr=[text substringToIndex:location+1];
    
    return finalStr;
}

//是否包含汉字
+ (BOOL)containsChinese:(NSString *)string
{
    for (int i = 0; i < [string length]; i++) {
        int a = [string characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    
    return NO;
}

// 刷新列表信息
//static CGFloat const HeightHeadrView = 70.0;
+ (void)refreshTableView:(NSArray *)dataSource tabelview:(UITableView *)tableview message:(NSString *)message image:(NSString *)image
{
    if (!dataSource || 0 == dataSource.count)
    {
        UIView *footView = InsertView(nil, CGRectMake(0, 0, tableview.width, kBodyHeight - KWidth(200.0)), nil);
        UIImageView *nilShopImage = InsertImageView(footView, CGRectMake((tableview.width - KWidth(200.0)) / 2.0, AutoWHGetHeight(126.0), KWidth(200.0), KWidth(200.0)), [UIImage imageNamed:image]);
        nilShopImage.contentMode = UIViewContentModeScaleAspectFit;
        InsertLabel(footView, CGRectMake(0, nilShopImage.bottom + AutoWHGetHeight(20.0), tableview.width, AutoWHGetHeight(19.0)), NSTextAlignmentCenter, message, kFontSize16, kColorBlack, NO);
        tableview.tableFooterView = footView;
    }
    else
    {
        tableview.tableFooterView = nil;
        [DataHelper setExtraCellLineHidden:tableview];
    }
    
    [tableview reloadData];
}
//刷新搜索
+ (void)refreshSearchTableView:(NSArray *)dataSource tabelview:(UITableView *)tableview message:(NSString *)message image:(NSString *)image
{
    {
        if (!dataSource || 0 == dataSource.count)
        {
            UIView *footView = InsertView(nil, CGRectMake(0, 0, tableview.width, kBodyHeight - AutoWHGetHeight(131.5)), nil);
            UIImageView *nilShopImage = InsertImageView(footView, CGRectMake((tableview.width - AutoWHGetWidth(172.0))/2.0, AutoWHGetHeight(125.0), AutoWHGetWidth(172.0), AutoWHGetHeight(106.0)), [UIImage imageNamed:image]);
            InsertLabel(footView, CGRectMake(0, nilShopImage.bottom + AutoWHGetHeight(20.0), tableview.width, AutoWHGetHeight(16.0)), NSTextAlignmentCenter, message, kFontSize15, kColorBlack, NO);
            tableview.tableFooterView = footView;
        }
        else
        {
            tableview.tableFooterView = nil;
            [DataHelper setExtraCellLineHidden:tableview];
        }
        
        [tableview reloadData];
    }
    
}

@end

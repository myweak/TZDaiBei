//
//  NSString+Extend.m
//  NewJingYuBao
//
//  Created by linshaokai on 16/6/24.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import "NSString+Extend.h"
#include <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (Extend)


+(BOOL)compareAppVersionShouldNeedUpdate:(NSString *)newVersion
{
    if ([newVersion compare:kApp_Version options:NSNumericSearch] == NSOrderedDescending) {
        return YES;
    }else
    {
        return NO;
    }
}

#pragma mark 计算文本内容的大小
-(CGSize)calculateTextSize:(CGFloat)font withSize:(CGSize)size
{
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:KFont(font)} context:nil];
    
    return rect.size;
}

-(CGFloat)calculateTextWidth:(CGFloat)font
{
    return [self calculateTextSize:font withSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
}

-(CGFloat)calculateTextHeight:(CGFloat)font withWidth:(CGFloat)width
{
    return [self calculateTextSize:font withSize:CGSizeMake(width, MAXFLOAT)].height;
}

//去空格
- (NSString *)stringBySpaceTrim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


//转化成货币形式￥34,560.53
-(NSString *)convertToCurrencyStyle
{
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    
    currencyFormatter.numberStyle = kCFNumberFormatterCurrencyStyle;
    [currencyFormatter setCurrencySymbol:@"￥"];
    [currencyFormatter setNegativeFormat:@"¤-#,##0.00"];
    
    NSString *string = [currencyFormatter stringFromNumber:[NSNumber numberWithDouble:self.doubleValue]];
    
    return string;
}

//转化成标准数字形式 3位一个","
-(NSString *)convertToDecimalStyle
{
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    currencyFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    NSString *myString = (NSMutableString *)[currencyFormatter stringFromNumber:[NSNumber numberWithDouble:self.integerValue]];
    return myString;
}




/*
 *MD5
 */
+ (NSString *)MD5WithString:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (int)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

//获取设备MAC地址
+ (NSString *)getMacAddress
{
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = NULL;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    // Befor going any further...
    if (errorFlag != NULL)
    {
        DLog(@"Error: %@", errorFlag);
        free(msgBuffer);
        return errorFlag;
    }
    
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    
    // Release the buffer memory
    free(msgBuffer);
    
    return macAddressString;
}


// 隐藏index开始到剩余4位的地方
+(NSString *)CardSecurityString:(NSString *)string andFirstShowIndex:(int)index
{
    int Stringlenth = (int)string.length;
    if (Stringlenth < 5 || Stringlenth < index+4)
    {
        return string;
    }
    NSString *StringFirst = [string substringToIndex:index];
    NSString *StringLaster = [string substringFromIndex:Stringlenth-4];
    int count = Stringlenth-index-4;
    for (int i=0; i< count; i++)
    {
        StringFirst = [StringFirst stringByAppendingString:@"*"];
    }
    StringFirst = [StringFirst stringByAppendingString:StringLaster];
    
    return StringFirst;
}

// 返回正整数
+(NSString *)getPositiveInteger:(NSString *)string{
    
    if ([string isEqualToString:@""])
    {
        return @"";
    }
    if ([string validatePositiveInteger]) {
        
        return string;
    }
    else
    {
        if (string.length>1)
        {
       
            if ([[string substringToIndex:1] isEqualToString:@"0"]){
                return [string substringFromIndex:1];
            }
            else {
                return [NSString changeStringToNumber:string];
            }
        }
        else
        {
            return @"";
        }
    }
}


// 替换字符串中不数字的
+ (NSString *)changeStringToNumber:(NSString *)string{
    
    for (int i = 0; i < [string length]; i++) {
        
        NSString *stringSingle = [string substringWithRange:NSMakeRange(i, 1)];
        if (![stringSingle validateAllNumber]) {
            NSRange range = NSMakeRange(i, 1);
            string = [string stringByReplacingCharactersInRange:range withString:@" "];
        }
    }
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}

#pragma mark 正则表达式
//是否是数字
-(BOOL)validateNumber
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^([\\d.])$"]evaluateWithObject:self];
}
//是否是数字或者英文组合的
-(BOOL)validateNumberOrLetter
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^([0-9A-Za-z_])$"] evaluateWithObject:self];
}


//是否是数字6位验证码
-(BOOL)validateCode
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"\\d{6}"] evaluateWithObject:self];
}
//是否是正整数
-(BOOL)validatePositiveInteger
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[1-9]\\d*$"] evaluateWithObject:self];
}

//是否是全数字
-(BOOL)validateAllNumber
{
    NSScanner *scan = [NSScanner scannerWithString:self];
    NSInteger val;
    return [scan scanInteger:&val] && [scan isAtEnd];
}
//是否是浮点型
-(BOOL)validateFloat
{
    NSScanner *scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}
//浮点型数据不四舍五入
+(NSString *)notRounding:(double)price afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal = nil;
    NSDecimalNumber *roundedOunces = nil;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%.2f",[roundedOunces doubleValue]];
}
//是否是电话号码
-(BOOL)validateMobilePhone
{
    
    NSRange range = [self rangeOfString:@"-"];
    NSString *mobileString = [self stringByReplacingOccurrencesOfString:@" " withString:@""];;
    if (range.location != NSNotFound) {
        mobileString = [self stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    NSString *phoneRegex = @"^1[34578][0-9]{9}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [predicate evaluateWithObject:mobileString];
 
    
}
//是否是身份证
-(BOOL)validateIdentityCard
{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
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



//+ (BOOL)UnlockPasswordOpen
//{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSNumber *result = [userDefaults objectForKey:KEY_IF_UNLOCK_OPEN];
//    if (result == nil || [result intValue] == 0)
//    {
//        return NO;
//    }
//    else if([result intValue] == 1)
//    {
//        return YES;
//    }
//    return NO;
//}


@end

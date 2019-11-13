//
//  DataHelper.m
//  CarpFinancial
//
//  Created by weibin on 15/12/11.
//  Copyright © 2015年 cwb. All rights reserved.
//

#import "DataHelper.h"
#import <CommonCrypto/CommonDigest.h>
#define FileHashDefaultChunkSizeForReadingData 1024*8

@implementation DataHelper

+ (void)imageViewAnimation:(UIImageView *)imageView image:(UIImage *)image
{
    imageView.alpha = 0;
    imageView.image = nil;
    [imageView setImage:image];
    
    NSTimeInterval animationDuration = 1.0f;
    [UIView beginAnimations:@"ImageLoaded" context:nil];
    [UIView setAnimationDuration:animationDuration];
    imageView.alpha = 1;
    [UIView commitAnimations];
}

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+ (UIImage *)scaleImage:(UIImage *)image toMinSize:(float)size
{
    //    DLog(@"%@",NSStringFromCGSize(image.size));
    CGSize temSize = CGSizeZero;
    if (MIN(image.size.width, image.size.height)<=size) {
        temSize = image.size;
    }else if (image.size.width-image.size.height>0) {
        temSize = CGSizeMake(image.size.width*size/image.size.height, size);
    }else{
        temSize = CGSizeMake(size, image.size.height*size/image.size.width);
    }
    UIGraphicsBeginImageContext(temSize);
    [image drawInRect:CGRectMake(0, 0, temSize.width, temSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

#pragma mark 保存图片到Cache
+ (void)saveImage:(UIImage *)tempImage WithPath:(NSString *)path{
    NSData *imageData = UIImageJPEGRepresentation(tempImage, 0.5);
    //    NSString *fullPathToFile  = [self cachesFolderPathWithName:imageName];
    [imageData writeToFile:path atomically:NO];
    //    return fullPathToFile;
}

#pragma mark 从文档目录下获取路径
+ (NSString *)cachesFolderPathWithName:(NSString *)imageName{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    NSString *fullPathToFile  = [cachesDirectory stringByAppendingPathComponent:imageName];
    return fullPathToFile;
    //    return [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Library/Caches/%@",imageName]];
}

+ (void)removeCachesFolderAtPath:(NSString*)filePath{
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

+(NSString *)getCurrentTime{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    return [dateFormatter stringFromDate:nowDate];
}

+ (void)setExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view =[[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

+ (NSString*)conversionDeviceToken:(NSData*)deviceToken{
    NSString *deviceTokenStr = [NSString stringWithFormat:@"%@",deviceToken];
    deviceTokenStr = [[deviceTokenStr substringWithRange:NSMakeRange(0, 72)] substringWithRange:NSMakeRange(1, 71)];
    deviceTokenStr = [deviceTokenStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    return deviceTokenStr;
}

#pragma mark - gps
//判断gps是否有效
+ (BOOL)gpsIsValidLongitude:(double)longitude latitude:(double)latitude
{
    if (latitude!=0.0
        && longitude!=0.0
        && latitude<90.0
        && latitude>-90.0
        && longitude<180.0
        && longitude>-180.0) {
        return YES;
    }
    return NO;
}

#pragma mark - Random
//+ (NSString*)getRandomFileName
//{
//    NSDate *date = [NSDate date];
//    NSString *dateString = [TimeUtil getDate:date withFormat:@"yyyyMMddHHmmss"];
//    int random = [self getRandomNumber:0 to:1000000];
//    return [NSString stringWithFormat:@"%@_%06d",dateString,random];
//}

//获取一个随机整数，范围在[from,to），包括from，不包括to
+(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to-from + 1)));
}

#pragma mark - xml
//+(NSXMLElement*)creationPropertyName:(NSString*)name valueType:(NSString*)valueType value:(NSString*)value{
//    NSXMLElement *properties = [NSXMLElement elementWithName:@"property"];
//    NSXMLElement *nameElement = [NSXMLElement elementWithName:@"name" stringValue:name];
//    NSXMLElement *valueElement = [NSXMLElement elementWithName:@"value" stringValue:value];
//    [valueElement addAttributeWithName:@"type" stringValue:valueType];
//    [properties addChild:nameElement];
//    [properties addChild:valueElement];
//    return properties;
//}

#pragma mark - UIColor
+ (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

#pragma mark - md5 32位加密
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString uppercase:(BOOL)uppercase
{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return uppercase ? [result uppercaseString] : result;
}

#pragma mark - md5 16位加密
+ (NSString *)getMd5_16Bit_String:(NSString *)srcString uppercase:(BOOL)uppercase
{
    //提取32位MD5散列的中间16位
    NSString *md5_32Bit_String=[self getMd5_32Bit_String:srcString uppercase:uppercase];
    NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];//即9～25位
    
    return result;
}

#pragma mark - DES
/**
 *  设置请求参数携带版本号
 */
+(NSDictionary *)setupPostParams:(nullable NSDictionary *)param footUrl:(NSString *)footUrl
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (param) {
        [params addEntriesFromDictionary:param];
    }
//    [params setObject:[NSString stringWithFormat:@"%@",kApp_Version] forKey:@"version"];
//    [params setObject:[NSString stringWithFormat:@"App Store"] forKey:@"channel"];
//    [params setObject:[NSString stringWithFormat:kClientType] forKey:@"clientType"];
//    [params setObject:[NSString stringWithFormat:@"%@", [kUserMessageManager getUserToken]] forKey:@"token"];

    return params;
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark-

#pragma mark - 计算高度
+ (CGFloat)heightWithString:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    CGSize rtSize;
//    if(ISIOS7) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        rtSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        return ceil(rtSize.height) + 0.5;
//    }
//    else {
//        rtSize = [string sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
//        return rtSize.height;
//    }
}

#pragma mark- 单行文字宽度
+ (CGFloat)widthWithString:(NSString *)string font:(UIFont *)font
{
    CGSize rtSize;
//    if(ISIOS7) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        rtSize = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        return ceil(rtSize.width) + 0.5;
//    } else {
//        rtSize = [string sizeWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
//        return rtSize.width;
//    }
}

#pragma mark- 设置TextField左边空白
+ (void)setEmptyLeftViewForTextField:(UITextField *)textField withFrame:(CGRect)rect
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor clearColor];
    textField.leftView = view;
    textField.leftViewMode = UITextFieldViewModeAlways;
}

/*
 + (HZActivityIndicatorView*)getActivityIndicatorView
 {
 HZActivityIndicatorView *activityIndicator = [[HZActivityIndicatorView alloc] init];
 //    activityIndicator.backgroundColor = self.view.backgroundColor;
 activityIndicator.opaque = YES;
 activityIndicator.steps = 8;
 activityIndicator.finSize = CGSizeMake(2, 4);
 activityIndicator.indicatorRadius = 5;//指示器半径
 activityIndicator.stepDuration = 0.100;
 activityIndicator.color = [UIColor colorWithRed:0 green:174.0/255 blue:125.0/255 alpha:1.0];
 activityIndicator.roundedCoreners = UIRectCornerAllCorners;
 activityIndicator.cornerRadii = CGSizeMake(10, 10);//圆角半径
 return activityIndicator;
 }
 */

+ (NSString *)showPromptMessage:(NSString *)phone
{
    NSString *text;
    if ([phone isMobile]) {
        NSMutableString *phoneNumber = [NSMutableString stringWithString:phone];
        [phoneNumber replaceCharactersInRange:NSMakeRange(3,4) withString:@"****"];
        text = [NSString stringWithFormat:@"我们已经给您%@发送了验证短信",phoneNumber];
        //        [iToast alertWithTitle:text];
        //        [SVProgressHUD showWithStatus:text];
    }
    return text;
    
}


/*
 +(BOOL) isEmptyOrNull:(NSString *) string {
 if ([NSString isNull:string]) {
 // null object
 return YES;
 } else {
 NSString *trimedString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
 if ([trimedString length] == 0) {
 // empty string
 return YES;
 } else {
 // is neither empty nor null
 return NO;
 }
 }
 }
 
 *  限制textfild 小数位数为2位
 */
+ (BOOL)setRadixPointForTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    /*
     BOOL _isHasRadixPoint;
     if ([textField isFirstResponder]) {
     _isHasRadixPoint = YES;
     NSString *existText = textField.text;
     if ([existText rangeOfString:@"."].location == NSNotFound) {
     _isHasRadixPoint = NO;
     }
     if (string.length > 0) {
     unichar newChar = [string characterAtIndex:0];
     if ((newChar >= '0' && newChar <= '9') || newChar == '.' ) {
     if (newChar == '.') {
     if (_isHasRadixPoint)
     return NO;
     else
     return YES;
     }else {
     if (_isHasRadixPoint) {
     NSRange ran = [existText rangeOfString:@"."];
     int radixPointCount = range.location - ran.location;
     if (radixPointCount <= 2) return YES;
     else return NO;
     } else
     return YES;
     }
     
     }else {
     if ( newChar == '\n') return YES;
     return NO;
     }
     
     }else {
     return YES;
     }
     }
     return YES;
     */
    if ([textField isFirstResponder]) {
        //   NSCharacterSet *firstSet = [NSCharacterSet characterSetWithCharactersInString:@".0"];
        NSCharacterSet *numberSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSCharacterSet *limitSet = [NSCharacterSet characterSetWithCharactersInString:@".0123456789"];
        
        NSString *tempStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (tempStr.length == 1)
        {
            // 首个输入不能为0或小数点
            //    NSRange firstRange = [tempStr rangeOfCharacterFromSet:firstSet];
            // 但可以输入数字
            NSRange numberRange = [tempStr rangeOfCharacterFromSet:numberSet];
            if (/*IfirstRange.location != NSNotFound || */numberRange.location == NSNotFound)
            {
                return NO;
            }
        }
        else if (tempStr.length > 1)
        {
            /*
             // 编辑状态中移动光标后，首个输入不能为0
             NSString *firstString = [tempStr substringToIndex:1];
             if ([firstString isEqualToString:@"0"] || [firstString isEqualToString:@"."])
             {
             return NO;
             }
             */
            for (int i = 0; i < tempStr.length; i++)
            {
                
                NSString *subString = [tempStr substringWithRange:NSMakeRange(i, 1)];
                
                // 只能输入数字和小数点
                NSRange numberRange = [subString rangeOfCharacterFromSet:limitSet];
                if (numberRange.location == NSNotFound)
                {
                    return NO;
                }
            }
            
            // 无小数点时，只能输入6个数字
            NSRange pointRange = [tempStr rangeOfString:@"."];
            if (pointRange.location == NSNotFound && 7 == tempStr.length)
            {
                return NO;
            }
            
            // 存在小数点时，只能再输入两位小数，不能再输入小数点
            if (pointRange.location != NSNotFound)
            {
                // 只能有一个小数点
                CGFloat limitlength = pointRange.location + pointRange.length;
                NSString *temp = [tempStr substringFromIndex:limitlength];
                NSRange hasPointRange = [temp rangeOfString:@"."];
                if (hasPointRange.location != NSNotFound)
                {
                    return NO;
                }
                
                // 小数点后两位
                if (limitlength + 3 == tempStr.length)
                {
                    return NO;
                }
                
                // 存在小数时点，整数不足五位时，最多只能输入6位
                NSString *subTemp = [tempStr substringToIndex:pointRange.location];
                if (7 == subTemp.length)
                {
                    return NO;
                }
            }
        }
        return YES;
        
    }
    return YES;
}

// begin 金额输入限制位数，可自定义整数位

+ (BOOL)setlimitForTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string number:(int)number
{
    if ([textField isFirstResponder])
    {
        NSCharacterSet *numberSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSCharacterSet *limitSet = [NSCharacterSet characterSetWithCharactersInString:@".0123456789"];
        
        NSString *tempStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (tempStr.length == 1)
        {
            // 首个输入不能为0或小数点
            // 但可以输入数字
            NSRange numberRange = [tempStr rangeOfCharacterFromSet:numberSet];
            if (numberRange.location == NSNotFound)
            {
                return NO;
            }
        }
        else if (tempStr.length > 1)
        {
            for (int i = 0; i < tempStr.length; i++)
            {
                NSString *subString = [tempStr substringWithRange:NSMakeRange(i, 1)];
                
                // 只能输入数字和小数点
                NSRange numberRange = [subString rangeOfCharacterFromSet:limitSet];
                if (numberRange.location == NSNotFound)
                {
                    return NO;
                }
            }
            
            // 无小数点时，只能输入number个数字，0时无限制
            NSRange pointRange = [tempStr rangeOfString:@"."];
            if (number != 0)
            {
                if (pointRange.location == NSNotFound && number + 1 == tempStr.length)
                {
                    return NO;
                }
            }
            
            // 存在小数点时，只能再输入两位小数，不能再输入小数点
            if (pointRange.location != NSNotFound)
            {
                // 只能有一个小数点
                CGFloat limitlength = pointRange.location + pointRange.length;
                NSString *temp = [tempStr substringFromIndex:limitlength];
                NSRange hasPointRange = [temp rangeOfString:@"."];
                if (hasPointRange.location != NSNotFound)
                {
                    return NO;
                }
                
                // 小数点后两位
                if (limitlength + 3 == tempStr.length)
                {
                    return NO;
                }
                
                // 存在小数时点，整数不足五位时，最多只能输入6位，0时无限制
                if (number != 0)
                {
                    NSString *subTemp = [tempStr substringToIndex:pointRange.location];
                    if (number + 1 == subTemp.length)
                    {
                        return NO;
                    }
                }
            }
        }
        
        return YES;
    }
    return YES;
}

// 金额输入限制（首位不能为0）
+ (BOOL)setlimitForTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string number:(int)number shouldBiggerThanOne:(BOOL)bigger
{
    if ([textField isFirstResponder])
    {
        NSCharacterSet *withoutZeroNumberSet = [NSCharacterSet characterSetWithCharactersInString:@"123456789"];
        NSCharacterSet *numberSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSCharacterSet *limitSet = [NSCharacterSet characterSetWithCharactersInString:@".0123456789"];
        
        NSString *tempStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (tempStr.length == 1)
        {
            // 首个输入限制
            if (bigger)
            {
                // 不能为0或小数点，即不能小于1
                NSRange numberRange = [tempStr rangeOfCharacterFromSet:withoutZeroNumberSet];
                if (numberRange.location == NSNotFound)
                {
                    return NO;
                }
            }
            else
            {
                // 可以小于1
                NSRange numberRange = [tempStr rangeOfCharacterFromSet:numberSet];
                if (numberRange.location == NSNotFound)
                {
                    return NO;
                }
            }
        }
        else if (tempStr.length > 1)
        {
            for (int i = 0; i < tempStr.length; i++)
            {
                NSString *subString = [tempStr substringWithRange:NSMakeRange(i, 1)];
                
                // 只能输入数字和小数点
                NSRange numberRange = [subString rangeOfCharacterFromSet:limitSet];
                if (numberRange.location == NSNotFound)
                {
                    return NO;
                }
            }
            
            // 无小数点时，只能输入number个数字，0时无限制
            NSRange pointRange = [tempStr rangeOfString:@"."];
            if (number != 0)
            {
                if (pointRange.location == NSNotFound && number + 1 == tempStr.length)
                {
                    return NO;
                }
            }
            
            // 存在小数点时，只能再输入两位小数，不能再输入小数点
            if (pointRange.location != NSNotFound)
            {
                // 只能有一个小数点
                CGFloat limitlength = pointRange.location + pointRange.length;
                NSString *temp = [tempStr substringFromIndex:limitlength];
                NSRange hasPointRange = [temp rangeOfString:@"."];
                if (hasPointRange.location != NSNotFound)
                {
                    return NO;
                }
                
                // 小数点后两位
                if (limitlength + 3 == tempStr.length)
                {
                    return NO;
                }
                
                // 存在小数时点，整数不足五位时，最多只能输入6位，0时无限制
                if (number != 0)
                {
                    NSString *subTemp = [tempStr substringToIndex:pointRange.location];
                    if (number + 1 == subTemp.length)
                    {
                        return NO;
                    }
                }
            }
        }
        
        return YES;
    }
    return YES;
}

// 密码输入长度限制
+ (BOOL)setlimitPwdForTextField:(UITextField *)textField number:(int)number min:(BOOL)min
{
    // 密码限制，输入8-16位
    if ([textField isFirstResponder] && ![NSString isNull:textField.text])
    {
        if (!min)
        {
            // 密码限制最多输入16位
            if (textField.text.length > number - 1)
            {
                return NO;
            }
        }
        else
        {
            // 最少输入8位
            if (textField.text.length < number)
            {
                //                [iToast alertWithTitle:@"请输入8到16位密码"];
                return NO;
            }
        }
    }
    
    return YES;
}

// string to number
+ (NSNumber *)stringToNum:(NSString *)string
{
    return [NSNumber numberWithLongLong:[string longLongValue]];
}

+ (NSString *)getSecretStylePhone:(NSString *)phoneStr
{
    return [phoneStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
}

//替换frame 的高度
+ (CGRect)changeFrame:(CGRect)frame setHeight:(CGFloat)height
{
    CGRect newFrame = frame;
    newFrame.size.height = height;
    return newFrame;
}

@end

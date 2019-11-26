//
//  AppStyleRelated.h
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/19.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#ifndef AppStyleRelated_h
#define AppStyleRelated_h

typedef enum {
    kAlertwindow,       //添加在window层
    kAlertview         //添加在view层
}kAlertSuperView;

typedef NS_ENUM(NSUInteger, HTTPRequestType) {
    HTTPRequestType_GET = 0,
    HTTPRequestType_POST,
    HTTPRequestType_MultiPartPOST
};

typedef enum : NSUInteger
{
    kSendCodeForRegister = 0,
    kSendCodeForForgetKey,
    kSendCodeForCodeLogin,
} kTimeSecondType;

/*
 各版本尺寸
 1 iPhone4      640*960   320*480 2倍
 2 iPhone4S     640*960   320*480 2倍
 3 iPhone5      640*1136  320*568 2倍
 4 iPhone5S     640*1136  320*568 2倍
 5 iPhone5C     640*1136  320*568 2倍
 6 iPhone6      750*1334  375*667 2倍
 7 iPhone6 Plus 1242*2208 414*736 3倍
 8 iPhone X     1125*2436 375*812 3倍
 
 各版本比例
 iPhone5，    autoSizeScaleX=1，autoSizeScaleY=1；
 iPhone6，    autoSizeScaleX=1.171875，autoSizeScaleY=1.17429577；
 iPhone6Plus，autoSizeScaleX=1.29375， autoSizeScaleY=1.295774；
 
 各版本比例
 iPhone4，    autoSizeScaleX=0.853333，autoSizeScaleY=0.84507；
 iPhone5，    autoSizeScaleX=0.853333，autoSizeScaleY=0.851574；
 iPhone6，    autoSizeScaleX=1，autoSizeScaleY=1；
 iPhone6Plus，autoSizeScaleX=1.104， autoSizeScaleY=1.103448；
 */

#define kAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

/// Sys
#define ISiPhone    [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone

#define ISiPad      [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


#define iPhone6P_Pix (([[UIScreen mainScreen] scale] >=3) ? YES : NO)
#define kiP6WidthRace(x)           ((x) * kScreenWidth) / 375.0

//iPhoneX系列
#define kIsPhoneX (iPhoneX || iPhoneXR || iPhoneXS || iPhoneXMax || isIphoneXR_XSMax)
//iPhoneX系列

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

// 判断是否是iPhone XR
#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否是iPhone XS
#define iPhoneXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否是iPhone X Max
#define iPhoneXMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define  isIphoneXR_XSMax    (kScreenWidth == 375.f && kScreenHeight == 812.f ? YES : NO)

#define ISIOS7      ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7)
#define ISIOS8      ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8)
#define ISIOS9      ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 9)
#define ISIOS10      ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10)
#define ISIOS11      ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 11)


#define UIInterfaceOrientationIsPortrait(orientation)  ((orientation) == UIInterfaceOrientationPortrait || (orientation) == UIInterfaceOrientationPortraitUpsideDown)
#define UIInterfaceOrientationIsLandscape(orientation) ((orientation) == UIInterfaceOrientationLandscapeLeft || (orientation) == UIInterfaceOrientationLandscapeRight)

#define INTERFACEPortrait self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown
#define INTERFACELandscape self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight

#define IS_IPAD_AutoSize             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE_AutoSize           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA_AutoSize           ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH_AutoSize        ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT_AutoSize       ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH_AutoSize   (MAX(SCREEN_WIDTH_AutoSize, SCREEN_HEIGHT_AutoSize))
#define SCREEN_MIN_LENGTH_AutoSize   (MIN(SCREEN_WIDTH_AutoSize, SCREEN_HEIGHT_AutoSize))

#define IS_IPHONE_4_OR_LESS_AutoSize (IS_IPHONE_AutoSize && SCREEN_MAX_LENGTH_AutoSize < 568.0)
#define IS_IPHONE_5_AutoSize         (IS_IPHONE_AutoSize && SCREEN_MAX_LENGTH_AutoSize == 568.0)
#define IS_IPHONE_6_AutoSize         (IS_IPHONE_AutoSize && SCREEN_MAX_LENGTH_AutoSize == 667.0)
#define IS_IPHONE_6P_AutoSize        (IS_IPHONE_AutoSize && SCREEN_MAX_LENGTH_AutoSize == 736.0)


/*--------------------------- 尺寸 ---------------------------*/

/// Height/Width
#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight       [UIScreen mainScreen].bounds.size.height
#define kAllHeight          ([UIScreen mainScreen].bounds.size.height)
#define kBodyHeight         ([UIScreen mainScreen].applicationFrame.size.height - 44.0)
#define kViewHeight         ([UIScreen mainScreen].bounds.size.height - 64.0)
#define kWidthRace(x)        ((x) * kScreenWidth) / 320.0
#define kiP6WidthRace(x)           ((x) * kScreenWidth) / 375.0

//以iphone6适配
#define iPH(asd) ((asd/667.0f)*[UIScreen mainScreen].bounds.size.height)
#define iPW(asd) ((asd/375.0f)*[UIScreen mainScreen].bounds.size.width)

//高度
#define kCPWidth(v)         AutoWHGetWidth(v)
#define kCPHeight(v)        AutoWHGetHeight(v)
#define kAppBtnHeight           kiP6WidthRace(48.0)
#define kAppBtnWidth            kiP6WidthRace(345.0)

////////////////////////////////////////////////////////////////////////////////////

#define AutoSizeDelegate_AutoSize     ([[UIApplication sharedApplication] delegate])
/** 屏幕宽度 */
#define AutoSizeScreenWidth_AutoSize  ([[UIScreen mainScreen] bounds].size.width)
/** 屏幕高度 */
#define AutoSizeScreenHeight_AutoSize ([[UIScreen mainScreen] bounds].size.height)

//状态栏高度
#define kStatusBarH (kIsPhoneX ? 44.0 : 20.0)

//app 版本号
#define kApp_Version [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]



#define AutoSizeScaleX_AutoSize ((AutoSizeScreenHeight_AutoSize > 667.0) ? (AutoSizeScreenWidth_AutoSize / 375.0) : 1.0)

#define AutoSizeScaleY_AutoSize ((AutoSizeScreenHeight_AutoSize > 667.0) ? (AutoSizeScreenWidth_AutoSize / 375) : 1.0)

#define AutoSizeScaleY_AutoSize1 ((AutoSizeScreenHeight_AutoSize != 667) ? (AutoSizeScreenWidth_AutoSize / 375) : 1.0)

//#define AutoSizeScaleX_AutoSize ((AutoSizeScreenHeight_AutoSize > 480.0) ? (AutoSizeScreenWidth_AutoSize / 320.0) : 1.0)
//#define AutoSizeScaleY_AutoSize ((AutoSizeScreenHeight_AutoSize > 480.0) ? (AutoSizeScreenHeight_AutoSize / 568.0) : 1.0)

////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////初始化存储数据/////////////////////////////////////////
#define kRisk_url @"risk_url"                   //风险评测协议
#define kRegisterProtocol @"register_protocol"  //注册协议
#define kBindcardProtocol @"bindcard_protocol"  //更换银行卡协议
#define kLoanProtocol @"loan_protocol"          //网络借贷风险和禁止性行为提示书
#define kLendProtocol @"lend_protocol"          //出借咨询与服务协议
#define kLondProtocol @"lond_protocol"          //财鹿管家借款合同
#define kVoucherProtocol @"voucher_protocol"    //凭证协议
#define SERVICE_PHONE    @"service_phone"       //客服电话
#define UserAgreement  @"UserAgreement"// 用户协议


//时间戳 得到的时间戳是毫秒
#define INTERVAL_STRING [NSString stringWithFormat:@"%lf",[[NSDate date] timeIntervalSince1970] * 1000]



/**
runtime实现通用copy
*/
#define tz_CopyWithZone \
- (id)copyWithZone:(NSZone *)zone {\
    id obj = [[[self class] allocWithZone:zone] init];\
    Class class = [self class];\
    while (class != [NSObject class]) {\
        unsigned int count;\
        Ivar *ivar = class_copyIvarList(class, &count);\
        for (int i = 0; i < count; i++) {\
            Ivar iv = ivar[i];\
            const char *name = ivar_getName(iv);\
            NSString *strName = [NSString stringWithUTF8String:name];\
            id value = [[self valueForKey:strName] copy];\
            [obj setValue:value forKey:strName];\
        }\
        free(ivar);\
        class = class_getSuperclass(class);\
    }\
    return obj;\
}\
\
-(id)mutableCopyWithZone:(NSZone *)zone{\
    id obj = [[[self class] allocWithZone:zone] init];\
    Class class = [self class];\
    while (class != [NSObject class]) {\
        unsigned int count;\
        Ivar *ivar = class_copyIvarList(class, &count);\
        for (int i = 0; i < count; i++) {\
            Ivar iv = ivar[i];\
            const char *name = ivar_getName(iv);\
            NSString *strName = [NSString stringWithUTF8String:name];\
            id value = [[self valueForKey:strName] copy];\
            [obj setValue:value forKey:strName];\
        }\
        free(ivar);\
        class = class_getSuperclass(class);\
    }\
    return obj;\
}\
\

/**
 二、runtime实现通用
 归档的实现
 */

#define tz_CodingImplementation \
- (void)encodeWithCoder:(NSCoder *)aCoder \
{ \
unsigned int outCount = 0; \
Ivar * vars = class_copyIvarList([self class], &outCount); \
for (int i = 0; i < outCount; i++) { \
    Ivar var = vars[i]; \
    const char * name = ivar_getName(var); \
    NSString * key = [NSString stringWithUTF8String:name]; \
    id value = [self valueForKey:key]; \
    if (value) { \
        [aCoder encodeObject:value forKey:key]; \
    } \
} \
} \
\
- (instancetype)initWithCoder:(NSCoder *)aDecoder \
{ \
    if (self = [super init]) { \
        unsigned int outCount = 0; \
        Ivar * vars = class_copyIvarList([self class], &outCount); \
        for (int i = 0; i < outCount; i++) { \
            Ivar var = vars[i]; \
            const char * name = ivar_getName(var); \
            NSString * key = [NSString stringWithUTF8String:name]; \
            id value = [aDecoder decodeObjectForKey:key]; \
            if (value) { \
                [self setValue:value forKey:key]; \
            } \
        } \
    } \
    return self; \
}




//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;\

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}\




CG_INLINE CGFloat
AutoCGRectGetMinX(CGRect rect)
{
    CGFloat x = rect.origin.x * AutoSizeScaleX_AutoSize;
    return x;
}

CG_INLINE CGFloat
AutoCGRectGetMinY(CGRect rect)
{
    CGFloat y = rect.origin.y * AutoSizeScaleX_AutoSize;
    return y;
}

CG_INLINE CGFloat
AutoCGRectGetWidth(CGRect rect)
{
    CGFloat width = rect.size.width * AutoSizeScaleX_AutoSize;
    return width;
}

CG_INLINE CGFloat
AutoCGRectGetHeight(CGRect rect)
{
    CGFloat height = rect.size.height * AutoSizeScaleX_AutoSize;
    return height;
}

CG_INLINE CGPoint
AutoCGPointMake(CGFloat x, CGFloat y)
{
    CGPoint point;
    point.x = x * AutoSizeScaleX_AutoSize;
    point.y = y * AutoSizeScaleY_AutoSize;
    
    return point;
}

CG_INLINE CGSize
AutoCGSizeMake(CGFloat width, CGFloat height)
{
    CGSize size;
    size.width = width * AutoSizeScaleX_AutoSize;
    size.height = height * AutoSizeScaleY_AutoSize;
    
    return size;
}

CG_INLINE CGRect
AutoCGRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = x * AutoSizeScaleX_AutoSize;
    rect.origin.y = y * AutoSizeScaleY_AutoSize;
    rect.size.width = width * AutoSizeScaleX_AutoSize;
    rect.size.height = height * AutoSizeScaleY_AutoSize;
    
    return rect;
}

////////////////////////////////////////////////////////////////////////////////////

CG_INLINE CGRect
AutoWHCGRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height, BOOL autoW, BOOL autoH)
{
    CGRect rect;
    rect.origin.x = x;
    rect.origin.y = y;
    rect.size.width = (autoW ? (width * AutoSizeScaleX_AutoSize) : width);
    rect.size.height = (autoH ? (height * AutoSizeScaleY_AutoSize) : height);
    
    return rect;
}

CG_INLINE CGFloat
AutoWHGetHeight(CGFloat height)   // 5,6同尺寸,7以上自动放大
{
    CGFloat autoHeight = height * AutoSizeScaleY_AutoSize;
    return autoHeight;
}

CG_INLINE CGFloat
kAHeight(CGFloat width)
{
    return AutoWHGetHeight(width);
}


CG_INLINE CGFloat
AutoWHGetWidth(CGFloat width)    // 5,6同尺寸,7以上自动放大
{
    CGFloat autoWidth = width * AutoSizeScaleX_AutoSize;
    return autoWidth;
}

CG_INLINE CGFloat
kAWidth(CGFloat width)
{
    return AutoWHGetWidth(width);
}

CG_INLINE CGFloat
AutoGetHeight(CGFloat height)  // 5,6,7自动放大
{
    CGFloat autoHeight = height * AutoSizeScaleY_AutoSize1;
    return autoHeight;
}
///**
// 基于6的屏幕适配
// */
//CG_INLINE CGFloat
//AutoWidth(CGFloat width)
//{
//    CGFloat autoWidth = width * AutoSizeScaleX_AutoSize1;
//    return autoWidth;
//}
//CG_INLINE CGFloat
//AutoHeight(CGFloat height)
//{
//    CGFloat autoHeight = height * AutoSizeScaleY_AutoSize;
//    return autoHeight;
//}


#endif /* AppStyleRelated_h */

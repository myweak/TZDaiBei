//
//  AppRelatedDefinition.h
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/20.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#ifndef AppRelatedDefinition_h
#define AppRelatedDefinition_h

/********************** 常用宏 ****************************/

// 新增宏定义判断无网络情况
#define GetNetworkStatusNotReachable ([Reachability reachabilityForInternetConnection].currentReachabilityStatus == NotReachable)

#define JSIsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) || ([(_ref) isEqual:@""]))

#define GetAPPDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

/// DataManager
#define GetDataManager [DataManager sharedManager]

/// NSMutableDictionary
#define GetMutableDic           NSMutableDictionary *dic = [NSMutableDictionary dictionary]
#define DicObjectSet(obj,key)   [dic setObject:obj forKey:key]
#define DicValueSet(value,key)  [dic setValue:value forKey:key]

#define kUserDefaults [NSUserDefaults standardUserDefaults]

#define kUserMessageManager [UserMessageManager sharedUserMessageManager]

#define kSelfWeak __weak typeof(self) weakSelf = self
#define kSelfStrong __strong __typeof__(self) strongSelf = weakSelf

#define kLocalizedString(key) NSLocalizedString(key, nil)


//app 版本号
#define kApp_Version [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]




/** 转成字符串 */
#define kString(v)          (v = ([v isKindOfClass:[NSString class]]) ? v : [NSString stringWithFormat:@"%@",v])

#define UNIQUE_ID [[UIDevice currentDevice].identifierForVendor UUIDString]

/*
 *判断和修改空值
 */
#define NotNullJudge(x) ![(x) isKindOfClass:[NSNull class]] && (x) != nil

#define StringHasDataJudge(x) ![(x) isKindOfClass:[NSNull class]] && (x) != nil && ![(x) isEqualToString:@""]

#define ChangeNullData(x) [(x) isKindOfClass:[NSNull class]]?@"":((x) == nil ? @"":(x))

/// int to str
#define NSIntegerToNSString(intValue) [NSString stringWithFormat:@"%d", intValue]

// 圆角效果 view 10
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

/*
 * 添加阴影
 */
#define ViewShadow(View , Radius)\
\
[View.layer setShadowColor:UIColorHex(@"#608edb").CGColor];\
[View.layer setShadowOffset:CGSizeMake(0.0, 5.0)];\
[View.layer setCornerRadius:Radius];\
[View.layer setShadowOpacity:0.51]

#define kAutoScrollTimeInterval  3.0f

#define kplaceSmallImage nil
#define kplaceImage [UIImage imageNamed:@"out_icon"]


#define SYNTHESIZE_SINGLETON_ARC_FOR_CLASS(classname) \
\
__strong static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
static dispatch_once_t pred;\
dispatch_once(&pred, ^{\
shared##classname = [[super allocWithZone:NULL] init];\
});\
\
return shared##classname; \
} \
\

#define NUMBERSExpertZero             @"123456789"
#define NUMBERS             @"0123456789"
#define NUMBERSAndSpace     @"0123456789 "
#define xX          @"xX"
#define kAlphaNum   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define kCardIDInputLimit     @"0123456789xX"


#define Special_Character  @"[-/:\\;()$&@.,?!'\"{}#%^*+=_|~<>£¥€•]-：；（）¥@“”。，、？！.【】｛｝#%^*+=_—|～《》$&•…,^_^?!'"

#define SpecialCharacterAndNumber @"[-/:\\;()$&@.,?!'\"{}#%^*+=_|~<>£¥€•]-：；（）¥@“”。，、？！.【】｛｝#%^*+=_—|～《》$&•…,^_^?!'0123456789"

#define AllCharacterAndNumber @"[-/:\\;()$&@.,?!'\"{}#%^*+=_|~<>£¥€•]-：；（）¥@“”。，、？！.【】｛｝#%^*+=_—|～《》$&•…,^_^?!'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" // 限制输入标点符号，字母，数字等字符
//用户相关
#define kMax_BankIDNum           19 // 银行卡号
#define kMax_IDCardNum           18 // 身份证号
#define kMax_RealName            24 // 真实姓名
#define kMax_Money               12 // 充值金额位数限制
#define kMax_Phone               11  // 手机号
#define kMax_Password            16  // 密码:8-16  字母数字构成
#define kMax_NickName            30  // 昵称最大数
#define kMax_TradingPassword      6  // 交易密码
#define kMax_SmsCode              6  //验证码

#define kHomePageBannerImg_IPhoneX     @"_banner_375x282.png"
#define kHomePageBannerImg     @"_banner_750x390.png"
#define kHomePageNewGuide     @"_novice_750x180.png"
#define kHomePageAboutJinr     @"_about_280x180.png"


//图片
#define R_ImageName(imagName)  [UIImage imageNamed:imagName]


#define Kimage_placeholder R_ImageName(@"common_image_empty")

#endif /* AppRelatedDefinition_h */

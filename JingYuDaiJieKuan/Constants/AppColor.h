//
//  AppColor.h
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/19.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#ifndef AppColor_h
#define AppColor_h


#pragma mark- Color

// 颜色

/// 导航栏背景颜色
#define kColorNavBground UIColorHex(@"#2e3737")

/// 登录注册背景颜色
#define kColorBgBackground UIColorHex(@"#00a69a")

/// 透明色
#define kColorClear [UIColor clearColor]

/// 白色-如导航栏字体颜色
#define kColorWhite UIColorHex(@"#ffffff")

/// 淡灰色-如普通界面的背景颜色
#define kColorLightgrayBackground UIColorHex(@"#f5f5f5")

/// 灰色—如内容字体颜色
#define kColorLightgrayContent UIColorHex(@"#969696")

/// 灰色-如输入框占位符字体颜色
#define kColorLightgrayPlaceholder UIColorHex(@"#aaaaaa")

/// 深灰色
#define kColorDarkgray UIColorHex(@"#666666")

/// 黑色-如输入框输入字体颜色或标题颜色
//#define kColorBlack UIColorHex(@"#323232")
#define kColorBlack UIColorHex(@"#2b262a")

#define kColorNavBlack UIColorHex(@"#8a8b8f")

/// 黑色-纯黑
#define kColorDeepBlack UIColorHex(@"000000")

/// 灰色—如列表cell分割线颜色
#define kColorSeparatorline UIColorHex(@"#d1d1d1")

/// 灰色—如列表cell分割线颜色
#define kColorShortTerm UIColorHex(@"#cccccc")

/// 灰色-边框线颜色
#define kColorBorderline UIColorHex(@"#b8b8b8")

/// 绿色-如导航栏背景颜色
#define kColorGreenNavBground UIColorHex(@"#38ad7a")

/// 绿色
#define kColorGreen UIColorHex(@"#349c6f")

/// 深绿色
#define kColorDarkGreen UIColorHex(@"#188d5a")

/// 橙色
#define kColorOrange UIColorHex(@"#fe933d")

/// 深橙色
#define kColorDarkOrange UIColorHex(@"#e48437")

/// 淡紫色
#define kColorLightPurple UIColorHex(@"#909af8")

/// 红色
#define kColorRed UIColorHex(@"#ff585f")

/// 蓝色
#define kColorBlue UIColorHex(@"#0076ff")

/// 黑色
#define kColorRoughness UIColorHex(@"#474747")

/// 高雅黑
#define kColorElegantBlack UIColorRGB(29, 31, 38)

// 浅绿色
#define kColorLightGreen   UIColorRGB(143,209,59)

#define kHomeBlueColor      UIColorRGB(12, 114, 227)

/// Color
#define UIColorRGB(R,G,B)   [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorRGBA(R,G,B,A)   [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define UIColorHexSystem(rgbValue,a) [UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(rgbValue & 0xFF))/255.0 alpha:a]


#define UIColorHex(hex)     [DataHelper colorWithHexString:hex]
#define kLyNavColor         UIColorHex(@"#ff7633")
#define kLySeparatorColor   UIColorHex(@"#e5e5e5")
#define kLyOrangeColor      UIColorHex(@"#ff6e41")
/// 绿色
#define kLyColorGreen       UIColorHex(@"#00b8a8")
#define kLyRedColor         UIColorHex(@"#ff585f")
#define kLyBuleColor        UIColorHex(@"#00b9ff")
#define kLyBlackColor       UIColorHex(@"#2b262a")
#define kLyGrayColor        UIColorHex(@"#9d9e9e")
#define kLyLightGrayColor   UIColorHex(@"#b5b5b5")
#define kHomeNaviBgColor    UIColorHex(@"#f2f2f2")
#define kHomeLabelColor     UIColorHex(@"#cecece")
#define kBtnGrayColor       UIColorHex(@"#999999")
#define kgrayTextColor      UIColorHex(@"#cccccc")
#define kLastLineColor    UIColorHex(@"#e5e5e5")

//上海颜色

#define kSHColorBlack UIColorHex(@"#2b262a")
#define kSHColorGray  UIColorHex(@"#969696")
#define kSHSeparatorColor   UIColorHex(@"#cccccc")
#define kSHGreenColor   UIColorHex(@"#00b9a7")

#define CP_ColorMBlack      UIColorHex(@"#333333")      //主色
#define CP_ColorLBlack      UIColorHex(@"#181818")      //辅色
#define CP_ColorMLight      UIColorHex(@"#757575")
#define CP_ColorLLight      UIColorHex(@"#a0a0a0")
#define CP_ColorLine        UIColorHex(@"#707070")      //线条颜色
#define CP_ColorL_Line      UIColorHex(@"#e5e5e5")      //线条颜色



/** 存票红e60012 */
#define CP_ColorRed         UIColorHex(@"#ff585f")      //存票红
/** 白色ffffff */
#define CP_ColorWhite       UIColorHex(@"#ffffff")      //白色

#define CP_ColorGreen       UIColorHex(@"#049cbd")      //绿色

#define kBlueMainColor     UIColorHexSystem(0x0c72e3, 1)


#define Bg_ColorGray            UIColorHex(@"#f4f4f4")      //灰色背景
#define Bg_Btn_Colorblue        UIColorHex(@"#39bae8")      //按钮蓝色背景
#define KText_ColorRed          UIColorHex(@"#fa4645")      //字体浅红红色
#define KText_ColorSubRed       UIColorHex(@"#e83939")      //字体浅红红色
#define KText_ColorGreen        UIColorHex(@"#33cc66")      //字体 绿色


#endif /* AppColor_h */

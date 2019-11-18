//
//  Constants.h
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/19.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

typedef NS_ENUM(NSInteger,InvestRefundType) {
    InvestRefundType_XXHB = 1,      // 1 先息后本  ------> 按月付息到期还本
    InvestRefundType_DQBX,          // 2 到期还本  ------> 到期还本付息
    InvestRefundType_DBDX,          // 3 等本等息  ------>
    InvestRefundType_DEBX,          // 4 等额本息  ------> 等额本息
    InvestRefundType_DEBJ,           // 5 等额本金  ------>
    InvestRefundType_ERROR
};


#import "AppDelegate.h"

///公共类
#import "AppStyleRelated.h"
#import "AppRelatedTips.h"
#import "AppFontSize.h"
#import "AppColor.h"
#import "AppRelatedDefinition.h"
#import "UIInitMethod.h"
#import "Util.h"
#import "DataManager.h"
#import "DataHelper.h"
#import "ZXAlertView.h"
#import "UserMessageManager.h"
#import "HUD.h"
#import "BaseWebViewController.h"
#import "CustomLoadingView.h"
#import "NetworkReachability.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

///类别
#import "NSObject+RAC.h"
#import "UIButton+EXT.h"
#import "NSDate+EXT.h"
#import "iToast+myToast.h"
#import "NSString+MyString.h"
#import "NSString+Regex.h"
#import "NSString+Extend.h"
#import "UIImage+MyImage.h"
#import "UIView+Corner.h"
#import "UIView+TYAlertView.h"
#import "NSDate+Category.h"
#import "UIImageView+CornerRadius.h"
#import "UILabel+WLAttributedString.h"
#import "NSDictionary+RequestEncoding.h"
#import "UITextField+EXT.h"
#import "UIView+Frame.h"
#import "UILabel+WLAttributedString.h"
#import "UIFactory.h"
#import "NSString+PJR.h"
#import "CPAutoSize.h"
#import "PigMJRefreshGifHeader.h"
#import "DViewManager.h"
#import "UITableView+NATools.h"
#import "UIView+Line.h"
#import "UILabel+Additions.h" // 
#import "UIView+Tap.h"
#import "ViewUtils.h" // view。frame
#import "UITableViewCell+NATools.h"
#import "NSMutableArray+Additions.h"
#import "SVProgressHUD.h"
#import <objc/runtime.h>
#import "TZShowAlertView.h"
#import "TZUserDefaults.h"

/***************************模块接口****************************/
#import "HttpManager.h"
#import "HomePageAPI.h"
#import "UserCenterAPI.h"
#import "LoginAanRegisteAPI.h"
#import "TransactionRecordsAPI.h"
#import "CardVoucherAPI.h"
#import "PasswordAPI.h"
#import "BankAPI.h"
#import "MoneyAPI.h"
#import "LnitialAPI.h"
#import "ProductItemAPI.h"
#import "CommonAPI.h"

#import "HomeAPI.h"
#import "HomeAPIParameter.h"

#import "UserAPI.h"
#import "UserAPIParameter.h"
///pod库
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "iToast.h"
#import <UIImageView+WebCache.h>
#import "YYWebImage.h"
#import <Masonry.h>
#import <MJRefresh.h>
#import <YYModel.h>
#import <OpenUDID.h>
#import <MBProgressHUD.h>

/// Dlog
#ifdef DEBUG
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif



/***************************环境切换****************************/
///是否线上1为线上,0为测试
#define isTrueEnvironment 0
///app 模板id  1为橙色模板,2为蓝色模板
#define kTemplateId 1
/***************************环境切换****************************/
#define Kwap_hot   1 // 0:本地



//根据模板名取对应的宏
#if kTemplateId == 1

///app模板名
#define kTplKey @"orange"
///app渠道名
#define kChannel @"JZD_XXL"
#define kClientType @"20"

#elif kTemplateId == 2
#define kTplKey @"blue"
#define kChannel @"JZD_XXL"
#define kClientType @"20" // 10:安卓；20:ios；30:H5

#endif

#if isTrueEnvironment

// 正式机
#define SERVER_URL @"http://112.74.53.99:8005/"
//#define SERVER_URL @"http://192.168.1.135:8001/" //本地地址

#define HTTPS_type 1
#define VERSION_URL @"1.0.0"
#define WAP_URL @"http://192.168.28.99:9013/report/2017/index.html"
#define WAP_PHONEURL  SERVER_URL

#else

// 开发机
#define SERVER_URL @"http://112.74.53.99:8005/"
//#define SERVER_URL @"http://192.168.1.135:8001/" //本地地址
#define HTTPS_type 1
#define VERSION_URL @"1.0.0"
#define WAP_URL @"http://192.168.28.99:9013/report/2017/index.html"

//#define WAP_PHONEURL   @"http://192.168.1.135:8001/" //本地地址
#define WAP_PHONEURL   SERVER_URL

#endif

#define UMENG_AppKey @"appkey"

#endif /* Constants_h */

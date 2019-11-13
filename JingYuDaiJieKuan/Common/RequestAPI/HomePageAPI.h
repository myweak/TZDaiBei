//
//  HomePageAPI.h
//  JingYuDaiJieKuan
//
//  Created by Macmini on 2017/8/14.
//  Copyright © 2017年 Macmini. All rights reserved.
//

#import <Foundation/Foundation.h>

/** app/login/banner   APP初始化数据获取接口 */
UIKIT_EXTERN NSString *const appLoginBanner;

/** 首页横幅接口 */
UIKIT_EXTERN NSString *const homeBanner;

/** 金刚区接口 */
UIKIT_EXTERN NSString *const homeIconZone;

/** 滚动消息通知接口 */
UIKIT_EXTERN NSString *const homeMessageNotice;

/**  /今日推荐接口 */
UIKIT_EXTERN NSString *const homeTodayRecommend ;

/**  最新口子接口 */
UIKIT_EXTERN NSString *const homeLastMerchant ;

/**  底部瓷片区配置接口 */
UIKIT_EXTERN NSString *const homeBottomIco ;

/** 精选贷款 */
UIKIT_EXTERN NSString *const homeCareChosen;

/** 商户点击隐藏接口 /home/merchant/click/{merchantId} */
UIKIT_EXTERN NSString *const merchantClick;

/** 商户广告横幅接口 /streamer/{pos}   1为首页 2为贷款大全 */
UIKIT_EXTERN NSString *const streamer;


/** 首页最下方信息 统计 ：运营时间 交易数量 */
UIKIT_EXTERN NSString *const API_IntervalDays;


/** 信息安全申明 H5 */
UIKIT_EXTERN NSString *const HTML_infoSecurityStatement_api ;

/** 公司介绍*/
UIKIT_EXTERN NSString *const HTML_companyIntroduction_api;

/** 首征信页面 修复首页 */
UIKIT_EXTERN NSString *const HTML_creditRepair_api;

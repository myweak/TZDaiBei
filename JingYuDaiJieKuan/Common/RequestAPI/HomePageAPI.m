//
//  HomePageAPI.m
//  JingYuDaiJieKuan
//
//  Created by Macmini on 2017/8/14.
//  Copyright © 2017年 Macmini. All rights reserved.
//

#import "HomePageAPI.h"

/** app/login/banner   APP初始化数据获取接口 */
NSString *const appLoginBanner = @"app/login/banner";


/** 首页横幅接口 */
NSString *const homeBanner = @"home/banner";

/** 金刚区接口 */
NSString *const homeIconZone = @"home/icon/zone";

/** 滚动消息通知接口 */
NSString *const homeMessageNotice = @"home/message/notice";

/**  /今日推荐接口 */
NSString *const homeTodayRecommend = @"home/today/recommend";

/**  最新口子接口 */
NSString *const homeLastMerchant = @"home/last/merchant";

/**  底部瓷片区配置接口 */
NSString *const homeBottomIco = @"home/bottom/icon";

/** 获取首页推荐标 */
NSString *const homeCareChosen = @"home/care/chosen";

/** 商户点击隐藏接口 /home/merchant/click/{merchantId} */
NSString *const merchantClick = @"home/merchant/click/";

/** 商户广告横幅接口 /streamer/{pos}   1为首页 2为贷款大全 */
NSString *const streamer = @"streamer";

/** 首页最下方信息 统计 ：运营时间 交易数量 */
NSString *const API_IntervalDays = @"home/IntervalDays";


/** 信息安全申明 H5 */
NSString *const HTML_infoSecurityStatement_api = @"static/agreement/infoSecurityStatement/";

/** 公司介绍*/
NSString *const HTML_companyIntroduction_api = @"static/agreement/companyIntroduction/";

/** 首征信页面 修复首页 */
NSString *const HTML_creditRepair_api =@"static/agreement/creditRepair";

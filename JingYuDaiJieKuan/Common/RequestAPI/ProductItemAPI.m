//
//  ProductItemAPI.m
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/2.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "ProductItemAPI.h"

/** 热门搜索 */
NSString *const productItemHotPath = @"market/hot/key";

/** 贷款大全列表搜索接口(缓存) */
NSString *const productItemListPathCache = @"market/search/cache";
/** 贷款大全列表搜索接口 */
NSString *const productItemListPath = @"market/search";

/** 随机商户接口 */
NSString *const productItemRandomPath = @"market/random/merchant";

/** 标签查询接口（返回特色标签和热门标签，自行筛选） */
NSString *const productItemLableListPath = @"market/label/list";

/** 贷款大全最下方banner接口 */
NSString *const loanDaquanBannerPath = @"home/loanDaquanBanner";


/** 精选贷款接口  */
NSString *const careChosenPath = @"home/care/chosen";


/** 个人中心-贷款攻略文章列表接口(只返回前三条)  */
NSString *const articleRecommendList_Path = @"article/recommend/list";
/** 贷款攻略文章列表接口（所有的  */
NSString *const articleAllList_Path = @"article/all/list";

/** 点赞文章接口 */
NSString *const articleAddLikeNum_Path = @"article/add/likeNum/";

/** 线下资料填写步骤-基本信息 */ // 快速办理贷款
NSString *const THTML_essentialInfo_api = @"/static/agreement/essentialInfo";

/** 线上极速贷款 数据 {pageNo} */ //全部新品接口-查询所有的
NSString *const API_homeLastAll_path = @"home/last/all/mch/";
/** 获取信用卡模块信息 */
NSString *const API_getCreditCardList_path = @"offline/product/getCreditCardList";



/** 征信页面修复资料填写 */
NSString *const HTML_personalAccess_api = @"static/agreement/personalAccess";

/** 线下产品大全
 {
 "cid": 0, 二级城市id。
 "maxAmount":最大金额,
 "mortgageAttr": "string", //抵押资产属性
 "occuAttr": "string", 职业身份
 "pageNo": 0,
 "termAttr": "string" // 期限
 }
 */
NSString *const API_getOfflineInfo_path = @"/offline/getOfflineInfo";

/** 线下热门产品*/
NSString *const API_getOfflineRecommend_path = @"/offline/getOfflineRecommend";

/** 获取一级城市接口*/
NSString *const API_getFirstTierCities_path = @"/offline/city/getFirstTierCities";

/** 获取二级城市接口 {cityId} */
NSString *const API_getTwoTierCities_path = @"/offline/city/getTwoTierCities";

/** 获取线下 <贷款期限> 筛选条件*/
NSString *const API_getTerm_path = @"/offline/screenCond/getTerm";

/** 获取线下筛选条件*/
NSString *const API_getScreeningConditions_path = @"/offline/screenCond/getScreeningConditions";

/** 添加用户点击产品信息 */
NSString *const API_saveProductClick_path = @"/offline/product/saveProductClick";
NSString *const API_checkProduct_path = @"offline/product/checkProduct"; // 数据补齐


NSString *const API_offlineAmountInfo_path = @"/offline/product/offlineAmountInfo";



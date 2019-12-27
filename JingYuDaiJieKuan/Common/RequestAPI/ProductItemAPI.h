//
//  ProductItemAPI.h
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/2.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 热门搜索 */
UIKIT_EXTERN NSString *const productItemHotPath;

/** 贷款大全列表搜索接口(缓存) */
UIKIT_EXTERN NSString *const productItemListPathCache;

/** 贷款大全列表搜索接口 */
UIKIT_EXTERN NSString *const productItemListPath;

/** 随机商户接口 */
UIKIT_EXTERN NSString *const productItemRandomPath;

/** 标签查询接口（返回特色标签和热门标签，自行筛选） */
UIKIT_EXTERN NSString *const productItemLableListPath;


/** 贷款大全最下方banner接口 -- 货款大全底部scorll */
UIKIT_EXTERN NSString *const loanDaquanBannerPath;

/** 精选贷款接口  */
UIKIT_EXTERN NSString *const careChosenPath;

/** 个人中心-贷款攻略文章列表接口(只返回前三条)  */
UIKIT_EXTERN NSString *const articleRecommendList_Path;
/** 贷款攻略文章列表接口（所有的  */
UIKIT_EXTERN NSString *const articleAllList_Path;

/** 点赞文章接口 */
UIKIT_EXTERN NSString *const articleAddLikeNum_Path;

/** 线下资料填写步骤-基本信息 */ // 快速办理贷款
UIKIT_EXTERN NSString *const THTML_essentialInfo_api;

/** 线上极速贷款 数据  {pageNo}*/ //全部新品接口-查询所有的
UIKIT_EXTERN NSString *const API_homeLastAll_path;

/** 征信页面修复资料填写 */
UIKIT_EXTERN NSString *const HTML_personalAccess_api;

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
UIKIT_EXTERN NSString *const API_getOfflineInfo_path;

/** 获取一级城市接口*/
UIKIT_EXTERN NSString *const API_getFirstTierCities_path;

/** 获取二级城市接口 {cityId} */
UIKIT_EXTERN NSString *const API_getTwoTierCities_path ;

/** 获取线下 <期限> 筛选条件*/
UIKIT_EXTERN NSString *const API_getTerm_path;

/** 获取线下筛选条件*/
UIKIT_EXTERN NSString *const API_getScreeningConditions_path;

/** 添加用户点击产品信息 */
UIKIT_EXTERN NSString *const API_saveProductClick_path;
UIKIT_EXTERN NSString *const API_checkProduct_path;

/** 用户贷款列表信息 */
UIKIT_EXTERN NSString *const API_offlineAmountInfo_path;

/** 获取信用卡模块信息 */
UIKIT_EXTERN NSString *const API_getCreditCardList_path;

/** 线下热门产品*/
UIKIT_EXTERN NSString *const API_getOfflineRecommend_path;

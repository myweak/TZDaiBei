//
//  UserCenterAPI.h
//  JingYuDaiJieKuan
//
//  Created by JY on 2018/3/30.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 抢金夺宝.明星产品-个人中心banner */
UIKIT_EXTERN NSString *const personalCenterSnatchGold;

/** / 热门工具 */
UIKIT_EXTERN NSString *const personalCenterHotTools;

/**  article/recommend/list 个人中心-贷款攻略文章列表接口(只返回前三条) */
UIKIT_EXTERN NSString *const articleRecommendList;

/**  /user/logout  用户退出登录接口 */
UIKIT_EXTERN NSString *const userLogout;

/**  关于我们 */
UIKIT_EXTERN NSString *const aboutUsInfo;

/**  /user/update/nick/name/{nickName}修改昵称接口 */
UIKIT_EXTERN NSString *const userUpdateNickName;

/**  点赞 */

UIKIT_EXTERN NSString *const articleAddLikeNum;


/**  获取登录页面背景图 */

UIKIT_EXTERN NSString *const loginBanner;


/**  /user/update/education/{education}修改学历接口 */
UIKIT_EXTERN NSString *const userUpdateEducation;


/**  /user/update/gender/{gender}修改性别接口*/
UIKIT_EXTERN NSString *const userUpdateGender;

/**  /user/update/mailbox/{mailbox}修改邮箱接口 */
UIKIT_EXTERN NSString *const userUpdateMailbox;

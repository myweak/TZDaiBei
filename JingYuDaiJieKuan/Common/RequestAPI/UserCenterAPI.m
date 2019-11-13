//
//  UserCenterAPI.m
//  JingYuDaiJieKuan
//
//  Created by JY on 2018/3/30.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "UserCenterAPI.h"

/** 测试数据接口 */
NSString *const personalCenterSnatchGold  = @"personal/center/snatch/gold/";

/** / 热门工具 */
NSString *const personalCenterHotTools  = @"personal/center/hot/tools/";

/**  article/recommend/list 个人中心-贷款攻略文章列表接口(只返回前三条) */
NSString *const articleRecommendList  = @"article/recommend/list";

/**  /user/logout  用户退出登录接口 */
NSString *const userLogout  = @"user/logout";

/**  关于我们 */
NSString *const aboutUsInfo  = @"about/us/info/";

/**  /user/update/nick/name/{nickName}修改昵称接口 */
NSString *const userUpdateNickName  = @"user/update/nick/name/";

/**  /article/add/likeNum/{articleId}  点赞文章接口 */
NSString *const articleAddLikeNum  = @"article/add/likeNum/";


/**  /user/update/education/{education}修改学历接口 */
NSString *const userUpdateEducation  = @"user/update/education/";

/**  /user/update/gender/{gender}修改性别接口*/
NSString *const userUpdateGender  = @"user/update/gender/";

/**  /user/update/mailbox/{mailbox}修改邮箱接口 */
NSString *const userUpdateMailbox  = @"user/update/mailbox/";

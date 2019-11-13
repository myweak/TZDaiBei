//
//  UserModel.h
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/7/2.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LUserModel: NSObject
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *photoIphonex;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *readNum;
@property (nonatomic, copy) NSString *likesNum;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *articleId;
@property (nonatomic, copy) NSString *canLike;
@property (nonatomic, copy) NSString *cooperation;
@property (nonatomic, copy) NSString *mchId;
@property (nonatomic, copy) NSString *mchName;

@end


@interface UserModel : StatusModel

@property (nonatomic, strong) NSArray * list;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *copyright;  //版权信息
@property (nonatomic, copy) NSString *conpanyIntro; //啊大大大公司介绍
@property (nonatomic, copy) NSString *businessCooperation;  //微信:2434,qq:234



@end

@interface AppUpdateModel : StatusModel

/// 版本升级介绍
@property (nonatomic, strong) NSString * appDesc;
/// 升级标题
@property (nonatomic, strong) NSString *appTitle;
/// 版本号
@property (nonatomic, strong) NSString *appV;
/// 建议升级时，升级弹框是否每次都弹出：0-否|1-是
@property (nonatomic, assign) NSInteger dialogRepeat;
/// 升级_方式：0-不升级|1-建议升级|2-强制升级|3-应用关闭
@property (nonatomic, assign) NSInteger upgradeWay;
/// 安装包地址
@property (nonatomic, strong) NSString *url;

@end

@interface HotToolListModel : StatusModel

/// 跳转url
@property (nonatomic, strong) NSArray *list;

@end

@interface HotToolModel : NSObject

/// 跳转url
@property (nonatomic, strong) NSString *url;
/// 排序
@property (nonatomic, strong) NSString *sort;
/// idid
@property (nonatomic, strong) NSString *id;
/// 背景图片
@property (nonatomic, strong) NSString *backImg;
/// 背景图片
@property (nonatomic, strong) NSString *backImgX;
/// 图标
@property (nonatomic, strong) NSString *icon;
/// 图标
@property (nonatomic, strong) NSString *cooperation;

/// 名称
@property (nonatomic, strong) NSString *name;

@end


@interface CheckMchStatusModel : StatusModel

/// 商户id
@property (nonatomic, strong) NSString * mchId;
/// 商户名称
@property (nonatomic, strong) NSString *mchName;
/// 提示文字
@property (nonatomic, strong) NSString *toast;
/// 商户状态1:可用  2:下线
@property (nonatomic, assign) NSInteger status;

@end

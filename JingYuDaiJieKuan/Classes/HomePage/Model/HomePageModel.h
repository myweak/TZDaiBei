//
//  HomePageModel.h
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/21.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "StatusModel.h"

@interface AdBannerModel: NSObject
SINGLETON_FOR_HEADER(AdBannerModel)
@property (nonatomic, copy) NSString *ad_id;
@property (nonatomic, copy) NSString *ad_url;
@property (nonatomic, copy) NSString *ad_name;
@property (nonatomic, copy) NSString *ad_image_url;
@property (nonatomic, copy) NSString *smallBright;//小亮图
@property (nonatomic, copy) NSString *smallGrayt;//小灰图
@property (nonatomic, copy) NSString *bigBright;//大亮图
@property (nonatomic, copy) NSString *bigGrayt;//大灰图
@property (nonatomic, copy) NSString *m_id;
@property (nonatomic, copy) NSString *m_Url;

//首页横幅接口
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *sort;
//精选贷款
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *maxAmount;
@property (nonatomic, copy) NSString *lineDate;
//跑马灯
@property (nonatomic, copy) NSString *message;
// 金刚区
@property (nonatomic, copy) NSString *defaultIcon;
@property (nonatomic, copy) NSString *selectedIcon;
@property (nonatomic, copy) NSString *iconTxt;

@property (nonatomic, copy) NSString *merchartid;
@property (nonatomic, copy) NSString *mchId;
@property (nonatomic, copy) NSString *mchName;
@property (nonatomic, copy) NSString *txtDesc;

// 最新口子
@property (nonatomic, copy) NSString *rate;
@property (nonatomic, copy) NSString *recommendReason;

@end

@interface IndexProjectInfoModel: NSObject

@property (nonatomic, copy) NSString *rateInit;
@property (nonatomic, copy) NSString *financeMoney;
@property (nonatomic, copy) NSString *projectid;
@property (nonatomic, copy) NSString *projectPeriod;

@property (nonatomic, copy) NSString *leftRateInit;
@property (nonatomic, copy) NSString *rightRateInit;

@end

// 首页 头部数据
@interface IndexBannerInfoModel: NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *photoIphonex;



@end


// 首页 头部数据
@interface TZBannerInfoModel: NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *photoIphonex;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, assign) NSInteger referType;
@end



// 列表 图
@interface TZBannerNavigationModel: NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *photoIphonex;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, copy) NSString *referType; // 1申请贷款； 2:表示 web地址 , 3 行用卡

@end





@interface IndexAboutInfoModel: NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imgurl;
@property (nonatomic, strong) NSArray *list;

@end

@interface StartBannerModel: NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *imgIphonex;
/// 倒计时
@property (nonatomic, copy) NSString *time;
/// 触发方式：1-每日首次打开|2-每次打开|3-首次打开
@property (nonatomic, assign) NSInteger triggerWay;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *title;
/// 商户id
@property (nonatomic, copy) NSString *mchId;
/// 商户名称
@property (nonatomic, copy) NSString *mchName;
@end

//  底部交易数量
@interface homeIntervalDaysModel: StatusModel
@property (nonatomic, copy) NSString *operateTime; // 累计交易金额
@property (nonatomic, assign) NSInteger turnoverNumber;//订单数
@end


@interface HomePageModel : StatusModel

//@property (nonatomic, copy) NSString *ID;
//@property (nonatomic, copy) NSString *img;
//@property (nonatomic, copy) NSString *photoIphonex;
//@property (nonatomic, copy) NSString *title;
//@property (nonatomic, assign) NSInteger sort;
//@property (nonatomic, copy) NSString *referType;

@property (nonatomic, strong) NSArray *bannerInfo;//头部图
@property (nonatomic, strong) NSArray *bannerNavigation;// body 列表图










@property (nonatomic, strong) NSArray * indexTopNoticInfo;
@property (nonatomic, strong) NSArray * indexProjectInfo;
@property (nonatomic, strong) NSDictionary *indexTicketInfo;
@property (nonatomic, strong) NSArray * indexNewGuide;
@property (nonatomic, strong) NSArray * indexAboutInfo;
@property (nonatomic, strong) NSArray * indexBannerInfo;
@property (nonatomic, strong) NSArray * list;
@property (nonatomic, strong) NSArray * bottomIcon;
@property (nonatomic, strong) StartBannerModel *startBaner;//启动广告图


@property (nonatomic, copy) NSString *isFirstTend;
@property (nonatomic, copy) NSString *realStatus;
@property (nonatomic, copy) NSString *identityid;//身份证
@property (nonatomic, copy) NSString *username;//姓名
@property (nonatomic, copy) NSString *is_bind;//是否绑卡
@property (nonatomic, copy) NSString *passwd;//是否设置交易密码
@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *photoIphonex;

@property (nonatomic, copy) NSString *articleMoreUrl;
@property (nonatomic, copy) NSString *waterMchUrl;
/// 服务条款url
@property (nonatomic, copy) NSString *regUrl;
/// 隐私条款url
@property (nonatomic, copy) NSString *privacyPolicyUrl;
/// 商户名称
@property (nonatomic, copy) NSString *title;
/// 商户id
@property (nonatomic, copy) NSString *mchId;
/// 商户name
@property (nonatomic, copy) NSString *mchName;

///"我的"中间位置放水新口子文案
@property (nonatomic, copy) NSString *myNewProductMsg;

///"我的"->"放水新口子"页面的title文案
@property (nonatomic, copy) NSString *myNewProductTitle;

///"首页"最新口子文案
@property (nonatomic, copy) NSString *indexNewProductTitle;

@end


@interface HomeNoticeListModel : StatusModel

@property (nonatomic, strong) NSArray * list;

@end

//首页滚动信息模型
@interface HomeNoticeModel : NSObject

@property (nonatomic, strong) NSString * mchId;
@property (nonatomic, strong) NSString * mchName;
@property (nonatomic, strong) NSString *rate;
@property (nonatomic, strong) NSString * rateType;
@property (nonatomic, strong) NSString * message;
//关联类型：1-商户|2-地址
@property (nonatomic, strong) NSString *referType;
@property (nonatomic, strong) NSString * minAmount;
@property (nonatomic, strong) NSString * maxAmount;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *title;

@end


@interface StreamerListModel : StatusModel

@property (nonatomic, strong) NSArray *list;

@end

///商户广告横幅模型
@interface StreamerModel : NSObject

@property (nonatomic, strong) NSString *mchId;
@property (nonatomic, strong) NSString *mchName;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, assign) NSInteger referType;
@property (nonatomic, assign) NSInteger *streamerPos;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) NSInteger weightValue;

@end

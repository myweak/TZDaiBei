//
//  TZProductPageModel.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/2.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TZProductPageModel : BaseModel
@property (nonatomic, strong) NSArray * bannerInfo;  // 底部滚动图。数据
@property (nonatomic, strong) NSArray * offlineProductBanks;// 线下银行
@property (nonatomic, strong) NSArray * chosenResponseList;// 线下上银行
@property (nonatomic, strong) NSArray * newsList; // list改->newsList // 新闻
@property (nonatomic, strong) NSArray * bankList; // mchList改->bankList  线上极速贷款 数据

@end




@interface TZProductBankModel : NSObject
@property (nonatomic, copy) NSString * icon;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * lineDate;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, copy) NSString * txtDesc; // 副标题
@property (nonatomic, copy) NSString * maxAmount;
@property (nonatomic, copy) NSString * rate; // 利率：
@property (nonatomic, copy) NSString * rateType; // 1:日利率；2:月利率；1:年利率-》rate
@property (nonatomic, copy) NSString * rateType_str;//自定义
@property (nonatomic, copy) NSString * merchartid;
@property (nonatomic, copy) NSString * tags;
@property (nonatomic, copy) NSString * recvMoneyTime; // 放款时间
@property (nonatomic, copy) NSString * productType; // 1:立即申请 2:人数已满, 3:线下产品
@property (nonatomic, copy) NSString * recvMoneyType; // 0:分；1:小时：2:天；3:月 recvMoneyTime
@property (nonatomic, copy) NSString * recvMoneyType_str;//自定义
@property (nonatomic, copy) NSString * period; // 贷款期限

- (NSString *)setProductCenterBank_recvMoneyTime;

@end



@interface TZProductNewsModel : NSObject
@property (nonatomic, copy) NSString * articleId;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * photo; // image url
@property (nonatomic, copy) NSString * readNum; //浏览数
@property (nonatomic, copy) NSString * canLike;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, copy) NSString * updateTime;
@end




@interface TZProductBannerInfoModel : NSObject
@property (nonatomic, copy) NSString * ID;
@property (nonatomic, copy) NSString * img;
@property (nonatomic, copy) NSString * photoIphonex;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, copy) NSString * sort;
@property (nonatomic, copy) NSString * referType;

@end






@interface TZProductListModel : StatusModel
@property (nonatomic, copy) NSString * ID;
@property (nonatomic, copy) NSString * icon;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * rate;
@property (nonatomic, copy) NSString * rateType;
@property (nonatomic, copy) NSString * tags;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, copy) NSString * maxAmount;
@property (nonatomic, copy) NSString * merchartid;
@property (nonatomic, copy) NSString * type; // 2线上 1:线下

@end



NS_ASSUME_NONNULL_END

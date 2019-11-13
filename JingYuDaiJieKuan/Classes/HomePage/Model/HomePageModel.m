//
//  HomePageModel.m
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/21.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "HomePageModel.h"

@implementation  AdBannerModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"icon":@"icon",
             @"introduce":@"introduce",
             @"tags":@"tags",
             @"maxAmount":@"maxAmount",
             @"name":@"name",
             @"url":@"url",
             @"img":@"img",
             @"lineDate":@"lineDate",
             @"message":@"message",
             @"sort":@"sort",
             @"merchartid":@"merchartid",
             @"mchId":@"mchId",
             @"mchName":@"mchName",
             @"txtDesc":@"txtDesc",
             @"m_id":@"id",
             @"rate":@"rate",
             
             };
}
@end

@implementation IndexProjectInfoModel

@end



@implementation IndexBannerInfoModel

@end

// 底部交易数量
@implementation homeIntervalDaysModel

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"operateTime":@"data.operateTime",
             @"turnoverNumber":@"data.turnoverNumber",
             
             };
}
@end



@implementation TZBannerNavigationModel
+(NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id",             
             };
}
@end
@implementation TZBannerInfoModel

@end

@implementation IndexAboutInfoModel

@end

@implementation StartBannerModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"id":@"id",
             @"img":@"img",
             @"imgIphonex":@"imgIphonex",
             @"time":@"time",
             @"triggerWay":@"triggerWay",
             @"url":@"url",
             @"title":@"title",
             @"mchId":@"mchId",
             @"mchName":@"mchName",
             };
}
@end

@implementation HomePageModel

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"indexTopNoticInfo":@"data.indexTopNoticInfo",
             @"indexProjectInfo":@"data.indexProjectInfo",
             @"indexTicketInfo":@"data.indexTicketInfo",
             @"indexNewGuide":@"data.indexNewGuide",
             @"indexAboutInfo":@"data.indexAboutInfo",
             @"indexBannerInfo":@"data.indexBannerInfo",
             @"realStatus":@"data.realStatus",
             @"isFirstTend":@"data.isFirstTend",
             @"identityid":@"data.identityid",
             @"username":@"data.username",
             @"is_bind":@"data.is_bind",
             @"passwd":@"data.passwd",
             @"mobile":@"data.mobile",
             @"list":@"data.list",
             @"bottomIcon":@"data.bottomIcon",
             @"img":@"data.img",
             @"url":@"data.url",
             @"id":@"data.id",
             @"ID":@"data.id",
             @"photoIphonex":@"data.photoIphonex",
             @"articleMoreUrl":@"data.articleMoreUrl",
             @"waterMchUrl":@"data.waterMchUrl",
             @"startBaner":@"data.startBaner",
             @"title":@"data.title",
             @"mchId":@"data.mchId",
             @"regUrl":@"data.regUrl",
             @"privacyPolicyUrl":@"data.privacyPolicyUrl",
             @"mchName":@"data.mchName",
             @"myNewProductMsg":@"data.myNewProductMsg",
             @"myNewProductTitle":@"data.myNewProductTitle",
             @"indexNewProductTitle":@"data.indexNewProductTitle",
             @"bannerNavigation":@"data.bannerNavigation",
             @"bannerInfo":@"data.bannerInfo",

             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"indexAboutInfo" : [IndexAboutInfoModel class],
             @"indexBannerInfo" : [IndexBannerInfoModel class],
             @"indexProjectInfo" : [IndexProjectInfoModel class],
             @"list" : [AdBannerModel class],
             @"bottomIcon" : [AdBannerModel class],
             @"startBaner" : [StartBannerModel class],
             @"bannerNavigation" : [TZBannerNavigationModel class],
             @"bannerInfo" : [TZBannerInfoModel class],
             };
}

@end


@implementation HomeNoticeListModel
+(NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"list":@"data.list",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [HomeNoticeModel class],
             };
}
@end

@implementation HomeNoticeModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"mchId":@"mchId",
             @"mchName":@"mchName",
             @"rate":@"rate",
             @"rateType":@"rateType",
             @"message":@"message",
             @"referType":@"referType",
             @"minAmount":@"minAmount",
             @"maxAmount":@"maxAmount",
             @"icon":@"icon",
             @"url":@"url",
             @"title":@"title",
             };
}

@end

@implementation StreamerListModel
+(NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"list":@"data.list",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [StreamerModel class],
             };
}

@end

@implementation StreamerModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"mchId":@"mchId",
             @"mchName":@"mchName",
             @"photo":@"photo",
             @"referType":@"referType",
             @"streamerPos":@"streamerPos",
             @"title":@"title",
             @"url":@"url",
             @"weightValue":@"weightValue",
             };

}

@end


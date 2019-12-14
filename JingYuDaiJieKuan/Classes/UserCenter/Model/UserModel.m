//
//  UserModel.m
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/7/2.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "UserModel.h"

@implementation  LUserModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"icon":@"icon",
             @"img":@"img",
             @"title":@"title",
             @"likesNum":@"likesNum",
             @"photo":@"photo",
             @"readNum":@"readNum",
             @"mchId":@"mchId",
             @"mchName":@"mchName",
             };
}
@end

@implementation UserModel
+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"img":@"data.img",
             @"url":@"data.url",
             @"list":@"data.list",
             @"copyright":@"data.copyright",
             @"conpanyIntro":@"data.conpanyIntro",
             @"businessCooperation":@"data.businessCooperation",

             
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"list" : [LUserModel class]
             };
}

@end

@implementation AppUpdateModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"appDesc":@"data.appDesc",
             @"appTitle":@"data.appTitle",
             @"appV":@"data.appV",
             @"dialogRepeat":@"data.dialogRepeat",
             @"upgradeWay":@"data.upgradeWay",
             @"url":@"data.url",
             @"isOffline":@"data.isOffline",
             };
}

@end

@implementation HotToolListModel
+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"list":@"data.list",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"list" : [HotToolModel class]
             };
}
@end

@implementation HotToolModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"url":@"url",
             @"sort":@"sort",
             @"id":@"id",
             @"backImg":@"backImg",
             @"backImgX":@"backImgX",
             @"icon":@"icon",
             @"name":@"name",
             @"cooperation":@"cooperation",
             };
}

@end


@implementation  CheckMchStatusModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"mchId":@"data.mchId",
             @"mchName":@"data.mchName",
             @"status":@"data.status",
             @"toast":@"data.toast",
             };
}
@end

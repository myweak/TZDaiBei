//
//  LoginModel.m
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/6/29.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "LoginModel.h"

@implementation  MLoginModel
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
             };
}
@end

@implementation LoginModel

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"token":@"data.token",
             @"headImg":@"data.headImg",
             @"nickName":@"data.nickName",
             @"userId":@"data.userId",
             
              @"education":@"data.education",
              @"gender":@"data.gender",
              @"mailbox":@"data.mailbox",
              @"mobile":@"data.mobile",
              @"type":@"data.type",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"list" : [MLoginModel class]
             };
}

@end

@implementation  LoginBannerModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"id":@"data.id",
             @"img":@"data.img",
             @"photoIphonex":@"data.photoIphonex",
             @"sort":@"data.sort",
             @"title":@"data.title",
             @"url":@"data.url",
             };
}
@end

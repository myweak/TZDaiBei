//
//  CheckLoginKeyModel.m
//  JingYuDaiJieKuan
//
//  Created by JY on 2019/6/4.
//  Copyright © 2019年 Jincaishen. All rights reserved.
//

#import "CheckLoginKeyModel.h"

@implementation CheckLoginKeyModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"passwd" : @"data.passwd",
             @"identityid" : @"data.identityid",
             @"email" : @"data.email",
             @"userid" : @"data.userid",
             @"username" : @"data.username",
             @"nikename" : @"data.nikename",
             @"bank_cardno" : @"data.bank_cardno",
             @"is_bind_bankcard":@"data.is_bind_bankcard",
             @"tel" : @"data.tel",
             @"token":@"data.token",
             @"mobile" : @"data.mobile",
             @"user_limit_type":@"data.user_limit_type",
             @"risk_status":@"data.risk_status",
             @"is_visit_jyd":@"data.is_visit_jyd",
             @"jyd_url":@"data.jyd_url"
             };
}

@end

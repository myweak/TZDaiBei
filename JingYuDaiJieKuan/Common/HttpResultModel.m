//
//  HttpResultModel.m
//  NewJingYuBao
//
//  Created by linshaokai on 16/7/4.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import "HttpResultModel.h"

@implementation HttpResultModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"code" : @"code",
             @"msg" : @"msg",
             @"is_exist":@"data.is_exist",
             @"is_set_trade_pwd":@"data.is_set_trade_pwd",
             @"money_range":@"data.money_range",
             @"payMaxLimit":@"data.payMaxLimit",
             };
}

@end

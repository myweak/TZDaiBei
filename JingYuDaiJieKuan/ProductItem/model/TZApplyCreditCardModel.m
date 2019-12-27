//
//  TZApplyCreditCardModel.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/12/24.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZApplyCreditCardModel.h"

@implementation TZApplyCreditCardModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"list":@"data.list",
             };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"list" : [TZApplyCreditCardListModel class],
             };
}

@end


@implementation TZApplyCreditCardListModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID":@"id",
             };
}
@end

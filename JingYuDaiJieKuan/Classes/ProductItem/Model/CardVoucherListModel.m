//
//  CardVoucherListModel.m
//  JingYuDaiJieKuan
//
//  Created by air on 2018/4/10.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "CardVoucherListModel.h"
@implementation CardVoucherListDataModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"descriptionStr":@"description",
             };
}


@end
@implementation CardVoucherListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"list":[CardVoucherListDataModel class],
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"list":@"data.list",
             @"total":@"data.total"
             };
}

@end

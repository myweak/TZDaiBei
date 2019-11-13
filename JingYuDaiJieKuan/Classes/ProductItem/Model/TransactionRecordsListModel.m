//
//  TransactionRecordsListModel.m
//  JingYuDaiJieKuan
//
//  Created by air on 2018/4/4.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "TransactionRecordsListModel.h"

@implementation TransactionDetailsListDataModel


@end

@implementation TransactionListDataModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"list":[TransactionDetailsListDataModel class],
             };
}


@end


@implementation TransactionRecordsListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"list":[TransactionListDataModel class],
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"list":@"data.list",
             @"total":@"data.total"
             };
}

@end

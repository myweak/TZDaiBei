//
//  MessageCenterModel.m
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/4/3.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "MessageCenterModel.h"

@implementation MessageCenterListModel

@end

@implementation MessageCenterModel

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"list":@"data.list"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [MessageCenterListModel class],
             };
}

@end

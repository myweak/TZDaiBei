//
//  TZProductScreenConditionModel.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/5.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZProductScreenConditionModel.h"

@implementation TZProductScreenConditionModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"list":@"data.list",
             };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"list":[TZProductOfflineInfoModel class],
             };
}
@end



@implementation TZProductOfflineInfoModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"labelInfo":[TZProductOfflineInfoCollasModel class],
             };
}

- (void)setLendingType:(NSString *)lendingType{
    // 0:小时；1:天；2:月
    _lendingType = lendingType;
    NSString *title = @"";
    switch (lendingType.integerValue) {
        case 0:
            title = @"小时";
            break;
        case 1:
            title = @"天";
            break;
        case 2:
            title = @"月";
            break;
        default:
            break;
    }
    self.lendingTypeStr = title;
}

@end

@implementation TZProductOfflineInfoCollasModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID":@"id",
             };
}
@end

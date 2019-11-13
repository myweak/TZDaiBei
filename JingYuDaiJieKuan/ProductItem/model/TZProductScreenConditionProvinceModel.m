//
//  TZProductScreenConditionProvinceModel.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/7.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZProductScreenConditionProvinceModel.h"

@implementation TZProductScreenConditionProvinceModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"list":@"data.list",
             };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"list":[TZProvinceModel class],
             };
}
@end

@implementation TZProvinceModel
@end




@implementation TZProductScreenConditionCityModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"list":@"data.list",
             };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"list":[TZCityModel class],
             };
}
@end

@implementation TZCityModel
@end



@implementation TZProductScreenConditionDateModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"list":@"data.list",
             @"typesOfMortgage":@"data.typesOfMortgage",
             @"occupation":@"data.occupation",

             };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"list":[TZLoanDataModel class],
             @"typesOfMortgage":[TZLoanDataModel class],
             @"occupation":[TZLoanDataModel class],

             };
}
@end

@implementation TZLoanDataModel
- (instancetype)init{
    if ([super init]) {
        
    }
    return self;
}
- (void)setDictValue:(NSString *)dictValue{
    _dictValue =dictValue;
    if ([dictValue containsString:@"不限"]) {
        self.isSelected = YES;
    }
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID":@"id",
             };
}

@end




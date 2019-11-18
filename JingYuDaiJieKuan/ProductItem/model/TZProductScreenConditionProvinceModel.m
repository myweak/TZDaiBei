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
tz_CopyWithZone

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



- (id)copyWithZone:(NSZone *)zone {
    
    id obj = [[[self class] allocWithZone:zone] init];
    Class class = [self class];
    while (class != [NSObject class]) {
        unsigned int count;
        Ivar *ivar = class_copyIvarList(class, &count);
        for (int i = 0; i < count; i++) {
            Ivar iv = ivar[i];
            const char *name = ivar_getName(iv);
            NSString *strName = [NSString stringWithUTF8String:name];
            //利用KVC取值
            id value = [[self valueForKey:strName] copy];//如果还套了模型也要copy呢
            [obj setValue:value forKey:strName];
        }
        free(ivar);
        
        class = class_getSuperclass(class);//记住还要遍历父类的属性呢
    }
    return obj;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    
    id obj = [[[self class] allocWithZone:zone] init];
    Class class = [self class];
    while (class != [NSObject class]) {
        unsigned int count;
        Ivar *ivar = class_copyIvarList(class, &count);
        for (int i = 0; i < count; i++) {
            Ivar iv = ivar[i];
            const char *name = ivar_getName(iv);
            NSString *strName = [NSString stringWithUTF8String:name];
            //利用KVC取值
            id value = [[self valueForKey:strName] copy];//如果还套了模型也要copy呢
            [obj setValue:value forKey:strName];
        }
        free(ivar);
        
        class = class_getSuperclass(class);//记住还要遍历父类的属性呢
    }
    return obj;
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




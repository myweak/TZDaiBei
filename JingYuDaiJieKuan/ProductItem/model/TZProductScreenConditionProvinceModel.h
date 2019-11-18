//
//  TZProductScreenConditionProvinceModel.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/7.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TZProductScreenConditionProvinceModel : BaseModel<NSCopying,NSMutableCopying>
@property (nonatomic, strong) NSArray * list;

@end


@interface TZProvinceModel :NSObject
@property (nonatomic, copy) NSString * cityid;
@property (nonatomic, copy) NSString * cityName;

@end




@interface TZProductScreenConditionCityModel : BaseModel
@property (nonatomic, strong) NSArray * list;

@end

@interface TZCityModel :NSObject
@property (nonatomic, copy) NSString * quxianId;
@property (nonatomic, copy) NSString * quxianName;
@property (nonatomic, copy) NSString * cityId;
@end



@interface TZProductScreenConditionDateModel : BaseModel
@property (nonatomic, strong) NSArray * list;
@property (nonatomic, strong) NSArray * typesOfMortgage;//抵押类型
@property (nonatomic, strong) NSArray * occupation; // 职业身份

@end

@interface TZLoanDataModel :NSObject<NSCopying,NSMutableCopying> // 贷款日期
@property (nonatomic, copy) NSString * ID;
@property (nonatomic, copy) NSString * dictValue;
@property (nonatomic, copy) NSString * dictKey;
@property (nonatomic, copy) NSString * typeId;
@property (nonatomic, copy) NSString * sortWeight;

// 自定义
@property (nonatomic, assign) BOOL isSelected;

@end

NS_ASSUME_NONNULL_END

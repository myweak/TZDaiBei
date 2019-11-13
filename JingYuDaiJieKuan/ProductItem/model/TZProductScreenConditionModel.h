//
//  TZProductScreenConditionModel.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/5.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TZProductScreenConditionModel : BaseModel
@property (nonatomic, strong) NSArray * list; // 线下产品大全

@end




@interface TZProductOfflineInfoModel : NSObject
@property (nonatomic, copy) NSString * proId;
@property (nonatomic, copy) NSString * proIco;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * minAmount;
@property (nonatomic, copy) NSString * maxAmount;
@property (nonatomic, copy) NSString * monthlyRate; // l费率
@property (nonatomic, copy) NSString * lendingTime; // 放宽时长
@property (nonatomic, copy) NSString * lendingType; // 0:小时；1:天；2:月
@property (nonatomic, strong) NSArray * labelInfo;
//
@property (nonatomic, copy) NSString * lendingTypeStr;

@end

@interface TZProductOfflineInfoCollasModel : NSObject
@property (nonatomic, copy) NSString * ID;
@property (nonatomic, copy) NSString * labelName;
@property (nonatomic, copy) NSString * labelColor;
@end



NS_ASSUME_NONNULL_END

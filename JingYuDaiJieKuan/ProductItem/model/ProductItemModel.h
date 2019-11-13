//
//  ProductItemModel.h
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/2.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "StatusModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProductItemListModel : StatusModel

@property (nonatomic, strong) NSString * pageSize;
@property (nonatomic, strong) NSArray * result;
@property (nonatomic, strong) NSString *current;
@property (nonatomic, strong) NSString * totalCount;
@property (nonatomic, strong) NSString * hasPre;
@property (nonatomic, strong) NSString * totalPages;
@property (nonatomic, strong) NSString * hasNext;
@property (nonatomic, copy) NSString *nextPage;
@property (nonatomic, copy) NSString *autoCount;
@property (nonatomic, copy) NSString *prePage;
@property (nonatomic, copy) NSString *jpaCurrent;

@end


@interface ProductItemModel : NSObject

@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * tags;
@property (nonatomic, strong) NSString * sort;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * maxAmount;
@property (nonatomic, strong) NSString * icon;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * merchartid;


@end

@interface sortListModel : StatusModel
@property (nonatomic, strong) NSArray * list;
@end

@interface sortModel : NSObject
/// 1为排序类型 2为筛选类型
@property (nonatomic, strong) NSString * lfilterType;
@property (nonatomic, strong) NSString * lfilterId;
@property (nonatomic, strong) NSString * labelId;
@property (nonatomic, strong) NSString * labelName;
@property (nonatomic, strong) NSString * weightValue;

@end

@interface filterModel : NSObject
@property (nonatomic, strong) NSString * filterId;  //"-1"为不限 , "1"为"以上"只传最小值 ,"2"传最小最大值
@property (nonatomic, strong) NSString * labelName;
@property (nonatomic, assign) NSInteger max;
@property (nonatomic, assign) NSInteger min;
@property (nonatomic, assign) BOOL isSelected;

+ (filterModel *)createWithFilterId:(NSString *)filterId
                       labelName:(NSString *)labelName
                             min:(NSInteger)min
                             max:(NSInteger)max
                      isSelected:(BOOL)isSelected;
@end


@interface randomProductModel : StatusModel
@property (nonatomic, assign) NSInteger maxAmount;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger numPeople;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *merchartid;
@end

@interface advertisementDialogListModel : StatusModel
@property (nonatomic, strong) NSArray *list;

@end

@interface advertisementDialogModel : NSObject
/// 1-弹窗|2-悬浮
@property (nonatomic, assign) NSInteger dialogType;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *photoIphonex;
@property (nonatomic, strong) NSString *title;
/// 1-每日首次打开|2-每次打开|3-首次打开
@property (nonatomic, assign) NSInteger triggerWay;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *mchId;
@property (nonatomic, strong) NSString *mchName;
/// referType 关联类型：1-商户|2-地址
@property (nonatomic, strong) NSString *referType;

@end

@interface ProductItemHistoryListModel : StatusModel<NSCoding>
@property (nonatomic, strong) NSArray *list;
@end

@interface ProductItemHistoryModel : NSObject<NSCoding>
@property (nonatomic, strong) NSString *searchKey;
@property (nonatomic, strong) NSString *mchId;
@property (nonatomic, strong) NSString *mchName;
@property (nonatomic, strong) NSString *rate;
@property (nonatomic, strong) NSString *maxAmount;
@property (nonatomic, strong) NSString *referType;
@property (nonatomic, strong) NSString *minAmount;
@property (nonatomic, strong) NSString *recommendReason;
@property (nonatomic, strong) NSString *rateType;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *url;

@end

NS_ASSUME_NONNULL_END

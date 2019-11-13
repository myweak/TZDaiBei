//
//  ProductItemModel.m
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/2.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "ProductItemModel.h"

@implementation  ProductItemModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"url":@"url",
             @"tags":@"tags",
             @"sort":@"sort",
             @"title":@"title",
             @"maxAmount":@"maxAmount",
             @"icon":@"icon",
             @"name":@"name",
             @"merchartid":@"merchartid",
             };
}
@end

@implementation ProductItemListModel
+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"pageSize":@"data.pageSize",
             @"result":@"data.result",
             @"current":@"data.current",
             @"totalCount":@"data.totalCount",
             @"hasPre":@"data.hasPre",
             @"totalPages":@"data.totalPages",
             @"hasNext":@"data.hasNext",
             @"nextPage":@"data.nextPage",
             @"autoCount":@"data.autoCount",
             @"prePage":@"data.prePage",
             @"jpaCurrent":@"data.jpaCurrent",
             
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : [ProductItemModel class],
             };
}

@end

@implementation  sortListModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"list":@"data.list",
             };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [sortModel class],
             };
}
@end

@implementation  sortModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"lfilterType":@"lfilterType",
             @"lfilterId":@"lfilterId",
             @"labelId":@"labelId",
             @"labelName":@"labelName",
             @"weightValue":@"weightValue",
             };
}
@end


@implementation filterModel

+ (filterModel *)createWithFilterId:(NSString *)filterId
                          labelName:(NSString *)labelName
                                min:(NSInteger)min
                                max:(NSInteger)max
                         isSelected:(BOOL)isSelected{
    filterModel *model = [[filterModel alloc]init];
    model.filterId = filterId;
    model.labelName = labelName;
    model.max = max;
    model.min = min;
    model.isSelected = isSelected;
    
    return model;
    
}

@end


@implementation  randomProductModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"maxAmount":@"data.maxAmount",
             @"name":@"data.name",
             @"numPeople":@"data.numPeople",
             @"url":@"data.url",
             @"icon":@"data.icon",
             @"merchartid":@"data.merchartid",
             };
}

@end


@implementation  advertisementDialogListModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"list":@"data.list",
             };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [advertisementDialogModel class],
             };
}
@end

@implementation  advertisementDialogModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"dialogType":@"dialogType",
             @"photo":@"photo",
             @"photoIphonex":@"photoIphonex",
             @"title":@"title",
             @"triggerWay":@"triggerWay",
             @"url":@"url",
             @"id":@"id",
             @"mchId":@"mchId",
             @"mchName":@"mchName",
             @"referType":@"referType"
             };
}
@end

@implementation  ProductItemHistoryListModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"list":@"data.list",
             };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [ProductItemHistoryModel class],
             };
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_list forKey:@"list"];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _list = [aDecoder decodeObjectForKey:@"list"];
    }
    return self;
}

@end

@implementation  ProductItemHistoryModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"searchKey":@"searchKey",
             @"mchId":@"mchId",
             @"mchName":@"mchName",
             @"rate":@"rate",
             @"maxAmount":@"maxAmount",
             @"referType":@"referType",
             @"minAmount":@"minAmount",
             @"recommendReason":@"recommendReason",
             @"rateType":@"rateType",
             @"icon":@"icon",
             @"url":@"url",
             };
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_searchKey forKey:@"searchKey"];
    [aCoder encodeObject:_mchId forKey:@"mchId"];
    [aCoder encodeObject:_mchName forKey:@"mchName"];
    [aCoder encodeObject:_rate forKey:@"rate"];
    [aCoder encodeObject:_maxAmount forKey:@"maxAmount"];
    [aCoder encodeObject:_referType forKey:@"referType"];
    [aCoder encodeObject:_minAmount forKey:@"minAmount"];
    [aCoder encodeObject:_recommendReason forKey:@"recommendReason"];
    [aCoder encodeObject:_rateType forKey:@"rateType"];
    [aCoder encodeObject:_icon forKey:@"icon"];
    [aCoder encodeObject:_url forKey:@"url"];
    
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _searchKey = [aDecoder decodeObjectForKey:@"searchKey"];
        _mchId = [aDecoder decodeObjectForKey:@"mchId"];
        _mchName = [aDecoder decodeObjectForKey:@"mchName"];
        _rate = [aDecoder decodeObjectForKey:@"rate"];
        _maxAmount = [aDecoder decodeObjectForKey:@"maxAmount"];
        _referType = [aDecoder decodeObjectForKey:@"referType"];
        _minAmount = [aDecoder decodeObjectForKey:@"minAmount"];
        _recommendReason = [aDecoder decodeObjectForKey:@"recommendReason"];
        _rateType = [aDecoder decodeObjectForKey:@"rateType"];
        _icon = [aDecoder decodeObjectForKey:@"icon"];
        _url = [aDecoder decodeObjectForKey:@"url"];
    }
    return self;
}

@end


//
//  TZProductPageModel.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/2.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZProductPageModel.h"

@implementation TZProductPageModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"offlineProductBanks":@"data.offlineProductBanks",
             @"chosenResponseList":@"data.chosenResponseList",
             @"bannerInfo":@"data.bannerInfo",
             @"newsList":@"data.list",
             @"bankList":@"data.mchList",
             };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"offlineProductBanks":[TZProductListModel class],
             @"chosenResponseList":[TZProductListModel class],
             @"bannerInfo" : [TZProductBannerInfoModel class],
             @"newsList" : [TZProductNewsModel class],
             @"bankList" : [TZProductBankModel class],
             
             };
}

@end


@implementation TZProductBankModel
- (void)setRecvMoneyType:(NSString *)recvMoneyType{
    _recvMoneyType =recvMoneyType;
    // recvMoneyType 0:分钟；1:小时：2:天；3:月 recvMoneyTime
    NSString *title = @"";
    switch (self.recvMoneyType.integerValue) {
        case 0:
            title = @"分钟";
            break;
        case 1:
            title = @"小时";
            break;
        case 2:
            title = @"天";
            break;
        case 3:
            title = @"月";
            break;
        default:
            break;
    }
    self.recvMoneyType_str = title;
}
- (void)setRateType:(NSString *)rateType{
    _rateType =rateType;
    // 1:日利率；2:月利率；1:年利率-》rate
    NSString *title = @"";
    switch (self.rateType.integerValue) {
        case 1:
            title = @"日利率";
            break;
        case 2:
            title = @"月利率";
            break;
        case 3:
            title = @"年利率";
            break;
        default:
            break;
    }
    self.rateType_str = title;
}

@end




@implementation TZProductNewsModel
@end



@implementation TZProductBannerInfoModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID":@"id",
             };
}
@end





@implementation TZProductListModel

@end


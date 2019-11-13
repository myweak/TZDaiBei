//
//  CardVoucherModel.h
//  JingYuDaiJieKuan
//
//  Created by air on 2018/4/10.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "BaseModel.h"
#import "CardVoucherListModel.h"

@interface CardVoucherModel : BaseModel

/**
 *  获取用户卡券列表页 -- 7224
 *  coupon_type  卡券类型
 *  page         分页
 */
+ (void)cardVoucherListPath:(NSString *)path
                       params:(NSMutableDictionary *)params
                       target:(id)target
                      success:(void (^)(CardVoucherListModel * model))success
                      failure:(void (^)(NSError *error))failure;

/**
 *  获取卡券适用的产品类列表 -- 7224
 *  couponid  卡券id
 *  page         分页
 */
+ (void)useTheProductPath:(NSString *)path
                     params:(NSMutableDictionary *)params
                     target:(id)target
                    success:(void (^)(CardVoucherListModel * model))success
                    failure:(void (^)(NSError *error))failure;


@end



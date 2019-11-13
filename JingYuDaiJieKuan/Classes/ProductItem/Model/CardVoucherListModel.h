//
//  CardVoucherListModel.h
//  JingYuDaiJieKuan
//
//  Created by air on 2018/4/10.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "StatusModel.h"


@interface CardVoucherListDataModel : NSObject

@property (copy ,nonatomic) NSString *couponid; //卡券id
@property (copy ,nonatomic) NSString *userid; //用户id
@property (copy ,nonatomic) NSString *valid_time_end; //最后有效时间
@property (copy ,nonatomic) NSString *coupon_money; //现金券金额
@property (copy ,nonatomic) NSString *coupon_rate; //卡劵利率
@property (copy ,nonatomic) NSString *use_status;  //使用状态[1-未使用|2-已使用|3-已过期|4-已到期']
@property (copy ,nonatomic) NSString *descriptionStr; //卡券描述
@property (copy ,nonatomic) NSString *coupon_name; //卡券_名称

//使用产品
@property (copy ,nonatomic) NSString *project_name; //卡券_名称
@property (copy ,nonatomic) NSString *project_period; //项目期限
@property (copy ,nonatomic) NSString *repay_way; //立即投资



@end


@interface CardVoucherListModel : StatusModel

@property (nonatomic, strong) NSArray *list;



@end








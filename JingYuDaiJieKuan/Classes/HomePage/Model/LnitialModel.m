//
//  LnitialModel.m
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/4/12.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "LnitialModel.h"

@implementation LnitialListModel

@end


@implementation LnitialModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [LnitialListModel class],
             
             };
}

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"indexTopNoticInfo":@"data.indexTopNoticInfo",
             @"register_protocol":@"data.protocol_urls.register_protocol",
             @"bindcard_protocol":@"data.protocol_urls.bindcard_protocol",
             @"loan_protocol":@"data.protocol_urls.loan_protocol",
             @"lend_protocol":@"data.protocol_urls.lend_protocol",
             @"lond_protocol":@"data.protocol_urls.lond_protocol",
             @"voucher_protocol":@"data.protocol_urls.voucher_protocol",
             @"service_phone":@"data.service_phone",
             @"app_v":@"data.upgrade.app_v",
             @"upgrade_way":@"data.upgrade.upgrade_way",
             @"dialog_repeat":@"data.upgrade.dialog_repeat",
             @"app_title":@"data.upgrade.app_title",
             @"app_url":@"data.upgrade.app_url",
             @"app_desc":@"data.upgrade.app_desc",
             @"risk_url":@"data.risk_url",
             @"token_status":@"data.popup.token_status",
             @"isShowStartup":@"data.popup.isShowStartup",
             @"isPopup":@"data.popup.isPopup",
             @"ad_name":@"data.popup.ad_name",
             @"ad_url":@"data.popup.ad_url",
             @"ad_image_url":@"data.popup.ad_image_url",
             @"ad_id":@"data.popup.ad_id",
             @"list":@"data.list",
             @"smallImg":@"data.popup.smallImg",
             @"bigImg":@"data.popup.bigImg",
             @"regAgreement":@"data.regAgreement",

             };
    
    
    
    
    
    
    
    
}

@end


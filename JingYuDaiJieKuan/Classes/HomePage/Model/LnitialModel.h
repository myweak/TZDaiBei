//
//  LnitialModel.h
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/4/12.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LnitialListModel : NSObject

@property (nonatomic ,copy) NSString *ad_image_url;
@property (nonatomic ,copy) NSString *smallImg;
@property (nonatomic ,copy) NSString *bigImg;

@end

@interface LnitialModel : StatusModel

@property (nonatomic ,strong) NSArray *list;

@property (nonatomic ,copy) NSString *risk_url;         //风险评测协议

@property (nonatomic ,copy) NSString *register_protocol;//注册协议

@property (nonatomic ,copy) NSString *bindcard_protocol;//更换银行卡协议

@property (nonatomic ,copy) NSString *loan_protocol;//网络借贷风险和禁止性行为提示书

@property (nonatomic ,copy) NSString *lend_protocol;//出借咨询与服务协议

@property (nonatomic ,copy) NSString *lond_protocol;//财鹿管家借款合同

@property (nonatomic ,copy) NSString *voucher_protocol;//凭证协议

@property (nonatomic ,copy) NSString *service_phone;//客服电话


/***********************升级******************************/


@property (copy ,nonatomic) NSString *app_desc;//需要升级到此版本,如果已经是最新版本，此值为空字符串
@property (copy ,nonatomic) NSString *app_url;//如果已经是最新版本或是IOS版本，则此值为空字符串
@property (copy ,nonatomic) NSString *app_title;//需要升级到此版本,如果已经是最新版本，此值为空字符串
@property (copy ,nonatomic) NSString *dialog_repeat;//升级弹窗重复提示 0 - 否，1 - 是。
@property (nonatomic ,copy) NSString *app_v;//对应版本
@property (nonatomic ,copy) NSString *upgrade_way;//0 - 不升级、1 - 建议升级、2 - 强制升级、3 - 应用关闭

@property (nonatomic ,copy) NSString *token_status;
@property (nonatomic ,copy) NSString *isShowStartup;
@property (nonatomic ,copy) NSString *isPopup;
@property (nonatomic ,copy) NSString *ad_name;
@property (nonatomic ,copy) NSString *ad_url;
@property (nonatomic ,copy) NSString *ad_image_url;
@property (nonatomic ,copy) NSString *ad_id;
@property (nonatomic ,copy) NSString *smallImg;
@property (nonatomic ,copy) NSString *bigImg;
@property (nonatomic ,copy) NSString *regAgreement;

@end

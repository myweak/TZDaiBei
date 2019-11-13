//
//  BankAPI.h
//  JingYuDaiJieKuan
//
//  Created by JY on 2018/4/9.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <Foundation/Foundation.h>

//获取公共银行卡列表
UIKIT_EXTERN NSString *const userGetBankList;

//绑定银行卡发送短信
UIKIT_EXTERN NSString *const userUserBindBank;

//绑定银行卡确认
UIKIT_EXTERN NSString *const userCheckBindBankInfo;

//获取用户绑定的银行卡列表
UIKIT_EXTERN NSString *const userGetUserBindBankCard;
/**用户解绑银行卡加急**/
UIKIT_EXTERN NSString *const userUserUnBindBankUrgent;

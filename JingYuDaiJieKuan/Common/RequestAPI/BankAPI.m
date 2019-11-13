//
//  BankAPI.m
//  JingYuDaiJieKuan
//
//  Created by JY on 2018/4/9.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "BankAPI.h"
//获取公共银行卡列表
NSString *const userGetBankList = @"User.getBankList";
//绑定银行卡发送短信
NSString *const userUserBindBank = @"User.userBindBank";
//绑定银行卡确认
NSString *const userCheckBindBankInfo = @"User.checkBindBankInfo";

//获取用户绑定的银行卡列表
NSString *const userGetUserBindBankCard = @"User.getUserBindBankCard";
/**用户解绑银行卡加急**/
NSString *const userUserUnBindBankUrgent = @"User.userUnBindBankUrgent";

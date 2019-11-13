//
//  TransactionRecordsAPI.m
//  JingYuDaiJieKuan
//
//  Created by air on 2018/4/3.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "TransactionRecordsAPI.h"

//交易记录

NSString *const detailList = @"User.getOrderDetailList";
//意见反馈
NSString *const feedback = @"FeedBack.saveFeedBackData";

//交易记录类型数据
NSString *const orderGetDetailType = @"Order.getDetailType";

//我的借款
NSString *const userProjectMyProjectList = @"Project.myProjectList";

//项目列表
NSString *const listOfItemsList = @"Project.getProductList";

//我的借款下级还款列表 借款详情
NSString *const repayMyRepayList = @"Repay.myRepayList";

//查看明细
NSString *const checkTheDetails = @"User.getInvestPlanList";

//投资记录  7208
NSString *const investmentRecord = @"Project.getProductInvest";

//产品详情-审核资料
NSString *const projectGetProductCheckDattum = @"Project.getProductCheckDattum";

//获取卡券适用的产品类列表
NSString *const useTheProduct = @"Coupon.getCouponUseProject";





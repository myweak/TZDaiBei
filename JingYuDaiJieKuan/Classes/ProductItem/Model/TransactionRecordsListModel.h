//
//  TransactionRecordsListModel.h
//  JingYuDaiJieKuan
//
//  Created by air on 2018/4/4.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionDetailsListDataModel : NSObject

@property (copy ,nonatomic) NSString *userid;
@property (copy ,nonatomic) NSString *c_time;
/// 可用余额
@property (copy ,nonatomic) NSString *residue_money;
@property (copy ,nonatomic) NSString *u_time;
@property (copy ,nonatomic) NSString *orderid;
@property (copy ,nonatomic) NSString *detail_type;
@property (copy ,nonatomic) NSString *trade_money;
@property (copy ,nonatomic) NSString *odetailid;
@property (copy ,nonatomic) NSString *name;
@property (copy ,nonatomic) NSString *color;


@end

@interface TransactionListDataModel : NSObject

@property (strong ,nonatomic) NSArray *list;
@property (copy ,nonatomic) NSString *name;
@property (copy ,nonatomic) NSString *value;
@property (copy ,nonatomic) NSString *c_group_time;
@property (copy ,nonatomic) NSString *count;
//项目列表
@property (copy ,nonatomic) NSString *projectid;        //项目ID   项目详情根据这个ID获取
@property (copy ,nonatomic) NSString *project_name;     //项目名字
@property (copy ,nonatomic) NSString *project_period;   //项目周期  项目期数 单位（月）
@property (copy ,nonatomic) NSString *repay_way;        //还款方式：1-先息后本|2-到期本息|3-等本等息|4-等额本息|5-等额本金',
@property (copy ,nonatomic) NSString *rate_init;        //利率
@property (copy ,nonatomic) NSString *leftRateInit;        //利率
@property (copy ,nonatomic) NSString *rightRateInit;        //利率
@property (copy ,nonatomic) NSString *c_time;//还款时间
@property (copy ,nonatomic) NSString *cur_status;       // |3-招标中|4-已满标|5-还款中|6-已结清',
@property (copy ,nonatomic) NSString *valid_time_start; //开始时间
@property (copy ,nonatomic) NSString *valid_time_end;   //结束时间
@property (copy ,nonatomic) NSString *overplusTime;     //项目开始倒计时  单位（秒）   如果为 0 表示项目已经开始   还要根据cur_status字段判断标的状态
@property (copy ,nonatomic) NSString *statusType;
@property (copy ,nonatomic) NSString *contract_url;//借款合同
//我的投资
@property (copy ,nonatomic) NSString *prospective_yield; //收益金额
@property (copy ,nonatomic) NSString *invest_money; //收益金额
@property (copy ,nonatomic) NSString *finance_money;//借款jin'e
@property (copy ,nonatomic) NSString *need_time; //项目时间
@property (copy ,nonatomic) NSString *pinvestid; //项目投资id
@property (copy ,nonatomic) NSString *contract_no;
//投资详情
@property (copy ,nonatomic) NSString *color; //颜色
@property (copy ,nonatomic) NSString *url; //url

//查看明细
@property (copy ,nonatomic) NSString *need_money; //颜色

//投资记录
@property (copy ,nonatomic) NSString *mobile; //手机号
@property (copy ,nonatomic) NSString *invest_time; //投资时间



@end



@interface TransactionRecordsListModel : StatusModel

@property (nonatomic, copy) NSString *detail_type;       //提现
@property (nonatomic, copy) NSString *trade_money;       //1000
@property (nonatomic, copy) NSString *residue_money;       //可用余额
@property (nonatomic, copy) NSString *c_time;       //交易时间
@property (copy ,nonatomic) NSString *total;
@property (nonatomic, strong) NSArray *list;
@property (copy ,nonatomic) NSString *firstTime;//最近的一个产品开抢时间倒计时 秒


@end

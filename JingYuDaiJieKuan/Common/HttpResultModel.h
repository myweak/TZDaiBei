//
//  HttpResultModel.h
//  NewJingYuBao
//
//  Created by linshaokai on 16/7/4.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpResultModel : NSObject
@property (assign ,nonatomic) NSInteger code;
@property (copy ,nonatomic) NSString *msg;
@property (nonatomic, copy) NSString * is_exist;                   //对应的Model
@property (nonatomic, copy) NSString *is_set_trade_pwd;
@property (nonatomic, strong)NSArray *money_range;
@property (nonatomic, copy) NSString *payMaxLimit;


@end

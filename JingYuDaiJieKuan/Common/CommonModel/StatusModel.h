//
//  StatusModel.h
//  CarpFinancial
//
//  Created by weibin on 15/12/11.
//  Copyright © 2015年 cwb. All rights reserved.
//

#import "BaseModel.h"

@interface StatusModel : BaseModel

@property (nonatomic, strong) id data;                   //对应的Model
@property (nonatomic, copy) NSString *totalsize;       //总数
@property (nonatomic, assign) NSInteger code;            //状态码
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *remarks;





@end

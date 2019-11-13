//
//  HomeFourEarningsModel.h
//  NewJingYuBao
//
//  Created by linshaokai on 16/7/6.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import "HttpResultModel.h"

@interface HomeFourEarningsModel : HttpResultModel
@property (copy ,nonatomic) NSString *isopen;
@property (copy ,nonatomic) NSString *content_four;
@property (copy ,nonatomic) NSString *content_three;
@property (copy ,nonatomic) NSString *productCode;
@end

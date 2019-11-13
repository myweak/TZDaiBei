//
//  HttpPropertyEntity.h
//  NewJingYuBao
//
//  Created by linshaokai on 16/6/27.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpPropertyEntity : NSObject
@property (copy ,nonatomic) NSString *requestApi;
@property (assign ,nonatomic) Class responseObject;
@property (strong ,nonatomic) NSDictionary *param;
@property (assign ,nonatomic) HTTPRequestType requestType;
@property (assign ,nonatomic) BOOL isNotEncryption;
@end

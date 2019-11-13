//
//  DataManager.h
//  CarpFinancial
//
//  Created by weibin on 15/12/11.
//  Copyright © 2015年 cwb. All rights reserved.
//

#import "BaseModel.h"
#import <CoreLocation/CoreLocation.h>

@interface DataManager : BaseModel

@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *payPwd;

@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, strong) dispatch_queue_t myQueue;
@property (nonatomic, strong) dispatch_queue_t modelQueue;
@property (nonatomic, strong) dispatch_queue_t mainQueue;

@property (nonatomic, copy) NSLock *codeLock;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

+ (DataManager *)sharedManager;

//登录成功保存密码
- (void)loginSucceed;
// 退出帐号
- (void)logOut;

@end

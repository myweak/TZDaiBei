//
//  LoginModel.h
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/6/29.
//  Copyright © 2019 Jincaishen. All rights reserved.
//
#define KUserData @"用户数据"
#import "StatusModel.h"


@interface MLoginModel: NSObject

@end

@interface LoginModel : StatusModel<NSCoding>

SINGLETON_FOR_HEADER(LoginModel)

@property (nonatomic, strong) LoginModel *userModel;// 当前model数据

@property (nonatomic, copy) NSString *token;// token
@property (nonatomic, copy) NSString *headImg;// token
@property (nonatomic, copy) NSString *nickName;// token
@property (nonatomic, copy) NSString *userId;// 用户ID

@property (nonatomic, copy) NSString *education;// 教育程度
@property (nonatomic, copy) NSString *gender;// 性别
@property (nonatomic, copy) NSString *mailbox;// 邮箱
@property (nonatomic, copy) NSString *mobile;// 手机号码
@property (nonatomic, copy) NSString *type;// login

// 清空用户数据
- (void)removeUserData;
//读取用户数据
- (LoginModel *)readUserData;
// 保存用户数据
- (void)saveUserData;
@end



@interface LoginBannerModel : StatusModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *photoIphonex;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;

@end



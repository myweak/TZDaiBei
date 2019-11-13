//
//  CheckLoginKeyModel.h
//  JingYuDaiJieKuan
//
//  Created by JY on 2019/6/4.
//  Copyright © 2019年 Jincaishen. All rights reserved.
//

#import "HttpResultModel.h"


@interface CheckLoginKeyModel : HttpResultModel
@property (nonatomic, copy) NSString *passwd;
@property (nonatomic, copy) NSString *identityid;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *nikename;
@property (nonatomic, copy) NSString *bank_cardno;
@property (nonatomic, copy) NSString *is_bind_bankcard;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *user_limit_type;//0-不能购买不能看，1-能购买能看，2-不能购买能看
@property (copy ,nonatomic) NSString *is_visit_jyd;//1 访问鲸鱼   0 访问鲸鱼理财
@property (copy ,nonatomic) NSString *jyd_url;//鲸鱼H5页面URL
@property (nonatomic, assign) BOOL risk_status;
@end


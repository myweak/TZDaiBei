//
//  TZEditUserTextFiedldVC.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/1.
//  Copyright © 2019 Jincaishen. All rights reserved.
//


typedef NS_ENUM(NSInteger, TZEditUserTextFiedldVCType)
{
    TZEditUserTextFiedldVCType_mobile = 0,  // 手机号码
    TZEditUserTextFiedldVCType_eMail  = 1, // 邮箱
    
};

#import "SuperVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface TZEditUserTextFiedldVC : SuperVC
@property (nonatomic, copy) NSString * placeholderStr;
@property (nonatomic, assign) TZEditUserTextFiedldVCType type;

@property (copy,nonatomic) void (^saveSuccessBlock) (NSString *saveStr);


@end

NS_ASSUME_NONNULL_END

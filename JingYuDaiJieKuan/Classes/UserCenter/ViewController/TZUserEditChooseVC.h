//
//  TZUserEditChooseVC.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/1.
//  Copyright © 2019 Jincaishen. All rights reserved.
//


typedef NS_ENUM(NSInteger, TZUserEditChooseVCType)
{
    TZUserEditChooseVCType_gender = 0,  // 性别选择
    TZUserEditChooseVCType_education  = 1, // 教育选择
    
};

#import "SuperVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface TZUserEditChooseVC : SuperVC
@property (nonatomic, assign) TZUserEditChooseVCType type;
@property (copy,nonatomic) void (^saveSuccessBlock) (NSString *saveStr);
@end

NS_ASSUME_NONNULL_END

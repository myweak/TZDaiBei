//
//  TZProductScreenConditionVC.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/5.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

typedef NS_ENUM(NSInteger, TZProductScreenConditionType)
{
    TZProductScreenConditionType_all = 0,  //所有数据
    TZProductScreenConditionType_main  = 1, // 主推产品
};

#import "SuperVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface TZProductScreenConditionVC : SuperVC
@property (nonatomic, assign) TZProductScreenConditionType type;
@end

NS_ASSUME_NONNULL_END

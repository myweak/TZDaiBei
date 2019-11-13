//
//  ModifyTheNicknameVC.h
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/7/3.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "SuperVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ModifyTheNicknameVC : SuperVC

@property (copy,nonatomic) void (^reloadDataBlock) (void);

@end

NS_ASSUME_NONNULL_END

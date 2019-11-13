//
//  NSObject+RAC.h
//  YBaby
//
//  Created by Cullen on 2016/11/1.
//  Copyright © 2016年 Cullen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (RAC)

@property (strong,readonly,nonatomic) NSHashTable *racSignals;

@property (strong,readonly,nonatomic) NSHashTable *deallocSignals;

/**
 将RAC创建的信号添加到管理列表中，管理列表会自动管理这些信号（在self释放时释放信号）

 @param signal RAC信号
 */
-(void)addSignalToList:(id)signal;

@end

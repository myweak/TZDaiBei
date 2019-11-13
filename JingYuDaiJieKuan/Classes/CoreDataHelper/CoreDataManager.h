//
//  CoreDataManager.h
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/5.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

//管理对象上下文
@property(nonatomic,strong)NSManagedObjectContext *managedContext;

//管理对象模型
@property(nonatomic,strong)NSManagedObjectModel *managedModel;

//调度存储器
@property(nonatomic,strong)NSPersistentStoreCoordinator *persistentStoreCoordinator;

//单例
+ (instancetype)defaultManager;


@end


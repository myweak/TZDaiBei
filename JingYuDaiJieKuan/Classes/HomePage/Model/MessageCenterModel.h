//
//  MessageCenterModel.h
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/4/3.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusModel.h"

@interface MessageCenterListModel :NSObject

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * c_time;
@property (nonatomic, copy) NSString * url;

@end

@interface MessageCenterModel : StatusModel

@property (nonatomic, copy) NSString * total;
@property (nonatomic,copy)NSArray *list;

@end

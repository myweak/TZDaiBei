//
//  NSDate+Category.h
//  kinhop
//
//  Created by weibin on 14/12/31.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@interface NSDate (Category)

+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;

@end

//
//  GFSharedItem.h
//  GoldfishStocks
//
//  Created by 曹梦涛 on 2018/1/31.
//  Copyright © 2018年 goldfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UShareUI/UShareUI.h>
@interface GFSharedItem : NSObject

+(NSArray*)items;

@property(nonatomic, copy) NSString *iconImageName;
@property(nonatomic, copy) NSString *iconTitle;
@property(nonatomic, assign) UMSocialPlatformType type;

@end

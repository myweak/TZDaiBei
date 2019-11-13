//
//  GFSharedItem.m
//  GoldfishStocks
//
//  Created by 曹梦涛 on 2018/1/31.
//  Copyright © 2018年 goldfish. All rights reserved.
//

#import "GFSharedItem.h"
#import "GFSharedHelp.h"
@implementation GFSharedItem

+ (NSArray*)items {
    NSMutableArray *array = [NSMutableArray new];
    
//    if ([GFSharedHelp isInstalledSina]) {
//        GFSharedItem *itemSina = [GFSharedItem new];
//        itemSina.iconTitle = @"新浪微博";
//        itemSina.iconImageName = @"share_ic_微博";
//        itemSina.type = UMSocialPlatformType_Sina;
//        [array addObject:itemSina];
//    }
    
    if ([GFSharedHelp isInstalledWechat]) {
        GFSharedItem *itemWechat = [GFSharedItem new];
        itemWechat.iconTitle = @"微信好友";
        itemWechat.iconImageName = @"share_ic_微信";
        itemWechat.type = UMSocialPlatformType_WechatSession;
        [array addObject:itemWechat];
        
        GFSharedItem *itemWcTimeLine = [GFSharedItem new];
        itemWcTimeLine.iconTitle = @"朋友圈";
        itemWcTimeLine.iconImageName = @"share_ic_朋友圈";
        itemWcTimeLine.type = UMSocialPlatformType_WechatTimeLine;
        [array addObject:itemWcTimeLine];
    }
   
//    GFSharedItem *itemCopy = [GFSharedItem new];
//    itemCopy.iconTitle = @"复制链接";
//    itemCopy.iconImageName = @"share_ic_Copylink";
//    itemCopy.type = UMSocialPlatformType_UserDefine_Begin+2;
//    [array addObject:itemCopy];
    
    return array;
}

@end

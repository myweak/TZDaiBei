//
//  GFSharedHelp.h
//  GoldfishStocks
//
//  Created by 曹梦涛 on 2018/1/31.
//  Copyright © 2018年 goldfish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFSharedHelp : NSObject
//是否安装qq
+ (BOOL)isInstalledQQ;
//是否安装新浪
+ (BOOL)isInstalledSina;
//是否安装微博
+ (BOOL)isInstalledWechat;

@end

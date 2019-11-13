//
//  GFSharedHelp.m
//  GoldfishStocks
//
//  Created by 曹梦涛 on 2018/1/31.
//  Copyright © 2018年 goldfish. All rights reserved.
//

#import "GFSharedHelp.h"
#import <UMSocialSinaHandler.h>
#import <UMSocialQQHandler.h>
#import <UMSocialWechatHandler.h>

@implementation GFSharedHelp

+ (BOOL)isInstalledQQ
{
    #if defined(APPSTORE)
        return  [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
    #endif
    
    #if defined(RELEASESERVER)
        return  [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
    #endif
        return YES;
}

+ (BOOL)isInstalledSina
{
#if defined(APPSTORE)
    return [[UMSocialSinaHandler defaultManager] umSocial_isInstall] && [[UMSocialSinaHandler defaultManager] umSocial_isSupport];
#endif
    
#if defined(RELEASESERVER)
    return [[UMSocialSinaHandler defaultManager] umSocial_isInstall] && [[UMSocialSinaHandler defaultManager] umSocial_isSupport];
#endif
    
    return YES;
}

+ (BOOL)isInstalledWechat
{
#if defined(APPSTORE)
    return [[UMSocialWechatHandler defaultManager] umSocial_isInstall] && [[UMSocialWechatHandler defaultManager] umSocial_isSupport];
#endif
    
#if defined(RELEASESERVER)
    return [[UMSocialWechatHandler defaultManager] umSocial_isInstall] && [[UMSocialWechatHandler defaultManager] umSocial_isSupport];
#endif
    
    return YES;
}

@end

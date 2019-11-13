//
//  HomeAPIParameter.h
//  NewJingYuBao
//
//  Created by linshaokai on 16/7/7.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeAPIParameter : NSObject
/**
 *  获取版本信息
 */
+(HttpPropertyEntity *)getAppVersion;

/**
 *  系统广告接口
 *  code 广告位编码 每个位置编码视业务系统而定
 */
+(HttpPropertyEntity *)getySystemAdsWithCode:(NSString *)code;

@end

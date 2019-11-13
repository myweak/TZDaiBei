//
//  HomeAPIParameter.m
//  NewJingYuBao
//
//  Created by linshaokai on 16/7/7.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import "HomeAPIParameter.h"
#import "AppVersionModel.h"
#import "HomePageModel.h"
#import "LnitialModel.h"
@implementation HomeAPIParameter
+(HttpPropertyEntity *)getAppVersion
{
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.requestApi = kSystemInit;
    //保存获取数据的版本号
//    [kUserMessageManager setMessageManagerForObjectWithKey:kHomeVersionData value:ChangeNullData(kApp_Version)];
    entity.requestType = 1;
    if ([kUserMessageManager checkUserLogin]) {
        entity.param = @{@"token":[kUserMessageManager getUserToken]?:@"",@"app_v":ChangeNullData(kApp_Version),@"method":kSystemInit};
    }else
    {
        entity.param = @{@"token":@"",@"app_v":ChangeNullData(kApp_Version),@"method":kSystemInit};
    }

    entity.responseObject = [AppVersionModel class];
    return entity;
}

+(HttpPropertyEntity *)getySystemAdsWithCode:(NSString *)code{
    
    HttpPropertyEntity *entity = [HttpPropertyEntity new];
    entity.requestApi = kNetUser_systemAds;
    entity.requestType = 1;
    entity.param = @{@"code":code,@"method":kNetUser_systemAds};
    DLog(@"param===%@",entity.param);
    entity.responseObject = [HomePageModel class];
    return entity;
}


@end

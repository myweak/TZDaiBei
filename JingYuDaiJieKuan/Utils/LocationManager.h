//
//  LocationManager.h
//  NewJingYuBao
//
//  Created by linshaokai on 2017/2/6.
//  Copyright © 2017年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^LocationBlock)(NSInteger status,CGFloat latitude,CGFloat longitude);
@interface LocationManager : NSObject
-(void)getLocation:(LocationBlock)location;
+(LocationManager *)sharedLocationManager;
-(void)authorLocation;
@end

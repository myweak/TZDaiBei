//
//  LocationManager.m
//  NewJingYuBao
//
//  Created by linshaokai on 2017/2/6.
//  Copyright © 2017年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import "JZLocationConverter.h"

#define kLocationAuthorFailTime @"FailAuthorTime"

@interface LocationManager()<CLLocationManagerDelegate>
@property (copy ,nonatomic)LocationBlock locationBlock;
@property (strong ,nonatomic) CLLocationManager *locationManager;
@property (strong ,nonatomic) CLLocation *currentLocation;
@property (assign ,nonatomic) BOOL isLoadingSend;
@end
@implementation LocationManager
SYNTHESIZE_SINGLETON_ARC_FOR_CLASS(LocationManager)
-(void)getLocation:(LocationBlock)location
{
    if (self.locationBlock != location) {
        self.locationBlock = nil;
        self.locationBlock= location;
    }
    [self startLocation];
}
-(instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}
-(void)authorLocation
{
    if(([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
        [self startLocation];
    }
}
-(BOOL)startLocationService
{
    if ([self locationServicesEnable]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locationManager.distanceFilter = 100;
        _locationManager.pausesLocationUpdatesAutomatically = YES;
        if (ISIOS8 && [CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined)
        {   //ios8下定位服务开启
            [_locationManager requestWhenInUseAuthorization];
        }
//        [kUserMessageManager removeMessageManagerForKey:kLocationAuthorFailTime];
        return YES;
    }else
    {
//        if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
//            NSDate *date = [kUserMessageManager getMessageManagerForObjectWithKey:kLocationAuthorFailTime];
//            if (date == nil) {
//                [kUserMessageManager setMessageManagerForObjectWithKey:kLocationAuthorFailTime value:[NSDate date]];
//            }else
//            {
////                if ([[NSDate date]timeIntervalSinceDate:date] >= 7 * 60 * 60 * 24) {
//                    [self jumpSystemSettingChangeLocation];
////                }else
////                {
////                    self.locationBlock(0,0,0);
////                }
//            }
//        }else
//        {
            [self blockResult:0 lat:0 lng:0 ];
//        }
        
        return NO;
    }
}

-(void)blockResult:(NSInteger)status lat:(CGFloat)lat lng:(CGFloat)lng
{
    if (self.locationBlock) {
        self.locationBlock(status,lat,lng);
    }
}

-(void)startLocation
{
    
    if (!_currentLocation || [_currentLocation.timestamp timeIntervalSinceNow]>= 3 * 60) {
        if (!_locationManager) {
            if (![self startLocationService]) {
                return;
            }
        }
        _currentLocation = nil;
        [_locationManager startUpdatingLocation];
    }else
    {
        if (_currentLocation) {
            [self transformLocation:_currentLocation];
        }
    }
    
    
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
//    [self setAuthorTimeForFail];
    [self blockResult:0 lat:0 lng:0];
}

-(void)setAuthorTimeForFail
{
    if (([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)) {
        [kUserMessageManager setMessageManagerForObjectWithKey:kLocationAuthorFailTime value:[NSDate date]];
    }
}
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    [self stopLocationService];
    if (!_currentLocation) {
        _currentLocation = newLocation;
        [self transformLocation:newLocation];
    }
}
-(void)transformLocation:(CLLocation *)location
{
    CLLocationCoordinate2D locationCoordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    CLLocationCoordinate2D gcj02 = [JZLocationConverter wgs84ToBd09:locationCoordinate];
    [self blockResult:1 lat:gcj02.latitude lng:gcj02.longitude];
     [kUserMessageManager setMessageManagerForObjectWithKey:@"latitude" value:[NSString stringWithFormat:@"%.6f",gcj02.latitude]];
    [kUserMessageManager setMessageManagerForObjectWithKey:@"longitude" value:[NSString stringWithFormat:@"%.6f",gcj02.longitude]];
    
}

-(BOOL)locationServicesEnable
{
    if(([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) || ![CLLocationManager locationServicesEnabled]) {
        return NO;
    }else
    {
        return YES;
    }
}
-(void)stopLocationService
{
    [_locationManager stopUpdatingLocation];
}
-(void)dealloc
{
    self.locationManager.delegate = nil;
}

@end

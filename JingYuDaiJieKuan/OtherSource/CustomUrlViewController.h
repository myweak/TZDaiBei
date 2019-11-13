//
//  CustomUrlViewController.h
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/27.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "SuperVC.h"

@interface CustomUrlViewController : SuperVC

@property (nonatomic,copy)void (^addUrlBlock)(NSString *key, NSString *value);

@end

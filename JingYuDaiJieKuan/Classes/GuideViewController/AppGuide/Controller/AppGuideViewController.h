//
//  AppGuideViewController.h
//  NewJingYuBao
//
//  Created by 张永杰 on 16/7/27.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppGuideViewController : UIViewController

@property(nonatomic, copy) NSMutableArray *m_arrayData;

@property(nonatomic, copy) void (^startBlock)(void);

@end

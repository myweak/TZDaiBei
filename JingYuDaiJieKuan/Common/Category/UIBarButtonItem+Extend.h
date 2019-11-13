//
//  UIBarButtonItem+Extend.h
//  NewJingYuBao
//
//  Created by linshaokai on 16/6/24.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extend)
+ (UIBarButtonItem *)customBarButtonItemWithNornalImage:(NSString *)nornalImage
                                           seletedImage:(NSString *)seletedImage
                                                  title:(NSString *)title
                                                 target:(id)target
                                                 action:(SEL)action;
@end

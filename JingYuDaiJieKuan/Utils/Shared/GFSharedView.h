//
//  GFSharedView.h
//  GoldfishStocks
//
//  Created by 曹梦涛 on 2018/1/31.
//  Copyright © 2018年 goldfish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFSharedItem.h"

typedef void (^GFSharedViewDidSelectItemBlock)(GFSharedItem *item);

@interface GFSharedView : UIView

+ (void)showSharedView:(GFSharedViewDidSelectItemBlock)selectComplete;

@end

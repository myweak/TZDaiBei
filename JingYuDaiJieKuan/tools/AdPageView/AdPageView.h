//
//  AdPageView.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/12/6.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 启动广告页面
 */

static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";

typedef void(^TapBlockAdPageView)(void);

@interface AdPageView : UIView

- (instancetype)initWithFrame:(CGRect)frame withTapBlock:(TapBlockAdPageView)tapBlock;

/** 显示广告页面方法*/
- (void)show;

/** 图片路径*/
@property (nonatomic, copy) NSString *filePath;

@end

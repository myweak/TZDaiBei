//
//  YYLabel+tool.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2020/1/9.
//  Copyright © 2020 Jincaishen. All rights reserved.
//



#import <YYLabel.h>
#import "YYLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYLabel (tool)
/**
 *  获取lb的高度（默认字体13，行间距8，lb宽ScreenWidth-100）
 *  @param mess lb.text
 *  @return lb的高度
 */
-(CGFloat)getMessageHeight:(NSString *)mess;
@end

NS_ASSUME_NONNULL_END

//
//  YYLabel+tool.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2020/1/9.
//  Copyright © 2020 Jincaishen. All rights reserved.
//

#import "YYLabel+tool.h"


@implementation YYLabel (tool)

/**
 *  获取lb的高度（默认字体13，行间距8，lb宽ScreenWidth-100）
 *  @param mess lb.text
 *  @return lb的高度
 */
-(CGFloat)getMessageHeight:(NSString *)mess
{
    NSMutableAttributedString *introText = [[NSMutableAttributedString alloc] initWithString:mess];
    introText.yy_font = self.font;
    self.attributedText = introText;
    introText.yy_lineSpacing = 1;
    CGSize introSize = CGSizeMake(self.frame.size.width, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:introSize text:introText];
    self.textLayout = layout;
    CGFloat introHeight = layout.textBoundingSize.height;
    return introHeight;
}
@end

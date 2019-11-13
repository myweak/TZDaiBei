//
//  TZProductHeaderView.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/1.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZProductHeaderView.h"

@implementation TZProductHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.viewBg.image = R_ImageName(@"pro_bg");
    self.moneyLabel.keywords = @"￥";
    self.moneyLabel.keywordsFont = kFontSize24;
    [self.moneyLabel reloadUIConfig];
}
@end

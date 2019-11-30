//
//  TZMineHeaderCardView.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/29.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZMineHeaderCardView.h"

@implementation TZMineHeaderCardView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.cardViewBg.layer.shadowColor = [@"000000" getColorWithAlpha:0.2].CGColor;
    self.cardViewBg.layer.shadowOpacity = 5.0;
    self.cardViewBg.layer.shadowOffset = CGSizeMake(0, 5);
    self.cardViewBg.layer.shadowRadius = 5;
    self.detailLabel.underlineStr = @"查看借款详情";
    [self.detailLabel reloadUIConfig];
}



@end

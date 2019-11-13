//
//  TZProductQualityItemView.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/1.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZProductQualityItemView.h"

@implementation TZProductQualityItemView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth= 1;
}

@end

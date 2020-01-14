//
//  TZProductLineFrontDetailSurplusCell.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2020/1/12.
//  Copyright © 2020 Jincaishen. All rights reserved.
//

#import "TZProductLineFrontDetailSurplusCell.h"
@interface TZProductLineFrontDetailSurplusCell()
@property (nonatomic, strong) CAGradientLayer *gradient;
@end
@implementation TZProductLineFrontDetailSurplusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.surplusView.frame = CGRectMake(0, 0, 0, 3);
    //为颜色设置渐变效果：
     self.gradient= [CAGradientLayer layer];
    //设置开始和结束位置(设置渐变的方向)
    self.gradient.startPoint = CGPointMake(0, 0);
    self.gradient.endPoint = CGPointMake(1, 0);
    self.gradient.colors = [NSArray arrayWithObjects:(id)[@"ff8745" getColor].CGColor,(id)[@"e82f16" getColor].CGColor,nil];

}

- (void)setSurplusValue{
    @weakify(self)

    CGFloat value = 0.3;
    CGFloat MaxSurplusView_W = kScreenWidth - 60;
    [UIView animateWithDuration:2.5*value <1 ? 1:2.5*value animations:^{
       @strongify(self)
       self.surplusView.width = MaxSurplusView_W *value;
        self.gradient.frame =CGRectMake(0,0,MaxSurplusView_W *value,self.surplusView.height);
        [self.surplusView.layer insertSublayer:self.gradient atIndex:0];


    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

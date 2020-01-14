//
//  TZProductLineFrontDetailPostMoneyNumbCell.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2020/1/12.
//  Copyright © 2020 Jincaishen. All rights reserved.
//

#import "TZProductLineFrontDetailPostMoneyNumbCell.h"
@interface TZProductLineFrontDetailPostMoneyNumbCell()

@property (weak, nonatomic) IBOutlet UIView *viewBg;

@end
@implementation TZProductLineFrontDetailPostMoneyNumbCell

- (void)awakeFromNib {
    [super awakeFromNib];
        self.viewBg.layer.shadowColor = [@"8b8b8b," getColorWithAlpha:0.25].CGColor;
        self.viewBg.layer.shadowOpacity = 5.0;
        self.viewBg.layer.shadowOffset = CGSizeMake(0, 5);
        self.viewBg.layer.shadowRadius = 5;
    self.postMoneyLabel.keywords = @"元";
    self.postMoneyLabel.keywordsFont = kFontSize14;
    self.dateLabel.keywords = @"月";
    self.dateLabel.keywordsFont = kFontSize14;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

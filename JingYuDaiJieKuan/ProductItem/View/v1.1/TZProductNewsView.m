//
//  TZProductNewsView.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/2.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZProductNewsView.h"

@implementation TZProductNewsView

- (void)setModel:(TZProductNewsModel *)model{
    _model = model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:Kimage_placeholder];
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
    self.timeLabel.text = model.updateTime;
    [self.showNumBtn setTitle:model.readNum forState:UIControlStateNormal];
    
}

@end

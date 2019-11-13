//
//  TZProductNewsView.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/2.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZXibNibView.h"
#import "TZProductPageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TZProductNewsView : TZXibNibView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageView_H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageView_W;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabel_L;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabel_T;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *showNumBtn; // 浏览数量

// 设置数据
@property (nonatomic, strong) TZProductNewsModel *model;

@end

NS_ASSUME_NONNULL_END

//
//  TZMyFutureMoneyDetailCommentCell.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/30.
//  Copyright © 2019 Jincaishen. All rights reserved.
//


static NSString * const TZMyFutureMoneyDetailCommentCell_ID = @"TZMyFutureMoneyDetailCommentCellID";

#import <UIKit/UIKit.h>
#import "StarSliderView.h"
NS_ASSUME_NONNULL_BEGIN

@interface TZMyFutureMoneyDetailCommentCell : UITableViewCell<StarSLiderDelegate>
@property (weak, nonatomic) IBOutlet StarSliderView *starView;

@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *notifyLabel;
@property (nonatomic, copy) void (^backOnTapAction)(NSInteger num);

@end

NS_ASSUME_NONNULL_END

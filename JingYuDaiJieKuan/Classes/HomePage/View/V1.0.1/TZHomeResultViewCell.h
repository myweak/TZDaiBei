//
//  TZHomeResultViewCell.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/10/29.
//  Copyright © 2019 Jincaishen. All rights reserved.
//
static NSString * const TZHomeResultViewCellID = @"TZHomeResultViewCellID";

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TZHomeResultViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *playTimetLabel; //  累计运营 时间
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel; // 累计交易 数量

@end

NS_ASSUME_NONNULL_END

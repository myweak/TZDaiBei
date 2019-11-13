//
//  TZProductToolsCell.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/1.
//  Copyright © 2019 Jincaishen. All rights reserved.
//
static NSString * const TZProductToolsCell_ID = @"TZProductToolsCell_ID";

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TZProductToolsCell : UITableViewCell
@property (copy,nonatomic) void (^backBtnTapAcionBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END

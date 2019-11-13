//
//  TZUserEditChooseCell.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/1.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString * const TZUserEditChooseCell_ID = @"TZUserEditChooseCellID";


@interface TZUserEditChooseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *chooseImageView; // ☑️ 默认：隐藏
@property (weak, nonatomic) IBOutlet UIButton *rightBtn; //  默认：隐藏
@property (copy,nonatomic) void (^backBtnTapAcionBlock)(void);


@end

NS_ASSUME_NONNULL_END

//
//  TZMineRowCell.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/10/30.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
static NSString * const TZMineRowCellID = @"TZMineRowCellID";

@interface TZMineRowCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView; // 左边图片
@property (weak, nonatomic) IBOutlet UILabel *mianTitleLabel;// 标题
@property (weak, nonatomic) IBOutlet UIView *rightViewBg;// 右边双标题。默认隐藏

@property (weak, nonatomic) IBOutlet UIImageView *moreImageView;// 更多箭头
@property (weak, nonatomic) IBOutlet UILabel *rightSubLabel;// 右边副标题
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightSubLable_R;// 距离箭头的 距离。默认 5； -17
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainLabel_L;// 距离左边的距离 默认：60； 16

@property (weak, nonatomic) IBOutlet UILabel *companyPhoneLabel; //公司客服联系电话
@property (weak, nonatomic) IBOutlet UILabel *companyTimeLabel; //热线服务时间：9:00-18:00



// 是否 显示箭头 默认显示
- (void)showMoreImageView:(BOOL)isShow;
// 是否 显示 左边的。icon 默认显示
- (void)showIconImageView:(BOOL)isShow;
@end

NS_ASSUME_NONNULL_END

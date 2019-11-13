//
//  TheThirdHomePageCell.h
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/9/3.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TheThirdHomePageCell : UITableViewCell

@property (strong, nonatomic) UIImageView *m_IconImage; // 推荐image

+ (instancetype)creatCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END

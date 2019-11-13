//
//  AboutUsCell.h
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/7/3.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AboutUsCell : UITableViewCell
@property (nonatomic ,strong) UILabel *m_cooperationName;


+ (instancetype)creatCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

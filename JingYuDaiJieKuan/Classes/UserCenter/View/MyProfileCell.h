//
//  MyProfileCell.h
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/7/3.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyProfileCell : UITableViewCell

@property (strong ,nonatomic) UILabel *m_leftLabel;
@property (strong ,nonatomic) UILabel *m_rightLabel;
@property (strong ,nonatomic) UIImageView *m_rightImage;

+ (instancetype)creatCellWithTableView:(UITableView *)tableView;


@end


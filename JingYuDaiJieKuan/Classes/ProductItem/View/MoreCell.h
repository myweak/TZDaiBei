//
//  MoreCell.h
//  JingYuDaiJieKuan
//
//  Created by air on 2018/3/22.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreCell : UITableViewCell
@property (nonatomic ,strong)UILabel *leftLabel;
@property (nonatomic ,strong)UILabel *rightLabel;
@property (nonatomic ,strong)UIImageView *arrowImg;

+ (instancetype)creatCellWithTableView:(UITableView *)tableView;

@end

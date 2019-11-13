//
//  TheFirstHomePageCell.h
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/6/26.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TheFirstHomePageCellDelegate <NSObject>

@end
typedef void (^RecommendedBlock)(void);

@interface TheFirstHomePageCell : UITableViewCell

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UIImageView *m_recommendedImage; // 推荐image
@property (strong, nonatomic) UIImageView *m_IconImage;
@property (strong, nonatomic) UILabel *m_nameLabel;
@property (strong, nonatomic) UILabel *m_timeLabel;
@property (strong, nonatomic) UIButton *m_immediatelyBtn;


+ (instancetype)creatCellWithTableView:(UITableView *)tableView;

@end

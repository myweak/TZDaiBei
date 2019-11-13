//
//  TheSecondHomePageCell.h
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/6/26.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TheSecondHomeBlock) (void);
@protocol TheSecondHomePageCellDelegate <NSObject>
@end


@class AdBannerModel;
    @interface TheSecondHomePageCell : UITableViewCell

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UIImageView *m_IconImage;
@property (strong, nonatomic) UILabel *m_nameLabel;
@property (strong, nonatomic) UILabel *m_interestLabel;

@property (strong, nonatomic) UILabel *m_highestLabel;
@property (strong, nonatomic) UILabel *m_moneyLabel;

@property (strong, nonatomic) UIButton *m_immediatelyBtn;

@property (strong, nonatomic) UILabel *firstTagLbl;
@property (strong, nonatomic) UILabel *secondTagLbl;
@property (strong, nonatomic) UILabel *thirdTagLbl;

@property (strong, nonatomic) AdBannerModel *model;

+ (instancetype)creatCellWithTableView:(UITableView *)tableView;

@end



//
//  LoanStrategyCell.h
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/6/28.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

typedef void (^GiveALikeBlock) (void);

@interface LoanStrategyCell : UITableViewCell
@property (strong ,nonatomic) UILabel *m_nameLabel;
@property (strong ,nonatomic) UIButton *m_iconBtn;
@property (strong ,nonatomic) UILabel *m_numberLabel;
@property (strong ,nonatomic) UIButton *m_praiseBtn;
@property (strong ,nonatomic) UILabel *m_praiseLabel;

@property (assign ,nonatomic)BOOL isClick;
@property (strong ,nonatomic) UIImageView *m_iconImage;

+ (instancetype)creatCellWithTableView:(UITableView *)tableView;

- (void)loanStrategyModelValue:(LUserModel *)model;


@property (copy ,nonatomic) GiveALikeBlock giveALikeBlock;

@end



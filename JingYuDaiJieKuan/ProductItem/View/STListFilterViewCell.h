//
//  STListFilterViewCell.h
//  my
//
//  Created by soso-mac on 2016/11/21.
//  Copyright © 2016年 soso-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZProductScreenConditionProvinceModel.h"
@interface STListFilterViewCell : UICollectionViewCell
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UIButton *titleBtn;

-(void)setFilterIndexPath:(NSIndexPath *)indexPath andfilterModel:(TZLoanDataModel *)model;
@end

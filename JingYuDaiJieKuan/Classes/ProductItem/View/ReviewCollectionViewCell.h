//
//  ReviewCollectionViewCell.h
//  JingYuDaiJieKuan
//
//  Created by JY on 2018/4/10.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransactionRecordsListModel.h"
@interface ReviewCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *m_imageView;
@property (nonatomic,strong)UILabel *m_textLabel;;

-(void)getCellData:(TransactionListDataModel *)model;

@end

//
//  ScrollviewCollectionViewCell.h
//  JingYuDaiJieKuan
//
//  Created by JY on 2018/4/2.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ScrollviewCollectionViewCellDelegate;


@interface ScrollviewCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UITableView *m_tableView;


@property (nonatomic, strong) NSMutableArray *dataSource;

//代理
@property (nonatomic, assign) id<ScrollviewCollectionViewCellDelegate> delegate;
@end



@protocol ScrollviewCollectionViewCellDelegate<NSObject>

- (void)bodyCollection_didSelectRowWith:(NSIndexPath *)indexPath;

@end

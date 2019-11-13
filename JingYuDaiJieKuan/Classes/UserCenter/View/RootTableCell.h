//
//  RootCell.h
//  DKSTableCollcetionView
//
//  Created by aDu on 2017/10/10.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootTableCell;
@protocol RootCellDelegate <NSObject>

/**
 * 动态改变UITableViewCell的高度
 */
- (void)updateTableViewCellHeight:(RootTableCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath;


/**
 * 点击UICollectionViewCell的代理方法
 */
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content andIsWeb: (BOOL)isWeb cooperation:(NSString *)cooperation;
@end

@interface RootTableCell : UITableViewCell

@property (nonatomic, weak) id<RootCellDelegate> delegate;


@end

//
//  ProductItemHeadView.h
//  JingYuDaiJieKuan
//
//  Created by JY on 2019/6/29.
//  Copyright © 2019年 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductItemModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProductItemHeadView : UIView

/// 显示筛选下拉的回调
@property (copy,nonatomic) void (^showFilterBlock) (BOOL isShowFilter);

/// 排序回调
@property (copy,nonatomic) void (^chooseClickBlock) (NSString *tags
                                                    , NSInteger maxAmount
                                                    , NSInteger mixAmount
                                                    , NSInteger maxLimit
                                                    , NSInteger mixLimit
                                                    , BOOL isSort);


@property (strong,nonatomic)sortListModel *sortListModel;

/// 重置控件的筛选及排序条件
- (void)reSetCondition;

@end

NS_ASSUME_NONNULL_END

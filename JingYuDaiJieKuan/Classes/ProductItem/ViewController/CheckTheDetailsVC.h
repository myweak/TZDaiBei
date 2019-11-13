//
//  CheckTheDetailsVC.h
//  JingYuDaiJieKuan
//
//  Created by air on 2018/4/9.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "SuperVC.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>


@interface CheckTheDetailsVC : SuperVC<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic ,copy) NSString * investmentID;

@end

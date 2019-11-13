//
//  TransactionRecordsVC.h
//  JingYuDaiJieKuan
//
//  Created by air on 2018/3/27.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "SuperVC.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface TransactionRecordsVC : SuperVC<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic ,strong)UITableView *tableView;
@end

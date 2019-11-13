
//
//  InvestmentRecordVC.h
//  JingYuDaiJieKuan
//
//  Created by air on 2018/3/30.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "SuperVC.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>


@interface InvestmentRecordVC : SuperVC<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong)UITableView *m_tableView;

@property (nonatomic, copy)NSString *projectId;

@end

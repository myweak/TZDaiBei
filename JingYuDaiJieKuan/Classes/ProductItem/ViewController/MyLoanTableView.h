//
//  MyLoanTableView.h
//  JingYuDaiJieKuan
//
//  Created by air on 2018/4/11.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "InvestmentDetailsVC.h"
#import "MyLoanCell.h"

@interface MyLoanTableView : UITableView<UITableViewDataSource,UITableViewDelegate,MyLoanCellDelegate>

@property (nonatomic,strong)UIViewController *superVC;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic,copy) NSString *titleStr;
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;

@end



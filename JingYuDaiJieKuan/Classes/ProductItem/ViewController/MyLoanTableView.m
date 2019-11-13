//
//  MyLoanTableView.m
//  JingYuDaiJieKuan
//
//  Created by air on 2018/4/11.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "MyLoanTableView.h"

//#import "InvestmentDetailsVC.h"


@implementation MyLoanTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = kColorLightgrayBackground;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}
#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyLoanCell *cell = [MyLoanCell creatCellWithTableView:tableView];
    cell.delegate = self;
    TransactionListDataModel *model  = [self.dataArray objectAtIndex:indexPath.section];
    [cell setupCellContentWithModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count > 0) {
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        InvestmentDetailsVC * vc = [[InvestmentDetailsVC alloc] init];
        TransactionListDataModel *model  = [self.dataArray objectAtIndex:indexPath.section];
        vc.investmentID = model.projectid;
        vc.titleStr = self.titleStr;
        
        [self.superVC.navigationController pushViewController:vc animated:YES];
    }else{
        
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KWidth(159);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return KWidth(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#define MyLoanCellDelegate 借款合同

- (void)myLoanCellClick:(UIButton *)sender
{
    if (self.dataArray.count >0) {
        TransactionListDataModel *model  = [self.dataArray objectAtIndex:sender.tag - 100];
        BaseWebViewController *vc = [[BaseWebViewController alloc] init];
        vc.url = model.contract_url?:@"";
        [self.superVC.navigationController pushViewController:vc animated:YES];
    }else{
        
    }
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


@end

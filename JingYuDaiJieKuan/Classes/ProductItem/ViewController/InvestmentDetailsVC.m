//
//  InvestmentDetailsVC.m
//  JingYuDaiJieKuan
//
//  Created by air on 2018/4/4.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "InvestmentDetailsVC.h"
#import "InvestmentDetailsCell.h"
#import "TransactionRecordsModel.h"
#import "CheckTheDetailsVC.h"
#import "BaseWebViewController.h"
@interface InvestmentDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
{
}
@property (nonatomic, strong)UITableView *m_tableView;
@property(nonatomic,strong) UIView *headView;
@property(nonatomic,strong) UIView *footerView;
@property(nonatomic,strong) NSMutableArray *dataArray;


@end

@implementation InvestmentDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr?:@"我的借款";
    self.view.backgroundColor = UIColorRGB(247,247,248);
    [self.view addSubview:self.m_tableView];
    
    [self initView];
    [self initData];
    if ([self.title  isEqualToString: @"投标中"]) {

    }else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"明细" style:UIBarButtonItemStylePlain target:self action:@selector(etail)];
    }

}
- (void)initView{
//    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kiP6WidthRace(40))];
//    self.headView.backgroundColor = [UIColor whiteColor];
//    self.m_tableView.tableHeaderView = self.headView;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kiP6WidthRace(10))];
    view.backgroundColor = UIColorRGB(247,247,248);
    [self.headView addSubview:view];
    
//    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kiP6WidthRace(20))];
//
//    self.footerView.backgroundColor = [UIColor whiteColor];
//    self.m_tableView.tableFooterView =self.footerView;
    
}

- (void)initData{
    kSelfWeak;
    NSMutableDictionary *dic = (NSMutableDictionary *)@{@"token":[kUserMessageManager getUserToken],@"pinvestid":self.investmentID};
    
    [CustomLoadingView showLoadingView:self.view];
    [TransactionRecordsModel investmentListDetailsPath:repayMyRepayList params:dic target:self success:^(TransactionRecordsListModel *model) {
        
        if (model.list && [model.list isKindOfClass:[NSArray class]]) {
            [weakSelf.dataArray addObjectsFromArray:model.list];
        }
        if (model.code == 200) {
            [weakSelf.m_tableView reloadData];
        }
        [CustomLoadingView hiddenLoadingView:weakSelf.view];
    } failure:^(NSError *error) {
        [CustomLoadingView hiddenLoadingView:weakSelf.view];

    }];
}

- (void)etail
{
    DLog(@"明细");
    CheckTheDetailsVC *vc = [[CheckTheDetailsVC alloc] init];
    vc.investmentID = _investmentID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InvestmentDetailsCell *cell = [InvestmentDetailsCell creatCellWithTableView:tableView];
    TransactionListDataModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [cell setupCellContentWithModel:model];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count > 0) {
        TransactionListDataModel *model = [self.dataArray objectAtIndex:indexPath.row];
        if (model.url) {
            BaseWebViewController *vc = [[BaseWebViewController alloc] init];
            vc.url = model.url;
            vc.isShowWebTitle = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else
        {
            return;
        }
    }else{
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KWidth(35);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return KWidth(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UITableView *)m_tableView
{
    if (!_m_tableView) {
        _m_tableView = InsertTableView(nil, CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.view.frame)), self, self, UITableViewStylePlain, UITableViewCellSeparatorStyleSingleLine);
        _m_tableView.separatorStyle = UITableViewCellSelectionStyleNone;
//        _m_tableView.userInteractionEnabled = NO;
        _m_tableView.scrollEnabled = NO;
        if (IS_iPhoneX) {
            _m_tableView.height = self.view.height;
        }
        if ([_m_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [_m_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_m_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [_m_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return _m_tableView;
}


- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end

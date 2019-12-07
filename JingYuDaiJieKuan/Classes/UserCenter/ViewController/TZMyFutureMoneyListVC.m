//
//  TZMyFutureMoneyListVC.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/30.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZMyFutureMoneyListVC.h"
#import "TZMyFutureMoneyListCell.h"
#import "TZMyFutureMoneyDetailVC.h"

@interface TZMyFutureMoneyListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong ,nonatomic) UITableView *m_tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation TZMyFutureMoneyListVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"贷款总览";
    
    [self initWithUI];
    [self bindSignal];
    
    [self refreshData];

}
- (void)refreshData{
    [self posthomeLastAllPathUrl];
}


- (void)bindSignal{
    @weakify(self)
    [self.m_tableView registerNibString:NSStringFromClass([TZMyFutureMoneyListCell class]) cellIndentifier:TZMyFutureMoneyListCell_ID];
    
    

}

- (void)initWithUI{
    [self.view addSubview:self.m_tableView];
}

// 线上极速贷款 数据
- (void)posthomeLastAllPathUrl{
    @weakify(self)
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setValue:@(self.page) forKey:@"pageNo"];
//    NSString *urlStr = [NSString stringWithFormat:@"%@%@",API_homeLastAll_path,@(self.page)];
//
//    [ProductItemViewModel homeLastAllPath:urlStr params:nil target:self success:^(TZProductPageModel * _Nonnull model) {
//        @strongify(self)
//        if (self.page == 1) {
//            self.dataArr = [[NSMutableArray alloc] initWithArray:model.bankList];
//        }else{
//            if (model.bankList.count == 0) {
//                [self.m_tableView.mj_footer endRefreshingWithNoMoreData];
//                return ;
//            }else{
//                [self.dataArr addObjectsFromArray:model.bankList];
//            }
//        }
//        [self.m_tableView.mj_header endRefreshing];
//        [self.m_tableView.mj_footer endRefreshing];
//        [self.m_tableView reloadData];
//    } failure:^(NSError * _Nonnull error) {
//        [self.m_tableView.mj_header endRefreshing];
//        [self.m_tableView.mj_footer endRefreshing];
//    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TZMyFutureMoneyListCell *cell = [tableView dequeueReusableCellWithIdentifier:TZMyFutureMoneyListCell_ID forIndexPath:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TZMyFutureMoneyDetailVC *detailVC = [TZMyFutureMoneyDetailVC new];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


#pragma mark -UI
- (UITableView *)m_tableView{
    if (!_m_tableView) {//UITableViewStyleGrouped
        _m_tableView = InsertTableView(nil, CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.view.frame)), self, self, UITableViewStylePlain, UITableViewCellSeparatorStyleNone);
        _m_tableView.height = self.view.height;
        _m_tableView.rowHeight = UITableViewAutomaticDimension;
        _m_tableView.estimatedRowHeight = 120;
        
        if ([_m_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [_m_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_m_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [_m_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        
    }
    return _m_tableView;
}




@end

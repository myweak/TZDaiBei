//
//  TZApplyCreditCardVC.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/12/24.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZApplyCreditCardVC.h"
#import "TZApplyCreditCardCell.h"
#import "TZApplyCreditCardModel.h"
#import "ProductItemViewModel.h"

@interface TZApplyCreditCardVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong ,nonatomic) UITableView *m_tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation TZApplyCreditCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信用卡申请";
    self.page = 1;
    
    [self initWithUI];
    [self bindSignal];
    
    [self refreshData];

}
- (void)refreshData{
    [self posthomeLastAllPathUrl];
}


- (void)bindSignal{
    @weakify(self)
    [self.m_tableView registerNibString:NSStringFromClass([TZApplyCreditCardCell class]) cellIndentifier:TZApplyCreditCardCell_ID];
    self.m_tableView.mj_header =  [PigMJRefreshGifHeader headerWithRefreshingBlock:^{
     @strongify(self)
        self.page = 1;
        [self refreshData];
    }];
    
    MJRefreshAutoNormalFooter *footRefre =  [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        self.page++;
        [self refreshData];
    }];
    [footRefre setTitle:@"没有更多数据了" forState:(MJRefreshStateNoMoreData)];
    self.m_tableView.mj_footer = footRefre;

}

- (void)initWithUI{
    [self.view addSubview:self.m_tableView];
}

// 线上极速贷款 数据
- (void)posthomeLastAllPathUrl{
    @weakify(self)
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(self.page) forKey:@"pageNo"];
    [ProductItemViewModel conditionPath:API_getCreditCardList_path params:params target:self modelClass:[TZApplyCreditCardModel class] success:^(TZApplyCreditCardModel  *model) {
        @strongify(self)
        if (self.page == 1) {
            self.dataArr = [[NSMutableArray alloc] initWithArray:model.list];
        }else{
            [self.dataArr addObjectsFromArray:model.list];
        }
        if (model.list.count < 10) {
            [self.m_tableView.mj_header endRefreshing];
            [self.m_tableView.mj_footer endRefreshingWithNoMoreData];
            [self.m_tableView reloadData];
            return ;
        }
        
        [self.m_tableView.mj_header endRefreshing];
        [self.m_tableView.mj_footer endRefreshing];
        [self.m_tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [self.m_tableView.mj_header endRefreshing];
        [self.m_tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 98;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    @weakify(self)
    TZApplyCreditCardCell *cell = [tableView dequeueReusableCellWithIdentifier:TZApplyCreditCardCell_ID forIndexPath:indexPath];
    TZApplyCreditCardListModel *model = [self.dataArr objectAtIndex:indexPath.row];
    cell.model = model;
    cell.backTapBtnActionBlock = ^(UIButton * _Nonnull btn) {
     @strongify(self)
        [self PushToBaseWebViewControllerUrl:model.url andTitle:model.title];

    };
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TZApplyCreditCardListModel *model = [self.dataArr objectAtIndex:indexPath.row];

}


#pragma mark -UI
- (UITableView *)m_tableView{
    if (!_m_tableView) {//UITableViewStyleGrouped
        _m_tableView = InsertTableView(nil, CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.view.frame)), self, self, UITableViewStylePlain, UITableViewCellSeparatorStyleSingleLine);
        _m_tableView.height = self.view.height;
        _m_tableView.rowHeight = UITableViewAutomaticDimension;
        _m_tableView.estimatedRowHeight = 120;
        
        if ([_m_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [_m_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_m_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [_m_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        
        _m_tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
    }
    return _m_tableView;
}

#pragma mark - push VC
// web
- (void)PushToBaseWebViewControllerUrl:(NSString *)urlStr andTitle:(NSString *)title{
    if (checkStrEmty(urlStr)) {
        return;
    }
    BaseWebViewController *targetVC = [[BaseWebViewController alloc]init];
    targetVC.url = urlStr;
    targetVC.navigationItem.title = title;
    [self.navigationController pushViewController:targetVC animated:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

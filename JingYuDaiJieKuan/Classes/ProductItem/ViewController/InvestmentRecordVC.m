//
//  InvestmentRecordVC.m
//  JingYuDaiJieKuan
//
//  Created by air on 2018/3/30.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//
// 投资记录

#import "InvestmentRecordVC.h"
#import "CouponsView.h"
#import "InvestmentRecordwCell.h"
#import "TransactionRecordsModel.h"


@interface InvestmentRecordVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *titleArray;
}

@property (nonatomic,strong)UIView *headView;
@property (nonatomic, strong)CouponsView *m_couponsView;

@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)NSMutableArray *dataArray;

@property (assign ,nonatomic) NSInteger m_page;
@property (assign ,nonatomic) UIImage *imageNoData;

@end

@implementation InvestmentRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"投资记录";
    self.view.backgroundColor = UIColorRGB(247,247,248);
    [self.view addSubview:self.m_tableView];
    
    self.m_page = 1;
    
    self.m_tableView.tableHeaderView = self.headView;
    [self.view addSubview:self.headView];
    [self initView];
    
    [self initDataPage:1];
    
    PigMJRefreshGifHeader *header = [PigMJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.m_tableView.mj_header = header;
    self.imageNoData = [UIImage imageNamed:@"notrade_image"];

}
- (void)initView{
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.top.mas_equalTo(kiP6WidthRace(0));
        make.width.mas_equalTo(kScreenWidth);
        make.height.height.mas_equalTo(kiP6WidthRace(50));
    }];

    titleArray = @[@"投资人",@"投资金额(元)",@"投资时间"];
    _m_couponsView = [[CouponsView alloc] initWithNameAry:titleArray];
    [_headView addSubview:_m_couponsView];
    [_m_couponsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_headView);
    }];
    _m_couponsView.clickButtonBlock = ^(NSInteger num) {
        //点击方法
        
    };
}

- (void)initDataPage:(NSInteger)page{
    
    kSelfWeak;
    NSMutableDictionary *dic = (NSMutableDictionary *)@{@"token":[kUserMessageManager getUserToken],@"productId":self.projectId,@"page":@(page)};
    [CustomLoadingView showLoadingView:self.view];

    [TransactionRecordsModel InvestmentRecordPath:investmentRecord params:dic target:self success:^(TransactionRecordsListModel *model) {
        [CustomLoadingView hiddenLoadingView:weakSelf.view];

        [_m_tableView.mj_header endRefreshing];
        [_m_tableView.mj_footer endRefreshing];
        if (model.code == 200) {
            if (self.m_page == 1) {
                [self.dataArray removeAllObjects];
            }
            if (model.list && [model.list isKindOfClass:[NSArray class]]) {
                [weakSelf.dataArray addObjectsFromArray:model.list];
            }
            [weakSelf.m_tableView reloadData];
        }
        self.m_tableView.mj_footer.hidden = NO;
        self.m_tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf loadMoreData];
        }];
        [self.m_tableView.mj_footer resetNoMoreData];

        
//        NSInteger totalCount = [model.total integerValue];
        
//        if (self.dataArray.count >= totalCount) {
//
//            [self.m_tableView.mj_footer endRefreshingWithNoMoreData];
//        }else
//        {
//            [self.m_tableView.mj_footer resetNoMoreData];
//        }
        self.m_tableView.emptyDataSetSource = self;
        self.m_tableView.emptyDataSetDelegate = self;
    } failure:^(NSError *error) {
//        [CustomLoadingView hiddenLoadingView:weakSelf.view];
        [_m_tableView.mj_header endRefreshing];


    }];
}

#pragma 私有事件

- (void)loadData{
    [self initDataPage:self.m_page];
}

- (void)loadMoreData
{
    self.m_page += 1;
    [self initDataPage:self.m_page];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InvestmentRecordwCell *cell = [[InvestmentRecordwCell alloc] init];
    TransactionListDataModel *model  = [self.dataArray objectAtIndex:indexPath.row];
    [cell investmentRecordModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KWidth(55);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return KWidth(0.01);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)headView{
    if (!_headView) {
        _headView = InsertView(nil, CGRectZero, kColorWhite);
    }
    return _headView;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = InsertView(nil, CGRectZero, kColorRed);
    }
    return _lineView;
}

- (UITableView *)m_tableView{
    if (!_m_tableView) {
        _m_tableView = InsertTableView(nil, CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.view.frame)), self, self, UITableViewStylePlain, UITableViewCellSeparatorStyleSingleLine);
        _m_tableView.showsVerticalScrollIndicator = NO;
        
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

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

#pragma mark - DZEmptyDelegate

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"暂时没有相关数据!";
    
    NSDictionary *attributes = @{NSFontAttributeName: KFont(17),
                                 NSForegroundColorAttributeName: UIColorHex(@"#a5a5a5")};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"notrade_image"];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    UIImage *image = [UIImage imageNamed:@"notrade_image"];
    return -(image.size.height/2);
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    DLog(@"----refresh-----");
//    [self initDataPage:self.m_page];
    
}
@end


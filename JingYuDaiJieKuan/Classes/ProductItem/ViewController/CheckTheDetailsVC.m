//
//  CheckTheDetailsVC.m
//  JingYuDaiJieKuan
//
//  Created by air on 2018/4/9.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "CheckTheDetailsVC.h"
#import "CouponsView.h"
#import "CustomButton.h"
#import "InvestmentRecordwCell.h"
#import "TransactionRecordsModel.h"

@interface CheckTheDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *titleArray;
}

@property (nonatomic,strong)UIView *headView;
@property (nonatomic, strong)CouponsView *m_couponsView;
@property (nonatomic, strong)UITableView *m_tableView;
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)NSMutableArray *dataArray;

@property (assign ,nonatomic) NSInteger m_page;
@property (assign ,nonatomic) UIImage *imageNoData;


@end

@implementation CheckTheDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看明细";
    self.view.backgroundColor = UIColorRGB(247,247,248);
    [self.view addSubview:self.m_tableView];
    
    self.m_tableView.tableHeaderView = self.headView;
    [self.view addSubview:self.headView];
    //    [self.headView addSubview:self.lineView];
    
    self.imageNoData = [UIImage imageNamed:@"notrade_image"];
    self.m_tableView.emptyDataSetSource = self;
    self.m_tableView.emptyDataSetDelegate = self;
    
    
    [self initView];
    [self initDataPage:1];
    
    self.m_page = 1;
    PigMJRefreshGifHeader *header = [PigMJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.m_tableView.mj_header = header;

}
- (void)initView{
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.top.mas_equalTo(kiP6WidthRace(0));
        make.width.mas_equalTo(kScreenWidth);
        make.height.height.mas_equalTo(kiP6WidthRace(50));
    }];
    
    titleArray = @[@"回款明细",@"回款金额(元)",@"状态"];
    _m_couponsView = [[CouponsView alloc] initWithNameAry:titleArray];
    _m_couponsView.backgroundColor = UIColorRGB(247, 247, 248);
//    [_m_couponsView.clickBtn setBackgroundColor:kColorBlue];
    
    
    
    
//    _CustomButton
//    - (void)clickState{//
//        [self setBackgroundColor:kColorWhite];
//        [self setTitleColor:kColorBlack forState:UIControlStateNormal];
//    }

    [_headView addSubview:_m_couponsView];
    [_m_couponsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_headView);
    }];
    _m_couponsView.clickButtonBlock = ^(NSInteger num) {
        //点击事件
    };
}
- (void)initDataPage:(NSInteger)page{
    kSelfWeak; //self.investmentID
    NSMutableDictionary *dic = (NSMutableDictionary *)@{@"token":[kUserMessageManager getUserToken],@"pinvestid":self.investmentID,@"page":@(page)};
//    [CustomLoadingView showLoadingView:self.view];
    [TransactionRecordsModel checkTheDetailsPath:checkTheDetails params:dic target:self success:^(TransactionRecordsListModel *model) {
//        [CustomLoadingView hiddenLoadingView:weakSelf.view];
        [_m_tableView.mj_header endRefreshing];

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
        
        NSInteger totalCount = [model.total integerValue];
        
        if (self.dataArray.count >= totalCount) {
            [self.m_tableView.mj_footer endRefreshingWithNoMoreData];
        }else
        {
            [self.m_tableView.mj_footer resetNoMoreData];
        }
    } failure:^(NSError *error) {
        [_m_tableView.mj_header endRefreshing];

    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InvestmentRecordwCell *cell = [InvestmentRecordwCell creatCellWithTableView:tableView];
    TransactionListDataModel *model  = [self.dataArray objectAtIndex:indexPath.section];
    [cell checkTheDetailsModel:model];
    
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

#pragma 私有事件

- (void)loadData{
    [self initDataPage:self.m_page];
}

- (void)loadMoreData
{
    self.m_page += 1;
    [self initDataPage:self.m_page];
}


- (UIView *)headView{
    if (!_headView) {
        _headView = InsertView(nil, CGRectZero, UIColorRGB(247, 247, 248));
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
    return [UIImage imageNamed:@"notrade_image"];//self.imageNoData;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
   UIImage *img = [UIImage imageNamed:@"notrade_image"];
    return -(img.size.height/2);
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    DLog(@"----refresh-----");
//    [self initDataPage:self.m_page];
    
}

@end


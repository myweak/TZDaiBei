
//  MyLoanVC.m
//  JingYuDaiJieKuan
//
//  Created by air on 2018/3/22.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//
#import "MyLoanVC.h"
#import "MyLoanCell.h"
#import "HeadScrollView.h"
#import "TransactionRecordsModel.h"
#import "InvestmentDetailsVC.h"
#import "MyLoanTableView.h"

@interface MyLoanVC ()<UIScrollViewDelegate>
{
    NSArray *titleArray;
    NSInteger *isType;
    
}
//@property (nonatomic, strong)UITableView *m_tableView;
@property (nonatomic, strong)MyLoanTableView *m_tableView;
@property (nonatomic,strong)HeadScrollView *headView;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,assign)NSInteger indexTable;
@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)UITableView *tempTableView;
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,assign)NSInteger m_page;

@property (strong ,nonatomic) UIButton *btnFrame;

@property (strong ,nonatomic)UIImage *imageNoData;

@end

@implementation MyLoanVC


- (void)viewDidLoad {
    [super viewDidLoad];
    //我的投资
    self.title = @"我的借款";
    self.view.backgroundColor = UIColorRGB(247,247,248);
    self.indexTable = 0;
    [self.view addSubview:self.headView];
    [self initView];
    [self initData:1 page:1];
    self.index = 1;
    self.m_page = 1;
    
    MyLoanTableView *tableView = (MyLoanTableView *)[self.view viewWithTag:3000+self.indexTable];
    PigMJRefreshGifHeader *header = [PigMJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    tableView.mj_header = header;
    self.imageNoData = [UIImage imageNamed:@"notrade_image"];
}

- (void)initView
{
    titleArray = @[@"待还款",@"待放款",@"已结清"];
    self.headView = [[HeadScrollView alloc]initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth, AutoGetHeight(50)) array:titleArray index:self.indexTable];
    self.headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headView];
    kSelfWeak;
    self.headView.selectIndexAction = ^(UIButton *selectBtn, UIButton *previousBtn) {
        [weakSelf clickIndexAction:selectBtn previous:previousBtn];
    };
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0, AutoGetHeight(50), kScreenWidth, kScreenHeight - AutoGetHeight(50)-44)];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth*3, self.scrollView.size.height);
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    for (NSInteger i = 0; i < titleArray.count; i ++)
    {
        MyLoanTableView *tableView = [[MyLoanTableView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, self.scrollView.frame.size.height) style:UITableViewStylePlain];
        tableView.tag = 3000 +i;
        tableView.superVC = self;
        if (i == 0) {
            self.tempTableView = tableView;
        }

        [self.scrollView addSubview:tableView];
        
        if (@available(iOS 11.0,*)) {
            tableView.estimatedRowHeight = 0;
            tableView.estimatedSectionHeaderHeight = 0;
            tableView.estimatedSectionFooterHeight = 0;
        }
        tableView.rowHeight = AutoGetHeight(55.0);
        
        tableView.emptyDataSetSource = self;
        tableView.emptyDataSetDelegate = self;
        
    }
 
}

#pragma mark - Network

- (void)loadData{
    [self initData:self.index page:self.m_page];
}

- (void)loadMoreData
{
    self.m_page += 1;
    [self initData:self.index page:1];
}

- (void)initData:(NSInteger)type page:(NSInteger)page{
    
    kSelfWeak;
     MyLoanTableView *tableView = (MyLoanTableView *)[self.view viewWithTag:3000+self.indexTable];
    
    NSString *tp =[NSString stringWithFormat:@"%ld",(long)type];
    NSMutableDictionary *dic = (NSMutableDictionary *)@{@"token":[kUserMessageManager getUserToken],@"statusType":tp,@"page":@(page)};
    [CustomLoadingView showLoadingView:self.view];

    [TransactionRecordsModel myInvestmentPath:userProjectMyProjectList params:dic target:self success:^(TransactionRecordsListModel *model) {
        [CustomLoadingView hiddenLoadingView:weakSelf.view];
        if (model.code == 200) {
            if (page == 1) {
                [weakSelf.dataArray removeAllObjects];
            }

            if (model.list && [model.list isKindOfClass:[NSArray class]]) {
                [weakSelf.dataArray addObjectsFromArray:model.list];
            }
            //刷新界面
            self.m_tableView.mj_footer.hidden = NO;
            self.m_tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                [weakSelf loadMoreData];
            }];
            
            NSInteger totalCount = [model.total integerValue];
            if (self.dataArray.count >= totalCount) {
                [self.m_tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.m_tableView.mj_footer resetNoMoreData];
            }
            [weakSelf getResponseNetworkData:self.dataArray];
            
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0* NSEC_PER_SEC));
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [tableView.mj_header endRefreshing];
            });

        }else{
            if (self.dataArray.count == 0) {
//                [self showNoDataView];
            }else{
                [self.m_tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [weakSelf.m_tableView.mj_header endRefreshing];

    } failure:^(NSError *error) {
        [CustomLoadingView hiddenLoadingView:weakSelf.view];
        [weakSelf.m_tableView.mj_header endRefreshing];
    }];
    
}

-(void)getResponseNetworkData:(NSMutableArray *)array
{
//    [self.dataArray addObjectsFromArray:array];
    MyLoanTableView *tableView = (MyLoanTableView *)[self.view viewWithTag:3000+self.indexTable];
    tableView.dataArray = array;
    [tableView reloadData];
}

#pragma mark - Action
-(void)clickIndexAction:(UIButton *)selectBtn previous:(UIButton *)previousBtn
{
    [selectBtn setTitleColor:UIColorHex(@"#3f85ff") forState:UIControlStateNormal];
    [previousBtn setTitleColor:UIColorHex(@"#333333") forState:UIControlStateNormal];
    
    [self settingIndex:selectBtn];
    [UIView animateWithDuration:0.3 animations:^{
        [self.scrollView setContentOffset:CGPointMake(self.indexTable*kScreenWidth, 0.0) animated:YES];
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x/kScreenWidth;
    [self.headView.previousBtn setTitleColor:UIColorHex(@"#333333") forState:UIControlStateNormal];
    UIButton *btn = (UIButton *)[self.view viewWithTag:3100+page];
    [btn setTitleColor:UIColorHex(@"#3f85ff") forState:UIControlStateNormal];
    
    [self settingIndex:btn];
}

-(void)settingIndex:(UIButton *)selectButton
{
    CGRect frame = selectButton.frame;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.headView.bottomLine.frame = CGRectMake(frame.origin.x+(frame.size.width/4), selectButton.frame.size.height-3.0, frame.size.width/2, 3.0);
    }];
    self.headView.previousBtn = selectButton;
    self.indexTable = selectButton.tag - 3100;
    
    MyLoanTableView *tableView = (MyLoanTableView *)[self.view viewWithTag:3000+self.indexTable];
    tableView.superVC = self;
    //跳转详情界面传值
    tableView.titleStr = titleArray[self.indexTable];
    
    PigMJRefreshGifHeader *header = [PigMJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    tableView.mj_header = header;
    self.tempTableView = tableView;

    if (self.indexTable == 0)
    {
        self.index = 1;
        [self initData:1 page:1];
    }else if (self.indexTable == 1)
    {
        self.index = 2;
        [self initData:2 page:1];
    }else
    {
        self.index = 3;
        [self initData:3 page:1];
    }
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - DZEmptyDelegate

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{//您还没有记录哦~
    NSString *text = @"暂时没有相关数据!";
    
    NSDictionary *attributes = @{NSFontAttributeName: KFont(17),
                                 NSForegroundColorAttributeName: UIColorHex(@"#a5a5a5")};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.imageNoData;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -(self.imageNoData.size.height/2);
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    DLog(@"----refresh-----");
//    [self initData:self.index page:self.m_page];
    
}

@end


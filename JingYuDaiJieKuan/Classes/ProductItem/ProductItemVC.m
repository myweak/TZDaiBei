//
//  ProductItemVC.m
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/19.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "ProductItemVC.h"
#import "ProductListCell.h"
#import "UIFactory.h"
#import "InvestmentDetailInfoVC.h"
#import "TransactionRecordsModel.h"
#import "FinancingAplicationVC.h"
#import "BaseWebViewController.h"
#define LoadImage(B)    [UIImage imageNamed:B]


@interface ProductItemVC ()<UITableViewDelegate,UITableViewDataSource,InvestmentCellDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (strong ,nonatomic) NSMutableArray *m_dataArray;

@property (strong ,nonatomic) NSMutableArray *m_imageArray;

@property (assign ,nonatomic) NSInteger m_page;

@property (assign, nonatomic) NSInteger seconds;

@property (strong ,nonatomic)UIImage *imageNoData;

@end

@implementation ProductItemVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"项目列表";
    self.view.backgroundColor = kColorLightgrayBackground;
    self.m_page = 1;
//    self.seconds = 10;
    
//    [self.view addSubview:self.tableView];
 
//    [self initDatapage:1];
//    PigMJRefreshGifHeader *header = [PigMJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
//    self.tableView.mj_header = header;
//
//    self.imageNoData = [UIImage imageNamed:@"notrade_image"];
//
//    self.m_imageArray = [[NSMutableArray alloc] initWithObjects:LoadImage(@"section_one"),LoadImage(@"section_two"), nil];
    
    NSMutableArray *urlArray = [kUserMessageManager getMessageManagerForObjectWithKey:USERINDEXARRAY];
    NSMutableArray *titleArray = [kUserMessageManager getMessageManagerForObjectWithKey:USERITITLEARRAY];
   
    NSString * index = [kUserMessageManager getMessageManagerForObjectWithKey:USERINDEX];
    BaseWebViewController *vc= [[BaseWebViewController alloc] init];
    NSString *url;
    NSString *title;
    title = titleArray[[index integerValue]];
    title = [title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([urlArray[[index integerValue]] rangeOfString:@"?"].location !=NSNotFound) {
        
        url = [NSString stringWithFormat:@"%@&name=%@&goBack=0",urlArray[[index integerValue]],title];
    }else{
        url = [NSString stringWithFormat:@"%@?name=%@&goBack=0",urlArray[[index integerValue]],title];
    }
    vc.url = url;
    vc.isShowWebTitle = YES;
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSTimer *timer;
    [timer invalidate];
    timer = nil;
}
- (void)delayMethod:(NSTimer *)timer{
    NSLog(@"定时器");
    self.seconds--;
    if (self.seconds == 0) {
        [self initDatapage:1];
        [timer invalidate];
        timer = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)initDatapage:(NSInteger )page {
 
    kSelfWeak;
    NSMutableDictionary *dic = (NSMutableDictionary *)@{@"token":[kUserMessageManager getUserToken],@"page":@(page)};
    [CustomLoadingView showLoadingView:self.view];

    [TransactionRecordsModel listOfItemsPath:listOfItemsList params:dic target:self success:^(TransactionRecordsListModel *model) {
        [CustomLoadingView hiddenLoadingView:weakSelf.view];

        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        if (model.code == 200) {
            if (weakSelf.m_page == 1) {
                [weakSelf.m_dataArray removeAllObjects];
            }
            
            if (model.list && [model.list isKindOfClass:[NSArray class]]) {
                [weakSelf.m_dataArray addObjectsFromArray:model.list];
                weakSelf.seconds  = [model.firstTime integerValue];
                if (weakSelf.seconds > 0) {
                    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(delayMethod:) userInfo:nil repeats:YES];
                    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
                }
            }
//            [weakSelf.tableView reloadData];

        }else{
            weakSelf.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                [weakSelf loadMoreData];
            }];
            NSInteger totalCount = [model.total integerValue];
            
            if (weakSelf.m_dataArray.count >= totalCount) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [weakSelf.tableView.mj_footer resetNoMoreData];
            }
        }
//        weakSelf.tableView.mj_footer.hidden = NO;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
    } failure:^(NSError *error) {
        
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
    
}
#pragma 私有事件

- (void)loadData{
    [self initDatapage:self.m_page];
}

- (void)loadMoreData
{
    self.m_page += 1;
    [self initDatapage:self.m_page];
}

#pragma mark -- delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kiP6WidthRace(225);
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductListCell *cell = [ProductListCell creatCellWithTableView:tableView];
    cell.delegte = self; 
    cell.m_bgImageView.image = self.m_imageArray[indexPath.section];
//    TransactionListDataModel *model = self.m_dataArray[indexPath.section];
//    [cell setupCellContentWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{        
//        InvestmentDetailInfoVC *vc = [[InvestmentDetailInfoVC alloc]init];
//        TransactionListDataModel *model = self.m_dataArray[indexPath.section];
//        vc.projectId = model.projectid ?:@"";
//        [self.navigationController pushViewController:vc animated:YES];
       
        FinancingAplicationVC *vc = [[FinancingAplicationVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return 0.01;
//    }else{
//        return 10;
//    }
    return KWidth(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma Click
//立即投资点击事件
- (void)investmentCell:(ProductListCell *)cell investmentId:(NSString *)investmentID{
    
    if (self.m_dataArray.count >0) {
        
        NSIndexPath *path = [self.tableView indexPathForCell:cell];
        TransactionListDataModel *model = self.m_dataArray[path.section];
                InvestmentDetailInfoVC *vc = [[InvestmentDetailInfoVC alloc]init];
        vc.projectId = model.projectid ?:@"";
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        
    }
}

#pragma getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = InsertTableView(nil, CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.view.frame)), self, self, UITableViewStylePlain, UITableViewCellSeparatorStyleSingleLine);
        if (IS_iPhoneX) {
            _tableView.height = self.view.height;
        }
        
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    
    return _tableView;
    
}

-(NSMutableArray *)m_dataArray
{
    if (!_m_dataArray)
    {
        _m_dataArray = [[NSMutableArray alloc] init];
    }
    return _m_dataArray;
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
//    [self initDatapage:self.m_page];    
}


@end

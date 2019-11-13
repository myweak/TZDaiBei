//
//  TransactionRecordsVC.m
//  JingYuDaiJieKuan
//
//  Created by air on 2018/3/27.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "TransactionRecordsVC.h"
#import "TransactionRecordsCell.h"
#import "TransactionRecordsModel.h"
#import "SelectTypeView.h"

#define kCellHeadHeight kiP6WidthRace(30)

static CGFloat sectionHeaderHeight = 40.0;

@interface TransactionRecordsVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,SelectTypeViewDelegate>



@property (nonatomic, strong) SelectTypeView *selectView;

@property (nonatomic, strong) UIButton * m_rightBtn;

@property (nonatomic, strong) UIControl *m_boardView;

@property (strong ,nonatomic) NSMutableArray *m_dataArray;

@property (strong ,nonatomic) NSMutableArray *m_dataTitleArray;

@property (assign ,nonatomic) NSInteger index;

@property (assign ,nonatomic) NSInteger m_page;
@property (strong ,nonatomic)UIImage *imageNoData;


@end

@implementation TransactionRecordsVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"交易记录";
    
    [self.view addSubview:self.tableView];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.m_rightBtn];//隐藏筛选按钮
    
//    [self orderGetDetailTypeData];
    
    self.m_page = 1;
    
    [self acquisitionRecordData:0 page:1];
    
    PigMJRefreshGifHeader *header = [PigMJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_header = header;
    self.imageNoData = [UIImage imageNamed:@"notrade_image"];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;

}

//筛选数据源
- (void)orderGetDetailTypeData
{
    kSelfWeak;
    [TransactionRecordsModel orderGetDetailTypePath:orderGetDetailType params:nil target:self success:^(TransactionRecordsListModel *model) {
        if (model.code == 200) {
            [self.m_dataArray removeAllObjects];
            if (model.list && [model.list isKindOfClass:[NSArray class]]) {
                [weakSelf.m_dataTitleArray addObjectsFromArray:model.list];
            }
            [weakSelf.tableView reloadData];
            
        }else
        {
            [[ZXAlertView shareView] showMessage:model.msg?:@""];
        }
    } failure:^(NSError *error) {
        [[ZXAlertView shareView] showMessage:@"网络异常"];

    }];
}

//交易记录数据源
- (void)acquisitionRecordData:(NSInteger)type page:(NSInteger)page{
    
    NSMutableDictionary *dic = (NSMutableDictionary *)@{@"token":[kUserMessageManager getUserToken],@"detail_type":@(type),@"page":@(page)};
    
    kSelfWeak;
    [CustomLoadingView showLoadingView:weakSelf.view];
    
    [TransactionRecordsModel acquisitionRecordPath:detailList params:dic target:self success:^(TransactionRecordsListModel *model) {
        [CustomLoadingView hiddenLoadingView:weakSelf.view];
        if (self.m_page == 1) {
            [weakSelf.m_dataArray removeAllObjects];
        }
        if (model.code == 200) {
            [weakSelf changeNetData:model];
        }else
        {
            [[ZXAlertView shareView]showMessage:model.msg];
        }
        [weakSelf.tableView.mj_header endRefreshing];
        
        
    } failure:^(NSError *error) {
        
        [CustomLoadingView hiddenLoadingView:weakSelf.view];
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
}

//设置加载完后数据的重新组织
-(void)changeNetData:(TransactionRecordsListModel *)model
{
    NSInteger totalCount = [model.total integerValue];
    NSInteger count = 0;
    //遍历所有的数组
    if (self.m_dataArray.count > 0) {
        for (TransactionListDataModel *model in self.m_dataArray) {
            count += model.list.count;
        }
    }
    NSString *lastTime = nil;//最后的时间
    if (self.m_dataArray.count != 0) {
        TransactionListDataModel *lastModel = self.m_dataArray.lastObject;
        lastTime = lastModel.c_group_time;
    }
    if (model.list && [model.list isKindOfClass:[NSArray class]]) {
        for (TransactionListDataModel *modelList in model.list) {
            
            count += [ChangeNullData(modelList.count) integerValue];
            if ( StringHasDataJudge(lastTime) && [lastTime isEqualToString:ChangeNullData(modelList.c_group_time)] && self.m_dataArray.count > 0) {
                TransactionListDataModel *lastModel1 = self.m_dataArray.lastObject;
                NSMutableArray *array = [NSMutableArray arrayWithArray:lastModel1.list];
                [array addObjectsFromArray:modelList.list];
                lastModel1.list = array;
            }else
            {
                [self.m_dataArray addObject:modelList];
            }
        }
    }
    [self.tableView reloadData];
    
    
    self.tableView.mj_footer.hidden = NO;
    kSelfWeak;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
    if (self.m_dataArray.count >= totalCount) {
        
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }else
    {
        [self.tableView.mj_footer resetNoMoreData];
    }
}

#pragma make --- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.m_dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    TransactionListDataModel *listModel = [self.m_dataArray objectAtIndex:section];
    if (listModel.list && [listModel.list isKindOfClass:[NSArray class]]) {
        return listModel.list.count;
    }else
    {
        return 0;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TransactionRecordsCell *cell = [TransactionRecordsCell creatCellWithTableView:tableView];
    cell.backgroundColor = [UIColor whiteColor];
    TransactionListDataModel *listModel = [self.m_dataArray objectAtIndex:indexPath.section];
    TransactionDetailsListDataModel *model = [listModel.list objectAtIndex:indexPath.row];
    [cell setupCellContentWithModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kiP6WidthRace(110);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 37;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kCellHeadHeight)];
    headView.backgroundColor = UIColorRGB(242, 242, 242);
    
    TransactionListDataModel *listModel = [self.m_dataArray objectAtIndex:section];
    
    UILabel *timeLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, listModel.c_group_time, kFontSize12, kColorRoughness, NO);
    
    [headView addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headView).insets(UIEdgeInsetsMake(0, kiP6WidthRace(15), 1, kiP6WidthRace(15)));
    }];
    
    //    UIView *lineView = [[UIView alloc]init];
    //    lineView.backgroundColor = UIColorRGB(203, 203, 203);
    //    [headView addSubview:lineView];
    //    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(timeLabel.mas_bottom);
    //        make.left.equalTo(headView);
    //        make.right.equalTo(headView);
    //        make.height.mas_equalTo(1);
    //    }];
    return headView;
}

#pragma 私有事件

- (void)loadData
{
    [self acquisitionRecordData:self.index page:self.m_page];
}
- (void)loadMoreData
{
    self.m_page += 1;
    [self acquisitionRecordData:self.index page:self.m_page];
}

#pragma mark -- delegate
- (void)selectItem:(NSInteger)index
{
    self.index = index;
    self.m_page = 1;
    TransactionListDataModel *model = self.m_dataTitleArray[index];
    [self acquisitionRecordData:[model.value integerValue] page:self.m_page];
    [self showSelect];
}

- (void)dismissView {
    
}

#pragma getter

-(NSMutableArray *)m_dataArray
{
    if (!_m_dataArray)
    {
        _m_dataArray = [[NSMutableArray alloc] init];
    }
    return _m_dataArray;
}

-(NSMutableArray *)m_dataTitleArray
{
    if (!_m_dataTitleArray)
    {
        _m_dataTitleArray = [[NSMutableArray alloc] init];
    }
    return _m_dataTitleArray;
}

- (SelectTypeView *)selectView {
    
    NSMutableArray *titles = [NSMutableArray array];
    
    [_m_dataTitleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TransactionListDataModel *model = obj;
        [titles addObject:model.name];
    }];
    
    
    double height = AutoWHGetHeight(40.0) + AutoWHGetHeight(40.0) * ceil(titles.count / 3.0) + kiP6WidthRace(10) * (ceil(titles.count / 3.0) - 1);
    
    if (!_selectView) {
        _selectView = [[SelectTypeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height) title:titles selectNum:-1];
        _selectView.delegate = self;
    }
    return _selectView;
}

- (UITableView *)tableView{
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
        _tableView.mj_header.hidden = NO;
        
    }
    return _tableView;
}

- (UIButton *)m_rightBtn {
    if (!_m_rightBtn) {
        _m_rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_m_rightBtn setFrame:CGRectMake(0, 0, 50, 40)];
        [_m_rightBtn normalTitle:@"筛选"];
        [_m_rightBtn selectTitle:@"收起"];
        [_m_rightBtn normalTitleColor:kColorBlue];
        _m_rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_m_rightBtn addTarget:self action:@selector(showSelect) forControlEvents:UIControlEventTouchUpInside];
    }
    return _m_rightBtn;
}

#pragma mark -- 展示/隐藏 选择类型View
- (void)showSelect
{
    self.m_rightBtn.selected = !self.m_rightBtn.selected;
    if (self.m_rightBtn.selected) {
        self.title = @"筛选";
        self.m_boardView.hidden = NO;
    }else{
        self.m_boardView.hidden = YES;
        //        _m_boardView = nil;
        //        self.selectView.delegate = nil;
        //        _selectView = nil;
        self.title = @"交易记录";
    }
}

- (UIControl *)m_boardView {
    if (!_m_boardView) {
        _m_boardView = [[UIControl alloc] initWithFrame:self.view.bounds];
        _m_boardView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        [_m_boardView addTarget:self action:@selector(showSelect) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.m_boardView];
        [self.m_boardView addSubview:self.selectView];
        
    }
    return _m_boardView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    if (!_isFirstload) {
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y> 0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else{
        if(scrollView.contentOffset.y >= sectionHeaderHeight){
            
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(@0);
            make.left.right.mas_equalTo(@0);
            make.bottom.mas_equalTo(@-0);
        }];
    }
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
    return self.imageNoData;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -(self.imageNoData.size.height/2);
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    DLog(@"----refresh-----");
//    [self acquisitionRecordData:self.index page:self.m_page];
}


@end

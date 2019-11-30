//
//  TZProductScreenConditionVC.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/5.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#define KCondtionView_H 40

#import "TZProductScreenConditionVC.h"
#import "ProductItemViewModel.h"
#import "TZProductScreenConditionItemCell.h"
#import "TZProductScreenConditionModel.h"
#import "QZConditionFilterView.h"
#import "TZProductScreenConditionProvinceModel.h"


@interface TZProductScreenConditionVC ()<UITableViewDelegate,UITableViewDataSource>
// 顶部view
@property (nonatomic, strong) QZConditionFilterView *conditionFilterView;
// *存储* 网络请求url中的筛选项 数据来源：View中_dataSource1或者一开始手动的初值
@property (nonatomic, strong) NSArray *selectedDataSource1Ary;
@property (nonatomic, strong) NSArray *selectedDataSource2Ary;
@property (nonatomic, strong) NSArray *selectedDataSource3Ary;
@property (nonatomic, strong) NSArray *selectedDataSource4Ary;
@property (nonatomic, strong) NSArray *provinceArr; // 身份数据

@property (strong ,nonatomic) UITableView *m_tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) NSInteger page;


@end


@implementation TZProductScreenConditionVC

- (void)backToSuperView{
    [_conditionFilterView.filterTableView3.textField resignFirstResponder];
    [_conditionFilterView dismiss];
    _conditionFilterView = nil;
    [_conditionFilterView removeFromSuperview];
    [super backToSuperView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    self.title = @"全部贷款";
    
    [self initWithUI];
    [self bindSignal];
    
    [self postdataUrl];
    
}
- (void)refreshData{
    [self getOfflineInfoPathUrl];

}
- (void)postdataUrl{
    [self getOfflineInfoPathUrl];
    // 贷款日期
    [self postConditonDateUrl];
    //塞选按钮数据
    [self postgetScreeningConditionsUrl];
}


- (void)bindSignal{
    @weakify(self)
    [self.m_tableView registerNibString:NSStringFromClass([TZProductScreenConditionItemCell class]) cellIndentifier:TZProductScreenConditionItemCell_ID];
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
    [self addTopCondtionView];
}


- (void)addTopCondtionView{
    // 设置初次加载显示的默认数据
    _selectedDataSource1Ary = @[@"不限地区"];
    _selectedDataSource2Ary = @[@"不限期限"];
    _selectedDataSource3Ary = @[@"不限金额"];
    _selectedDataSource4Ary = @[@"筛选"];
    
    @weakify(self)
    _conditionFilterView = [QZConditionFilterView conditionFilterViewWithFilterBlock:^(BOOL isFilter, NSArray *dataSource1Ary, NSArray *dataSource2Ary, NSArray *dataSource3Ary ,NSArray *dataSource4Ary) {
        @strongify(self)
        if (isFilter) {
            //网络加载请求 存储请求参数
            self.selectedDataSource1Ary = dataSource1Ary;
            self.selectedDataSource2Ary = dataSource2Ary;
            self.selectedDataSource3Ary = dataSource3Ary;
            self.selectedDataSource4Ary = dataSource4Ary;
            
        }
        [self startRequest];
    }];
    
    _conditionFilterView.backLeverTwoArrTapAction = ^(NSInteger index) {
        @strongify(self)
        TZProvinceModel *models =  [self.provinceArr objectAtIndex:index];
        
    };
    
    // 传入数据源，对应三个tableView顺序
    //    _conditionFilterView.dataAry2 = @[@"不限期限",@"3个月",@"6个月",@"12个月",@"2年",@"3年",@"5年",@"10年"];
//    _conditionFilterView.dataAry3 = @[@"3-1",@"3-2",@"3-3",@"3-4",@"3-5"];

    
    // 初次设置默认显示数据，内部会调用block 进行第一次数据加载
    [_conditionFilterView bindChoseArrayDataSource1:_selectedDataSource1Ary DataSource2:_selectedDataSource2Ary DataSource3:_selectedDataSource3Ary DataSource4:_selectedDataSource4Ary];
    
    [self.view addSubview:_conditionFilterView];
}

- (void)startRequest
{
    
    NSString *source1 = [NSString stringWithFormat:@"%@",_selectedDataSource1Ary.firstObject];
    NSString *source2 = [NSString stringWithFormat:@"%@",_selectedDataSource2Ary.firstObject];
    NSString *source3 = [NSString stringWithFormat:@"%@",_selectedDataSource3Ary.firstObject];
    NSDictionary *dic = [_conditionFilterView keyValueDic];
    // 可以用字符串在dic换成对应英文key
    
    NSLog(@"\n第一个条件:%@\n  第二个条件:%@\n  第三个条件:%@\n",source1,source2,source3);
    
    self.page = 1;
    [self getOfflineInfoPathUrl];
    
    
}






// 贷款 筛选条件
- (void)postgetScreeningConditionsUrl{
    @weakify(self)
    [ProductItemViewModel conditionPath:API_getScreeningConditions_path params:nil target:self modelClass:[TZProductScreenConditionDateModel class] success:^(id  _Nonnull model) {
        @strongify(self)
        TZProductScreenConditionDateModel *models = (TZProductScreenConditionDateModel *)model;
       self.conditionFilterView.condiTionListModel = models;
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


// 添加用户点击产品信息 统计
- (void)postSaveProductClickUrlWithIndexModel:(TZProductOfflineInfoModel*)model{
    @weakify(self)
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(2) forKey:@"equipment"];//1安卓，2ios，3web
    [params setObject:model.proId forKey:@"pid"];//产品id
    [params setObject:model.title forKey:@"pname"];//产品名
    [params setObject:@(2) forKey:@"ptype"];//产品类型1:线上，2:线下
    [params setObject:[kUserMessageManager getUserId] forKey:@"uid"];//用户ID

    
    [ProductItemViewModel getOfflineInfoPath:API_saveProductClick_path params:params target:self success:^(TZProductScreenConditionModel * _Nonnull model) {
        
    } failure:^(NSError * _Nonnull error) {
   
        
    }];
}
// 贷款周期筛选条件
- (void)postConditonDateUrl{
    @weakify(self)
    [ProductItemViewModel conditionPath:API_getTerm_path params:nil target:self modelClass:[TZProductScreenConditionDateModel class] success:^(id  _Nonnull model) {
        @strongify(self)
        NSMutableArray *arr = [NSMutableArray array];
        TZProductScreenConditionDateModel *models = (TZProductScreenConditionDateModel *)model;
        [models.list enumerateObjectsUsingBlock:^(TZLoanDataModel  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arr addObject:obj.dictValue];
        }];
        self.conditionFilterView.dataAry2 = arr;
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


// 线下产品大全
- (void)getOfflineInfoPathUrl{
    @weakify(self)
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.page) forKey:@"pageNo"];
    
    [ProductItemViewModel getOfflineInfoPath:API_getOfflineInfo_path params:params target:self success:^(TZProductScreenConditionModel * _Nonnull model) {
        @strongify(self)
        if (self.page == 1) {
            self.dataArr = [[NSMutableArray alloc] initWithArray:model.list];
        }else{
            if (model.list.count == 0) {
                [self.m_tableView.mj_footer endRefreshingWithNoMoreData];
                return ;
            }else{
                [self.dataArr addObjectsFromArray:model.list];
            }
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
    return 90;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    @weakify(self)
    TZProductScreenConditionItemCell *cell = [tableView dequeueReusableCellWithIdentifier:TZProductScreenConditionItemCell_ID forIndexPath:indexPath];
    cell.model = [self.dataArr objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TZProductOfflineInfoModel *model = [self.dataArr objectAtIndex:indexPath.row];
    
    NSString *phone = [kUserMessageManager getMessageManagerForObjectWithKey:USER_MOBILE];
    
    NSString *strName =  [[NSString stringWithFormat:@"phoneNumber=%@&productInfo=off%@",phone,model.proId] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@?%@",WAP_PHONEURL,THTML_essentialInfo_api,strName];
    
    [self postSaveProductClickUrlWithIndexModel:model];
    [self PushToBaseWebViewControllerUrl:urlStr andTitle:@"智能匹配"];
    
}


#pragma mark -UI
- (UITableView *)m_tableView{
    if (!_m_tableView) {//UITableViewStyleGrouped
        _m_tableView = InsertTableView(nil, CGRectMake(0, KCondtionView_H, kScreenWidth, CGRectGetHeight(self.view.frame) - KCondtionView_H), self, self, UITableViewStylePlain, UITableViewCellSeparatorStyleSingleLine);
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
    targetVC.isShowBackView = YES;
    [self.navigationController pushViewController:targetVC animated:YES];
}

-(void)dealloc{
    [_conditionFilterView dismiss];
    _conditionFilterView = nil;
}
@end

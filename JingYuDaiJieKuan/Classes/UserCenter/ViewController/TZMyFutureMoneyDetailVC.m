//
//  TZMyFutureMoneyDetailVC.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/30.
//  Copyright © 2019 Jincaishen. All rights reserved.
//
#define KName_Cell    @"产品名"
#define KContent_cell @"产品详情"
#define KComment_Cell @"产品评价"
#import "TZMyFutureMoneyDetailVC.h"
#import "TZMyFutureMoneyDetailNameCell.h"
#import "TZMyFutureMoneyDetailContentCell.h"
#import "TZMyFutureMoneyDetailCommentCell.h"

@interface TZMyFutureMoneyDetailVC ()<UITableViewDataSource,UITableViewDelegate,StarSLiderDelegate>
@property (strong ,nonatomic) UITableView *m_tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation TZMyFutureMoneyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"贷款详情";
    
    
    [self initWithUI];
    [self bindSignal];
    
    [self refreshData];
    
}
- (void)dealloc{
    [[NAAssetsManager shareManager] reset];
    
}
- (void)refreshData{
    [self posthomeLastAllPathUrl];
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        NSArray *arr = @[KName_Cell,
                         m_blankCellReuseId,
                         KContent_cell,
//                         m_blankCellReuseId,
                         KComment_Cell];
        _dataArr = [NSMutableArray arrayWithArray:arr];
    }
    return _dataArr;
}

- (void)bindSignal{

    @weakify(self)
    [self.m_tableView registerNibString:NSStringFromClass([TZMyFutureMoneyDetailNameCell class]) cellIndentifier:TZMyFutureMoneyDetailNameCell_ID];
    [self.m_tableView registerNibString:NSStringFromClass([TZMyFutureMoneyDetailContentCell class]) cellIndentifier:TZMyFutureMoneyDetailContentCell_ID];
    [self.m_tableView registerNibString:NSStringFromClass([TZMyFutureMoneyDetailCommentCell class]) cellIndentifier:TZMyFutureMoneyDetailCommentCell_ID];

    
//    AXRatingView *stepRatingView = [[AXRatingView alloc] initWithFrame:nextFrame()];
//    [stepRatingView sizeToFit];
//    [stepRatingView setStepInterval:1.0];
//    [self.view addSubview:stepRatingView];
    
}

- (void)initWithUI{
    [self.view addSubview:self.m_tableView];
    [self.view addBottomTapButtonTitleStr:@"提交" block:^(UIButton *btn) {
        
    }];
}

// 线上极速贷款 数据
- (void)posthomeLastAllPathUrl{
    @weakify(self)
    //    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    [params setObject:@(self.page) forKey:@"pageNo"];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = [self.dataArr objectAtIndex:indexPath.row];
    if ([title isEqualToString:KName_Cell]) {
        return 71;
    }else if ([title isEqualToString:KContent_cell]){
        return 123;
    }else if ([title isEqualToString:KComment_Cell]){
        return 240;
    }
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = [self.dataArr objectAtIndex:indexPath.row];
    if ([title isEqualToString:KName_Cell]) {
        TZMyFutureMoneyDetailNameCell *cell = [tableView dequeueReusableCellWithIdentifier:TZMyFutureMoneyDetailNameCell_ID forIndexPath:indexPath];
        return cell;
    }else if ([title isEqualToString:KContent_cell]){
        TZMyFutureMoneyDetailContentCell *cell = [tableView dequeueReusableCellWithIdentifier:TZMyFutureMoneyDetailContentCell_ID forIndexPath:indexPath];
        [cell setInsetWithLeftAndRight:15];
        return cell;
    }else if ([title isEqualToString:KComment_Cell]){
        TZMyFutureMoneyDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:TZMyFutureMoneyDetailCommentCell_ID forIndexPath:indexPath];
        return cell;
    }
    return [UITableViewCell blankCell];
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
        
    }
    return _m_tableView;
}






@end

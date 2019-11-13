//
//  CouponsVC.m
//  JingYuDaiJieKuan
//
//  Created by air on 2018/3/27.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "CouponsVC.h"
#import "CouponsView.h"
#import "CouponsCell.h"
#import "CardVoucherModel.h"
#import "UseTheProductVC.h"
@interface CouponsVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *titleArray;
}

@property (nonatomic ,strong)UIView *headView;
@property (nonatomic ,strong)CouponsView *m_couponsView;

@property (nonatomic ,strong)UITableView *m_tableView;
@property (nonatomic ,strong)NSMutableArray *dataArray;

@end

@implementation CouponsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的优惠券";
    self.view.backgroundColor = kColorLightgrayBackground;
    
//    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kiP6WidthRace(45))];
//    self.headView.backgroundColor = kColorWhite;
//    self.m_tableView.tableHeaderView = self.headView;
    [self.view addSubview:self.m_tableView];

    [self initView];
    [self initData];
}

- (void)initView{
//    titleArray = @[@"现金券"];
//    _m_couponsView = [[CouponsView alloc] initWithNameAry:titleArray];
//    [_headView addSubview:self.m_couponsView];
//    [_m_couponsView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(_headView);
//    }];
    
}

- (void)initData
{
    kSelfWeak;
    NSMutableDictionary *dic = (NSMutableDictionary *)@{@"token":[kUserMessageManager getUserToken],@"coupon_type":@"1",@"page":@"1"};
    [CustomLoadingView hiddenLoadingView:self.view];
    [CardVoucherModel cardVoucherListPath:cardVoucherList params:dic target:self success:^(CardVoucherListModel *model) {
        if (model.code == 200) {
            if (model.list &&[model.list isKindOfClass:[NSArray class]]) {
                
                [weakSelf.dataArray addObjectsFromArray:model.list];
            }
            [weakSelf.m_tableView reloadData];
        }
        [CustomLoadingView hiddenLoadingView:weakSelf.view];
    } failure:^(NSError *error) {
        [CustomLoadingView hiddenLoadingView:weakSelf.view];

    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CouponsCell *cell = [CouponsCell creatCellWithTableView:tableView];
    CardVoucherListDataModel *model  = [self.dataArray objectAtIndex:indexPath.section];
    [cell setupCellContentWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count > 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        UseTheProductVC *vc = [[UseTheProductVC alloc]init];
        CardVoucherListDataModel *model = self.dataArray[indexPath.section];
        vc.projectid = model.couponid ?:@"";
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KWidth(100);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return KWidth(10);
}
- (UITableView *)m_tableView{
    if (!_m_tableView) {
        _m_tableView = InsertTableView(nil, CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.view.frame)), self, self, UITableViewStylePlain, UITableViewCellSeparatorStyleSingleLine);
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
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



@end

//
//  TZProductLineFrontDetailVC.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2020/1/12.
//  Copyright © 2020 Jincaishen. All rights reserved.
//

#define KPostMoneyNumb @"额度范围:"
#define KSurplus_Product @"今日申请名额已抢"
#define KPostProduct_flow_title @"贷款流程"
#define KPostProduct_flow_cell @"贷款流程cell"
#define KPice_explain_title @"费用说明"
#define KPice_explain_cell @"费用说明cell"
#define KReturn_explain_title @"还款说明"
#define KReturn_explain_cell @"还款说明cell"


#import "TZProductLineFrontDetailVC.h"
#import "TZProductBottomMenuView.h"
#import "TZProductLineFrontDetailPostMoneyNumbCell.h" // 1
#import "TZUserEditChooseCell.h" // 标题
#import "TZProductLineFrontDetailSurplusCell.h" // 今日申请名额已抢
#import "TZProductLineFrontDetailFlowCell.h" // 贷款流程


@interface TZProductLineFrontDetailVC ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) TZProductBottomMenuView *bottomView;
@property (strong ,nonatomic) UITableView *m_tableView;
@property (nonatomic, strong) NSArray *viewArr;

@end

@implementation TZProductLineFrontDetailVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewArr = @[KPostMoneyNumb,
                     KSurplus_Product,
                     KPostProduct_flow_title,
                     KPostProduct_flow_cell,
//                     KPice_explain_title,
//                     KPice_explain_cell,
                     KReturn_explain_title,
                     KReturn_explain_cell
    ];
    
    [self initWithUI];
    [self bindSignal];
    
    [self refreshData];
    
}
- (void)refreshData{
    [self posthomeLastAllPathUrl];
}


- (void)bindSignal{
    
    // 额度范围:
    [self.m_tableView registerNibString:NSStringFromClass([TZProductLineFrontDetailPostMoneyNumbCell class]) cellIndentifier:TZProductLineFrontDetailPostMoneyNumbCell_ID];
    // 标题
    [self.m_tableView registerNibString:NSStringFromClass([TZUserEditChooseCell class]) cellIndentifier:TZUserEditChooseCell_ID];
    
    // 今日申请名额已抢
    [self.m_tableView registerNibString:NSStringFromClass([TZProductLineFrontDetailSurplusCell class]) cellIndentifier:TZProductLineFrontDetailSurplusCell_ID];
    
    // 贷款流程
    [self.m_tableView registerNibString:NSStringFromClass([TZProductLineFrontDetailFlowCell class]) cellIndentifier:TZProductLineFrontDetailFlowCell_ID];
    
}

- (void)initWithUI{
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.m_tableView];
    self.m_tableView.bottom = self.bottomView.top;
}

// 添加用户点击产品信息 统计
//- (void)postSaveProductClickUrlWithIndexModel:(TZProductBankModel*)model{
//    @weakify(self)
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setValue:@(2) forKey:@"equipment"];//1安卓，2ios，3web
//    [params setValue:model.merchartid forKey:@"pid"];//产品id
//    [params setValue:model.name forKey:@"pname"];//产品名
//    [params setValue:@(1) forKey:@"ptype"];//产品类型1:线上，2:线下
//    [params setValue:aUser.userId forKey:@"uid"];//用户ID


//    [ProductItemViewModel homeLastAllPath:API_saveProductClick_path params:params target:self success:^(TZProductPageModel * _Nonnull model) {
//        @strongify(self)
//        [self postCheckProductUrlWithDict:params];
//    } failure:^(NSError * _Nonnull error) {
//        [self postCheckProductUrlWithDict:params];
//    }];
//}

- (void)postCheckProductUrlWithDict:(NSDictionary *)params{
    //    [ProductItemViewModel homeLastAllPath:API_checkProduct_path params:params target:self success:^(TZProductPageModel * _Nonnull model) {
    //    } failure:^(NSError * _Nonnull error) {
    //    }];
    
}




// 线上极速贷款 数据
- (void)posthomeLastAllPathUrl{
    @weakify(self)
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = [self.viewArr objectAtIndex:indexPath.row];
    if ([title isEqualToString:KPostMoneyNumb]) {
        return 188;
    }else if ([title isEqualToString:KSurplus_Product]){
        return 86;
    }else if ([title isEqualToString:KPostProduct_flow_title] ||
              [title isEqualToString:KPice_explain_title] ||
              [title isEqualToString:KReturn_explain_title]){
        return 44;
    }else if ([title isEqualToString:KPostProduct_flow_cell]){
        return 64;
    }else if ([title isEqualToString:KPice_explain_cell]){
        return 82;
    }else if ([title isEqualToString:KReturn_explain_cell]){
        return 218;
    }
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    @weakify(self)
    NSString *title = [self.viewArr objectAtIndex:indexPath.row];
    if ([title isEqualToString:KPostMoneyNumb]) {
        TZProductLineFrontDetailPostMoneyNumbCell *cell = [tableView dequeueReusableCellWithIdentifier:TZProductLineFrontDetailPostMoneyNumbCell_ID forIndexPath:indexPath];
        return cell;
        
    }else if ([title isEqualToString:KSurplus_Product]){
        TZProductLineFrontDetailSurplusCell *cell = [tableView dequeueReusableCellWithIdentifier:TZProductLineFrontDetailSurplusCell_ID forIndexPath:indexPath];
        [cell setSurplusValue];
        return cell;
        
    }else if ([title isEqualToString:KPostProduct_flow_title] ||
              [title isEqualToString:KPice_explain_title] ||
              [title isEqualToString:KReturn_explain_title]){
        TZUserEditChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:TZUserEditChooseCell_ID forIndexPath:indexPath];
        cell.mainTitleLabel.text = title;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }else if ([title isEqualToString:KPostProduct_flow_cell]){
        TZProductLineFrontDetailFlowCell *cell = [tableView dequeueReusableCellWithIdentifier:TZProductLineFrontDetailFlowCell_ID forIndexPath:indexPath];
        return cell;
        
    }else if ([title isEqualToString:KPice_explain_cell]){
        return [UITableViewCell blankCell];
    }else if ([title isEqualToString:KReturn_explain_cell]){
        return [UITableViewCell blankCell];
    }
    
    return [UITableViewCell blankCell];
}



#pragma mark -UI
- (TZProductBottomMenuView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[TZProductBottomMenuView alloc] init];
        _bottomView.frame = CGRectMake(0, kScreenHeight-kNavBarH -56-iPhoneXDiffHeight()*2, kScreenWidth, 44+iPhoneXDiffHeight()*2);
    }
    return _bottomView;
}


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


@end

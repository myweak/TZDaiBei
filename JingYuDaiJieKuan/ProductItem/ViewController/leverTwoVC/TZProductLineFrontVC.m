//
//  TZProductLineFrontVC.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/2.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZProductLineFrontVC.h"
#import "TZProductLineFrontItemCell.h"
#import "ProductItemViewModel.h"
@interface TZProductLineFrontVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong ,nonatomic) UITableView *m_tableView;
@property (nonatomic, assign) NSInteger page;
@end

@implementation TZProductLineFrontVC

- (void)viewDidLoad {
    [super viewDidLoad];

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
    [self.m_tableView registerNibString:NSStringFromClass([TZProductLineFrontItemCell class]) cellIndentifier:TZProductLineFrontItemCell_ID];
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

// 添加用户点击产品信息 统计
- (void)postSaveProductClickUrlWithIndexModel:(TZProductBankModel*)model{
    @weakify(self)
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(2) forKey:@"equipment"];//1安卓，2ios，3web
    [params setValue:model.merchartid forKey:@"pid"];//产品id
    [params setValue:model.name forKey:@"pname"];//产品名
    [params setValue:@(1) forKey:@"ptype"];//产品类型1:线上，2:线下
    [params setValue:aUser.userId forKey:@"uid"];//用户ID
    
    
    [ProductItemViewModel homeLastAllPath:API_saveProductClick_path params:params target:self success:^(TZProductPageModel * _Nonnull model) {
        @strongify(self)
        [self postCheckProductUrlWithDict:params];
    } failure:^(NSError * _Nonnull error) {
        [self postCheckProductUrlWithDict:params];
    }];
    
}
- (void)postCheckProductUrlWithDict:(NSDictionary *)params{
    [ProductItemViewModel homeLastAllPath:API_checkProduct_path params:params target:self success:^(TZProductPageModel * _Nonnull model) {
    } failure:^(NSError * _Nonnull error) {
    }];
}




// 线上极速贷款 数据
- (void)posthomeLastAllPathUrl{
    @weakify(self)
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(self.page) forKey:@"pageNo"];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",API_homeLastAll_path,@(self.page)];
    
    [ProductItemViewModel homeLastAllPath:urlStr params:nil target:self success:^(TZProductPageModel * _Nonnull model) {
        @strongify(self)
        if (self.page == 1) {
            self.dataArr = [[NSMutableArray alloc] initWithArray:model.bankList];
        }else{
            if (model.bankList.count == 0) {
                [self.m_tableView.mj_footer endRefreshingWithNoMoreData];
                return ;
            }else{
                [self.dataArr addObjectsFromArray:model.bankList];
            }
        }
        
        if([TZUserDefaults getBoolValueInUDWithKey:KCheck_app]){
            NSMutableArray *arr = [NSMutableArray array];
            [self.dataArr enumerateObjectsUsingBlock:^(TZProductBankModel  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.name containsString:@"银行"] || [obj.name containsString:@"帒呗"]) {
                    [arr addObject:obj];
                }
            }];
            [self.dataArr removeObjectsInArray:arr];
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
    return 115;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 44)];
    label.text= @"产品列表";
    label.font = kFontSize14;
    label.textColor = CP_ColorMBlack;
    [view addSubview:label];
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    @weakify(self)
    TZProductLineFrontItemCell *cell = [tableView dequeueReusableCellWithIdentifier:TZProductLineFrontItemCell_ID forIndexPath:indexPath];
    TZProductBankModel *model = [self.dataArr objectAtIndex:indexPath.row];
    cell.model = model;
    cell.backTapBtnActionBlock = ^(UIButton * _Nonnull btn) {
     @strongify(self)
//        [self PushToBaseWebViewControllerUrl:model.url andTitle:model.name];
    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TZProductBankModel *model = [self.dataArr objectAtIndex:indexPath.row];
    if (model.productType.integerValue == 2) {
        showMessage(@"申请人数已满，请申请其他产品");
        return;
    }else if(model.productType.integerValue == 3) {
        NSString *phone = aUser.mobile;

             NSString *strName =  [[NSString stringWithFormat:@"phoneNumber=%@&productInfo=on%@",phone,model.merchartid] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

             NSString *urlStr = [NSString stringWithFormat:@"%@%@?%@",WAP_PHONEURL,THTML_essentialInfo_api,strName];
        [self postSaveProductClickUrlWithIndexModel:model];
        [self PushToBaseWebViewControllerUrl:urlStr andTitle:model.name];
        return;
    }
    [self postSaveProductClickUrlWithIndexModel:model];
    [self PushToBaseWebViewControllerUrl:model.url andTitle:model.name];

}


#pragma mark -UI
- (UITableView *)m_tableView{
    if (!_m_tableView) {//UITableViewStyleGrouped
        _m_tableView = InsertTableView(nil, CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.view.frame)), self, self, UITableViewStyleGrouped, UITableViewCellSeparatorStyleSingleLine);
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

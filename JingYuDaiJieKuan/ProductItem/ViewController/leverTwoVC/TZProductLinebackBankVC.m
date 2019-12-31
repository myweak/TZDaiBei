//
//  TZProductLinebackBankVC.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/2.
//  Copyright © 2019 Jincaishen. All rights reserved.
//
#define KSpeed_title        @"快速通道"
#define KSpeed_cell         @"快速通道cell"
#define KFlow_title         @"办理流程"
#define KFlow_cell          @"办理流程cell"
#define KDevelop_title      @"经营模式"
#define KDevelop_cell       @"经营模式cell"
#define KMianProduct_title  @"主推产品"
#define KMianProduct_cell  @"主推产品cell"

#import "TZProductLinebackBankVC.h"
#import "TZProductLinebackBankHeadView.h"
#import "TZProductLinebackBankFlowView.h"
#import "TZUserEditChooseCell.h"
#import "TZProductLinebackBankSpeedItemView.h" // 快速通道 item
#import "TZProductScreenConditionVC.h"  // 商品塞选页
#import "TZProductLinebackBankDevelopView.h"
#import "TZProductScreenConditionItemCell.h" // 主推产品
#import "TZProductScreenConditionVC.h"
#import "TZProductScreenConditionItemView.h"
#import "ProductItemViewModel.h"

@interface TZProductLinebackBankVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong ,nonatomic) UITableView *m_tableView;
@property (nonatomic, strong) TZProductLinebackBankHeadView *headView;
@property (nonatomic, strong) TZProductLinebackBankFlowView * flowView;
@property (nonatomic, strong) TZProductLinebackBankDevelopView *developView;
@property (nonatomic, strong) UIView *speedView; // 快速通道
@property (nonatomic, strong) NSMutableArray *dataViewArr;
@property (nonatomic, strong) TZProductScreenConditionView *mianProductView;
@end

@implementation TZProductLinebackBankVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithUI];
    [self bindSignal];
    [self postdataUrl];
}

- (void)initWithUI{
    @weakify(self)
    [self.view addSubview:self.m_tableView];
}
- (void)bindSignal{
    @weakify(self)
    [self.headView handleTap:^(CGPoint loc, UIGestureRecognizer *tapGesture) {
        @strongify(self)
        if (loc.x<235 || loc.y<100) {
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self)
                if (self.headView.moneyTextField.isFirstResponder) {
                    [self.headView.moneyTextField resignFirstResponder];
                }else{
                    [self.headView.moneyTextField becomeFirstResponder];
                }
            });
        }
    }];
    self.m_tableView.tableHeaderView = self.headView;
    [self.m_tableView registerNibString:NSStringFromClass([TZUserEditChooseCell class]) cellIndentifier:TZUserEditChooseCell_ID];

    self.headView.backBtnTapAction = ^(UIButton * _Nonnull btn) {
        @strongify(self)
        if (checkStrEmty(self.headView.moneyTextField.text)) {
            showMessage(@"请输入您需要贷款的金额");
            return ;
        }
        if ([self.headView.moneyTextField.text floatValue]<100) {
            showMessage(@"线下贷款申请办理不能低于100元");
            return ;
        }
        NSLog(@"贷款金额：%@",self.headView.moneyTextField.text);
        
        NSString *phone = aUser.mobile;
        
        NSString *strName =  [[NSString stringWithFormat:@"phoneNumber=%@&loanAmount=%@",phone,self.headView.moneyTextField.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString *urlStr = [NSString stringWithFormat:@"%@%@?%@",WAP_PHONEURL,THTML_essentialInfo_api,strName];
        
        [self PushToBaseWebViewControllerUrl:urlStr andTitle:@"智能匹配"];
        
    };
}



- (NSMutableArray *)dataViewArr{
    if (!_dataViewArr) {
        NSArray *array = @[
            KFlow_title,
            KFlow_cell,
            KSpeed_title,
            KSpeed_cell,
            m_blankCellReuseId,
            KDevelop_title,
            KDevelop_cell,
            m_blankCellReuseId,
            KMianProduct_title,
            KMianProduct_cell,
        ];
        _dataViewArr = [[NSMutableArray alloc] initWithArray:array];
    }
    return _dataViewArr;
}

- (void)resignTextFieldFirstResponder{
    if (self.headView.moneyTextField.isFirstResponder) {
        [self.headView.moneyTextField resignFirstResponder];
    }
}

- (void)postdataUrl{
    [self getOfflineRecommendPathUrl];
}

#pragma mark - postUrl

// 主推产品
- (void)getOfflineRecommendPathUrl{
    @weakify(self)
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(100) forKey:@"pageSize"];
    [ProductItemViewModel getOfflineInfoPath:API_getOfflineRecommend_path params:params target:self success:^(TZProductScreenConditionModel * _Nonnull model) {
        @strongify(self)
        [self.mianProductView setTZProductScreenConditionItemViewWithArray:model.list];
        [self.m_tableView reloadData];
    } failure:^(NSError * _Nonnull error) {

    }];
}


// 添加用户点击产品信息 统计
- (void)postSaveProductClickUrlWithIndexModel:(TZProductOfflineInfoModel*)model{
    @weakify(self)
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(2) forKey:@"equipment"];//1安卓，2ios，3web
    [params setValue:model.proId forKey:@"pid"];//产品id
    [params setValue:model.title forKey:@"pname"];//产品名
    [params setValue:@(2) forKey:@"ptype"];//产品类型1:线上，2:线下
    [params setValue:[kUserMessageManager getUserId] forKey:@"uid"];//用户ID
    
    
    [ProductItemViewModel getOfflineInfoPath:API_saveProductClick_path params:params target:self success:^(TZProductScreenConditionModel * _Nonnull model) {
        
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id titleV = [self.dataViewArr objectAtIndex:indexPath.row];
    if ([titleV isEqualToString:KSpeed_title] ||
        [titleV isEqualToString:KFlow_title] ||
        [titleV isEqualToString:KMianProduct_title] ||
        [titleV isEqualToString:KDevelop_title]
        ) {
        return 44;
    }else if ([titleV isEqualToString:KSpeed_cell]) {
        return self.speedView.height;
    }else if ([titleV isEqualToString:KFlow_cell]) {
        return self.flowView.height;
    }else if ([titleV isEqualToString:KDevelop_cell]) {
        return self.developView.height;
    }else if ([titleV isEqualToString:KMianProduct_cell]) {
        return self.mianProductView.height;
    }
    
    return 10;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataViewArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    @weakify(self)
    NSString  *titleV = [self.dataViewArr objectAtIndex:indexPath.row];
    
    if ([titleV isEqualToString:KSpeed_title] ||
        [titleV isEqualToString:KFlow_title] ||
        [titleV isEqualToString:KMianProduct_title] ||
        [titleV isEqualToString:KDevelop_title]
        ) {
        TZUserEditChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:TZUserEditChooseCell_ID forIndexPath:indexPath];
        cell.mainTitleLabel.text = titleV;
        cell.backgroundColor = [UIColor whiteColor];
        if ([titleV isEqualToString:KFlow_title]) {
            cell.backgroundColor = [UIColor clearColor];
        }
        return cell;
        
    }else if ([titleV isEqualToString:KSpeed_cell]) {
        UITableViewCell *cell = [UITableViewCell blankWhiteCellWithID:titleV];
        cell.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:self.speedView];
        return cell;
    }else if ([titleV isEqualToString:KFlow_cell]) {
        UITableViewCell *cell = [UITableViewCell blankWhiteCellWithID:titleV];
        [cell.contentView addSubview:self.flowView];
        return cell;
    }else if ([titleV isEqualToString:KDevelop_cell]) {
        UITableViewCell *cell = [UITableViewCell blankWhiteCellWithID:titleV];
        [cell.contentView addSubview:self.developView];
        return cell;
    }else if ([titleV isEqualToString:KMianProduct_cell]) {
        UITableViewCell *cell = [UITableViewCell blankWhiteCellWithID:titleV];
        [cell.contentView addSubview:self.mianProductView];
        return cell;
    }
    return [UITableViewCell blankWhiteCell];
    
}




#pragma mark - UI

- (TZProductScreenConditionView *)mianProductView{
    if (!_mianProductView) {
        @weakify(self)
        _mianProductView = [[TZProductScreenConditionView alloc] initWithFrame:CGRectZero];
        _mianProductView.backItemTapAction = ^(TZProductOfflineInfoModel * _Nonnull model) {
         @strongify(self)
            NSString *phone = aUser.mobile;
            
            NSString *strName =  [[NSString stringWithFormat:@"phoneNumber=%@&productInfo=off%@",phone,model.proId] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSString *urlStr = [NSString stringWithFormat:@"%@%@?%@",WAP_PHONEURL,THTML_essentialInfo_api,strName];
            
            [self postSaveProductClickUrlWithIndexModel:model];
            [self PushToBaseWebViewControllerUrl:urlStr andTitle:@"智能匹配"];
        };
    }
    return _mianProductView;
}

- (TZProductLinebackBankDevelopView *)developView{
    if (!_developView) {
        _developView = [[TZProductLinebackBankDevelopView alloc] init];
        _developView.height = 100;
    }
    return _developView;
}

- (UIView *)speedView{
    if (!_speedView) {
        @weakify(self)
        _speedView  = InsertView(nil, CGRectMake(0, 0, kScreenWidth, 136), [UIColor clearColor]);
        [TZProductLinebackBankSpeedItemView  addBankSpeedItemViewWithAddSuperView:_speedView andTapIndexBlock:^(NSInteger index) {
            @strongify(self)
            [self pushToTZProductScreenConditionVC];
        }];
    }
    return _speedView;
}



- (TZProductLinebackBankFlowView *)flowView{
    if (!_flowView) {
        _flowView = [[TZProductLinebackBankFlowView alloc] init];
        _flowView.frame = CGRectMake(0, 0, kScreenWidth, 146);
        _flowView.backgroundColor = kColorLightgrayBackground;
    }
    return _flowView;
}

- (TZProductLinebackBankHeadView *)headView{
    if (!_headView) {
        _headView = [[TZProductLinebackBankHeadView alloc]init];
        _headView.frame = CGRectMake(0, 0, kScreenWidth, 200);
    }
    return _headView;
}

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
        _m_tableView.backgroundColor = [UIColor whiteColor];
        _m_tableView.separatorStyle = UITableViewCellAccessoryNone;
        
    }
    return _m_tableView;
}

#pragma mark - push VC
// web
- (void)PushToBaseWebViewControllerUrl:(NSString *)urlStr andTitle:(NSString *)title{
    [self resignTextFieldFirstResponder];
    if (checkStrEmty(urlStr)) {
        return;
    }
    BaseWebViewController *targetVC = [[BaseWebViewController alloc]init];
    targetVC.url = urlStr;
    targetVC.navigationItem.title = title;
    targetVC.isShowBackView = YES;
    [self.navigationController pushViewController:targetVC animated:YES];
}

// 塞选页
- (void)pushToTZProductScreenConditionVC{
    TZProductScreenConditionVC *conditonVc = [TZProductScreenConditionVC new];
    [self.navigationController pushViewController:conditonVc animated:YES];
}

@end

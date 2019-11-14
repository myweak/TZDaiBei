//
//  TZProductLinebackBankVC.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/2.
//  Copyright © 2019 Jincaishen. All rights reserved.
//
#define KSpeed_title     @"快速通道"
#define KSpeed_cell      @"快速通道cell"
#define KFlow_title      @"办理流程"
#define KFlow_cell       @"办理流程cell"
#define KDevelop_title      @"经营模式"
#define KDevelop_cell       @"经营模式cell"
#import "TZProductLinebackBankVC.h"
#import "TZProductLinebackBankHeadView.h"
#import "TZProductLinebackBankFlowView.h"
#import "TZUserEditChooseCell.h"
#import "TZProductLinebackBankSpeedItemView.h" // 快速通道 item
#import "TZProductScreenConditionVC.h"  // 商品塞选页
#import "TZProductLinebackBankDevelopView.h"


@interface TZProductLinebackBankVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong ,nonatomic) UITableView *m_tableView;
@property (nonatomic, strong) TZProductLinebackBankHeadView *headView;
@property (nonatomic, strong) TZProductLinebackBankFlowView * flowView;
@property (nonatomic, strong) TZProductLinebackBankDevelopView *developView;
@property (nonatomic, strong) UIView *speedView; // 快速通道
@property (nonatomic, strong) NSMutableArray *dataViewArr;
@end

@implementation TZProductLinebackBankVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithUI];
    [self bindSignal];
}

- (void)initWithUI{
    [self.view addSubview:self.m_tableView];
}
- (void)bindSignal{
    @weakify(self)
    self.m_tableView.tableHeaderView = self.headView;
    [self.m_tableView registerNibString:NSStringFromClass([TZUserEditChooseCell class]) cellIndentifier:TZUserEditChooseCell_ID];
    
    self.headView.backBtnTapAction = ^(UIButton * _Nonnull btn) {
        @strongify(self)

        NSLog(@"贷款金额：%@",self.headView.moneyTextField.text);
        
        if (!checkStrEmty(self.headView.moneyTextField.text)) {
            NSString *phone = [kUserMessageManager getMessageManagerForObjectWithKey:USER_MOBILE];

            NSString *strName =  [[NSString stringWithFormat:@"phoneNumber=%@&loanAmount=%@",phone,self.headView.moneyTextField.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            NSString *urlStr = [NSString stringWithFormat:@"%@%@?%@",SERVER_URL,THTML_essentialInfo_api,strName];
            
            [self PushToBaseWebViewControllerUrl:urlStr andTitle:@"智能匹配"];
        }
    };
}



- (NSMutableArray *)dataViewArr{
    if (!_dataViewArr) {
        NSArray *array = @[
                           KSpeed_title,
                           KSpeed_cell,
                           m_blankCellReuseId,
                           KDevelop_title,
                           KDevelop_cell,
                           m_blankCellReuseId,
                           KFlow_title,
                           KFlow_cell,
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



#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id titleV = [self.dataViewArr objectAtIndex:indexPath.row];
    if ([titleV isEqualToString:KSpeed_title] ||
        [titleV isEqualToString:KFlow_title] ||
        [titleV isEqualToString:KDevelop_title]
        ) {
        return 44;
    }else if ([titleV isEqualToString:KSpeed_cell]) {
        return self.speedView.height;
    }else if ([titleV isEqualToString:KFlow_cell]) {
        return self.flowView.height;
    }else if ([titleV isEqualToString:KDevelop_cell]) {
        return self.developView.height;
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
        [titleV isEqualToString:KDevelop_title]
        ) {
        TZUserEditChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:TZUserEditChooseCell_ID forIndexPath:indexPath];
        cell.mainTitleLabel.text = titleV;
        cell.backgroundColor = [UIColor whiteColor];
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
    }
    
    
    return [UITableViewCell blankWhiteCell];
    
}




#pragma mark - UI

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
    [self.navigationController pushViewController:targetVC animated:YES];
}

// 塞选页
- (void)pushToTZProductScreenConditionVC{
    TZProductScreenConditionVC *conditonVc = [TZProductScreenConditionVC new];
    [self.navigationController pushViewController:conditonVc animated:YES];
}

@end

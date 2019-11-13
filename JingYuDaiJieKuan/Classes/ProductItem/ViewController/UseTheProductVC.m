//
//  UseTheProductVC.m
//  JingYuDaiJieKuan
//
//  Created by air on 2018/4/10.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "UseTheProductVC.h"
#import "ProductListCell.h"
#import "UIFactory.h"
#import "CardVoucherModel.h"
@interface UseTheProductVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (strong ,nonatomic) NSMutableArray *m_dataArray;
@property (strong ,nonatomic) UIView *headView;
@property (strong ,nonatomic) UILabel *labelBtn;

@end

@implementation UseTheProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"使用产品";
    self.view.backgroundColor = kColorLightgrayBackground;
    [self.view addSubview:self.tableView];
    

    [self initView];

    [self initData];

    
}

- (void)initView{
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kiP6WidthRace(35))];
    self.headView.backgroundColor = UIColorRGB(247, 247, 248);
    self.tableView.tableHeaderView = self.headView;
    [self.headView addSubview:self.labelBtn];

//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kiP6WidthRace(15), 0, kScreenWidth, kiP6WidthRace(35))];
//    label.text =@"以下产品可使用该券";
//    label.font = kFontSize13;
//    [self.headView addSubview:label];
    
    [self.labelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(15));
        make.top.mas_equalTo(kiP6WidthRace(0));
        make.width.mas_equalTo(kScreenWidth );
        make.height.mas_equalTo(kiP6WidthRace(35));
    }];
    
}

- (void)initData{
    
    kSelfWeak;
    NSMutableDictionary *dic = (NSMutableDictionary *)@{@"token":[kUserMessageManager getUserToken],@"page":@"1",@"couponid":self.projectid};
    [CustomLoadingView showLoadingView:self.view];
    [CardVoucherModel useTheProductPath:useTheProduct params:dic target:self success:^(CardVoucherListModel *model) {
        if (model.code == 200) {
            if (model.list && [model.list isKindOfClass:[NSArray class]]) {
                [weakSelf.m_dataArray addObjectsFromArray:model.list];
            }
            [weakSelf.tableView reloadData];
            
        }
        [CustomLoadingView hiddenLoadingView:weakSelf.view];

    } failure:^(NSError *error) {
        [CustomLoadingView hiddenLoadingView:weakSelf.view];

    }];
    
    
}
#pragma 私有事件

- (void)loadData
{
    //    [self acquisitionRecordData:self.index page:self.m_page];
}
- (void)loadMoreData
{
//    self.m_page += 1;
    //    [self acquisitionRecordData:self.index page:self.m_page];
}

#pragma mark -- delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.m_dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KWidth(160);
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductListCell *cell = [ProductListCell creatCellWithTableView:tableView];
    CardVoucherListDataModel *model = self.m_dataArray[indexPath.row];
    [cell useTheProductModel:model];
//
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0.01;
    }else{
        return 10;
    }
    return KWidth(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma Click

- (void)investmentCell:(ProductListCell *)cell investmentId:(NSString *)investmentID{
    // 招标中点击方法
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

- (UILabel *)labelBtn{
    if (!_labelBtn) {
        _labelBtn = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"以下产品可使用该券", kFontSize13, kColorRed, NO);
    }
    return _labelBtn;
}

@end

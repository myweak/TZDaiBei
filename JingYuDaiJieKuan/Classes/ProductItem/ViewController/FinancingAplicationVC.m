//
//  FinancingAplicationVC.m
//  JingYuDaiJieKuan
//
//  Created by JY on 2018/8/10.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "FinancingAplicationVC.h"
#import "AddBankCardTableViewCell.h"
#import "RegularRollInBottomView.h"
#import "AuditStateVC.h"
@interface FinancingAplicationVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * m_tableView;

@property (nonatomic, strong) NSMutableArray *m_titleArray;

@property (nonatomic, strong) NSMutableArray *m_rightArray;

@property (nonatomic,strong)NSMutableDictionary *commitInfoDic;

@property (nonatomic, strong) UIView *m_footView;

@property (nonatomic, strong) RegularRollInBottomView * m_bottomView;


@end

@implementation FinancingAplicationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"融资申请";
    
    [self initUIView];
}

#pragma initView
- (void)initUIView{
    
    [self.view addSubview:self.m_tableView];

    self.m_bottomView = [[RegularRollInBottomView alloc]init];
    [self.m_footView addSubview:self.m_bottomView];
    ViewRadius(self.m_bottomView,kiP6WidthRace(48/2));
    self.m_bottomView.layer.masksToBounds = YES;
    self.m_tableView.tableFooterView = self.m_footView;
    
    [self.m_bottomView.m_rollInBtn addTarget:self action:@selector(setPasswordData) forControlEvents:UIControlEventTouchUpInside];
    [self.m_bottomView.m_rollInBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    
    [self makeConstraints];
}

- (void)makeConstraints{
    
    [self.m_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.m_footView.mas_top).offset(kiP6WidthRace(76));
        make.left.equalTo(self.view).offset(kiP6WidthRace(42));
        make.right.equalTo(self.view).offset(-kiP6WidthRace(42));
        make.height.mas_equalTo(kiP6WidthRace(48));
    }];
}

#pragma data

#pragma click

- (void)setPasswordData{
    
    AuditStateVC *vc = [[AuditStateVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)textFiledEditChang
{
    NSString *smallMoney = [self.commitInfoDic objectForKey:@"smallMoney"];
    NSString *mobile = [self.commitInfoDic objectForKey:@"mobile"];
    // 判断不为空 不为 nil
    if (([smallMoney isValid]) &&
        mobile.length ==11 && [smallMoney integerValue] >=1000 && [mobile isMobile])
    {
        self.m_bottomView.m_rollInBtn.backgroundColor = kColorBlue;
        self.m_bottomView.m_rollInBtn.userInteractionEnabled = YES;
        
    }else
    {
        self.m_bottomView.m_rollInBtn.backgroundColor = kColorSeparatorline;
        self.m_bottomView.m_rollInBtn.userInteractionEnabled = NO;
    }
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KWidth(50);
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddBankCardTableViewCell *cell = [AddBankCardTableViewCell addBankCellWithTableView:tableView indexPath:indexPath];
    cell.m_titleLabel.text = self.m_titleArray[indexPath.row];
    cell.m_editorTextField.placeholder = self.m_rightArray[indexPath.row];
    if (indexPath.row ==0) {
        cell.m_editorTextField.tag = 2012;
    }else{
        cell.m_editorTextField.tag = 2004;
    }
    
    
    cell.infoDic = self.commitInfoDic;
    cell.m_editorTextField.secureTextEntry = NO;
    cell.m_editorTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    kSelfWeak;
    cell.getInfoBlock = ^(NSMutableDictionary *dic) {
        [weakSelf textFiledEditChang];
    };
    [cell modifyitleLabelWidth];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return KWidth(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return KWidth(0.000001f);
}


#pragma getter

- (UITableView *)m_tableView
{
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

-(NSMutableDictionary *)commitInfoDic
{
    if (!_commitInfoDic) {
        _commitInfoDic = [NSMutableDictionary dictionary];
    }
    return _commitInfoDic;
}

-(NSMutableArray *)m_titleArray
{
    if (!_m_titleArray) {
        _m_titleArray = [NSMutableArray arrayWithObjects:@"期望借款金额",@"合作商手机号", nil];
    }
    return _m_titleArray;
}

-(NSMutableArray *)m_rightArray
{
    if (!_m_rightArray) {
        _m_rightArray = [NSMutableArray arrayWithObjects:@"借款金额不得超过20万",@"请输入合作商手机号", nil];
    }
    return _m_rightArray;
}

- (UIView *)m_footView
{
    if (!_m_footView) {
        
        _m_footView = InsertView(nil, CGRectMake(0, 0, kScreenWidth, kiP6WidthRace(120)), kColorClear);
    }
    return _m_footView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

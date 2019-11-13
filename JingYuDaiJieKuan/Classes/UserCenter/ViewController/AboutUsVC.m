//
//  AboutUsVC.m
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/7/3.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "AboutUsVC.h"
#import "AboutUsCell.h"
#import "MyProfileCell.h"
#import "UserViewModel.h"


@interface AboutUsVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *m_tableView;
@property (nonatomic ,strong) UIView *m_headView;
@property (nonatomic ,strong) UIImageView *m_iconImage;
@property (nonatomic ,strong) UILabel *m_nameLabel; //公司名称
@property (nonatomic ,strong) UILabel *m_companyNameLabel;//公司介绍
@property (nonatomic ,strong) UILabel *m_companyContentLabel; //公司内容
@property (nonatomic ,strong) UILabel *m_businessCooperationLabel; //商务合作

@property (nonatomic ,strong) UILabel *m_copyrightLabel; //版权

@property (nonatomic ,strong) UIView *m_footView;
@property (nonatomic ,strong) NSMutableArray *m_abontUsArray;
@property (nonatomic ,strong) NSString *m_businessCooperation;

@end

@implementation AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
    

    [self aboutUsInfoData];
    
    [self initView];
}

- (void)initView{
    
    [self.view addSubview:self.m_tableView];
    
    self.m_tableView.tableHeaderView = self.m_headView;
    
    self.m_tableView.tableFooterView = self.m_footView;
    
    [self.m_headView addSubview:self.m_iconImage];

    [self.m_headView addSubview:self.m_nameLabel];

    [self.m_headView addSubview:self.m_companyNameLabel];

    [self.m_headView addSubview:self.m_companyContentLabel];

    [self.m_headView addSubview:self.m_businessCooperationLabel];
    
    [self.m_footView addSubview:self.m_copyrightLabel];
    
    [self.m_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(kiP6WidthRace(116/2));
        make.width.height.mas_equalTo(kiP6WidthRace(80));
    }];
    
    [self.m_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.m_iconImage.mas_bottom).offset(kiP6WidthRace(14));
    }];
    
    [self.m_companyNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.m_nameLabel.mas_bottom).offset(kiP6WidthRace(72));
    }];
    
    [self.m_companyContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(24));
        make.top.mas_equalTo(self.m_companyNameLabel.mas_bottom).offset(kiP6WidthRace(22));
        make.width.mas_equalTo(kScreenWidth - kiP6WidthRace(48));
    }];
    
    [self.m_businessCooperationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.m_companyContentLabel.mas_bottom).offset(kiP6WidthRace(52));
    }];
    
    [self.m_copyrightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(kiP6WidthRace(20));
        make.bottom.equalTo(self.m_footView);
    }];
}

- (void)aboutUsInfoData
{
    
    NSString *path = [NSString stringWithFormat:@"%@%@/",aboutUsInfo,[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]];
    [UserViewModel aboutUsInfoPath:path params:nil target:self success:^(UserModel *model) {
        if (model.code == 200) {
            self.m_businessCooperation = model.businessCooperation;
            self.m_businessCooperation = [self.m_businessCooperation stringByReplacingOccurrencesOfString:@":"withString:@"\n"];
            if (self.m_businessCooperation != nil) {
                NSString*string =[NSString stringWithFormat:@"%@",self.m_businessCooperation];
                NSArray *array = [string componentsSeparatedByString:@","];//从字符A中分隔成2个元素的数组
                [self.m_abontUsArray addObjectsFromArray:array];
            }
            
            self.m_companyContentLabel.text = model.conpanyIntro;
            self.m_copyrightLabel.text = model.copyright;
        }
        [self.m_tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
#pragma  mark  UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_abontUsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kiP6WidthRace(55);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AboutUsCell *cell = [AboutUsCell creatCellWithTableView:tableView];
    cell.accessoryType=UITableViewCellAccessoryNone;
    
    cell.m_cooperationName.text = self.m_abontUsArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma getter
- (UITableView *)m_tableView
{
    if (!_m_tableView) {
        _m_tableView = InsertTableView(nil, CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.view.frame)), self, self, UITableViewStylePlain, UITableViewCellSeparatorStyleNone);
        _m_tableView.backgroundColor = [UIColor whiteColor];
        if (kIsPhoneX) {
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


- (UIView *)m_headView
{
    if (!_m_headView) {
        _m_headView = InsertView(nil, CGRectMake(0, 0, kScreenWidth, kiP6WidthRace(430)), [UIColor whiteColor]);
    }
    return _m_headView;
}

- (UIImageView *)m_iconImage
{
    if (!_m_iconImage) {
        _m_iconImage  = InsertImageView(nil, CGRectZero, [UIImage imageNamed:@"user_icon"]);

    }
    return _m_iconImage;
}

- (UILabel *)m_nameLabel
{
    if (!_m_nameLabel) {
        
        _m_nameLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, [NSString getMyApplicationName], KFont(15), UIColorHex(@"#303030"), NO);
    }
    return _m_nameLabel;
}

- (UILabel *)m_companyNameLabel
{
    if (!_m_companyNameLabel) {
        _m_companyNameLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"公司简介", KFont(15), UIColorHex(@"#303030"), NO);
    }
    return _m_companyNameLabel;
}

- (UILabel *)m_companyContentLabel
{
    if (!_m_companyContentLabel) {
        _m_companyContentLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"公司简介公司简介公司简介公司简介公司简介公司简介公司简介公司简介公司简介公司简介公司简介公司简介公司简介公司简介", KFont(14), UIColorHex(@"#6c6c6c"), NO);
        _m_companyContentLabel.numberOfLines = 0;
    }
    return _m_companyContentLabel;
}

- (UILabel *)m_businessCooperationLabel
{
    if (!_m_businessCooperationLabel) {
        _m_businessCooperationLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"商务合作", KFont(15), UIColorHex(@"#303030"), NO);
    }
    return _m_businessCooperationLabel;
}

- (UILabel *)m_copyrightLabel
{
    if (!_m_copyrightLabel) {
        _m_copyrightLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"版权所有: 厦门雨霖网络科技有限公司", KFont(12), UIColorHex(@"#b2b2b2"), NO);
    }
    return _m_copyrightLabel;
}

- (UIView *)m_footView
{
    if (!_m_footView) {
        _m_footView = InsertView(nil, CGRectMake(0, 0, kScreenWidth, kiP6WidthRace(100)), [UIColor whiteColor]);
    }
    return _m_footView;
}

- (NSMutableArray *)m_abontUsArray
{
    if (!_m_abontUsArray) {
        _m_abontUsArray = [[NSMutableArray alloc] init];
    }
    return _m_abontUsArray;
}
@end

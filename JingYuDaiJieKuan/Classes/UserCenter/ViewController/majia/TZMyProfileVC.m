//
//  TZMyProfileVC.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/10/31.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#define KemailNotify @"选填，填写QQ邮箱审批更快";

#import "TZMyProfileVC.h"
#import "TZMineRowCell.h"
#import "TZEditUserTextFiedldVC.h" //个人信息 填写
#import "TZUserEditChooseVC.h" //
#import "LoginKeyInputViewModel.h"

@interface TZMyProfileVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong ,nonatomic) UITableView *m_tableView;
@property (strong ,nonatomic) NSArray *titleArr;

@end

@implementation TZMyProfileVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人信息";
    
    [self initWithUI];
    [self setNavBar];
    [self bindSignal];
    [self refreshData];
    
}

- (NSArray *)titleArr{
    return @[@"个人手机",
             @"邮箱地址",
             @"性别",
             @"教育程度",
    ];
}
- (void)setNavBar{
//    /user/getPersonalInfo
}

- (void)bindSignal{
    
}

-(void)initWithUI
{
    [self.view addSubview:self.m_tableView];
    
}


- (void)refreshData{
    [self getPersonalInfoUrl];
}

- (void)getPersonalInfoUrl{
    [LoginKeyInputViewModel userLoginPath:API_getPersonalInfo_path params:nil target:self success:^(LoginModel *model) {
            if (model.code == 200) {
                ///为保持用户的实时数据更新，需要重新赋值缓存和内存
              
                kUserMessageManager.userId = model.userId;
                [kUserMessageManager setMessageManagerForObjectWithKey:KEY_USER_ID value:model.userId];
                [kUserMessageManager setMessageManagerForObjectWithKey:KEY_USER_EMail value:model.mailbox];
                [kUserMessageManager setMessageManagerForObjectWithKey:KEY_USER_GENDER value:model.gender];
                [kUserMessageManager setMessageManagerForObjectWithKey:KEY_USER_EDUCATION value:model.education];
                
            }else{
                [[ZXAlertView shareView] showMessage:model.msg?:@""];
            }
        [self.m_tableView reloadData];
        } failure:^(NSError *error) {
            [[ZXAlertView shareView] showMessage:kloadfailedNotNetwork];
        }];
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
        [_m_tableView registerNibString:NSStringFromClass([TZMineRowCell class]) cellIndentifier:TZMineRowCellID];
        
        _m_tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
    }
    return _m_tableView;
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//返回头分组标题高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.titleArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TZMineRowCell *cell = [tableView dequeueReusableCellWithIdentifier:TZMineRowCellID forIndexPath:indexPath];
    
    NSString *title = self.titleArr[indexPath.row] ;
    [cell showIconImageView:NO] ;
    cell.mianTitleLabel.text = title;
    
    if ([title isEqualToString: @"个人手机"]) {
        NSString *phone = [kUserMessageManager getMessageManagerForObjectWithKey:USER_MOBILE];
        cell.rightSubLabel.text = phone;
        cell.moreImageView.hidden = YES;
        
    }else  if ([title isEqualToString: @"邮箱地址"]) {
        NSString *eMail = [kUserMessageManager getMessageManagerForObjectWithKey:KEY_USER_EMail];
        cell.rightSubLabel.text = checkStrEmty(eMail) ?@"填写QQ邮箱审批更快":eMail;
    }else  if ([title isEqualToString: @"性别"]) {
        NSString *gender = [kUserMessageManager getMessageManagerForObjectWithKey:KEY_USER_GENDER];
        cell.rightSubLabel.text = checkStrEmty(gender) ?@" 未填写":gender;
        
    }else  if ([title isEqualToString: @"教育程度"]) {
        NSString *edu = [kUserMessageManager getMessageManagerForObjectWithKey:KEY_USER_EDUCATION];
        cell.rightSubLabel.text = checkStrEmty(edu) ?@" 未填写":edu;
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = self.titleArr[indexPath.row] ;
    if ([title isEqualToString: @"个人手机"]) {
    }else  if ([title isEqualToString: @"邮箱地址"]) {
        TZEditUserTextFiedldVC *editVc = [TZEditUserTextFiedldVC new];
        editVc.title = @"邮箱设置";
        editVc.type = TZEditUserTextFiedldVCType_eMail;
        @weakify(self)
        editVc.saveSuccessBlock = ^(NSString * _Nonnull saveStr) {
            @strongify(self)
            [self.m_tableView reloadData];
        };
        [self.navigationController pushViewController:editVc animated:YES];
        
    }else  if ([title isEqualToString: @"性别"]) {
        TZUserEditChooseVC *editVc = [TZUserEditChooseVC new];
        editVc.title = @"性别设置";
        editVc.type = TZUserEditChooseVCType_gender;
        @weakify(self)
        editVc.saveSuccessBlock = ^(NSString * _Nonnull saveStr) {
            @strongify(self)
            [self.m_tableView reloadData];
        };
        [self.navigationController pushViewController:editVc animated:YES];
        
    }else  if ([title isEqualToString: @"教育程度"]) {
        TZUserEditChooseVC *editVc = [TZUserEditChooseVC new];
        editVc.title = @"学历设置";
        editVc.type = TZUserEditChooseVCType_education;
        @weakify(self)
        editVc.saveSuccessBlock = ^(NSString * _Nonnull saveStr) {
            @strongify(self)
            [self.m_tableView reloadData];
        };
        [self.navigationController pushViewController:editVc animated:YES];
        
    }
}
@end

//
//  MyProfileVC.m
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/7/3.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "MyProfileVC.h"
#import "MyProfileCell.h"
#import "UserViewModel.h"
#import "LoginVC.h"
#import "AboutUsVC.h"
#import "ModifyTheNicknameVC.h"
#import "UserViewModel.h"
#import "JingYuDaiJieKuan-Swift.h"
#import "CustomAlertView.h"
#import "LoginKeyInputViewModel.h"

@interface MyProfileVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *m_tableView;
@property (nonatomic, strong) UIView *m_footView;
@property (nonatomic, strong) UIButton *m_safetyExitBtn;

@end

@implementation MyProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资料";
    
    [self initView];

}


- (void)initView
{
    [self.view addSubview:self.m_tableView];
    self.m_tableView.tableFooterView = self.m_footView;
    [self.m_footView addSubview:self.m_safetyExitBtn];
    
    [self.m_safetyExitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(kiP6WidthRace(10));
        make.height.mas_equalTo(kiP6WidthRace(53));
    }];
}

//    /user/logout   用户退出登录接口
- (void)userLogoutData
{
    CustomAlertView *alertView = [CustomAlertView initNewStyleOneContent_TwoBtnPushWithAddInSuper:kAlertwindow Content:@"您确定要退出登录吗?" LeftBtnTitle:@"取消" RightBtnTitle:@"确认" clickBlock:^(NSInteger type) {
        if (type == 1) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            NSString *token = [kUserMessageManager getMessageManagerForObjectWithKey:KEY_USER_TOKEN];
            [params setObject:token?:@"" forKey:@"token"];
            [params setObject:token?:@"" forKey:@"channel"];
            [params setObject:token?:@"" forKey:@"clientType"];
            [params setObject:token?:kApp_Version forKey:@"version"];
            [UserViewModel userLogoutPath:userLogout params:params target:self success:^(UserModel *model) {
                if (model.code == 200) {
                    [kUserMessageManager removeDataWhenLogout];
                    [kUserMessageManager checkUserLoginAndLoginWithEventkey:nil];
                }
                [self.m_tableView reloadData];
            } failure:^(NSError *error) {
                
            }];
        }
    }];
    [alertView showInWindowWithView:self.navigationController.view];
}
#pragma  mark  UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kiP6WidthRace(63);
}

//返回头分组标题高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyProfileCell *cell = [MyProfileCell creatCellWithTableView:tableView];
    NSString *headImage = [kUserMessageManager getMessageManagerForObjectWithKey:KEY_HEAD_PORTRAIT];
    NSString *name = [kUserMessageManager getMessageManagerForObjectWithKey:KEY_NICK_NAME];
    NSString *phone = [kUserMessageManager getMessageManagerForObjectWithKey:USER_MOBILE];
    
    NSArray *firstArray = @[@"头像",@"昵称",@"账号"];
    NSArray *secondarray = @[@"检查更新",@"关于我们"];
    if (indexPath.section == 0) {
        cell.m_leftLabel.text = firstArray[indexPath.row];
        if (indexPath.row == 0) {
            cell.m_rightLabel.hidden = YES;
            cell.m_rightImage.hidden = NO;
            NSString *headImage = [kUserMessageManager getMessageManagerForObjectWithKey:KEY_HEAD_PORTRAIT];
            [cell.m_rightImage sd_setImageWithURL:[NSURL URLWithString:headImage]];

            cell.accessoryType=UITableViewCellAccessoryNone;
        }else if (indexPath.row == 1){
            cell.m_rightLabel.hidden = NO;
            cell.m_rightImage.hidden = YES;
            cell.m_rightLabel.text = name;
        }else{
            cell.accessoryType=UITableViewCellAccessoryNone;
            cell.m_rightLabel.hidden = NO;
            cell.m_rightImage.hidden = YES;
            cell.m_rightLabel.text = phone;
        }
    }else{
        cell.m_leftLabel.text = secondarray[indexPath.row];
        if (indexPath.row == 0) {
            cell.m_rightLabel.hidden = NO;
            cell.m_rightImage.hidden = YES;
            
            cell.m_rightLabel.text = kApp_Version;
        }else{
            cell.m_rightLabel.hidden = YES;
            cell.m_rightImage.hidden = YES;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    kSelfWeak;
    NSString *position = @"";
    if (indexPath.section == 0) {
        if (indexPath.row == 0) { //点击头像
            position = @"头像";
        } else {}
        if (indexPath.row == 1) { //点击昵称
            ModifyTheNicknameVC *VC = [[ModifyTheNicknameVC alloc] init];
            VC.reloadDataBlock = ^{
                [weakSelf.m_tableView reloadData];
            };
            [self.navigationController pushViewController:VC animated:YES];
             position = @"昵称";
        }else{}
    }else{
        if (indexPath.row == 0) { //点击检查更新
            [self checkAppUpdate];
             position = @"检查更新";
        } else {}
        if (indexPath.row == 1) { //点击关于我们
            AboutUsVC *VC = [[AboutUsVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            position = @"关于我们";
        } else {}
    }
    
    //如果设置了位置,那么记录埋点
    if (![position isEqualToString:@""]) {
        [SensorsAnalyticsSDKHelper mySettingsEventWithPosition:position];
    }
}

#pragma mark - func
- (void)checkAppUpdate {
    [UserViewModel appUpdatePath:appUpdatePath params:nil target:nil success:^(AppUpdateModel *model) {
        if (model.code == 200) {
            switch (model.upgradeWay) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    ///获取建议升级的版本号
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    NSString *appVersion = [defaults objectForKey:@"appupdateVersion"];
                    if (model.dialogRepeat == 0) {
                        if (appVersion == nil) {
                            //第一次建议升级,需要弹框
                            
                        } else {break;}
                    } else if (model.dialogRepeat == 1) {
                        
                    }
                    
                    /// 保存建议升级的版本号
                    [defaults setObject:model.appV forKey:@"appupdateVersion"];
                    [defaults synchronize];
                    
                    AppUpdateAlertView *alert = [[AppUpdateAlertView alloc]initWithModel:model cancelClosure:nil sureUpdateClosure:^{
                        //跳转网页
                        [UIApplication.sharedApplication openURL:[NSURL URLWithString:model.url]];
                    }];
                    
                    [alert showAlertViewInViewController:self leftOrRightMargin:30];
                    break;
                }
                    
                case 2: //强制升级
                {
                    AppUpdateAlertView *alert = [[AppUpdateAlertView alloc]initWithModel:model cancelClosure:nil sureUpdateClosure:^{
                        //跳转网页
                        [UIApplication.sharedApplication openURL:[NSURL URLWithString:model.url]];
                    }];
                    
                    [alert showAlertViewInViewController:self leftOrRightMargin:30];
                    break;
                }
                case 3:
                    abort();
                    break;
                default:
                    break;
            }
        }
    } failure:^(NSError *error) {
        
    }];
    
}


#pragma getter

- (UITableView *)m_tableView
{
    if (!_m_tableView) {//UITableViewStyleGrouped
        _m_tableView = InsertTableView(nil, CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.view.frame)), self, self, UITableViewStylePlain, UITableViewCellSeparatorStyleSingleLine);
        
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

- (UIView *)m_footView
{
    if (!_m_footView) {
        _m_footView = InsertView(nil, CGRectMake(0, kiP6WidthRace(0), kScreenWidth, kiP6WidthRace(63)), UIColorRGB(240, 240, 240));
    }
    return _m_footView;
}

- (UIButton *)m_safetyExitBtn
{
    if (!_m_safetyExitBtn) {
        _m_safetyExitBtn = InsertButtonWithType(nil, CGRectZero, 100, self, @selector(safetyExitClick), UIButtonTypeCustom);
        [_m_safetyExitBtn setTitle:@"安全退出" forState:UIControlStateNormal];
        [_m_safetyExitBtn setTitleColor:UIColorHex(@"#333333")
                                forState:UIControlStateNormal];
        _m_safetyExitBtn.titleLabel.font = KFont(16);
        _m_safetyExitBtn.backgroundColor= [UIColor whiteColor];

    }
    return _m_safetyExitBtn;
}

- (void)safetyExitClick
{
    [SensorsAnalyticsSDKHelper mySettingsEventWithPosition:@"安全退出"];
    [self userLogoutData];
}
@end

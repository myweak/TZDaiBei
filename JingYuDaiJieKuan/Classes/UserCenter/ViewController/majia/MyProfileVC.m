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
#import "MyProfileUserInfoCell.h"

@interface MyProfileModel : NSObject
@property (nonatomic, copy) NSString *cellType;       //使用的cell类型
@property (nonatomic, assign) CGFloat cellH;            //使用的cell高度
@property (nonatomic, copy) NSString *leftInfo;        //左信息
@property (nonatomic, copy) NSString *rightInfo;        //右信息
@end

@implementation MyProfileModel
+ (instancetype)createWithCellType:(NSString *)cellType withCellHeight: (CGFloat)cellH withLeftInfo: (NSString *)leftInfo withRightInfo: (NSString *)rightInfo{
    MyProfileModel *model = [MyProfileModel new];
    model.cellType = cellType;
    model.cellH = cellH;
    model.leftInfo = leftInfo;
    model.rightInfo = rightInfo;
    return model;
}
@end
@interface MyProfileVC ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *dataArray;
}

@property (nonatomic, strong) UITableView *m_tableView;
@property (nonatomic, strong) UIView *m_footView;
@property (nonatomic, strong) UIButton *m_safetyExitBtn;

@end

@implementation MyProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资料";
//    self.view.backgroundColor = UIColorHex(@"#F7F8FA");

    
    dataArray = @[@[[MyProfileModel createWithCellType:@"MyProfileUserInfoCell" withCellHeight:98 withLeftInfo:@"" withRightInfo:@""]],
                  @[[MyProfileModel createWithCellType:@"MyProfileCell" withCellHeight:54 withLeftInfo:@"账号与名称" withRightInfo:@"修改名称"]],
                  @[[MyProfileModel createWithCellType:@"MyProfileCell" withCellHeight:54 withLeftInfo:@"检查更新" withRightInfo:kApp_Version],
                    [MyProfileModel createWithCellType:@"MyProfileCell" withCellHeight:54 withLeftInfo:@"关于我们" withRightInfo:@""]]];
    [self initView];
}

- (void)initView
{
    [self.view addSubview:self.m_tableView];
    self.m_tableView.tableFooterView = self.m_footView;
    [self.m_footView addSubview:self.m_safetyExitBtn];
    
    [self.m_safetyExitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(kiP6WidthRace(16));
        make.height.mas_equalTo(kiP6WidthRace(54));
    }];
}

//    /user/logout   用户退出登录接口
- (void)userLogoutData
{
    CustomAlertView *alertView = [CustomAlertView initNewStyleOneContent_TwoBtnPushWithAddInSuper:kAlertwindow Content:@"您确定要退出登录么？" LeftBtnTitle:@"取消" RightBtnTitle:@"确认" clickBlock:^(NSInteger type) {
        if (type == 1) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            NSString *token = aUser.token;
            [params setValue:token?:@"" forKey:@"token"];
            [params setValue:token?:@"" forKey:@"channel"];
            [params setValue:token?:@"" forKey:@"clientType"];
            [params setValue:token?:kApp_Version forKey:@"version"];
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
    [alertView.m_leftBtn setTitleColor:UIColorHex(@"#B3B7C1") forState:UIControlStateNormal];
    [alertView showInWindowWithView:self.navigationController.view];
}
#pragma  mark  UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return [dataArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyProfileModel *model = dataArray[indexPath.section][indexPath.row];
    return model.cellH;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = UIColor.clearColor;
    return view;
}

//返回头分组标题高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {return 0.01;}
    return 16;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyProfileModel *model = dataArray[indexPath.section][indexPath.row];
    
    if ([model.cellType isEqualToString:@"MyProfileUserInfoCell"]) {
        MyProfileUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:model.cellType forIndexPath:indexPath];
        NSString *phone = [kUserMessageManager getMessageManagerForObjectWithKey:USER_MOBILE];
        NSString *strLabel = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        cell.phoneLbl.text = strLabel;
        cell.wellcomeLbl.text = [NSString stringWithFormat:@"欢迎来到%@，快速下款，马上有钱花！", [NSString getMyApplicationName]];
        NSString *headImage = [kUserMessageManager getMessageManagerForObjectWithKey:KEY_HEAD_PORTRAIT];
        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:headImage]];
    
        return cell;
    } else {
        //显示其他样式的数据
        MyProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:model.cellType forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.m_leftLabel.text = model.leftInfo;
        cell.m_rightLabel.hidden = NO;
        cell.m_rightImage.hidden = YES;
        cell.m_rightLabel.text = model.rightInfo;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    kSelfWeak;
    NSString *position = @"";
    if (indexPath.section == 0) {
        if (indexPath.row == 0) { //点击头像
            position = @"头像";
        } else {}
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) { //点击昵称
            ModifyTheNicknameVC *VC = [[ModifyTheNicknameVC alloc] init];
            VC.reloadDataBlock = ^{
                [weakSelf.m_tableView reloadData];
            };
            [self.navigationController pushViewController:VC animated:YES];
            position = @"昵称";
        }else{}
    } else if (indexPath.section == 2) {
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
        
        _m_tableView.backgroundColor = UIColorHex(@"#F7F8FA");
        
        [_m_tableView registerClass:MyProfileUserInfoCell.self forCellReuseIdentifier:@"MyProfileUserInfoCell"];
        [_m_tableView registerClass:MyProfileCell.self forCellReuseIdentifier:@"MyProfileCell"];

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
        _m_footView = InsertView(nil, CGRectMake(0, kiP6WidthRace(0), kScreenWidth, kiP6WidthRace(63)), UIColor.clearColor);
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

//
//  TZMineVC.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/10/30.
//  Copyright © 2019 Jincaishen. All rights reserved.
//



#import "TZMineVC.h"
#import "TZMineRowCell.h"
#import "JingYuDaiJieKuan-Swift.h"
#import "TZMyProfileVC.h"  // 个人信息
#import "TZShowAlertView.h"
#import "TZShowWeiXinAndQQView.h"
#import "TZMineHeaderCardView.h"
#import "TZMyFutureMoneyListVC.h" // d贷款订单列表

@interface TZMineVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong ,nonatomic) UITableView *m_tableView;
@property (strong ,nonatomic) NSArray *titleArr;
@property (strong ,nonatomic) NSArray *iconArr;

@property (strong ,nonatomic) TZShowWeiXinAndQQView *weiXinOrQQView;
@property (nonatomic, strong) TZMineHeaderCardView *headerCardView;
@end

@implementation TZMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWithUI];
    [self setNavBar];
    [self bindSignal];
    
}
- (NSArray *)iconArr{
    return @[
             @[@"per_icon_pi",
               @"per_icon_pri",
               @"per_icon_tel",
               @"per_icon_wc",
               @"per_icon_tel",
               @"per_icon_info",
               ],@[@""]
             ];
}
- (NSArray *)titleArr{
    return @[
             @[@"个人信息",
               @"隐私政策",
               @"客服热线",
               @"官方微信",
               @"官方QQ",
               @"版本信息",],@[@"退出登录"]
             ];
}
- (void)setNavBar{
    
}

- (void)bindSignal{
    @weakify(self)
    [self.headerCardView.detailLabel handleTap:^(CGPoint loc, UIGestureRecognizer *tapGesture) {
     @strongify(self)
        [self pushTZMyFutureMoneyListVC];
    }];
}

-(void)initWithUI
{
    self.m_tableView.tableHeaderView = self.headerCardView;
    [self.view addSubview:self.m_tableView];
    
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
    return self.titleArr.count;
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
    return [self.titleArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TZMineRowCell *cell = [tableView dequeueReusableCellWithIdentifier:TZMineRowCellID forIndexPath:indexPath];
        
        NSString *title = self.titleArr[indexPath.section][indexPath.row] ;
        cell.iconImageView.image = R_ImageName(self.iconArr[indexPath.section][indexPath.row]);
        cell.mianTitleLabel.text = title;
        
        if ([title isEqualToString: @"客服热线"]) {
            cell.rightViewBg.hidden = NO;
            cell.moreImageView.hidden = YES;
            cell.companyPhoneLabel.text = @"0757-8213-8840";
            cell.companyTimeLabel.text = @"热线服务时间：9:00-18:00";
            
        }else  if ([title isEqualToString: @"官方微信"]) {
            cell.rightSubLabel.text = @"帒呗官方微信";
            
        }else  if ([title isEqualToString: @"官方QQ"]) {
            cell.rightSubLabel.text = @"帒呗官方QQ";
            
        }else  if ([title isEqualToString: @"版本信息"]) {
            cell.rightSubLabel.text = [NSString stringWithFormat:@"%@版",kApp_Version];
            [cell showMoreImageView:NO];
            
        }
        return cell;
        
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
            InsertLabel(cell.contentView, CGRectMake(0, 0, kScreenWidth, 44), NSTextAlignmentCenter, self.titleArr[indexPath.section][indexPath.row], kFontSize14, CP_ColorMBlack, NO);
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.selected = YES;
        }
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    @weakify(self)
    NSString *title = self.titleArr[indexPath.section][indexPath.row];
    if ([title isEqualToString:@"退出登录"]) {
        [SensorsAnalyticsSDKHelper mySettingsEventWithPosition:@"安全退出"];
        [kUserMessageManager userLogoutAppData];
    }else if ([title isEqualToString:@"个人信息"]){
        TZMyProfileVC *profVc = [TZMyProfileVC new];
        profVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:profVc animated:YES];
        
    }else if ([title isEqualToString:@"隐私政策"]){
        
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",WAP_PHONEURL,userPrivacyProPolicy];
        
        BaseWebViewController *targetVC = [[BaseWebViewController alloc]init];
        targetVC.url = urlStr;
        targetVC.title = title;
        targetVC.bottomBtnTitleStr = @"我知道了";
        [self.navigationController pushViewController:targetVC animated:YES];
        
        
    }else if ([title isEqualToString:@"客服热线"]){
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"82138840"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }else if ([title isEqualToString:@"官方微信"]){
        self.weiXinOrQQView.type = TZShowWeiXinAndQQViewType_weiXin;
        
        TZShowAlertView *showView = [[TZShowAlertView alloc] initWithAlerTitle:nil ContentView:self.weiXinOrQQView];
        self.weiXinOrQQView.backCloseAtionBlock = ^(UIButton * _Nonnull btn) {
            [ showView disMiss];
        };
        [showView show];
        
    }else if ([title isEqualToString:@"官方QQ"]){
        
        self.weiXinOrQQView.type = TZShowWeiXinAndQQViewType_QQ;
        
        TZShowAlertView *showView = [[TZShowAlertView alloc] initWithAlerTitle:nil ContentView:self.weiXinOrQQView];
        self.weiXinOrQQView.backCloseAtionBlock = ^(UIButton * _Nonnull btn) {
            [ showView disMiss];
        };
        [showView show];
        
    }else if ([title isEndssWith:@"版本信息"]){
        
    }
    
}

- (TZShowWeiXinAndQQView *)weiXinOrQQView{
    if (!_weiXinOrQQView) {
        _weiXinOrQQView = [[TZShowWeiXinAndQQView alloc] init];
        _weiXinOrQQView.frame = CGRectMake(0, 0, kScreenWidth - 30, 315);
    }
    return _weiXinOrQQView;
}

- (TZMineHeaderCardView *)headerCardView{
    if (!_headerCardView) {
        _headerCardView = [TZMineHeaderCardView new];
    }
    return _headerCardView;
}

#pragma mark - push-VC
- (void)pushTZMyFutureMoneyListVC{
    TZMyFutureMoneyListVC *listVc = [TZMyFutureMoneyListVC new];
    [self.navigationController pushViewController:listVc animated:YES];
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

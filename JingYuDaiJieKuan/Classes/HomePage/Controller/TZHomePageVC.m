//
//  TZHomePageVC.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/10/30.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZHomePageVC.h"
#import "TZHomeBodyCell.h" // 列表
#import "TZHomeResultViewCell.h" // 底部累计统计
#import "HomePageViewModel.h"
#import "HomePageModel.h"
#import "SDCycleScrollView.h"
#import "CMTPaoMaView.h"   // 跑马灯
#import "AdWebViewController.h"
#import "TZProductCenterVC.h" // 产品中心
#import "TZShowAlertView.h"
@interface TZHomePageVC ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong ,nonatomic) UITableView *m_tableView;
@property (strong ,nonatomic) UIView *m_headView;
@property (strong ,nonatomic) SDCycleScrollView * m_cycleScrollView;
@property (strong ,nonatomic) CMTPaoMaView *m_paoMaView;

// data
@property (strong ,nonatomic) HomePageModel *m_HomeBodyModel; //banner 和主体body

@property (strong ,nonatomic) HomeNoticeListModel *m_PaoMaDengModel; // 跑马灯model

@property (strong ,nonatomic) homeIntervalDaysModel *m_HomeintervalDays; // 底部交易统计



@end

@implementation TZHomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWithUI];
    [self setNavBar];
    [self bindSignal];
    [self refreshData];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self urlIntervalDays];
    
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

- (void)refreshData{
    [self urlHomeBannerData];
    [self urlHomeMessageNoticeData];
    [self urlIntervalDays];
    
}

- (void)bindSignal{
    self.m_cycleScrollView.placeholderImage = Kimage_placeholder;
}


#pragma mark - nav
- (void)setNavBar {
    self.fd_prefersNavigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


-(void)initWithUI
{
    PigMJRefreshGifHeader *header = [PigMJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.m_tableView.mj_header = header;
    [self.view addSubview:self.m_tableView];
    
    [self.m_headView addSubview:self.m_cycleScrollView];
    self.m_tableView.tableHeaderView = self.m_headView;
    
}


#pragma  mark - 接口数据

//
- (void)urlIntervalDays{
    @weakify(self)
    [HomePageViewModel homeIntervalDaysPath:API_IntervalDays params:nil target:self success:^(homeIntervalDaysModel *model) {
        self.m_HomeintervalDays = model;
        [self.m_tableView reloadData];
    } failure:^(NSError *error) {
        [[ZXAlertView shareView] showMessage:kloadfailedNotNetwork];
        
    }];
}

// 首页 横幅接口:bannerInfo ,主题列表:bannerNavigation
- (void)urlHomeBannerData{
    @weakify(self);
    
    [HomePageViewModel homeBannerPath:homeBanner params:nil target:self success:^(HomePageModel *model) {
        @strongify(self)
        if (model.code == 200) {
            
            self.m_HomeBodyModel = model;
            
            NSMutableArray *array = [[NSMutableArray alloc] init];
            [model.bannerInfo enumerateObjectsUsingBlock:^(TZBannerInfoModel *infoModel, NSUInteger idx, BOOL * _Nonnull stop) {
                [array addObject:[NSString stringWithFormat:@"%@",infoModel.photoIphonex]];
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self)
                self.m_cycleScrollView.imageURLStringsGroup = array;
            });        } else {
                [[ZXAlertView shareView] showMessage:model.msg?:@""];
                [[TZShowAlertView new] showNotNetWorkViewWithBlock:^{
                    @strongify(self)
                    [self refreshData];
                }];
            }
        [self.m_tableView.mj_header endRefreshing];
        [self.m_tableView reloadData];
    } failure:^(NSError *error) {
        [[TZShowAlertView new] showNotNetWorkViewWithBlock:^{
            @strongify(self)
            [self refreshData];
        }];
        showMessage(kloadfailedNotNetwork);
        [self.m_tableView.mj_header endRefreshing];
    }];
}

//home / message / notice  滚动消息通知接口
- (void)urlHomeMessageNoticeData
{
    @weakify(self);
    [HomePageViewModel homeMessageNoticePath:homeMessageNotice params:nil target:self success:^(HomeNoticeListModel *model) {
        @strongify(self)
        if (model.code == 200) {
            self.m_PaoMaDengModel = model;
            [self paoMaDengView];
        } else {
            [[ZXAlertView shareView] showMessage:model.msg?:@""];
        }
        [self.m_tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.m_tableView.mj_header endRefreshing];
        //        [[ZXAlertView shareView] showMessage:kloadfailedNotNetwork];
    }];
}



#pragma  mark  UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    //所有数据都有的情况下,显示3组数据
    //    return 3 - [self adjustmentSection:0];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        return self.m_HomeBodyModel.bannerNavigation.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        return 111;
    }
    return 22;
}

//返回头分组标题高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15.0f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        TZHomeBodyCell *cell = [tableView dequeueReusableCellWithIdentifier:TZHomeBodyCellID forIndexPath:indexPath];
        if (self.m_HomeBodyModel.bannerNavigation.count>0) {
            TZBannerNavigationModel *model = self.m_HomeBodyModel.bannerNavigation[indexPath.row];
            [cell.imageViewBg sd_setImageWithURL: [NSURL URLWithString:model.photoIphonex] placeholderImage:Kimage_placeholder];
        }
        
        return cell;
        
    }else {

        TZHomeResultViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TZHomeResultViewCellID forIndexPath:indexPath];
        if (self.m_HomeintervalDays != nil) {
            cell.playTimetLabel.text = [NSString stringWithFormat:@"累计交易金额 %@",self.m_HomeintervalDays.operateTime] ;
            cell.playCountLabel.text = [NSString stringWithFormat:@"累计交易 %ld笔",(long)self.m_HomeintervalDays.turnoverNumber] ;
        }
        
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        TZBannerNavigationModel *model = self.m_HomeBodyModel.bannerNavigation[indexPath.row];
        if (model.referType.integerValue == 1) {
            TZProductCenterVC *centerVc = [TZProductCenterVC new];
            [self.navigationController pushViewController:centerVc animated:YES];
        }else{
            if ([model.url containsString:HTML_creditRepair_api] || [model.title containsString:@"征信"]) {
                NSString *phone = [kUserMessageManager getMessageManagerForObjectWithKey:USER_MOBILE];
                
                NSString *strName =  [[NSString stringWithFormat:@"phone=%@",phone] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString *urlStr = [NSString stringWithFormat:@"%@?%@",model.url,strName];
                
                [self PushToBaseWebViewControllerUrl:urlStr andTitle:model.title];
                
            }else{
                [self PushToBaseWebViewControllerUrl:model.url andTitle:model.title];
            }
        }
    }
    
}

#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    TZBannerInfoModel *model =  [self.m_HomeBodyModel.bannerInfo objectAtIndex:index];
    [self PushToBaseWebViewControllerUrl: model.url andTitle:model.title];
}
#pragma mark - UI

- (UITableView *)m_tableView
{
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
        [_m_tableView registerNibString:NSStringFromClass([TZHomeBodyCell class]) cellIndentifier:TZHomeBodyCellID];
        [_m_tableView registerNibString:NSStringFromClass([TZHomeResultViewCell class]) cellIndentifier:TZHomeResultViewCellID];
        _m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _m_tableView;
}


- (SDCycleScrollView *)m_cycleScrollView
{
    
    if (!_m_cycleScrollView) {
        _m_cycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kiP6WidthRace(180))];
        _m_cycleScrollView.delegate = self;
        _m_cycleScrollView.autoScrollTimeInterval = 10;
        _m_cycleScrollView.backgroundColor = Bg_ColorGray;
        _m_cycleScrollView.infiniteLoop = YES;
        _m_cycleScrollView.autoScroll = YES;
        _m_cycleScrollView.showPageControl = YES;
    }
    return _m_cycleScrollView;
}

- (UIView *)m_headView
{
    if (!_m_headView) {
        _m_headView  =InsertView(nil, CGRectMake(0, 0, kScreenWidth, kiP6WidthRace(220)), [UIColor whiteColor]);
    }
    return _m_headView;
}

//跑马灯
- (void)paoMaDengView
{
    //拿到跑马灯需要的文字列表
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self.m_PaoMaDengModel.list enumerateObjectsUsingBlock:^(HomeNoticeModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:[NSString stringWithFormat:@"%@",model.message]];
    }];
    [self.m_paoMaView removeFromSuperview];
    if (array.count != 0){
        //0的话不用加载跑马灯
        self.m_paoMaView = [[CMTPaoMaView alloc] initWithFrame:CGRectMake(0,self.m_cycleScrollView.bottom,kScreenWidth,kiP6WidthRace(40)) titleArray:array isShowIcon:YES];
        [self.m_headView addSubview:self.m_paoMaView];
        
        [self.m_paoMaView.verticalMarquee marqueeOfSettingWithState:MarqueeStart_H];
        
        MJWeakSelf
        self.m_paoMaView.PaoMaDengBlock = ^(NSInteger index) {
            //点击跑马灯跳到web
            HomeNoticeModel *model = weakSelf.m_PaoMaDengModel.list[index];
            
            AdWebViewController *vc = [[AdWebViewController alloc]init];
            [vc showWebWithURL:model.url
                andProductIcon:model.icon
           andProductMaxAmount:model.maxAmount
          andProductMerchartid:[model.referType isEqualToString:@"1"] ? model.mchId : @""
                andProductName:model.mchName
                andProductTags:@""
               andProductTitle:model.title
                 andProductUrl:model.url
               andFromPosition:[NSString stringWithFormat:@"滚动消息%ld",(index+1)]
          andIsNeedSaveHistory:NO
           withSuperController:weakSelf];
        };
        
    }
    
    //    //根据是否添加跑马灯来判断是否要添加高度
    if (array.count == 0) {
        self.m_headView.height = self.m_cycleScrollView.height;
        self.m_paoMaView.hidden = YES;
    } else {
        self.m_headView.height = self.m_cycleScrollView.height  +self.m_paoMaView.height;
        self.m_paoMaView.hidden = NO;
    }
    
}

#pragma mark - push VC
// web
- (void)PushToBaseWebViewControllerUrl:(NSString *)urlStr andTitle:(NSString *)title{
    if (checkStrEmty(urlStr)) {
        return;
    }
    BaseWebViewController *targetVC = [[BaseWebViewController alloc]init];
    targetVC.url = urlStr;
    targetVC.title = title;
    [self.navigationController pushViewController:targetVC animated:YES];
}


@end

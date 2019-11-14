//
//  TZProductVC.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/1.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#define KHeaderView_H    180
#define KSpeed_cell      @"极速贷cell"
#define KHot_title       @"热销产品"
#define KHot_cell        @"热销产品Cell"
#define KTool_title      @"便捷工具"
#define KTool_cell       @"便捷工具cell"
#define KNews_title      @"新闻资讯"
#define KNews_cell       @"新闻资讯cell"
#define KBottom_scroll   @"底部滚动试图"

#import "TZProductPageVC.h"
#import "TZProductHeaderView.h"
#import "TZProductPToPCell.h" // 线上 线下 极速贷
#import "SDCycleScrollView.h"
#import "TZUserEditChooseCell.h" //    标题
#import "TZProductQualityItemView.h" //精品推荐 Item
#import "TZProductToolsCell.h" // 便捷工具
#import "ProductItemViewModel.h"
#import "TZProductPageModel.h"
#import "TZProductNewsView.h" // 新闻
#import "TZProductCenterVC.h" // 产品中心
#import "TZProductNewPageVC.h" // 新闻 VC
#import "TZProductScreenConditionVC.h" // 全部贷款

@interface TZProductPageVC ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,UIScrollViewDelegate>

@property (strong ,nonatomic) UITableView *m_tableView;
@property (nonatomic, strong) TZProductHeaderView *headView;
@property (strong ,nonatomic) SDCycleScrollView * m_cycleScrollView;
@property (nonatomic, strong) UIView *qualityView; // 火热 商品
@property (nonatomic, strong) UIView *newsView; // 新闻
@property (nonatomic, strong) NSMutableArray *dataViewArr;
@property (nonatomic, strong) TZProductPageModel *model;
@end

@implementation TZProductPageVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self refreshData];

}

- (NSMutableArray *)dataViewArr{
    if (!_dataViewArr) {
        NSArray *array = @[m_blankCellReuseId,
                           KSpeed_cell,
                           KHot_title,
                           KHot_cell,
                           KTool_title,
                           KTool_cell,
                           m_blankCellReuseId,
                           KBottom_scroll,
                           KNews_title,
                           KNews_cell,
                           
        ];
        _dataViewArr = [[NSMutableArray alloc] initWithArray:array];
    }
    return _dataViewArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWithUI];
    [self bindSignal];
    [self refreshData];

}


- (void)refreshData{
    [self postLoanDaquanBannerPathUrl];
    [self postCareChosenPathUrl];
    [self postArticleRecommendListPathUrl];
    
}

// 新闻数量统计
- (void)postArticleAddLikeNumPathUrlWithID:(NSString *)ID{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",articleAddLikeNum_Path,ID];
    
    [ProductItemViewModel articleAddLikeNumPath:urlStr params:nil target:self success:^(TZProductPageModel * _Nonnull model) {
    } failure:^(NSError * _Nonnull error) {
    }];
}

// 新闻
- (void)postArticleRecommendListPathUrl{
    @weakify(self)
    [ProductItemViewModel articleRecommendListPath:articleRecommendList_Path params:nil target:self success:^(TZProductPageModel * _Nonnull model) {
        @strongify(self)
        self.model = model;
        [self addTZProductNewsView:model.newsList];
        [self.m_tableView reloadData];
        [self.m_tableView.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [self.m_tableView.mj_header endRefreshing];
        [[ZXAlertView shareView] showMessage:kloadfailedNotNetwork];
    }];
}

// 热销产品
- (void)postCareChosenPathUrl{
    @weakify(self)
    
    [ProductItemViewModel careChosenPath:careChosenPath params:nil target:self success:^(TZProductPageModel * _Nonnull model) {
        @strongify(self)
        self.model = model;
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [model.chosenResponseList enumerateObjectsUsingBlock:^(TZProductListModel *itmeModel, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx <3) {
                [array addObject:itmeModel];
            }        }];
        [model.offlineProductBanks enumerateObjectsUsingBlock:^(TZProductListModel *itmeModel, NSUInteger idx, BOOL * _Nonnull stop) {
            [array addObject:itmeModel];
        }];
        
        [self addTZProductQualityItemView:array];
        [self.m_tableView reloadData];
        [self.m_tableView.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [self.m_tableView.mj_header endRefreshing];
        [[ZXAlertView shareView] showMessage:kloadfailedNotNetwork];
    }];
}

// 中间滚动图
- (void)postLoanDaquanBannerPathUrl{
    @weakify(self)
    [ProductItemViewModel loanDaquanBannerPath:loanDaquanBannerPath params:nil target:self success:^(TZProductPageModel * _Nonnull model) {
        @strongify(self)
        self.model = model;
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [model.bannerInfo enumerateObjectsUsingBlock:^(TZProductBannerInfoModel *infoModel, NSUInteger idx, BOOL * _Nonnull stop) {
            [array addObject:[NSString stringWithFormat:@"%@",infoModel.photoIphonex]];
        }];

        if (array.count == 0 && [self.dataViewArr containsObject:KBottom_scroll]) {
            [self.dataViewArr removeObject:KBottom_scroll];
        }else if (array.count > 0 && ![self.dataViewArr containsObject:KBottom_scroll]){
            [self.dataViewArr insertObject:KBottom_scroll atIndex:7];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self)
            self.m_cycleScrollView.imageURLStringsGroup = array;
        });
        [self.m_tableView.mj_header endRefreshing];
        [self.m_tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [self.m_tableView.mj_header endRefreshing];
    }];
}


- (void)bindSignal{
    
    @weakify(self)
    self.m_tableView.mj_header =  [PigMJRefreshGifHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self refreshData];
    }];
    
    [_m_tableView registerNibString:NSStringFromClass([TZProductPToPCell class]) cellIndentifier:TZProductPToPCell_ID];
    [_m_tableView registerNibString:NSStringFromClass([TZUserEditChooseCell class]) cellIndentifier:TZUserEditChooseCell_ID];
    [_m_tableView registerNibString:NSStringFromClass([TZProductToolsCell class]) cellIndentifier:TZProductToolsCell_ID];
    
    //    self.m_tableView.contentInset = UIEdgeInsetsMake(KHeaderView_H, 0, 0, 0);
    //    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)initWithUI{
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.m_tableView];
    self.m_tableView.tableHeaderView = self.headView;
}
// 热门商品 模块
- (void)addTZProductQualityItemView:(NSArray <TZProductListModel*>*)array{
    @weakify(self)
    if (!_qualityView) {
        _qualityView  = InsertView(nil, CGRectMake(0, 0, kScreenWidth, 0), [UIColor clearColor]);
    }
    
    NSInteger macCount = 6; // 最多显示
    
    CGFloat item_LR = 15.0f;
    CGFloat item_row = 8.0f;
    CGFloat item_column = 10.0f;
    NSInteger count_row = 3;
    
    CGFloat item_W = (CGFloat)(kScreenWidth - item_LR*2 -item_row )/count_row;
    CGFloat item_H = 50;
    
    for (UIView *view in self.qualityView.subviews) {
        if ([view isKindOfClass:[TZProductQualityItemView class]]) {
            [view removeFromSuperview];
        }
    }
    
    [array enumerateObjectsUsingBlock:^(TZProductListModel  *model, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self)
        if (idx >= macCount) {
            return ;
        }
        NSInteger row = idx % count_row;
        NSInteger column = idx / count_row;
        
        TZProductQualityItemView *itemView = [[TZProductQualityItemView alloc] init];
        itemView.backgroundColor = [UIColor whiteColor];
        itemView.frame = CGRectMake(item_LR + row*(item_W+item_row), column * (item_column +item_H), item_W, item_H);
        [self.qualityView addSubview:itemView];
        
        self.qualityView.height = itemView.bottom;
        
        
        //
        [itemView.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
        itemView.titleLab.text = model.name;
        itemView.maxMoneyLabel.text = [NSString stringWithFormat:@"最高可贷%@",model.maxAmount.getLargeNumbersAbbreviation];
        itemView.maxMoneyLabel.keywords = model.maxAmount.getLargeNumbersAbbreviation;
        itemView.maxMoneyLabel.keywordsColor = KText_ColorRed;
        [itemView.maxMoneyLabel reloadUIConfig];
        [itemView handleTap:^(CGPoint loc, UIGestureRecognizer *tapGesture) {
            @strongify(self)
            if (model.type.integerValue == 2) {
                [self pushToTZProductScreenConditionVC];
            }else{
                [self PushToBaseWebViewControllerUrl:model.url andTitle:model.title];
            }
        }];
        
    }];
}

// 新闻模块
- (void)addTZProductNewsView:(NSArray <TZProductNewsModel *>*)array{
    @weakify(self)
    if (!_newsView) {
        _newsView  = InsertView(nil, CGRectMake(15, 0, kScreenWidth-30, 0), [UIColor clearColor]);
        _newsView.layer.masksToBounds = YES;
        _newsView.layer.cornerRadius = 3.0f;
    }
    
    NSInteger macCount = 3; // 最多显示
    
    CGFloat item_W = (CGFloat)(kScreenWidth - 15);
    CGFloat item_H = 104;
    
    for (UIView *view in self.qualityView.subviews) {
        if ([view isKindOfClass:[TZProductNewsView class]]) {
            [view removeFromSuperview];
        }
    }
    
    [array enumerateObjectsUsingBlock:^(TZProductNewsModel  *model, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self)
        if (idx >= macCount) {
            return ;
        }
        
        TZProductNewsView *itemView = [[TZProductNewsView alloc] init];
        itemView.backgroundColor = [UIColor whiteColor];
        itemView.frame = CGRectMake(0, idx * item_H, item_W, item_H);
        
        if (idx < MIN((array.count-1), macCount)) {
            [itemView addLine:CGRectMake(23, item_H-0.5f, item_W- 23*2, 0.5f)];
        }
        
        [self.newsView addSubview:itemView];
        
        self.newsView.height = itemView.bottom;
        
        //
        [itemView setModel:model];
        [itemView handleTap:^(CGPoint loc, UIGestureRecognizer *tapGesture) {
            @strongify(self)
            if (!checkStrEmty(model.articleId)) {
                [self postArticleAddLikeNumPathUrlWithID:model.articleId];
            }
            [self PushToBaseWebViewControllerUrl:model.url andTitle:model.title];
        }];
        
    }];
    [self.m_tableView reloadData];
    
}


#pragma mark - scrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    if (scrollView == self.m_tableView) {
    //        CGFloat offset_y = scrollView.contentOffset.y;
    //        if (offset_y < -KHeaderView_H) {
    //            CGFloat width = self.headView.width;
    //            CGFloat height = self.headView.height;
    //           height = ABS(offset_y);
    //            CGFloat f = ABS(offset_y)/height;
    //            self.headView.frame = CGRectMake((width *f - width)/2, height - ABS(offset_y), width *f, ABS(offset_y));
    ////            self.headView.top = height - ABS(offset_y);
    ////            self.headView.height = ABS(offset_y);
    //        }
    //    }
    //    //获取偏移量
    //    CGPoint offset = scrollView.contentOffset;
    //    //判断是否改变
    //    if (offset.y < 0) {
    //        CGRect rect = self.m_tableView.tableHeaderView.frame;
    //        //我们只需要改变图片的y值和高度即可
    //        rect.origin.y = offset.y;
    //        rect.size.height = KHeaderView_H - offset.y;
    //        self.m_tableView.tableHeaderView.frame = rect;
    //    }
}


#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    TZProductBannerInfoModel *model = [self.model.bannerInfo objectAtIndex:index];
    [self PushToBaseWebViewControllerUrl:model.url andTitle:model.title];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id titleV = [self.dataViewArr objectAtIndex:indexPath.row];
    if ([titleV isEqualToString:KSpeed_cell]) {
        return 80;
    }else if ([titleV isEqualToString:KHot_title] ||
              [titleV isEqualToString:KTool_title] ||
              [titleV isEqualToString:KNews_title]
              ) {
        return 44;
    }else if ([titleV isEqualToString:KHot_cell]) {
        return self.qualityView.height;
    }else if ([titleV isEqualToString:KTool_cell]) {
        return 80;
        
    }else if ([titleV isEqualToString:KNews_cell]) {
        return self.newsView.height;
        
    }else if ([titleV isEqualToString:KBottom_scroll]) {
        return self.m_cycleScrollView.height;
    }
    return 15;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataViewArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    @weakify(self)
    NSString  *titleV = [self.dataViewArr objectAtIndex:indexPath.row];
    if ([titleV isEqualToString:KSpeed_cell]) {
        TZProductPToPCell *cell = [tableView dequeueReusableCellWithIdentifier:TZProductPToPCell_ID forIndexPath:indexPath];
        cell.backBtnTapAcionBlock = ^(NSInteger index) {
            @strongify(self)
            [self pushToTZProductCenterVCWithPage:index];
        };
        return cell;
    } if ([titleV isEqualToString:KHot_title]) {
        TZUserEditChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:TZUserEditChooseCell_ID forIndexPath:indexPath];
        cell.rightBtn.hidden = NO;
        cell.mainTitleLabel.text = KHot_title;
        cell.backBtnTapAcionBlock = ^{
            @strongify(self)
            [self pushToTZProductCenterVCWithPage:0];
        };
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }else if ([titleV isEqualToString:KHot_cell]) {
        UITableViewCell *cell = [UITableViewCell blankWhiteCellWithID:KBottom_scroll];
        cell.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:self.qualityView];
        return cell;
        
    }else if ([titleV isEqualToString:KTool_title]) {
        TZUserEditChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:TZUserEditChooseCell_ID forIndexPath:indexPath];
        cell.mainTitleLabel.text = KTool_title;
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
    }else if ([titleV isEqualToString:KTool_cell]) {
        TZProductToolsCell *cell = [tableView dequeueReusableCellWithIdentifier:TZProductToolsCell_ID forIndexPath:indexPath];
        cell.backBtnTapAcionBlock = ^(NSInteger index) {
            @strongify(self)
            
            if (index == 0) {
                NSString *urlStr = @"https://m.tianxiaxinyong.cn/cooperation/crp-v2/index.html?channel=NDVSVlc5Qmg0ZDBubVNLMjNnY3BLQT09#home";
                [self PushToBaseWebViewControllerUrl:urlStr andTitle:@""];
                
            }else{ // 1
                
                NSString *phone = [kUserMessageManager getMessageManagerForObjectWithKey:USER_MOBILE];
                NSString *strName =  [[NSString stringWithFormat:@"phone=%@",phone] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString *urlStr = [NSString stringWithFormat:@"%@%@?%@",SERVER_URL,HTML_creditRepair_api,strName];
                [self PushToBaseWebViewControllerUrl:urlStr andTitle:@"征信修复咨询"];
            }
        };
        return cell;
    }if ([titleV isEqualToString:KNews_title]) {
        TZUserEditChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:TZUserEditChooseCell_ID forIndexPath:indexPath];
        cell.rightBtn.hidden = NO;
        cell.mainTitleLabel.text = KNews_title;
        cell.backgroundColor = [UIColor clearColor];
        cell.backBtnTapAcionBlock = ^{
            @strongify(self)
            [self pushToTZProductNewPageVC];
        };
        return cell;
    }else if ([titleV isEqualToString:KNews_cell]) {
        UITableViewCell *cell = [UITableViewCell blankWhiteCellWithID:KBottom_scroll];
        cell.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:self.newsView];
        return cell;
        
    }else if ([titleV isEqualToString:KBottom_scroll]) {
        UITableViewCell *cell = [UITableViewCell blankWhiteCellWithID:KBottom_scroll];
        cell.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:self.m_cycleScrollView];
        return cell;
    }
    
    return [UITableViewCell blankCell];
    
}




#pragma mark - UI

- (TZProductHeaderView *)headView{
    if (!_headView) {
        _headView = [[TZProductHeaderView alloc] init];
        _headView.frame = CGRectMake(0, 0, kScreenWidth, KHeaderView_H);
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
        
        _m_tableView.separatorStyle = UITableViewCellAccessoryNone;
        
    }
    return _m_tableView;
}

- (SDCycleScrollView *)m_cycleScrollView
{
    
    if (!_m_cycleScrollView) {
        _m_cycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, iPH(180))];
        _m_cycleScrollView.delegate = self;
        _m_cycleScrollView.autoScrollTimeInterval = 10;
        _m_cycleScrollView.backgroundColor = Bg_ColorGray;
        _m_cycleScrollView.infiniteLoop = YES;
        _m_cycleScrollView.autoScroll = YES;
        _m_cycleScrollView.showPageControl = YES;
        _m_cycleScrollView.placeholderImage = Kimage_placeholder;
    }
    return _m_cycleScrollView;
}


#pragma mark - puVC页面，
- (void)pushToTZProductCenterVCWithPage:(NSInteger) index{
    TZProductCenterVC * centerVc = [TZProductCenterVC new];
    centerVc.pageIndex = index;
    [self.navigationController pushViewController:centerVc animated:YES];
}
- (void)pushToTZProductScreenConditionVC{
    TZProductScreenConditionVC * allBankVc = [TZProductScreenConditionVC new];
    [self.navigationController pushViewController:allBankVc animated:YES];
}



// 新闻列表
-(void)pushToTZProductNewPageVC{
    TZProductNewPageVC *newsVc = [TZProductNewPageVC new];
    [self.navigationController pushViewController:newsVc animated:YES];
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

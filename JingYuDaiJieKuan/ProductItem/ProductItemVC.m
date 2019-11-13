//
//  ProductItemVC.m
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/19.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "ProductItemVC.h"
#import "ProductItemHeadView.h"
#import "TheSecondHomePageCell.h"
#import "JingYuDaiJieKuan-Swift.h"
#import "HomePageModel.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "ProductItemViewModel.h"
#import "AdvertisementHelper.h"
#import "AdWebViewController.h"
#import "HomePageViewModel.h"

@interface ProductItemVC () <UITableViewDataSource, UITableViewDelegate>{
    NSString *tags;
    BOOL isSort;
    NSInteger maxAmount;
    NSInteger mixAmount;
    NSInteger maxLimit;
    NSInteger mixLimit;
    NSString *posId;
    /// 是否点击过筛选框
    BOOL isClickedProductItemHeadView;
    BOOL isAlreadyAppear;
}

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *searchBGView;
@property (nonatomic, strong) UIImageView *searchImg;
@property (nonatomic, strong) UITextField *searchTxt;

@property (nonatomic, strong) ProductItemHeadView * m_productHeadView;

@property (nonatomic, strong) UIView *tipView;
@property (nonatomic, strong) UILabel *tipLbl;

@property (strong ,nonatomic) NSArray *streamerArray;// 广告横幅接口Array
@property (strong ,nonatomic) NSMutableArray *m_selectTheLoanArray;// 精选贷款+横幅Array
@property (strong ,nonatomic) NSMutableArray *simpleLoanArray;// 排序后的贷款大全Array
@property (nonatomic, strong) UITableView *tableView;

// 页码
@property (nonatomic, assign) NSInteger pageIndex;

//广告管理者
@property (nonatomic, strong) AdvertisementHelper *helper;

//最近一次浏览商户
@property (nonatomic, strong) BrowseHistory *historyModel;
//随机推荐商户
@property (nonatomic, strong) randomProductModel *randomModel;

@end

@implementation ProductItemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    tags = @"-1";
    isSort = YES;
    posId = @"2";
    isClickedProductItemHeadView = NO;
    isAlreadyAppear = NO;
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = UIColor.whiteColor;
    [self initView];
    [self getLableList];
//    [self reloadData];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.helper getAdvDialogWithPosId:@"2" SuperVC:self];
    [self getRandomMerchant];
//    if (isAlreadyAppear == YES) {
    
        [self clearAllFilter];
        //滚动到顶部
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
        
        [self streamerData];
        
//    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    isAlreadyAppear = YES;
}

- (void)initView{
    //搜索控件包裹视图
    [self.view addSubview:self.contentView];
    
    self.contentView.frame = CGRectMake(0, kStatusBarH+6, kScreenWidth, 30);
    
    //中间搜索控件包含的所有控件
    [self.contentView addSubview:self.searchBGView];
    [self.searchBGView addSubview:self.searchImg];
    self.searchBGView.frame = CGRectMake(20, 0, self.contentView.bounds.size.width - 40, 30);
    
    self.searchImg.frame = CGRectMake(15, 0, 15, 15);
    [self.searchImg setCenterY:self.searchBGView.centerY];
    
    [self.searchBGView addSubview:self.searchTxt];
    self.searchTxt.frame = CGRectMake(43, 0, self.contentView.bounds.size.width - CGRectGetMaxX(self.searchImg.frame) - 15, self.searchBGView.bounds.size.height);
    [self.searchTxt setCenterY:self.searchBGView.centerY];
    
    
    [self.view addSubview:self.tipView];
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.m_productHeadView];
    self.m_productHeadView.frame = CGRectMake(0, CGRectGetMaxY(self.contentView.frame) , kScreenWidth, kiP6WidthRace(44));
    
    [self.tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.searchBGView.mas_bottom).offset(kiP6WidthRace(44));
        make.height.mas_equalTo(kiP6WidthRace(28));
    }];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.tipView.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
   
    [self.view bringSubviewToFront:self.m_productHeadView];
}

- (void)dealloc {
    self.navigationController.delegate = nil;
}

#pragma mark -- netWork
//获取筛选标签
- (void)getLableList {
    kSelfWeak;
    [ProductItemViewModel filterListPath:productItemLableListPath params:nil target:self success:^(sortListModel *model) {
        if (model.code == 200) {
            weakSelf.m_productHeadView.sortListModel = model;
        } else {
            [[ZXAlertView shareView] showMessage:model.msg?:@""];
        }
        
    } failure:^(NSError *error) {
        
        [[ZXAlertView shareView] showMessage:kloadfailedNotNetwork];
    }];
}

//贷款大全
- (void)reloadData {
    self.pageIndex = 1;
    [self streamerData];
    
}
- (void)getMoreData {
    self.pageIndex += 1;
    [self streamerData];
}

///广告横幅查询
- (void)streamerData {
    [HomePageViewModel streamerListPath:streamer params:@{@"pos": @"2"} target:self success:^(StreamerListModel *model) {
        if (model.code == 200) {
            self.streamerArray = model.list;
        }
         [self getProductItemList];
    } failure:^(NSError *error) {
        //无论成功失败都要请求商户列表
        [self getProductItemList];
    }];
}
//商户列表查询
- (void)getProductItemList {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.pageIndex) forKey:@"pageNo"];
    if (isSort) {
        if (![tags isEqualToString:@"-1"]) { [params setObject:tags forKey:@"tag"];}
    } else {
        if (![tags isEqualToString:@"-1"]) { [params setObject:tags forKey:@"tag"];}
        ///这里要特殊操作,判断是否要传对应的max和min
        if (maxAmount != -1) { [params setObject:@(maxAmount) forKey:@"maxAmount"];}
        if (mixAmount != -1) { [params setObject:@(mixAmount) forKey:@"mixAmount"];}
        if (maxLimit != -1) { [params setObject:@(maxLimit) forKey:@"maxLimit"];}
        if (mixLimit != -1) { [params setObject:@(mixLimit) forKey:@"mixLimit"];}
    }
    
    kSelfWeak;
    [ProductItemViewModel productItemListPath:productItemListPath params:params target:self success:^(ProductItemListModel *model) {
        if (model.code == 200) {
            if (weakSelf.pageIndex == 1) {
                weakSelf.simpleLoanArray = [NSMutableArray arrayWithArray: model.result];
                [self.tableView.mj_header endRefreshing];
                if (weakSelf.simpleLoanArray.count == 0) {
                    [weakSelf.tableView.mj_footer setState:MJRefreshStateNoMoreData];
                } else {
                    [weakSelf.tableView.mj_footer setState:MJRefreshStateIdle];
                }
                
            } else {
                [weakSelf.simpleLoanArray addObjectsFromArray:model.result];
                if (model.result.count == 0){
                    [weakSelf.tableView.mj_footer setState: MJRefreshStateNoMoreData];
                } else {
                    [weakSelf.tableView.mj_footer endRefreshing];
                }
            }
            weakSelf.m_selectTheLoanArray = [self adjustmentHomeCareChosenData:weakSelf.simpleLoanArray];
            [weakSelf.tableView reloadData];
        }else {
            [[ZXAlertView shareView] showMessage:model.msg?:@""];
        }
       
    } failure:^(NSError *error) {
        [[ZXAlertView shareView] showMessage:kloadfailedNotNetwork];
    }];
}
//清除所有条件
- (void)clearAllFilter {
    //清空筛选栏的选择
    [self.m_productHeadView reSetCondition];
    self.pageIndex = 1;
    tags = @"-1";
    isSort = YES;
    maxAmount = -1;
    mixAmount = -1;
    maxLimit = -1;
    mixLimit = -1;
}
//横幅插入方法
- (NSMutableArray *)adjustmentHomeCareChosenData:(NSMutableArray *)dataArr {

    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:dataArr];
    
    //添加横幅
    NSInteger j = tempArr.count;
    NSInteger count = ((j-1)/5)+1;//因为count是NSUInteger数据类型,所以当count为0的时候,再-1就会导致数据类型问题
    NSInteger i = 0;
    while (1) {
        //如果横幅的个数用光了,就直接跳出了
        if (i>=self.streamerArray.count){break;}
        if (i == count-1) {
            [tempArr addObject:self.streamerArray[i]];
            break;
        } else {
            [tempArr insertObject:self.streamerArray[i] atIndex:(5*(i+1))+i];
        }
        i++;
    }
    
    return tempArr;
}


//获取随机推荐
- (void)getRandomMerchant {
    
    kSelfWeak;
    [weakSelf queryLastHistoryId];

    if (weakSelf.historyModel.merchartid == 0) {
        //没有历史
        [weakSelf.tipView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        [weakSelf.tipView setHidden:YES];
        return;
    } else {
    }
    
    NSString *path = [NSString stringWithFormat:@"market/random/merchant/%d", weakSelf.historyModel.merchartid];
    
    [ProductItemViewModel randomProductPath:path params:nil target:weakSelf success:^(randomProductModel *model) {
        if (model.code == 200) {
            self.randomModel = model;
            ///刷新
            if (model.name == nil) {
                //没有历史
                [weakSelf.tipView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(0);
                }];
                [weakSelf.tipView setHidden:YES];
                return;
            } else {
                //有历史
                [weakSelf.tipView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(28);
                }];
                [weakSelf.tipView setHidden:NO];
            }
            //富文本
            NSString *blackStr = [NSString stringWithFormat:@" 申请\"%@\"的用户同时还申请了",weakSelf.historyModel.name];
            NSString *AllStr = [NSString stringWithFormat:@"%@%@",blackStr,model.name];
           
            NSMutableAttributedString *mustrAtt = [[NSMutableAttributedString alloc]initWithString:AllStr];
            
            NSTextAttachment *imageAttachment = [[NSTextAttachment alloc]init];
            [imageAttachment setImage: [UIImage imageNamed:@"attention"]];
            imageAttachment.bounds = CGRectMake(0, -1, 12, 12);
            NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:(NSTextAttachment *)(imageAttachment)];
            
            [mustrAtt insertAttributedString:imageStr atIndex:0];
            
            //设置颜色
            [mustrAtt addAttribute:NSForegroundColorAttributeName value:UIColor.grayColor range:NSMakeRange(0, blackStr.length)];
            [mustrAtt addAttribute:NSForegroundColorAttributeName value:UIColorHex(@"#3a80ff") range:NSMakeRange(blackStr.length + 1, AllStr.length - blackStr.length)];
            
            weakSelf.tipLbl.attributedText = mustrAtt;
        }
        
    } failure:^(NSError *error) {
        //没有历史
        [weakSelf.tipView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        [weakSelf.tipView setHidden:YES];
        return;
    }];
    
}


#pragma mark -- datasource/delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.m_selectTheLoanArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.m_selectTheLoanArray[indexPath.row] isKindOfClass:StreamerModel.class]) {
        //如果是横幅,那就是另一个cell
        StreamerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StreamerCell" forIndexPath:indexPath];
        StreamerModel *model = self.m_selectTheLoanArray[indexPath.row];
        [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:model.photo]];
        return cell;
    } else {
        TheSecondHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TheSecondHomePageCell" forIndexPath:indexPath];
        
        ProductItemModel *tempModel = self.m_selectTheLoanArray[indexPath.row];
        AdBannerModel *model = [AdBannerModel new];
        model.name = tempModel.name;
        model.icon = tempModel.icon;
        model.maxAmount = tempModel.maxAmount;
        model.title = tempModel.title;
        model.tags = tempModel.tags;
        
        cell.model = model;
        
        return cell;
    }
}

/// 判断字符串是否为空
- (BOOL)isBlankString:(NSString *)aStr {
    if (!aStr) {
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!aStr.length) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AdWebViewController *targetVC = [AdWebViewController new];
    
    if ([self.m_selectTheLoanArray[indexPath.row] isKindOfClass:StreamerModel.class]) {
        //点击横幅
        StreamerModel *model = self.m_selectTheLoanArray[indexPath.row];
        NSInteger sort = [self.streamerArray indexOfObject:model] + 1;
        [SensorsAnalyticsSDKHelper streamerClickEventWithMchId:model.mchId mchName:model.mchName streamerTitle:model.title streamerUrl:model.url position:@"贷款大全" sort:[NSString stringWithFormat:@"%ld",sort]];
        
        [targetVC showWebWithURL:model.url
                  andProductIcon:nil
             andProductMaxAmount:nil
            andProductMerchartid:model.mchId
                  andProductName:model.mchName
                  andProductTags:nil
                 andProductTitle:model.title
                   andProductUrl:model.url
                 andFromPosition:[NSString stringWithFormat:@"贷款大全-横幅%ld",sort]
            andIsNeedSaveHistory:YES
             withSuperController:self];
        
    } else {
        ProductItemModel *model = self.m_selectTheLoanArray[indexPath.row];
        
        //传的位置根据是否点击过筛选排序来改变
        NSString *positionClick = @"";
        NSString *position = @"";
        NSInteger sort = [self.simpleLoanArray indexOfObject:model] + 1;
        if (isClickedProductItemHeadView) {
            //如果已经点击过了,那就传筛选
            positionClick = @"贷款大全-筛选";
            position = [NSString stringWithFormat:@"贷款大全-筛选%ld",sort];
        } else {
            //没有点击过,就传"C"
            positionClick = @"贷款大全";
            position = [NSString stringWithFormat:@"%ldC",sort];
        }
        
        [SensorsAnalyticsSDKHelper merchantClickWithMchId:model.merchartid mchName:model.name position:positionClick sort:[NSString stringWithFormat:@"%ld",sort]];
        
        
        [targetVC showWebWithURL:model.url
                  andProductIcon:model.icon
             andProductMaxAmount:model.maxAmount
            andProductMerchartid:model.merchartid
                  andProductName:model.name
                  andProductTags:model.tags
                 andProductTitle:model.title
                   andProductUrl:model.url
                 andFromPosition:position
            andIsNeedSaveHistory:YES
             withSuperController:self];
    }
}

#pragma Func
/// 调到搜索页面
- (void)searchProductItme {
    ProductItemSearchVC *targetVC = [[ProductItemSearchVC alloc]init];
    [self.navigationController pushViewController:targetVC animated:YES];
}

//查询搜索历史
- (void)queryLastHistoryId{
    
    //搜索所有.
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"BrowseHistory"];
    
    //按时间戳降序,越后面的时间越早
    NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:@"timeStamp" ascending:NO];
    // @[sort];//数组中可以放置多个sort，一般就用一个
    request.sortDescriptors = @[sort];
    
    NSArray *arr = [[CoreDataManager defaultManager].managedContext executeFetchRequest:request error:nil];
    
    BrowseHistory *historyModel = arr.firstObject;
    self.historyModel = historyModel;
    
}

//点击TipView
- (void)tapTipView {
    AdWebViewController *targetVC = [AdWebViewController new];
    [targetVC showWebWithURL:self.randomModel.url
              andProductIcon:self.randomModel.icon
         andProductMaxAmount:[NSString stringWithFormat:@"%ld", self.randomModel.maxAmount]
        andProductMerchartid:self.randomModel.merchartid
              andProductName:self.randomModel.name
              andProductTags:@""
             andProductTitle:@""
               andProductUrl:self.randomModel.url
             andFromPosition:@""
        andIsNeedSaveHistory:YES
         withSuperController:self];
    
}

#pragma mark - getter
- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
    }
    return _contentView;
}

//整个中间搜索控件部分底部颜色视图
- (UIView *)searchBGView
{
    if (!_searchBGView) {
        _searchBGView = [[UIView alloc]init];
        //切圆角
        _searchBGView.layer.cornerRadius = 5;
        _searchBGView.layer.masksToBounds = true;
        _searchBGView.backgroundColor = [[UIColor colorWithRed:242.0 / 255.0 green:242.0 / 255.0 blue:242.0 / 255.0 alpha:1.0] colorWithAlphaComponent:0.7];
        [_searchBGView setUserInteractionEnabled: YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchProductItme)];
        [_searchBGView addGestureRecognizer:tap];
        
    }
    return _searchBGView;
}

//搜索框放大镜
- (UIImageView *)searchImg
{
    if (!_searchImg) {
        _searchImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search"] ];
    }
    return _searchImg;
}

//搜索框文字
- (UITextField *)searchTxt
{
    if (!_searchTxt) {
        _searchTxt = [[UITextField alloc] init];
        _searchTxt.text = @"搜索商户名称";
        _searchTxt.textColor = [UIColor.grayColor colorWithAlphaComponent:0.5];
        [_searchTxt setEnabled: NO];
        _searchTxt.font = [UIFont systemFontOfSize:16];
    }
    return _searchTxt;
}

// 随机推荐
- (UIView *)tipView {
    if (!_tipView) {
        _tipView = [[UIView alloc]init];
        _tipView.backgroundColor = [UIColor colorWithRed:231/255.0 green:239/255.0 blue:253/255.0 alpha:0.8];
        
        [_tipView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTipView)];
        [_tipView addGestureRecognizer: tap];
        
        [_tipView addSubview:self.tipLbl];
        [self.tipLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.equalTo(_tipView).offset(-20);
            make.centerY.equalTo(_tipView);
        }];
    }
    return _tipView;
}

- (UILabel *)tipLbl {
    
    if (!_tipLbl) {
        _tipLbl = [[UILabel alloc] init];
        
        _tipLbl.text = @"搜索商户名称";
        _tipLbl.font = [UIFont systemFontOfSize:14];
        _tipLbl.textColor = [UIColor.grayColor colorWithAlphaComponent:1];
    }
    
    return _tipLbl;
}

///筛选栏
- (ProductItemHeadView *)m_productHeadView
{
    if (!_m_productHeadView) {
        kSelfWeak;
        _m_productHeadView = [[ProductItemHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kiP6WidthRace(44))];
        _m_productHeadView.showFilterBlock = ^(BOOL isSelect) {
            if (isSelect) {
                weakSelf.m_productHeadView.frame = CGRectMake(0, CGRectGetMaxY(weakSelf.contentView.frame), kScreenWidth, kiP6WidthRace(44) + kiP6WidthRace(820/2));
            }else{
                weakSelf.m_productHeadView.frame = CGRectMake(0, CGRectGetMaxY(weakSelf.contentView.frame), kScreenWidth, kiP6WidthRace(44));
            }
        };
        
        _m_productHeadView.chooseClickBlock = ^(NSString *tagsTemp
                                                , NSInteger maxAmountTemp
                                                , NSInteger mixAmountTemp
                                                , NSInteger maxLimitTemp
                                                , NSInteger mixLimitTemp
                                                , BOOL isSortTemp) {
            
            isClickedProductItemHeadView = YES;
            
            tags = tagsTemp;
            maxAmount = maxAmountTemp;
            mixAmount = mixAmountTemp;
            maxLimit = maxLimitTemp;
            mixLimit = mixLimitTemp;
            isSort = isSortTemp;
            //请求接口
            [weakSelf reloadData];
        };
    }
    return _m_productHeadView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = InsertTableView(nil, CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.view.frame)), self, self, UITableViewStylePlain, UITableViewCellSeparatorStyleSingleLine);
        [_tableView registerClass:[TheSecondHomePageCell class] forCellReuseIdentifier:@"TheSecondHomePageCell"];
        [_tableView registerClass:StreamerCell.class forCellReuseIdentifier:@"StreamerCell"];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = kiP6WidthRace(103);
        
        if (kIsPhoneX) {
            _tableView.height = self.view.height;
        }
        
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.mj_header = [PigMJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
        
    }
    return _tableView;
}

- (NSMutableArray *)m_selectTheLoanArray
{
    if (!_m_selectTheLoanArray) {
        _m_selectTheLoanArray = [[NSMutableArray alloc] init];
    }
    return _m_selectTheLoanArray;
}

- (NSInteger)pageIndex {
    if (!_pageIndex) {
        _pageIndex = 1;
    }
    return _pageIndex;
}

- (AdvertisementHelper *)helper{
    if (!_helper) {
        _helper = [[AdvertisementHelper alloc]init];
    }
    return _helper;
}

#pragma mark - DZNEmptyDataSetSource Methods
//提示文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"暂无相关产品";
    UIFont *font = [UIFont systemFontOfSize:16];
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//显示的图案
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [UIImage imageNamed:@"noData"];
    
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

@end


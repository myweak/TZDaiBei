
//
//  UserCenterVC.m
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/19.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "UserCenterVC.h"
#import "LoanStrategyCell.h"
#import "UserViewModel.h"
#import "RootTableCell.h"
#import "MyProfileVC.h"
#import "AdvertisementHelper.h"
#import "JingYuDaiJieKuan-Swift.h"
#import "AboutUsVC.h"
#import "ArticleRecommendWebController.h"
#import "RootCollectionCell.h"
#import "HotToolView.h"

#define K_T_Cell @"t_cell"
#define K_C_Cell @"c_cell"

//读取图片
#define LoadImage(B)    [UIImage imageNamed:B]
@interface UserCenterVC () <UITableViewDelegate, UITableViewDataSource, HotToolViewDelegate>

@property (nonatomic, strong) UITableView *m_tableView;

// tableView header
@property (nonatomic, strong) UIView *m_headView;
@property (nonatomic, strong) UILabel *appNameLabel;
@property (nonatomic, strong) UILabel *appDescLabel;

/// 头部个人信息视图
@property (nonatomic, strong) UIView *m_BGView;

///事件相应按钮
@property (nonatomic, strong) UIButton *actionBtn;

/// 个人头像
@property (nonatomic, strong) UIImageView *m_iconImage;

///个人名称
@property (nonatomic, strong) UILabel *m_nameLabel;

/// 个人电话
@property (nonatomic, strong) UIButton *m_phonebtn;

@property (nonatomic, strong) UIButton *m_arrowBtn;

///抢金多宝模块相关
@property (nonatomic, strong) UIImageView *snatchgoldLeftImg;
@property (nonatomic, strong) UIImageView *snatchgoldRightImg;
@property (nonatomic, strong) NSArray *snatchgoldArray; // 夺宝array

@property (nonatomic, strong) NSMutableArray *m_articleRecommendArray; // 贷款攻略array

@property (nonatomic, strong) HotToolView *hotToolView; // 贷款攻略array
@property (nonatomic, strong) NSMutableArray *m_toolNameArray; // 工具 名字

@property (nonatomic, strong) NSArray *dataAry;

@property (nonatomic, strong) NSString *m_articleId;



//广告管理者
@property (nonatomic, strong) AdvertisementHelper *helper;

@end

@implementation UserCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self initView];
    
    self.dataAry = @[@[@"我的钱包", @"专属客服", @"帮助中心", @"官方公众号", @"意见反馈", @"浏览记录"]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification) name:MODIFY_NICKNAME object:nil];
    NSString *name = [kUserMessageManager getMessageManagerForObjectWithKey:KEY_NICK_NAME];
    _m_nameLabel.text = [NSString stringWithFormat:@"hi,%@",name];
    
}

- (void)notification
{
    NSString *name = [kUserMessageManager getMessageManagerForObjectWithKey:KEY_NICK_NAME];
    _m_nameLabel.text = [NSString stringWithFormat:@"hi,%@",name];
}
- (void)refreshData
{
    [self personalCenterSnatchGoldData];  //抢金夺宝.明星产品-个人中心banner
    [self.hotToolView personalCenterHotToolsData];
    [self articleRecommendListData];  //贷款攻略
    [self.m_tableView.mj_header endRefreshing];

}

- (void)initView
{
    PigMJRefreshGifHeader *header = [PigMJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.m_tableView.mj_header = header;

    [self.view addSubview:self.m_tableView];

    self.m_tableView.tableHeaderView = self.m_headView;
    
    [self.m_headView addSubview:self.appNameLabel];
    [self.m_headView addSubview:self.appDescLabel];
    
    [self.m_headView addSubview:self.m_BGView];
    [self.m_BGView addSubview:self.actionBtn];
    [self.m_BGView addSubview:self.m_iconImage];
    [self.m_BGView addSubview:self.m_nameLabel];
    [self.m_BGView addSubview:self.m_phonebtn];
    [self.m_BGView addSubview:self.m_arrowBtn];
    [self.m_BGView addSubview:self.snatchgoldLeftImg];
    [self.m_BGView addSubview:self.snatchgoldRightImg];
    
    [self.m_headView addSubview:self.hotToolView];
    
    [self.m_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.m_tableView);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.hotToolView).offset(12);
    }];
    
    [self.appNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.m_headView).offset(52);
        make.left.equalTo(self.m_headView).offset(12);
        make.right.equalTo(self.m_headView).offset(-12);
    }];
    
    [self.appDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.appNameLabel.mas_bottom).offset(4);
        make.left.equalTo(self.appNameLabel);
    }];
    
    [self.m_BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.appDescLabel.mas_bottom).offset(16);
        make.left.right.equalTo(self.appNameLabel);
        make.bottom.equalTo(self.snatchgoldLeftImg.mas_bottom).offset(23);
    }];
    
    [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.m_BGView);
        make.bottom.equalTo(self.snatchgoldLeftImg.mas_top).offset(-12);
    }];
    
    [self.m_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.m_BGView).offset(20);
        make.width.height.mas_equalTo(59);
    }];
    
    [self.m_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.m_iconImage.mas_right).offset(28);
        make.top.equalTo(self.m_iconImage).offset(3);
    }];
    
    [self.m_phonebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.m_nameLabel);
        make.top.equalTo(self.m_nameLabel.mas_bottom).offset(8);
    }];
    
    [self.m_arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.m_headView).offset(-23);
        make.centerY.equalTo(self.m_iconImage);
        make.width.mas_equalTo(kiP6WidthRace(4));
        make.height.mas_equalTo(kiP6WidthRace(8));
    }];
    
    [self.snatchgoldLeftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.m_BGView).offset(56);
        make.top.equalTo(self.m_iconImage.mas_bottom).offset(23);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(44);
    }];
    
    [self.snatchgoldRightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.m_BGView).offset(-56);
        make.top.equalTo(self.m_iconImage.mas_bottom).offset(23);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(44);
    }];
    
    [self.hotToolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.m_BGView.mas_bottom).offset(25);
        make.left.right.equalTo(self.m_BGView);
        make.height.mas_equalTo(108+1);
    }];
    
}
//抢金夺宝.明星产品 UI
- (void)settingSnatchgoldUI
{
    [self.snatchgoldLeftImg setHidden:YES];
    [self.snatchgoldRightImg setHidden:YES];
    [self.snatchgoldLeftImg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.m_iconImage.mas_bottom).offset(0);
        make.height.mas_equalTo(0);
    }];


    for (int i = 0; i < 2; i++) {
        if (i>=self.snatchgoldArray.count) {return;}
        [self.snatchgoldLeftImg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.m_iconImage.mas_bottom).offset(23);
            make.height.mas_equalTo(44);
        }];
        LUserModel *model = self.snatchgoldArray[i];
        NSURL *url = [[NSURL alloc]initWithString:model.img];
        if (i == 0) {
            [self.snatchgoldLeftImg sd_setImageWithURL: url];
            [self.snatchgoldLeftImg setHidden:NO];
        } else if(i == 1) {
            [self.snatchgoldRightImg sd_setImageWithURL: url];
            [self.snatchgoldRightImg setHidden:NO];
        }
    }
    
//    [self.m_tableView reloadData];
}

// 抢金夺宝.明星产品-个人中心banner
- (void)personalCenterSnatchGoldData
{
    [UserViewModel personalCenterSnatchGoldPath:personalCenterSnatchGold params:nil target:self success:^(UserModel *model) {
        if (model.code == 200) {
            self.snatchgoldArray = model.list;
            [self settingSnatchgoldUI];
        }
        [self.m_tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

//article/recommend/list  个人中心-贷款攻略文章列表接口(只返回前三条)
- (void)articleRecommendListData
{
    [UserViewModel articleRecommendListPath:articleRecommendList params:nil target:self success:^(UserModel *model) {
        [self.m_articleRecommendArray removeAllObjects];
        if (model.code == 200) {
            [self.m_articleRecommendArray addObjectsFromArray:model.list];
        }else{
            [[ZXAlertView shareView] showMessage:model.msg?:@""];
        }
        [self.m_tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
//  点赞  article/add/likeNum/{articleId}
- (void)articleAddLikeNumData
{
    NSString *str = [NSString stringWithFormat:@"%@%@",articleAddLikeNum,self.m_articleId];
    [UserViewModel articleAddLikeNumPath:str params:nil target:self success:^(UserModel *model) {
        if (model.code == 200) {
            [self articleRecommendListData];
        }else{
            [[ZXAlertView shareView] showMessage:model.msg?:@""];
        }
        [self.m_tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma  mark  UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return self.m_articleRecommendArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kiP6WidthRace(110);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kWidthRace(15), kWidthRace(0), 100, kWidthRace(40))];
        label.font = KFont(17);
        label.textColor = UIColorHex(@"#333333");
        label.text = @"贷款攻略";
        [view addSubview:label];
    
        return view;
}
//返回头分组标题高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LoanStrategyCell *cell = [LoanStrategyCell creatCellWithTableView:tableView];
    cell.accessoryType=UITableViewCellAccessoryNone;
    LUserModel *model = self.m_articleRecommendArray[indexPath.row];
    [cell loanStrategyModelValue:model];
    cell.giveALikeBlock = ^{
        //取消点赞功能  --Dason
        //            self.m_articleId = model.articleId;
        //            [self articleAddLikeNumData]; //点赞
    };
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 //贷款攻略
        LUserModel *model = self.m_articleRecommendArray[indexPath.row];
       
        ArticleRecommendWebController *vc = [[ArticleRecommendWebController alloc] init];
        [vc showWebWithURL:model.url
                  andTitle:model.title
           andFromPosition:[NSString stringWithFormat:@"%ld", (indexPath.row + 1)]
       withSuperController:self];

}

#pragma mark ====== RootTableCellDelegate ======

//点击UICollectionViewCell的代理方法
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content andIsWeb:(BOOL )isWeb cooperation:(NSString *)cooperation {
    //埋点
    [SensorsAnalyticsSDKHelper myHotToolEventWithPosition:cooperation];
    
    if (isWeb) {
        BaseWebViewController *vc = [[BaseWebViewController alloc] init];
        vc.url = [NSString stringWithFormat:@"%@",[NSURL URLWithString:content]?:@""];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        // 如果是浏览记录的话跳转原生
        if ([cooperation isEqualToString:@"浏览记录"]) {
            ProductItemBrowseHistoryVC *targetVC = [[ProductItemBrowseHistoryVC alloc]init];
            [self.navigationController pushViewController:targetVC animated:YES];

        }else if ([cooperation isEqualToString:@"商务合作"])
        {
            AboutUsVC *targetVC = [[AboutUsVC alloc]init];
            [self.navigationController pushViewController:targetVC animated:YES];

        }else if ([cooperation isEqualToString:@"专属客服"])
        {
            CustomeServiceAlert *alert = [[CustomeServiceAlert alloc]initWithSureUpdateClosure:^{
                //复制到剪贴板
                [[UIPasteboard generalPasteboard]setString: @"orangekf01"];
                //打开微信
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"]];
                }
            }];
            
            [alert showAlertViewInViewController:self leftOrRightMargin:30];
        }
        return;
    };
    
}
#pragma getter

- (UITableView *)m_tableView
{
    if (!_m_tableView) {//UITableViewStyleGrouped
        _m_tableView = InsertTableView(nil, CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.view.frame)), self, self, UITableViewStylePlain, UITableViewCellSeparatorStyleSingleLine);
        
        _m_tableView.backgroundColor = UIColor.whiteColor;

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
        _m_headView = InsertView(nil, CGRectMake(0, 0, kScreenWidth, 428), nil);
        
        // gradient
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0,0,kScreenWidth,428);
        gl.startPoint = CGPointMake(0, 0);
        gl.endPoint = CGPointMake(1, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:108/255.0 green:80/255.0 blue:196/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:102/255.0 green:82/255.0 blue:197/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:71/255.0 green:96/255.0 blue:205/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:67/255.0 green:98/255.0 blue:206/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0), @(0.2f), @(0.4f), @(1.0f)];
        [_m_headView.layer insertSublayer:gl atIndex:0];
        
        _m_headView.layer.masksToBounds = YES;
    }
    return _m_headView;
}

- (UILabel *)appNameLabel {
    if (!_appNameLabel) {
        _appNameLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"", KFont(18), UIColorHex(@"#ffffff"), NO);
        _appNameLabel.text = [NSString getMyApplicationName];
    }
    return _appNameLabel;
}

- (UILabel *)appDescLabel {
    if (!_appDescLabel) {
        _appDescLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"", KFont(10), UIColorHex(@"#ffffff"), NO);
        _appDescLabel.text = @"用钱就用分期乐贷款";
    }
    return _appDescLabel;
}

- (UIView *)m_BGView
{
    if (!_m_BGView) {
        _m_BGView = InsertView(nil, CGRectMake(0, 0, kScreenWidth, 162), UIColorHex(@"#3a80ff"));//
        //添加kvc
        [_m_BGView addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _m_BGView;
}

- (UIButton *)actionBtn{
     if (!_actionBtn) {
         _actionBtn = [[UIButton alloc]init];
         [_actionBtn addTarget:self action:@selector(headClick:) forControlEvents:UIControlEventTouchUpInside];
     }
    return _actionBtn;
}

- (UIImageView *)m_iconImage
{
    if (!_m_iconImage) {
        _m_iconImage = [[UIImageView alloc]init];
        NSString *headImage = [kUserMessageManager getMessageManagerForObjectWithKey:KEY_HEAD_PORTRAIT];
        [_m_iconImage sd_setImageWithURL:[NSURL URLWithString:headImage]];
        _m_iconImage.layer.masksToBounds = YES;
        _m_iconImage.layer.cornerRadius = 29;
        [_m_iconImage setUserInteractionEnabled:NO];
    }
    return _m_iconImage;
}

- (UILabel *)m_nameLabel
{
    if (!_m_nameLabel) {
        _m_nameLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"", KFont(18), UIColorHex(@"#ffffff"), NO);
    }
    return _m_nameLabel;
}

- (UIButton *)m_phonebtn
{
    if (!_m_phonebtn) {
        _m_phonebtn = [[UIButton alloc]init];
        [_m_phonebtn setTitle:@"分期乐贷款金融账户" forState:UIControlStateNormal];
        [_m_phonebtn setTitleColor:UIColorHex(@"#ffffff") forState:UIControlStateNormal];
        _m_phonebtn.titleLabel.font = KFont(11);
        [_m_phonebtn setBackgroundImage:[UIImage imageNamed:@"user_btnBG"] forState:UIControlStateNormal];
        [_m_phonebtn setUserInteractionEnabled:NO];
        
    }
    return _m_phonebtn;
}

- (UIButton *)m_arrowBtn
{
    if (!_m_arrowBtn) {
        _m_arrowBtn  = InsertImageButton(nil, CGRectZero, 0, [UIImage imageNamed:@"user_desc"], nil, self, nil);
        [_m_arrowBtn setUserInteractionEnabled:NO];
    }
    return _m_arrowBtn;
}


- (UIImageView *)snatchgoldLeftImg{
    if (!_snatchgoldLeftImg) {
        _snatchgoldLeftImg = [[UIImageView alloc]init];
        _snatchgoldLeftImg.tag = 10000;
        _snatchgoldLeftImg.contentMode = UIViewContentModeScaleAspectFit;
        [_snatchgoldLeftImg setUserInteractionEnabled:YES];
        //解决手势冲突
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(snatchgoldClick:)];
        [_snatchgoldLeftImg addGestureRecognizer:tap];

        
    }
    return _snatchgoldLeftImg;
}

- (UIImageView *)snatchgoldRightImg{
    if (!_snatchgoldRightImg) {
        _snatchgoldRightImg = [[UIImageView alloc]init];
        _snatchgoldRightImg.tag = 10000 + 1;
        _snatchgoldRightImg.contentMode = UIViewContentModeScaleAspectFit;
        [_snatchgoldRightImg setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(snatchgoldClick:)];
        [_snatchgoldRightImg addGestureRecognizer:tap];
    }
    return _snatchgoldRightImg;
}

- (NSArray *)snatchgoldArray{
    if (!_snatchgoldArray) {
        _snatchgoldArray = [[NSArray alloc] init];
    }
    return _snatchgoldArray;
}

- (NSMutableArray *)m_articleRecommendArray
{
    if (!_m_articleRecommendArray) {
        _m_articleRecommendArray = [[NSMutableArray alloc] init];
    }
    return _m_articleRecommendArray;
}

- (HotToolView *)hotToolView {
    if (!_hotToolView) {
        _hotToolView = [[HotToolView alloc] init];
        _hotToolView.delegate = self;
    }
    return _hotToolView;
}

- (NSMutableArray *)m_toolNameArray
{
    if (!_m_toolNameArray) {
        _m_toolNameArray  = [[NSMutableArray alloc] init];
    }
    return _m_toolNameArray;
}

- (AdvertisementHelper *)helper{
    if (!_helper) {
        _helper = [[AdvertisementHelper alloc]init];
    }
    return _helper;
}

#pragma mark - action
- (void)headClick:(UIButton *)button
{
    MyProfileVC *myVC = [[MyProfileVC alloc] init];
    [self.navigationController pushViewController:myVC animated:YES];
}

- (void)moreClick
{
    NSLog(@"更多");
    NSString *m_url = [kUserMessageManager getMessageManagerForObjectWithKey:ARTICLEMOREURL];
    BaseWebViewController *vc = [[BaseWebViewController alloc] init];
    vc.url = [NSString stringWithFormat:@"%@",[NSURL URLWithString:m_url]?:@""];
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)snatchgoldClick:(UITapGestureRecognizer *)sender{

    UIView *view = sender.view;
    NSInteger index = view.tag - 10000;
    LUserModel *model = self.snatchgoldArray[index];
    NSString *position = @"";
    if (index == 0) {
        position = @"我的-卡片左";
    } else {
        position = @"我的-卡片右";
    }
    AdWebViewController *vc = [AdWebViewController new];
    [vc showWebWithURL:[NSString stringWithFormat:@"%@",[NSURL URLWithString:model.url]?:@""] andProductIcon:@""
   andProductMaxAmount:@""
  andProductMerchartid:model.mchId
        andProductName:model.mchName
        andProductTags:@""
       andProductTitle:@""
         andProductUrl:@""
       andFromPosition:position
  andIsNeedSaveHistory:YES
   withSuperController:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.helper getAdvDialogWithPosId:@"3" SuperVC:self];
    [self personalCenterSnatchGoldData];  //抢金夺宝.明星产品-个人中心banner
    [self articleRecommendListData];  //贷款攻略
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
   
    [self.m_tableView reloadData];
}

//改变状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark ====== UICollectionViewDelegate ======
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    if (self.m_dataAry.count == 0) {
//        return 1;
//    } else {
//        return self.m_dataAry.count;
//    }
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RootCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RootCollectionCell" forIndexPath:indexPath];
//    if (self.m_dataAry.count >0) {
//        LUserModel *model = self.m_dataAry[indexPath.row];
//        cell.m_label.text = model.name;
//        if ([model.name isEqualToString:@"浏览记录"]||[model.name isEqualToString:@"商务合作"]||[model.name isEqualToString:@"专属客服"]){
//            cell.m_imageView.image = [UIImage imageNamed:model.icon];
//        }else{
//            [cell.m_imageView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
//        }
//    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemAtIndexPath:withContent:andIsWeb:cooperation:)]) {
//
//        LUserModel *model =self.m_dataAry[indexPath.row];
//        //        [self.delegate didSelectItemAtIndexPath:indexPath withContent:model.url andIsWeb:@"浏览记录"
//        if ([model.name isEqualToString:@"浏览记录"]||[model.name isEqualToString:@"商务合作"]||[model.name isEqualToString:@"专属客服"]) {
//            [self.delegate didSelectItemAtIndexPath:indexPath withContent:model.url andIsWeb:NO cooperation:model.name];
//        } else {
//            [self.delegate didSelectItemAtIndexPath:indexPath withContent:model.url andIsWeb:YES cooperation:model.name];
//        }
//    }
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (self.m_BGView == object && [keyPath isEqualToString:@"bounds"]){
        //        NSLog(@"w:%lf h:%lf",self.bgView.bounds.size.width
        //              ,self.bgView.bounds.size.height);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.m_tableView reloadData];
        });
        
    } else {
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}


- (void)dealloc{
    [self.m_BGView removeObserver:self forKeyPath:@"bounds"];
}

@end

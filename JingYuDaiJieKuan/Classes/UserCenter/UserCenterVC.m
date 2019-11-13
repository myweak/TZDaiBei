
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

#define K_T_Cell @"t_cell"
#define K_C_Cell @"c_cell"

//读取图片
#define LoadImage(B)    [UIImage imageNamed:B]
@interface UserCenterVC () <UITableViewDelegate, UITableViewDataSource,RootCellDelegate>

@property (nonatomic, strong) UITableView *m_tableView;

@property (nonatomic, strong) UIView *m_headView;

@property (nonatomic, strong) UIView *m_BGView;

@property (nonatomic, strong) UIImageView *m_iconImage;

@property (nonatomic, strong) UILabel *m_nameLabel;

@property (nonatomic, strong) UILabel *m_phoneLabel;

@property (nonatomic, strong) UIButton *m_arrowBtn;

@property (nonatomic, strong) UIButton *m_aboutUsBtn; //关于我们

@property (nonatomic, strong) UIImageView *m_cutImage;

@property (nonatomic, strong) UIButton *m_contentBtn;

@property (nonatomic, strong) UIButton *m_NewArrowBtn;

///抢金多宝模块相关
@property (nonatomic, strong) UIImageView *snatchgoldLeftImg;
@property (nonatomic, strong) UIImageView *snatchgoldRightImg;
@property (nonatomic, strong) NSArray *snatchgoldArray; // 夺宝array

@property (nonatomic, strong) NSMutableArray *m_articleRecommendArray; // 贷款攻略array

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
//    [self personalCenterSnatchGoldData];  //抢金夺宝.明星产品-个人中心banner
//    [self personalCenterHotToolsData]; //热门工具
  
    
    self.dataAry = @[@[@"我的钱包", @"专属客服", @"帮助中心", @"官方公众号", @"意见反馈", @"浏览记录"]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification) name:MODIFY_NICKNAME object:nil];
    NSString *name = [kUserMessageManager getMessageManagerForObjectWithKey:KEY_NICK_NAME];
    _m_nameLabel.text = name;
    
    

}

- (void)notification
{
    NSString *name = [kUserMessageManager getMessageManagerForObjectWithKey:KEY_NICK_NAME];
    _m_nameLabel.text = name;
}
- (void)refreshData
{
    [self personalCenterSnatchGoldData];  //抢金夺宝.明星产品-个人中心banner
    //    [self personalCenterHotToolsData]; //热门工具
    [self articleRecommendListData];  //贷款攻略
    [self.m_tableView.mj_header endRefreshing];

}

- (void)initView
{
    PigMJRefreshGifHeader *header = [PigMJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.m_tableView.mj_header = header;

    [self.view addSubview:self.m_tableView];
    
    self.m_tableView.tableHeaderView = self.m_headView;
    
    [self.m_headView addSubview:self.snatchgoldLeftImg];
    [self.m_headView addSubview:self.snatchgoldRightImg];
    
    [self.m_headView addSubview:self.m_BGView];
    [self.m_BGView addSubview:self.m_iconImage];
    [self.m_BGView addSubview:self.m_nameLabel];
    [self.m_BGView addSubview:self.m_phoneLabel];
    [self.m_BGView addSubview:self.m_arrowBtn];
    [self.m_BGView addSubview:self.m_aboutUsBtn];
    
    [self.m_headView addSubview:self.m_cutImage];
    [self.m_cutImage addSubview:self.m_contentBtn];
    [self.m_cutImage addSubview:self.m_NewArrowBtn];

    
    [self.snatchgoldLeftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.m_headView);
        make.top.mas_equalTo(self.m_BGView.mas_bottom);
        make.height.equalTo(self.snatchgoldLeftImg.mas_width).multipliedBy(236/375.0);
    }];
    
    [self.snatchgoldRightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.snatchgoldLeftImg.mas_right);
        make.right.equalTo(self.m_headView);
        make.top.equalTo(self.snatchgoldLeftImg);
        make.width.equalTo(self.snatchgoldLeftImg);
        make.height.equalTo(self.snatchgoldLeftImg);
    }];
    
    [self.m_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(20));
        make.top.mas_equalTo(kiP6WidthRace(22)+kStatusBarH);
        make.width.height.mas_equalTo(kiP6WidthRace(116/2));
    }];
    
    [self.m_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.m_iconImage.mas_right).offset(kiP6WidthRace(15));
        make.top.mas_equalTo(kiP6WidthRace(61/2)+kStatusBarH);
    }];
    
    [self.m_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.m_iconImage.mas_right).offset(kiP6WidthRace(15));
        make.top.mas_equalTo(self.m_nameLabel.mas_bottom).offset(kiP6WidthRace(12));
    }];
    
    [self.m_arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.m_phoneLabel.mas_right).offset(kiP6WidthRace(16));
        make.centerY.equalTo(self.m_phoneLabel.mas_centerY);
        make.width.mas_equalTo(kiP6WidthRace(6));
        make.height.mas_equalTo(kiP6WidthRace(10));
    }];
    
    [self.m_aboutUsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(kiP6WidthRace(-16));
        make.top.mas_equalTo(kiP6WidthRace(22)+kStatusBarH);
        make.width.height.mas_equalTo(kiP6WidthRace(20));
    }];
    
    [self.m_cutImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(20));
        make.top.mas_equalTo(self.m_iconImage.mas_bottom).offset(kiP6WidthRace(37/2));
        make.right.mas_equalTo(-kiP6WidthRace(20));
        make.height.mas_equalTo(kiP6WidthRace(87/2));
    }];
    
    [self.m_contentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(20));
        make.centerY.equalTo(self.m_cutImage.mas_centerY);
        make.right.mas_equalTo(-kiP6WidthRace(0));
        make.height.mas_equalTo(kiP6WidthRace(87/2));
    }];
    
    [self.m_NewArrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kiP6WidthRace(23/2));
        make.centerY.mas_equalTo(self.m_contentBtn.mas_centerY);
        make.width.mas_equalTo(kiP6WidthRace(6));
        make.height.mas_equalTo(kiP6WidthRace(10));
    }];
}
//抢金夺宝.明星产品 UI
- (void)settingSnatchgoldUI
{
    [self.snatchgoldLeftImg setHidden:YES];
    [self.snatchgoldRightImg setHidden:YES];
    [self.snatchgoldLeftImg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.snatchgoldLeftImg.mas_width).multipliedBy(0);
        [self.m_headView setHeight:kiP6WidthRace(240)+kStatusBarH - kiP6WidthRace(90)];
    }];
   
   
    for (int i = 0; i < 2; i++) {
        if (i>=self.snatchgoldArray.count) {return;}
        [self.snatchgoldLeftImg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.snatchgoldLeftImg.mas_width).multipliedBy(236/375.0);
            [self.m_headView setHeight:kiP6WidthRace(240)+kStatusBarH];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.m_articleRecommendArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return kiP6WidthRace(150);
    }
    return kiP6WidthRace(110);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    [view setBackgroundColor:UIColorHex(@"#fafafa")]; // 改变标题的颜色，也可用图片
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kWidthRace(15), kWidthRace(0), 100, kWidthRace(40))];
    label.font = KFont(17);
    label.textColor = UIColorHex(@"#333333");
    [view addSubview:label];
    
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = KFont(13);
    [button setTitleColor:UIColorHex(@"#818183") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kiP6WidthRace(14));
        make.centerY.equalTo(label.mas_centerY);
        make.width.mas_equalTo(kiP6WidthRace(50));
        make.height.mas_equalTo(kiP6WidthRace(40));
    }];
    
    if (section == 0) {
        label.text = @"热门工具";
        button.hidden = YES;
    }else{
        label.text = @"贷款攻略";
        button.hidden = NO;
        [button setTitle:@"更多 >" forState:UIControlStateNormal];
    }
    return view;
    
}
//返回头分组标题高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [tableView registerClass:[RootTableCell class] forCellReuseIdentifier:K_C_Cell];
        RootTableCell *cell = [tableView dequeueReusableCellWithIdentifier:K_C_Cell forIndexPath:indexPath];
        cell.delegate = self;
        return cell;

    }else if (indexPath.section == 1)
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
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) { //贷款攻略
        LUserModel *model = self.m_articleRecommendArray[indexPath.row];
       
        ArticleRecommendWebController *vc = [[ArticleRecommendWebController alloc] init];
        [vc showWebWithURL:model.url
                  andTitle:model.title
           andFromPosition:[NSString stringWithFormat:@"%ld", (indexPath.row + 1)]
       withSuperController:self];
    }
}

#pragma mark ====== RootTableCellDelegate ======
- (void)updateTableViewCellHeight:(RootTableCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath {
//    if (![self.dicH[indexPath] isEqualToNumber:@(height)]) {
//        self.dicH[indexPath] = @(height);
//        [self.tableView reloadData];
//    }
}

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
        
        _m_tableView.height = self.view.height;

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
        _m_headView = InsertView(nil, CGRectMake(0, 0, kScreenWidth, kiP6WidthRace(240)+kStatusBarH), [UIColor redColor]);
    }
    return _m_headView;
}

- (UIView *)m_BGView
{
    if (!_m_BGView) {
        _m_BGView = InsertView(nil, CGRectMake(0, 0, kScreenWidth, kiP6WidthRace(120)+kStatusBarH), UIColorHex(@"#3a80ff"));//
    }
    return _m_BGView;
}

- (UIImageView *)m_iconImage
{
    if (!_m_iconImage) {
        _m_iconImage = InsertImageView(nil, CGRectZero, [UIImage imageNamed:@""]);//m_icon
        NSString *headImage = [kUserMessageManager getMessageManagerForObjectWithKey:KEY_HEAD_PORTRAIT];
        [_m_iconImage sd_setImageWithURL:[NSURL URLWithString:headImage]];
        _m_iconImage.layer.masksToBounds = YES;
        _m_iconImage.layer.cornerRadius = 29;
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

- (UILabel *)m_phoneLabel
{
    if (!_m_phoneLabel) {
        _m_phoneLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"", KFont(14), UIColorHex(@"#ffffff"), NO);
        NSString *phone = [kUserMessageManager getMessageManagerForObjectWithKey:USER_MOBILE];
        NSString *strLabel = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        _m_phoneLabel.text = strLabel;
    }
    return _m_phoneLabel;
}

- (UIButton *)m_arrowBtn
{
    if (!_m_arrowBtn) {
        _m_arrowBtn  = InsertImageButton(nil, CGRectZero, 100, [UIImage imageNamed:@"justOnline"], nil, self, @selector(headClick:));
    }
    return _m_arrowBtn;
}

- (UIButton *)m_aboutUsBtn
{
    if (!_m_aboutUsBtn) {
        _m_aboutUsBtn = InsertImageButton(nil, CGRectZero, 101, [UIImage imageNamed:@"setUpThe"], nil, self, @selector(headClick:));
    }
    return _m_aboutUsBtn;
}

- (UIImageView *)m_cutImage
{
    if (!_m_cutImage) {
        _m_cutImage = InsertImageView(nil, CGRectZero, [UIImage imageNamed:@"newCutImage"]);
        [_m_cutImage setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(newMouthClick)];
        [_m_cutImage addGestureRecognizer:tap];
        
    }
    return _m_cutImage;
}

- (UIButton *)m_contentBtn
{
    if (!_m_contentBtn) {
        _m_contentBtn = InsertButtonWithType(nil, CGRectZero, 100, self, nil, UIButtonTypeCustom);
        [_m_contentBtn setUserInteractionEnabled:NO];
        NSString *title = [kUserMessageManager getMessageManagerForObjectWithKey:MYNEWPRODUCTMSG];
        [_m_contentBtn setTitle:title forState:UIControlStateNormal];
        [_m_contentBtn.titleLabel setFont:KFont(12)];
        [_m_contentBtn setTitleColor:UIColorHex(@"#3a80ff")
                                forState:UIControlStateNormal];
        _m_contentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    }
    return _m_contentBtn;
}

- (UIButton *)m_NewArrowBtn
{
    if (!_m_NewArrowBtn) {
        _m_NewArrowBtn  = InsertImageButton(nil, CGRectZero, 102, [UIImage imageNamed:@"justOnline"], nil, self, nil);
        [_m_NewArrowBtn setUserInteractionEnabled:NO];
    }
    return _m_NewArrowBtn;
}

- (UIImageView *)snatchgoldLeftImg{
    if (!_snatchgoldLeftImg) {
        _snatchgoldLeftImg = [[UIImageView alloc]init];
        _snatchgoldLeftImg.tag = 10000;
        _snatchgoldLeftImg.contentMode = UIViewContentModeScaleAspectFill;
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
        _snatchgoldRightImg.contentMode = UIViewContentModeScaleAspectFill;
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
    if (button.tag == 101) {
        NSLog(@"设置");
        MyProfileVC *myVC = [[MyProfileVC alloc] init];
        [self.navigationController pushViewController:myVC animated:YES];
    }else{
        NSLog(@"dddddd");
    }
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



- (void)newMouthClick
{
    NSString *urlStr = [kUserMessageManager getMessageManagerForObjectWithKey:WATERMCHURL];
    if (![urlStr isEqualToString:@""] && urlStr != nil) {
        BaseWebViewController *vc = [[BaseWebViewController alloc] init];
        vc.url = urlStr?:@"";
        NSString *title = [kUserMessageManager getMessageManagerForObjectWithKey:MYNEWPRODUCTTITLE];
        vc.navigationItem.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }
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

@end

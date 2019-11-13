//
//  TZProductNewPageVC.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/4.
//  Copyright © 2019 Jincaishen. All rights reserved.
//
#define KNewsItem_H 94
#import "TZProductNewPageVC.h"
#import "TZProductNewsView.h"
#import "TZProductPageModel.h"
#import "ProductItemViewModel.h"

@interface TZProductNewPageVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong ,nonatomic) UITableView *m_tableView;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation TZProductNewPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻资讯";
    [self initWithUI];
    [self bindSignal];
    [self refreshData];
}


- (void)initWithUI{
    [self.view addSubview:self.m_tableView];
    
}

- (void)bindSignal{

    
}
- (void)refreshData{
    [self postArticleAllListPathUrl];
}


// 新闻
- (void)postArticleAllListPathUrl{
    @weakify(self)
    [ProductItemViewModel articleRecommendListPath:articleAllList_Path params:nil target:self success:^(TZProductPageModel * _Nonnull model) {
        @strongify(self)
        self.dataArr = model.newsList;
        [self.m_tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [[ZXAlertView shareView] showMessage:kloadfailedNotNetwork];
    }];
}

// 新闻数量统计
- (void)postArticleAddLikeNumPathUrlWithID:(NSString *)ID{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",articleAddLikeNum_Path,ID];

    [ProductItemViewModel articleAddLikeNumPath:urlStr params:nil target:self success:^(TZProductPageModel * _Nonnull model) {
    } failure:^(NSError * _Nonnull error) {
    }];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KNewsItem_H;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *ID = [NSString stringWithFormat:@"%@ID",NSStringFromClass(self.class)];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSLog(@"创建cell--%ld",indexPath.row);
        TZProductNewsView *newsView = [[TZProductNewsView alloc] init];
        newsView.frame = CGRectMake(0, 0, kScreenWidth, KNewsItem_H);
         [cell.contentView addSubview:newsView];
        cell.viewContent = newsView;
        
        newsView.imageView_W.constant = 100;
        newsView.imageView_H.constant = 63;
        newsView.titleLabel_L.constant = 19;
        newsView.titleLabel_T.constant = 5;
        
    }
    //
    TZProductNewsModel *model = [self.dataArr objectAtIndex:indexPath.row];
    TZProductNewsView *itemView = (TZProductNewsView *)cell.viewContent;
    [itemView setModel:model];
    itemView.contentLabel.text = @"";
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TZProductNewsModel *model = [self.dataArr objectAtIndex:indexPath.row];
    
    // 浏览量统计
    if (!checkStrEmty(model.articleId)) {
        [self postArticleAddLikeNumPathUrlWithID:model.articleId];
    }
    BaseWebViewController *webVC = [BaseWebViewController new];
    webVC.title = model.title;
    webVC.url = model.url;
    [self.navigationController pushViewController:webVC animated:YES];
}
#pragma mark - UI

- (UITableView *)m_tableView{
    
    if (!_m_tableView) {//UITableViewStyleGrouped
        _m_tableView = InsertTableView(nil, CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.view.frame)), self, self, UITableViewStylePlain, UITableViewCellSeparatorStyleSingleLine);
        _m_tableView.height = self.view.height;
        _m_tableView.rowHeight = UITableViewAutomaticDimension;
        _m_tableView.estimatedRowHeight = 120;
        
        if ([_m_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [_m_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_m_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [_m_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        _m_tableView.backgroundColor = [UIColor whiteColor];
        _m_tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
        
    }
    return _m_tableView;
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

//
//  AboutUsVC.m
//  JingYuDai
//
//  Created by JY on 2018/3/31.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "AboutUsVC.h"
#import "HeaderScrollview.h"
#import "BodyScrollview.h"
@interface AboutUsVC ()<HeaderScrollviewDelegate,BodyScrollviewDelegate>
@property(strong, nonatomic) HeaderScrollview *m_headerScrollView;
@property(strong, nonatomic) BodyScrollview   *m_bodyScrollview;

@end

@implementation AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpHeaderView];
    [self setUpBodyView];
    
}

#pragma getter
//设置头滚动视图
- (void)setUpHeaderView{
    _m_headerScrollView  = [[HeaderScrollview alloc] initWithFrame:CGRectMake(0,0, kScreenWidth,kiP6WidthRace(44))];
    //设置代理,获取点击事件
    _m_headerScrollView.delegate = self;
    _m_headerScrollView.dataSource = [NSMutableArray arrayWithArray:[self m_setUpDataSource]];
    [self.view addSubview:_m_headerScrollView];
}

//设置 body 滚动视图
- (void)setUpBodyView{
    
    _m_bodyScrollview = [[BodyScrollview alloc] initWithFrame:CGRectMake(0, kiP6WidthRace(44), kScreenWidth, kScreenHeight - kiP6WidthRace(44))];
    _m_bodyScrollview.delegate = self;
    _m_bodyScrollview.pages = [self m_setUpDataSource];
//    _m_bodyScrollview.pageDataSource = [self m_setUpDataSource];
    [self.view addSubview:_m_bodyScrollview];
}

//设置数据源
- (NSArray *)m_setUpDataSource{
    return @[@"销售订单(0)",@"退货订单(0)",@"销售单(0)",@"退货单(0)",@"退货单(1)",@"退货单(2)"];
}

#pragma mark -- HeaderScrollviewDelegate
- (void)header_disSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_m_bodyScrollview scrollToDesPageWithIndexPath:indexPath];
}

#pragma mark -- BodyScrollviewDelegate
- (void)body_didScrollAtPage:(NSInteger)page{
    
    [_m_headerScrollView scrollCollectionItemToDesWithDesIndex:page];
}

- (void)body_didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Tip" message:[NSString stringWithFormat:@"点击了第 %ld 页  第 %ld 行",indexPath.section, indexPath.row] preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertViewStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//
//  ViewControllerVC.m
//  JingYuDai
//
//  Created by xiaoguo on 2018/7/16.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "ViewControllerVC.h"

@interface ViewControllerVC ()

@end

@implementation ViewControllerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(kScreenHeight);
    }];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;

    _scrollView.contentSize = CGSizeMake(0, kScreenHeight);
}
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor orangeColor];
    }
    return _scrollView;
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

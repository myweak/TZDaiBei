//
//  BaseUrlVC.m
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/22.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "BaseUrlVC.h"
#import "UIFactory.h"
#import "CustomUrlViewController.h"

@interface BaseUrlVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation BaseUrlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"IP";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addAction:)];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"NetworkEnvironment" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    self.dataArray = [NSMutableArray array];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self.dataArray addObject:obj];
    }];
    
    
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(@0);
    }];
    if (@available(iOS 11.0,*)) {
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"BaseUrlVCCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count > 0) {
        NSUserDefaults *userDefault  = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:self.dataArray[indexPath.row] forKey:@"NetworkEnvironmentType"];
        [userDefault synchronize];
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
}

-(void)addAction:(id)sender
{
    kSelfWeak;
    CustomUrlViewController *url = [[CustomUrlViewController alloc]init];
    url.addUrlBlock = ^(NSString *key,NSString *value) {
        [weakSelf.dataArray addObject:value];
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:url animated:YES];
}

-(UITableView *)tableView
{
    if (!_tableView ) {
        _tableView = [UIFactory createTableView:CGRectZero dataSource:self delegete:self style:UITableViewStylePlain];
    }
    return _tableView;
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

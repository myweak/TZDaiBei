//
//  MoreVC.m
//  JingYuDaiJieKuan
//
//  Created by air on 2018/3/22.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "MoreVC.h"
#import "MoreCell.h"
#import "FeedbackVC.h"


@interface MoreVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UIView *headView;
@property(nonatomic,strong) UIImageView *Img;
@property(nonatomic,strong) UILabel *whaleLabel;

@end

@implementation MoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多";
    self.view.backgroundColor = kColorLightgrayBackground;
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kiP6WidthRace(182))];
    self.m_tableView.tableHeaderView = self.headView;

    [self.view addSubview:self.m_tableView];

    [self.headView addSubview:self.Img];
    
    [self.view addSubview:self.whaleLabel];
    
    [self initView];
}

#pragma getter

- (void)initView{
    [self.Img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(0));
        make.top.mas_equalTo(kiP6WidthRace(0));
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(kiP6WidthRace(182));
    }];
    
    [self.whaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(kiP6WidthRace(-20));
        make.width.mas_equalTo(kScreenWidth);
    }];
    
}

#pragma mark -- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KWidth(50);
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreCell *cell = [MoreCell creatCellWithTableView:tableView];
    if (indexPath.section == 0) {
        cell.leftLabel.text = @"意见反馈";
        cell.arrowImg.image = [UIImage imageNamed:@"arrow"];
//        cell.rightLabel.text = @"箭头";
    }else if (indexPath.section == 1){
        cell.leftLabel.text= @"官方微信号";
        cell.rightLabel.text = @"人民鲸鱼公众号";
    }else if (indexPath.section == 2){
        cell.leftLabel.text = @"官方客服电话";
          NSString *iphone = ChangeNullData([kUserMessageManager getMessageManagerForObjectWithKey:SERVICE_PHONE]);
        cell.rightLabel.text = iphone;
    }else if (indexPath.section == 3){
        cell.leftLabel.text = @"当前版本";

        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
        NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
        NSString *versionStr = [NSString stringWithFormat:@"v%@",appVersion];
        cell.rightLabel.text = versionStr;
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        //意见反馈
        FeedbackVC *feedbackVC = [[FeedbackVC alloc] init];
        [self.navigationController pushViewController:feedbackVC animated:YES];
    }else if(indexPath.section == 2){
        //客服电话
        NSString *iphone = ChangeNullData([kUserMessageManager getMessageManagerForObjectWithKey:SERVICE_PHONE]);
        NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel://%@",iphone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else{
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return KWidth(0.01);

}

- (UITableView *)m_tableView
{
    if (!_m_tableView) {
        _m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height) style:UITableViewStylePlain];
        _m_tableView.delegate = self;
        _m_tableView.dataSource = self;
//        InsertTableView(nil, CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.view.frame)), self, self, UITableViewStylePlain, UITableViewCellSeparatorStyleSingleLine);
        if (IS_iPhoneX) {
            _m_tableView.height = self.view.height;
        }
        
        if ([_m_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [_m_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([_m_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [_m_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return _m_tableView;
}

- (UIImageView *)Img{
    if (!_Img) {
        _Img = InsertImageView(nil, CGRectZero, [UIImage imageNamed:@"more_BG"]);
    }
    return _Img;
}

- (UILabel *)whaleLabel
{
    if (!_whaleLabel) {
        _whaleLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"Copyright Reserved 2018©滴滴速借", kFontSize12, UIColorRGB(153, 153, 153), NO);
    }
    return _whaleLabel;
}
@end

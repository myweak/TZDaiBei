//
//  AuditStateVC.m
//  JingYuDaiJieKuan
//
//  Created by JY on 2018/8/10.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "AuditStateVC.h"
#import "RegularRollInBottomView.h"

@interface AuditStateVC ()

@property (nonatomic, strong) UIImageView *m_auditImage;

@property (nonatomic, strong) UILabel *m_testLabel;

@property (nonatomic, strong) UILabel *m_auditLabel;

@property (nonatomic, strong) RegularRollInBottomView * m_bottomView;

@end

@implementation AuditStateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"审核中";

    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController
    [self addLeftButton:@"" seletedImage:nil title:nil target:nil action:nil];
    [self initView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 禁用返回手势
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 开启返回手势
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;
}

#pragma initViewUI
- (void)initView{
    
    [self.view addSubview:self.m_auditImage];
    [self.view addSubview:self.m_auditLabel];
    [self.view addSubview:self.m_testLabel];
    
    self.m_bottomView = [[RegularRollInBottomView alloc]init];
    [self.view addSubview:self.m_bottomView];
    ViewRadius(self.m_bottomView,kiP6WidthRace(48/2));
    self.m_bottomView.layer.masksToBounds = YES;
    self.m_bottomView.m_rollInBtn.backgroundColor = kColorBlue;
    self.m_bottomView.m_rollInBtn.userInteractionEnabled = NO;
    [self.m_bottomView.m_rollInBtn addTarget:self action:@selector(setPasswordData) forControlEvents:UIControlEventTouchUpInside];
     self.m_bottomView.m_rollInBtn.userInteractionEnabled = YES;
    [self.m_bottomView.m_rollInBtn setTitle:@"完成" forState:UIControlStateNormal];
    
    [self makeConstraints];
}

- (void)makeConstraints{
    
    [_m_auditImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kiP6WidthRace(43));
        make.centerX.mas_equalTo(self.view);
        
    }];
    
    [_m_auditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.m_auditImage.mas_bottom).mas_offset(kiP6WidthRace(31));
        make.centerX.mas_equalTo(self.view);
    }];
    
    [_m_testLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.m_auditLabel.mas_bottom).mas_offset(kiP6WidthRace(15));
        make.centerX.mas_equalTo(self.view);
    }];
    
    
    [self.m_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.m_testLabel.mas_top).offset(kiP6WidthRace(61));
        make.left.equalTo(self.view).offset(kiP6WidthRace(42));
        make.right.equalTo(self.view).offset(-kiP6WidthRace(42));
        make.height.mas_equalTo(kiP6WidthRace(48));
    }];
}

#pragma click
- (void)setPasswordData{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma getter

- (UIImageView *)m_auditImage{
    
    if (!_m_auditImage) {
        _m_auditImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _m_auditImage.image = [UIImage imageNamed:@"audit_icon"];
    }
    
    return _m_auditImage;
}

- (UILabel *)m_auditLabel{
    
    if (!_m_auditLabel) {
        _m_auditLabel = [UIFactory createLabel:CGRectZero align:NSTextAlignmentCenter text:@"审核中..." textcolor: UIColorHex(@"#3d85ff") font:KFont(28)];
    }
    return _m_auditLabel;
}

- (UILabel *)m_testLabel{
    
    if (!_m_testLabel) {
        _m_testLabel = [UIFactory createLabel:CGRectZero align:NSTextAlignmentCenter text:@"请配合面签人员提供融资所需资料!" textcolor: UIColorHex(@"#333333") font:KFont(15)];
    }
    return _m_testLabel;
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

//
//  NewFeatureVC.m
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/8.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "NewFeatureVC.h"
#import "UIImageView+WebCache.h"


@interface NewFeatureVC ()
@property(nonatomic,strong)UIImageView *newFeatureImg;

@property(nonatomic,strong)UIButton *enterBtn;

@property(nonatomic,strong)UIButton *skipBtn;

@property(nonatomic,strong)UILabel *timerLbl;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)NSInteger second;

@property(nonatomic,copy) void(^skipBlock)(void);
@property(nonatomic,copy) void(^enterBlock)(void);

@end

@implementation NewFeatureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.newFeatureImg];
    [self.view addSubview:self.enterBtn];
    [self.view addSubview:self.skipBtn];
    [self.view addSubview:self.timerLbl];
    
    
    
    [self.skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.newFeatureImg).offset(-15);
        make.top.equalTo(self.newFeatureImg).offset(54);
        make.height.mas_equalTo(36);
        make.width.mas_equalTo(76);
    }];
    
    [self.timerLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.skipBtn);
    }];
    
    [self.enterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.left.right.equalTo(self.view);
//        make.height.mas_equalTo(100);
        make.top.equalTo(self.skipBtn.mas_bottom).offset(20);
        make.bottom.equalTo(self.newFeatureImg.mas_bottom).offset(-50);
    }];
    
     self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    
     [self countdown];

}

- (void)initWithModel:(StartBannerModel *)model andSkip:(void (^)(void))skipBlock andEnter:(void (^)(void))enterBlock{
    _second = model.time.integerValue;
    self.skipBlock = skipBlock;
    self.enterBlock = enterBlock;
    if (kIsPhoneX) {
        [self.newFeatureImg sd_setImageWithURL:[NSURL URLWithString:model.imgIphonex]];
    } else {
        [self.newFeatureImg sd_setImageWithURL:[NSURL URLWithString:model.img]];
    }
    
}

#pragma mark -懒加载
- (UIImageView *)newFeatureImg {
    if (_newFeatureImg == nil) {
        _newFeatureImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH_AutoSize, SCREEN_HEIGHT_AutoSize)];
        _newFeatureImg.contentMode = UIViewContentModeScaleAspectFill;
        _newFeatureImg.clipsToBounds = YES;
    }
    return _newFeatureImg;
}

- (UILabel *)timerLbl {
    if (_timerLbl == nil) {
        _timerLbl = [[UILabel alloc]init];
        _timerLbl.textAlignment = NSTextAlignmentCenter;
        _timerLbl.textColor = UIColor.whiteColor;
        _timerLbl.font = [UIFont systemFontOfSize:18];
        _timerLbl.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.7];
        _timerLbl.layer.cornerRadius = 18;
        _timerLbl.layer.masksToBounds = YES;
    }
    return _timerLbl;
}
    
- (UIButton *)enterBtn{
    
    if (_enterBtn == nil) {
        _enterBtn = [[UIButton alloc]init];
        [_enterBtn addTarget:self action:@selector(enterLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterBtn;
}

- (UIButton *)skipBtn{
    
    if (_skipBtn == nil) {
        _skipBtn = [[UIButton alloc]init];

        _skipBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [_skipBtn addTarget:self action:@selector(skipLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipBtn;
}

//注册登录的点击事件
- (void)enterLogin{
    //关闭定时器
    [self.timer invalidate];
    self.timer = nil;
    
    if (self.enterBlock) {
        self.enterBlock();
    }
  
}

//跳过的点击事件
- (void)skipLogin{
    //关闭定时器
    [self.timer invalidate];
    self.timer = nil;
    
    if (self.skipBlock) {
        self.skipBlock();
    }
 
}

//倒计时的事件
- (void)countdown{
    
    NSString *str = [NSString stringWithFormat:@"跳过 %zd",_second];

    self.timerLbl.text = str;
    self.second = self.second - 1;
}

- (void)setSecond:(NSInteger)second{
    
    _second = second;
    if (_second<0) {
        //防止这个时候点击了按钮
        _enterBtn.enabled = NO;
        _skipBtn.enabled = NO;
        
        //关闭定时器
        [self.timer invalidate];
        self.timer = nil;
        
        [self skipLogin];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//界面消失后释放定时器
-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    //    //关闭定时器
    //    [self.timer invalidate];
    //    self.timer = nil;
    
}


@end

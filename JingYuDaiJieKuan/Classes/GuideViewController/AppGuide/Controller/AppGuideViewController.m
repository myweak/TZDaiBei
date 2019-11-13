//
//  AppGuideViewController.m
//  NewJingYuBao
//
//  Created by 张永杰 on 16/7/27.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import "AppGuideViewController.h"
#import "LnitialModel.h"
static int kCount = 3;
#define kBtnHeight  AutoWHGetHeight(64)

@interface AppGuideViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView  *m_mainScrollView;
@property (nonatomic, strong)UIView        *m_containerView;
@property (nonatomic, strong)UIPageControl *m_pageControl;
@end

@implementation AppGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.m_arrayData);
    [self createSubViews];
    // Do any additional setup after loading the view.
}

- (NSMutableArray *)m_arrayData
{
    if (!_m_arrayData) {
        _m_arrayData = [[NSMutableArray alloc] init];
    }
    
    return _m_arrayData;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    if ([UIApplication sharedApplication].statusBarStyle != UIStatusBarStyleLightContent){
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    }
}

- (void)createSubViews{
    _m_mainScrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_m_mainScrollView];
    [_m_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _m_containerView = [[UIView alloc] init];
    [_m_mainScrollView addSubview:_m_containerView];
    [_m_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.m_mainScrollView);
        make.width.mas_equalTo(kScreenWidth * kCount);
        make.height.mas_offset(kScreenHeight + 20);
    }];
    _m_mainScrollView.contentSize =  CGSizeMake(kScreenHeight, 0);
    _m_mainScrollView.pagingEnabled = YES;
    _m_mainScrollView.showsHorizontalScrollIndicator = NO;
    _m_mainScrollView.delegate = self;
    _m_mainScrollView.bounces = NO;
    [self addImageViews];
    
//    _m_pageControl = [[UIPageControl alloc] init];
//    _m_pageControl.pageIndicatorTintColor = UIColorHexSystem(0x7ed5fc, 1.0);
//    _m_pageControl.currentPageIndicatorTintColor = UIColorHexSystem(0x117ec9, 1.0);
//    _m_pageControl.numberOfPages = kCount;
//    _m_pageControl.currentPage = 0;
//    [self.view addSubview:_m_pageControl];
//    [_m_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.bottom.equalTo(self.view.mas_bottom).offset(- 15);
//        make.width.mas_equalTo(150);
//        make.height.mas_equalTo(37);
//    }];
}

- (void)addImageViews{
    
//    NSArray *imageArray = @[@"http://hbimg.b0.upaiyun.com/5c25833281e9b8e8d2f548f6ff9144ab63ac361419102-EEFFJN_fw658",@"http://hbimg.b0.upaiyun.com/5c25833281e9b8e8d2f548f6ff9144ab63ac361419102-EEFFJN_fw658",@"http://hbimg.b0.upaiyun.com/5c25833281e9b8e8d2f548f6ff9144ab63ac361419102-EEFFJN_fw658"];
    for (int i = 0; i < kCount; i++) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.userInteractionEnabled = YES;
      
        [_m_containerView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.m_containerView).offset(i * kScreenWidth);
            make.top.bottom.equalTo(self.m_containerView);
            make.width.mas_equalTo(kScreenWidth);
        }];
        NSString *imageName;
        if (iPhone4) {
            imageName = [NSString stringWithFormat:@"Guide0%d_4S",i + 1];
        }else if(iPhone5){
            imageName = [NSString stringWithFormat:@"Guide0%d_5S", i + 1];
        }else if (iPhoneX){
            imageName = [NSString stringWithFormat:@"Guide0%d_X", i + 1];
        }else{
            imageName = [NSString stringWithFormat:@"Guide0%d_6P", i + 1];
        }
        DLog(@"image=%@",imageName);
        // TODO: 用 contentfile.....
//        LnitialListModel *model = self.m_arrayData[i];
//        if (iPhone4 || iPhone5 || iPhone6) {
//            imageV.image = [self getImageFromURL:model.smallImg];
//        }else{
//            imageV.image = [self getImageFromURL:model.bigImg];
//        }
        imageV.image = [UIImage imageNamed:imageName];//[self getImageFromURL:imageArray[i]];//
        
        if (i == kCount - 1) {
            NSString *btnImageName;
            if (iPhone4) {
                btnImageName = @"GuideBtn4S";
            }else if (iPhone5){
                btnImageName = @"GuideBtn5S";
            }else if (iPhoneX){
                btnImageName = @"GuideBtnX";

            }else{
                btnImageName = @"GuideBtn6S";
            }
            UIImage *btnImage= [UIImage imageNamed:btnImageName];
            UIButton *startBtn = [[UIButton alloc] init];
//            [startBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
//            [startBtn setBackgroundColor:UIColorRGB(61, 133, 255)];
//            [startBtn setTitle:@"立即体验" forState:UIControlStateNormal];
            [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
            [imageV addSubview:startBtn];
            [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(btnImage.size.width);
                make.height.mas_equalTo(btnImage.size.height);
                make.centerX.equalTo(imageV.mas_centerX);
                make.bottom.equalTo(imageV.mas_bottom).offset(- 57 + (iPhone4 ? 20 : 0));
            }];
        }
    }
}

- (void)start{
    if (_startBlock) {
        _startBlock();
    }
}
//加载网络 图片
- (UIImage *)getImageFromURL:(NSString *)fileURL {
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return result;
}
#pragma mark 减速完毕就会调用（scrollview静止）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    _m_pageControl.currentPage = index;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

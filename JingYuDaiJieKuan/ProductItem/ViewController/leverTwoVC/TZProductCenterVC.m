//
//  TZProductCenterVC.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/2.
//  Copyright © 2019 Jincaishen. All rights reserved.
//
#define KTopSegmentedView_H 45
#import "TZProductCenterVC.h"
#import "TZProductLineFrontVC.h" //线上
#import "TZProductLinebackBankVC.h"   // 线下
@interface TZProductCenterVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *cureentTopSegmentBtn;
@property (nonatomic, strong) NSArray *topSegmentBtnArr;
@property (nonatomic, strong) NSArray *pageChildVCArr;
@end

@implementation TZProductCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"产品中心";
    
    [self initWithUI];
    [self bindSignal];
    
}

- (void)initWithUI{
    [self addTopSegmentedBtnViewWithIndex:self.pageIndex];
    [self.view addSubview:self.scrollView];
    [self addChilPageVC];
}
- (void)bindSignal{
    [self showUserMessageView];
    self.scrollView.contentOffset = CGPointMake(kScreenWidth *self.pageIndex, 0);
}

// 提示骚扰弹框
- (void)showUserMessageView{
    TZProductLineFrontVC *vc = [self.pageChildVCArr objectAtIndex:0];
    if (vc.dataArr.count == 0) {
        return;
    }
    NSString *phone = [kUserMessageManager getMessageManagerForObjectWithKey:USER_MOBILE];

    NSString *idKey = [NSString stringWithFormat:@"message_%@",phone];
    BOOL hadSave = [TZUserDefaults getBoolValueInUDWithKey:idKey];
    // 1/5概率判断
    BOOL numb =  (arc4random() % 5)== 4;
    
    // 神经体验
//    hadSave = YES;
//    numb = YES;
    
    if ((!hadSave || numb) && self.pageIndex == 0) {
        [[[TZShowAlertView alloc] initWithAlerTitle:@"温馨提示" Content:@"建议申请5个以上产品，成功率提升95%！" buttonArray:@[@"我知道了"] blueButtonIndex:0 alertButtonBlock:^(NSInteger buttonIndex) {
            [TZUserDefaults saveBoolValueInUD:YES forKey:idKey];
        }] show];
    }
}

- (void)addChilPageVC{
    TZProductLineFrontVC *frontVc = [TZProductLineFrontVC new];
    frontVc.view.frame = CGRectMake(0, 0, kScreenWidth, self.scrollView.height);
    [self addChildViewController:frontVc];
    [self.scrollView addSubview:frontVc.view];
    
    TZProductLinebackBankVC *backVc = [TZProductLinebackBankVC new];
    backVc.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, self.scrollView.height);
    [self addChildViewController:backVc];
    [self.scrollView addSubview:backVc.view];
    
    self.pageChildVCArr = @[frontVc,backVc];
    
}

#pragma mark - scrollView delegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index =  scrollView.contentOffset.x/scrollView.width;
    UIButton *topBtn = [self.topSegmentBtnArr objectAtIndex:index];
    [self topSegmentedBtnAction:topBtn];
}

#pragma  mark - 顶部Segmented按钮选择
- (void)topSegmentedBtnAction:(UIButton *)btn{
    self.pageIndex = btn.tag;
    if (btn != self.cureentTopSegmentBtn) {
        btn.selected = YES;
        self.cureentTopSegmentBtn.selected = NO;
        self.cureentTopSegmentBtn = btn;
        self.scrollView.contentOffset = CGPointMake(kScreenWidth *self.pageIndex, 0);
        
    }
    UIViewController *vc = [self.pageChildVCArr objectAtIndex:1];
    [(TZProductLinebackBankVC *)vc resignTextFieldFirstResponder];
    [self showUserMessageView];
}

- (void)addTopSegmentedBtnViewWithIndex:(NSInteger) index{
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, KTopSegmentedView_H)];
    topView.userInteractionEnabled = YES;
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, kScreenWidth/2.0f, KTopSegmentedView_H);
    [leftBtn setTitle:@"线上极速贷" forState:UIControlStateNormal];
    [leftBtn setTitle:@"线上极速贷" forState:UIControlStateSelected];
    [leftBtn setTitleColor:CP_ColorMBlack forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    leftBtn.titleLabel.font = kFontSize15;
    leftBtn.tag = 0;
    leftBtn.selected = YES;
    [leftBtn setBackgroundImage:R_ImageName(@"pro_center_sel") forState:UIControlStateSelected];
    leftBtn.backgroundColor = [UIColor whiteColor];
    [leftBtn addTarget:self action:@selector(topSegmentedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.adjustsImageWhenHighlighted = NO;
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(leftBtn.right, 0, kScreenWidth/2.0f, KTopSegmentedView_H);
    [rightBtn setTitle:@"线下银行贷" forState:UIControlStateNormal];
    [rightBtn setTitle:@"线下银行贷" forState:UIControlStateSelected];
    [rightBtn setTitleColor:CP_ColorMBlack forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    rightBtn.titleLabel.font = kFontSize15;
    rightBtn.tag = 1;
    rightBtn.selected = NO;
    rightBtn.backgroundColor = [UIColor whiteColor];
    [rightBtn setBackgroundImage:R_ImageName(@"pro_center_sel") forState:UIControlStateSelected];
    [rightBtn addTarget:self action:@selector(topSegmentedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.adjustsImageWhenHighlighted = NO;
    
    [topView addSubview:leftBtn];
    [topView addSubview:rightBtn];
    
    [self.view addSubview:topView];
    
    
    self.topSegmentBtnArr = @[leftBtn,rightBtn];
    
    [leftBtn addLine_bottom];
    [rightBtn addLine_bottom];
    
    if (index == 0) {
        leftBtn.selected = YES;
        rightBtn.selected = NO;
        self.cureentTopSegmentBtn = leftBtn;
        
    }else{
        leftBtn.selected = NO;
        rightBtn.selected = YES;
        self.cureentTopSegmentBtn = rightBtn;
    }
    
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KTopSegmentedView_H, kScreenWidth, self.view.height- KTopSegmentedView_H - kNavBarH)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.contentSize = CGSizeMake(kScreenWidth*2, _scrollView.height);
    }
    return _scrollView;
}




@end

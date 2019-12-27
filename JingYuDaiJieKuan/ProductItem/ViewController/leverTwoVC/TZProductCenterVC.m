//
//  TZProductCenterVC.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/2.
//  Copyright © 2019 Jincaishen. All rights reserved.
//
#define KTopSegmentedView_H 45
#define KSlider_space       3.0f
#import "TZProductCenterVC.h"
#import "TZProductLineFrontVC.h" //线上
#import "TZProductLinebackBankVC.h"   // 线下
@interface TZProductCenterVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *cureentTopSegmentBtn;
@property (nonatomic, strong) NSArray *topSegmentBtnArr;
@property (nonatomic, strong) NSArray *pageChildVCArr;
@property (nonatomic, strong) UIView *sliderBg;
@end

@implementation TZProductCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"产品中心";
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    UIViewController *vc = [self.pageChildVCArr objectAtIndex:1];
    if ([vc isKindOfClass:[TZProductLineFrontVC class]]) {
        TZProductLineFrontVC *vcc = (TZProductLineFrontVC *)vc;
        if (vcc.dataArr.count == 1) {
            return;
        }
    }
    
    NSString *phone = aUser.mobile;
    
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
    frontVc.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, self.scrollView.height);
    frontVc.title = @"线上银行";
    [self addChildViewController:frontVc];
    [self.scrollView addSubview:frontVc.view];
    
    TZProductLinebackBankVC *backVc = [TZProductLinebackBankVC new];
    backVc.view.frame = CGRectMake(0, 0, kScreenWidth, self.scrollView.height);
    [self addChildViewController:backVc];
    [self.scrollView addSubview:backVc.view];
    
    self.pageChildVCArr = @[backVc,frontVc];
    
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
        [self setsliderViewOffsetX:KSlider_space+self.pageIndex *(kScreenWidth- 30-KSlider_space*2)/2.0f];
        
    }
    UIViewController *vc = [self.pageChildVCArr objectAtIndex:0];
    if ([vc isKindOfClass:[TZProductLinebackBankVC class]]) {
        [(TZProductLinebackBankVC *)vc resignTextFieldFirstResponder];
        return;
    }
    [self showUserMessageView];
}

- (void)addTopSegmentedBtnViewWithIndex:(NSInteger) index{
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth-30, KTopSegmentedView_H)];
    topView.backgroundColor = Bg_Btn_Colorblue;
    [topView setCornerRadius:KTopSegmentedView_H/2.0f];
    
    
    // 滑动的滚动白条
    self.sliderBg = [[UIView alloc] initWithFrame:CGRectMake(KSlider_space, KSlider_space, (topView.width-2*KSlider_space)/2.0f, topView.height-KSlider_space*2)];
    self.sliderBg.backgroundColor = [UIColor whiteColor];
    [self.sliderBg setCornerRadius:self.sliderBg.height/2.0f];
    [topView addSubview:self.sliderBg];
    
    //  按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, kScreenWidth/2.0f-15, KTopSegmentedView_H);
    [leftBtn setTitle:@"线下银行贷" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn setTitleColor:Bg_Btn_Colorblue forState:UIControlStateSelected];
    leftBtn.titleLabel.font = kFontSize15;
    leftBtn.tag = 0;
    leftBtn.backgroundColor = [UIColor clearColor];
    
    [leftBtn setImage:R_ImageName(@"product_off_select") forState:UIControlStateSelected];
    [leftBtn setImage:R_ImageName(@"product_off_image") forState:UIControlStateNormal];
    leftBtn.selected = YES;
    
    [leftBtn addTarget:self action:@selector(topSegmentedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.adjustsImageWhenHighlighted = NO;
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(leftBtn.right, 0, kScreenWidth/2.0f-15, KTopSegmentedView_H);
    [rightBtn setTitle:@"线上极速贷" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:Bg_Btn_Colorblue forState:UIControlStateSelected];
    rightBtn.titleLabel.font = kFontSize15;
    rightBtn.tag = 1;
    rightBtn.selected = NO;
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn setImage:R_ImageName(@"product_on_select") forState:UIControlStateSelected];
    [rightBtn setImage:R_ImageName(@"product_on_image") forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(topSegmentedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.adjustsImageWhenHighlighted = NO;
    
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
    
    
    [topView addSubview:leftBtn];
    [topView addSubview:rightBtn];
    
    [self.view addSubview:topView];
    
    
    self.topSegmentBtnArr = @[leftBtn,rightBtn];
    
    
    if (index == 0) {
        leftBtn.selected = YES;
        rightBtn.selected = NO;
        [self setsliderViewOffsetX:KSlider_space animations:NO];
        self.cureentTopSegmentBtn = leftBtn;
        
    }else{
        leftBtn.selected = NO;
        rightBtn.selected = YES;
        [self setsliderViewOffsetX:KSlider_space+(kScreenWidth-30-2*KSlider_space)/2.0 animations:NO];
        self.cureentTopSegmentBtn = rightBtn;
    }
    
}
- (void)setsliderViewOffsetX:(CGFloat)offset_x{
    [self setsliderViewOffsetX:offset_x animations:YES];
}
- (void)setsliderViewOffsetX:(CGFloat)offset_x animations:(BOOL)animations
{
    @weakify(self)
    [UIView animateWithDuration:animations?0.25:0 animations:^{
        @strongify(self);
        if (offset_x == KSlider_space) {
            self.sliderBg.left = offset_x;
        }else{
            self.sliderBg.right = (kScreenWidth-30-KSlider_space);
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:animations?0.1:0 animations:^{
            if (offset_x == KSlider_space) {
                self.sliderBg.width = (kScreenWidth-30-2*KSlider_space)/2.0 ;
            }else{
                self.sliderBg.left = offset_x;
            }
        }];
    }];
    
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KTopSegmentedView_H+15, kScreenWidth, self.view.height- KTopSegmentedView_H - kNavBarH - 15)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.contentSize = CGSizeMake(kScreenWidth*2, _scrollView.height);
    }
    return _scrollView;
}




@end

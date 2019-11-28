//
//  SuperVC.m
//  CarpFinancial
//
//  Created by weibin on 15/12/11.
//  Copyright © 2015年 cwb. All rights reserved.
//

#import "SuperVC.h"


@interface SuperVC ()

@end

@implementation SuperVC

- (void)dealloc
{
    [SVProgressHUD dismiss];
        DLog(@"%@释放了",NSStringFromClass([self class]));
        [[NSNotificationCenter defaultCenter] removeObserver:self];
  
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.view.backgroundColor = kColorLightgrayBackground;//Bg_ColorGray;
    [self FullScreen:NO];
    [self ScrollFullScreen:NO];
    self.view.exclusiveTouch = YES;
    
    //    self.view.backgroundColor = Bg_ColorGray;
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //
    // 显示系统返回按钮
    if (!self.navigationItem.leftBarButtonItem)
    {
        self.navigationItem.leftBarButtonItem = [self isTabbarRoot] ? nil : [self barBackButton];;
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (![touch.view isKindOfClass: [UITextField class]] || ![touch.view isKindOfClass: [UITextView class]]) {
        [self.view endEditing:YES];
    }
}

-(void)addNavigationBackButton
{
    [self addLeftButton:@"backBtn" seletedImage:nil title:nil target:self action:@selector(backClick)];
}
-(void)addNavigationBackButtonForPop
{
    [self addLeftButton:@"backBtn" seletedImage:nil title:nil target:self action:@selector(backPopClick)];
}
-(void)backPopClick
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)addNavigationFinishButton
{
    UIBarButtonItem *finishBtn=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(backPopClick)];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = 0;
    self.navigationItem.rightBarButtonItems=@[negativeSpacer,finishBtn];
    
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem=nil;
    self.navigationController.navigationItem.hidesBackButton = YES;
}

-(void)backClick
{
    if (self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    
}
- (void)backToSuperView
{
    [self.view endEditing:YES];
    
    if (self.navigationController.viewControllers.firstObject == self)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
// 设置导航栏左按钮
- (UIBarButtonItem *)barBackButton
{
    return [self barBackButtonWithImage:[UIImage imageWithName:@"backBtn"]];
}

- (UIBarButtonItem *)barBackWhiteButton
{
    return [self barBackButtonWithImage:[UIImage imageWithName:@"back_white_icon"]];
}

- (UIBarButtonItem *)barBackNoButton
{
    return [self barBackButtonWithImage:[UIImage imageWithName:@""]];
}

- (UIBarButtonItem *)barBackButtonWithImage:(UIImage *)image
{
    CGRect buttonFrame;
    buttonFrame = CGRectMake(0, 0, image.size.width + 20, image.size.height);
    
    if (ISIOS11) {
        buttonFrame = CGRectMake(0, 0, 40, 40);
        
    }
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    [button addTarget:self action:@selector(backToSuperView) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    button.accessibilityLabel = @"back";
    if (ISIOS11) {
        button.contentEdgeInsets = UIEdgeInsetsMake(0,-20, 0, 0);
    }
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
}
//删除导航栏分割线
-(void)deletedNaviUnderLine:(UIColor *)color
{
    if (iPhoneX)
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(kScreenWidth,88)] forBarMetrics:UIBarMetricsDefault];
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    }
    
    
    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)])
    {
        [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:color size:CGSizeMake(kScreenWidth, 0.5)]];
    }
}

#pragma mark- 键盘弹出点击空白处回收键盘

//点击空白处键盘收回
- (void)textFieldReturn{
    //    监听键盘事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //键盘弹出后在屏幕添加手势，点击空白处收回键盘
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyboardHidden)];
    
}

//键盘弹出添加手势
- (void)keyboardWillShow:(NSNotification*)notification
{
    [self.view addGestureRecognizer:_tap];
}

//键盘收回移除手势
- (void)keyboardWillHide:(NSNotification*)notification
{
    [self.view removeGestureRecognizer:_tap];
}

//收回键盘
- (void)keyboardHidden
{
    [self.view endEditing:YES];
}

//销毁键盘弹出通知
- (void)deallocTextFieldNSNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController.viewControllers.count == 1)
        return NO;
    else
        return YES;
}

- (void)shakeAnimationByView:(UIView*)view
{
    CALayer *lbl = [view layer];
    CGPoint posLbl = [lbl position];
    CGPoint y = CGPointMake(posLbl.x - 10, posLbl.y);
    CGPoint x = CGPointMake(posLbl.x + 10, posLbl.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    [lbl addAnimation:animation forKey:nil];
}

#pragma mark 初始化导航栏
-(void)changeNavigationBackColor
{
    [self deletedNaviUnderLine:[UIColor clearColor]];
}
-(void)changeNaviDefault
{
    [self deletedNaviUnderLine:kLySeparatorColor];
}
- (BOOL)isNavRoot
{
    return self.navigationController.viewControllers.firstObject == self;
}

- (BOOL)isTabbarRoot
{
    for (UINavigationController *nc in self.tabBarController.viewControllers) {
        if (nc.viewControllers.firstObject == self) {
            return YES;
        }
    }
    return NO;
}
#pragma mark 添加导航栏左按钮
-(void)addLeftButton:(NSString *)imageName seletedImage:(NSString *)seletedImage title:(NSString *)title target:(id)target action:(SEL)action
{
    UIBarButtonItem *tLeftButton=nil;
    tLeftButton=[UIBarButtonItem customBarButtonItemWithNornalImage:imageName seletedImage:seletedImage title:title target:target action:action];
    
    [self addLeftBarButtonItem:tLeftButton];
}

//添加导行条右边按钮
-(void)addRightButton:(NSString *)imageName seletedIamge:(NSString *)seletedImage title:(NSString *)title target:(id)target action:(SEL)action
{
    UIBarButtonItem *tRightButton=nil;
    tRightButton = [UIBarButtonItem customBarButtonItemWithNornalImage:imageName seletedImage:seletedImage title:title target:target action:action];
    [self addRightBarButtonItem:tRightButton];
}


- (void)didReceiveMemoryWarning
 {
 [super didReceiveMemoryWarning];
 // Dispose of any resources that can be recreated.
 }

@end


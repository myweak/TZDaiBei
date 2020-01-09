//
//  MainViewController.m
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/19.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "MainViewController.h"
#import "TZHomePageVC.h"
#import "ProductItemVC.h"
#import "UserCenterVC.h"
#import "JYDNavigationVC.h"
#import "BufferedNavigationController.h"
#import "HomePageViewModel.h"
#import "HomePageModel.h"
#import "JingYuDaiJieKuan-Swift.h"

@interface MainViewController ()

@property (nonatomic, copy) NSMutableArray *m_arrayData;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 将状态栏改为白色
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    self.delegate = self;
    [kUserMessageManager setMessageManagerForIntegerWithKey:USERINDEX value:0];
    
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    
}

-(void)initWithVC :(NSArray *)list
{
    
    NSArray *titleArr = @[@"首页",@"贷款大全",@"我的"];
    
    NSArray * smallGraytArray = @[@"btn_home_nor",@"btn_pro_nor",@"btn_per_nor"];
    
    NSArray *smallBrightArray = @[@"btn_home_pre",@"btn_pro_pre",@"btn_per_pre"];

    NSArray *controllerArr = @[@"TZHomePageVC",@"TZProductPageVC",@"TZMineVC"];

    NSMutableArray *viewcontrollers = [NSMutableArray array];
    for(NSInteger i = 0;i < controllerArr.count;i++)
    {
        UIViewController *viewController = [[NSClassFromString(controllerArr[i]) alloc]init];
        BufferedNavigationController *nav = [[BufferedNavigationController alloc]initWithRootViewController:viewController];
        viewController.title = titleArr[i];
        [viewcontrollers addObject:nav];
//        UIImage *normalImg = [self getImageFromURL:smallGraytArray[i]];//[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_%ld_n",i+1]];//

        // 声明这张图片用原图(别渲染) 不然会变成蓝色
        UIImage *normalImg = R_ImageName(smallGraytArray[i]);
        UIImage *selectImg = R_ImageName(smallBrightArray[i]);
        normalImg = [normalImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectImg = [selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem = [nav.tabBarItem initWithTitle:titleArr[i] image:normalImg selectedImage:selectImg];
        
        [[self class] setTableBarItemStyle:nav.tabBarItem];
       
    }
    self.viewControllers = viewcontrollers;
}

+ (void)setTableBarItemStyle:(UITabBarItem*)tabBarItem
{
    [tabBarItem setImageInsets:UIEdgeInsetsMake(-2.0, 0.0, 2.0, 0.0)];
    tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
//    tabBarItem.imageInsets = UIEdgeInsetsMake(3, 3, -7, 0);
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = UIColorRGB(153, 153, 153);
    textAttrs[NSFontAttributeName] = kFontSize11;
    [tabBarItem  setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = UIColorHex(@"#0c72e3");
    textAttrs[NSFontAttributeName] = kFontSize11;
    [tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
//    return YES;
//    self.tabBar.selectedItem
    NSInteger index = [tabBarController.viewControllers indexOfObject:
                        viewController];
    [kUserMessageManager setMessageManagerForIntegerWithKey:USERINDEX value:index];
    //埋点
    [SensorsAnalyticsSDKHelper trackTabBarClickWithTabBarItemName:tabBarController.tabBar.selectedItem.title];
    
    return YES;
}

/**
 2  *  根据image 返回放大或缩小之后的图片
 3  *
 4  *  @param image    原始图片
 5  *  @param multiple 放大倍数 0 ~ 2 之间ƒ
 6  *
 7  *  @return 新的image
 8  */
- (UIImage *) createNewImageWithColor:(UIImage *)image multiple:(CGFloat)multiple
{
    CGFloat newMultiple = multiple;
    if (multiple == 0) {
        newMultiple = 1;
    }
    else if((fabs(multiple) > 0 && fabs(multiple) < 1) || (fabs(multiple)>1 && fabs(multiple)<2))
    {
        newMultiple = multiple;
    }
    else
    {
        newMultiple = 1;
    }
    CGFloat w = image.size.width*newMultiple;
    CGFloat h = image.size.height*newMultiple;
    CGFloat scale = [UIScreen mainScreen].scale;
    UIImage *tempImage = nil;
    CGRect imageFrame = CGRectMake(0, 0, w, h);
    UIGraphicsBeginImageContextWithOptions(image.size, NO, scale);
    [[UIBezierPath bezierPathWithRoundedRect:imageFrame cornerRadius:0] addClip];
    [image drawInRect:imageFrame];
    tempImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tempImage;
    
}

- (UIImage *)getImageFromURL:(NSString *)fileURL {
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return [self imageResize:result andResizeTo:CGSizeMake(kiP6WidthRace(22) , kiP6WidthRace(22))];
}

-(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (NSMutableArray *)m_arrayData{
    
    if (!_m_arrayData) {
        _m_arrayData = [[NSMutableArray alloc] init];
    }
    return _m_arrayData;
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

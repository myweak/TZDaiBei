//
//  JYDNavigationVC.m
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/27.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "JYDNavigationVC.h"

@interface JYDNavigationVC ()

@end

@implementation JYDNavigationVC

//- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
//{
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSInteger count = self.viewControllers.count;
    DLog(@"count=%ld",count);
    self.hidesBottomBarWhenPushed = (count >1)? YES :NO;
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

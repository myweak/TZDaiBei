//
//  ArticleRecommendWebController.m
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/29.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "ArticleRecommendWebController.h"
#import "JingYuDaiJieKuan-Swift.h"

@interface ArticleRecommendWebController ()

@property (strong ,nonatomic) NSString *title;

@property (strong ,nonatomic) NSString *position;
//开始时间
@property(nonatomic,assign)NSTimeInterval start;

//结束时间
@property(nonatomic,assign)NSTimeInterval end;

@end

@implementation ArticleRecommendWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.start = [[NSDate date] timeIntervalSince1970] * 1000;

}

- (void)showWebWithURL:(NSString *)url andTitle:(NSString *)title andFromPosition:(NSString *)fromPosition withSuperController:(UIViewController *)superVC{
    
    //如果不是有效的url,那么就不跳转了
    if ([url containsString:@"http://"]||[url containsString:@"https://"]) {
    } else {
        return;
    }
    
    self.url = url;
    self.title = title;
    self.position = fromPosition;
    
    [superVC.navigationController pushViewController:self animated:true];
    
}

- (void)dealloc{
    self.end = [[NSDate date] timeIntervalSince1970] * 1000;
    NSInteger stayTime = [NSString stringWithFormat:@"%.0f", self.end - self.start].integerValue;
    [SensorsAnalyticsSDKHelper loanStrategyWithArticleTitle:self.title articleType:@"默认列表" position:self.position stayTime:stayTime];
}



@end

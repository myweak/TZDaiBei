//
//  AdWebViewController.m
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/5.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "AdWebViewController.h"
#import <WebKit/WebKit.h>
#import "BrowseHistory+CoreDataProperties.h"
#import "CoreDataManager.h"
#import "JingYuDaiJieKuan-Swift.h"
#import <mach/mach_time.h>
#import "HomePageViewModel.h"

@interface AdWebViewController ()

/// 商户图标
@property (strong ,nonatomic) NSString *productIcon;
/// 最高金额
@property (strong ,nonatomic) NSString *productMaxAmount;
/// 商户id
@property (strong ,nonatomic) NSString *productMerchartid;
/// 商户名称
@property (strong ,nonatomic) NSString *productName;
/// 商户标签
@property (strong ,nonatomic) NSString *productTags;
/// 商户说明
@property (strong ,nonatomic) NSString *productTitle;
/// 跳转url
@property (strong ,nonatomic) NSString *productUrl;
/// 来源位置 (eg:首页-贷款精选, 贷款大全-搜索)
@property (strong ,nonatomic) NSString *fromPosition;
/// 是否需要保存浏览记录
@property (assign ,nonatomic) BOOL isNeedSaveHistory;

//开始时间
@property(nonatomic,assign)NSTimeInterval start;

//结束时间
@property(nonatomic,assign)NSTimeInterval end;

@end

@implementation AdWebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.start = [[NSDate date] timeIntervalSince1970] * 1000;
    
    //这里记录点击了商户
    if (![self.productMerchartid isEqualToString:@""]) {
        NSString *strPath = [NSString stringWithFormat:@"%@%@",merchantClick,self.productMerchartid];
        [HomePageViewModel merchantClickPath:strPath params:nil target:self success:^(HomePageModel *model) {
            if (model.code == 200) {
                NSLog(@"200");
            }
        } failure:^(NSError *error) {
        }];
    }
}

- (void)showWebWithURL:(NSString *)url andProductIcon:(NSString *)icon andProductMaxAmount:(NSString *)maxAmount andProductMerchartid:(NSString *)merchartid andProductName:(NSString *)name andProductTags:(NSString *)tags andProductTitle:(NSString *)title andProductUrl:(NSString *)productUrl andFromPosition:(nonnull NSString *)fromPosition  andIsNeedSaveHistory:(BOOL)isNeedSaveHistory withSuperController:(nonnull UIViewController *)superVC {
    
    //如果不是有效的url,那么就不跳转了
    if ([url containsString:@"http://"]||[url containsString:@"https://"]) {
    } else {
        return;
    }
    
    kSelfWeak;
    [self setDidFinishBlock:^{
        [weakSelf didFinishLoad];
    }];
    
    self.url = url;
    self.productIcon = icon;
    self.productMaxAmount = maxAmount;
    self.productMerchartid = merchartid;
    self.productName = name;
    self.productTags = tags;
    self.productTitle = title;
    self.productUrl = url;
    self.fromPosition = fromPosition;
    self.isNeedSaveHistory = isNeedSaveHistory;
    
    [superVC.navigationController pushViewController:self animated:true];
}

- (void)backToSuperView {
    
    if ([self.webView canGoBack]) {
        //如果可以回退,那么就是回退页面,没有退出整个控制器,这个时候不弹挽留弹窗
        [super backToSuperView];
    } else {
        if ([self.productMerchartid isEqualToString:@""]){
            /// 没有id直接退出
            [super backToSuperView];
        } else {
            [self getRandomMerchant];
        }
    }
    
}

#pragma mark - networkData
- (void)getRandomMerchant {
   
    kSelfWeak;
    NSString *path = [NSString stringWithFormat:@"%@/%@",@"market/random/merchant",weakSelf.productMerchartid];
    
    [ProductItemViewModel randomProductPath:path params:nil target:weakSelf success:^(randomProductModel *model) {
        if (model.code == 200) {
            //如果数据为空,不用弹窗
            if (model.merchartid == nil || [model.merchartid isEqualToString:@""] ||
                model.url == nil || [model.url isEqualToString:@""]) {
                [super backToSuperView];
                return;
            }
            
            RandomMerchantAlertView *alert = [[RandomMerchantAlertView alloc]initWithIsHiddenCancelButton:NO cancelClosure:^{
                [super backToSuperView];
            } sureUpdateClosure:^{
                
                ///跳转
                AdWebViewController *jumpVC = [[AdWebViewController alloc]init];
                jumpVC.url = model.url;
                
                //push可以自动隐藏tabbar
                [self.navigationController pushViewController:jumpVC animated:YES];
               
                ///控制器的替换
                NSArray *arr = self.navigationController.viewControllers;
                NSMutableArray *mArr = [NSMutableArray arrayWithArray:arr];
                if (mArr.count >= 1) {
                    /// 设置删除中间的adWebviewW
                    [mArr removeObjectAtIndex:mArr.count - 2];
                    [self.navigationController setViewControllers:mArr animated:NO];
                }
               
            }];
            
            alert.model = model;
            [alert showAlertViewInViewController:self leftOrRightMargin:30];
        } else {
            [super backToSuperView];
        }
        
    } failure:^(NSError *error) {
        [super backToSuperView];
    }];
    
}


#pragma mark - CoreData
//本地添加浏览历史
- (void)addHistory{
    // 不需要保存就直接返回
    if (!self.isNeedSaveHistory){return;}
    // 如果信息比较不完整就不保存了
    if ([self.productMerchartid isEqualToString:@""]||
        [self.productName isEqualToString:@""]||
        [self.productUrl isEqualToString:@""]||
        [self.productIcon isEqualToString:@""]||
        [self.productMaxAmount isEqualToString:@""]) {
        return;
    }
    kSelfWeak;
    //设置谓词
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(merchartid == %@) AND (name == %@)",weakSelf.productMerchartid, weakSelf.productName];
    
    //查询
    NSArray *arr = [weakSelf queryHistory:predicate];
    
    //判断，没有历史记录就添加
    if(arr == nil || arr.count == 0){
        
        BrowseHistory *history = [NSEntityDescription insertNewObjectForEntityForName:@"BrowseHistory" inManagedObjectContext:[CoreDataManager defaultManager].managedContext];

        history.icon = weakSelf.productIcon;
        history.maxAmount = weakSelf.productMaxAmount.intValue;
        history.merchartid = weakSelf.productMerchartid.intValue;
        history.name = weakSelf.productName;
        history.tags = weakSelf.productTags;
        history.title = weakSelf.productTitle;
        history.url = weakSelf.productUrl;
        history.timeStamp = INTERVAL_STRING;
        
        //保存
        if ([[CoreDataManager defaultManager].managedContext save:nil]){
            NSLog(@"保存成功");
        }else{
            NSLog(@"保存失败");
        };
    }
    
}

//查询搜索历史
- (NSArray *)queryHistory:(NSPredicate *)predicate{

    //搜索所有.
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"BrowseHistory"];


    if (predicate) {
        request.predicate = predicate;
    }
    //按时间戳降序,越后面的时间越早
    NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:@"timeStamp" ascending:NO];
    // @[sort];//数组中可以放置多个sort，一般就用一个
    request.sortDescriptors = @[sort];

    NSArray *arr = [[CoreDataManager defaultManager].managedContext executeFetchRequest:request error:nil];

    return arr.copy;

}


// 页面加载完成之后调用
- (void)didFinishLoad{
    {
        NSLog(@"这个位置是:%@, mchId:%@, mchName:%@",self.fromPosition,self.productMerchartid,self.productName);
        ///没有商户id的就不算为商户,不记录这个埋点
        if (self.productMerchartid == nil || [self.productMerchartid isEqualToString:@""]){return;}
        //埋点
        [SensorsAnalyticsSDKHelper trackLoadiFinishWithPosition:self.fromPosition mchId:self.productMerchartid mchName:self.productName];
        
        //添加历史
        [self addHistory];
    }
}

- (void)dealloc{
    self.end = [[NSDate date] timeIntervalSince1970] * 1000;

    [SensorsAnalyticsSDKHelper trackH5StayWithMchId:self.productMerchartid mchName:self.productName stayTime:[NSString stringWithFormat:@"%.0f", self.end - self.start].integerValue];
}

@end

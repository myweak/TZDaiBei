//
//  AppDelegate.m
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/19.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//
#define kFSSuccessTimeSave @"FSSuccessTimeSave_%"

#import "AppDelegate.h"
#import "AppDelegate+VersionUpdate.h"

#import "AppGuideViewController.h"

#import "AppVersionModel.h"
#import "NetworkAddressType.h"
#import "LocationManager.h"
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
#import "DAlertView.h"
#import <Bugly/Bugly.h>
#import "FingerScanManager.h"
#import "FingerScanBackgroundView.h"
#import "NewPublicNoticeView.h"
#import <UserNotifications/UserNotifications.h>
#import <UMPush/UMessage.h>
#import <UShareUI/UShareUI.h>
#import "HomeMainViewModel.h"
#import "UserViewModel.h"
#import "JingYuDaiJieKuan-Swift.h"
#import "NewFeatureVC.h"
#import "HomePageViewModel.h"
#import "HomePageModel.h"
#import "BufferedNavigationController.h"
#import "TZLoginVC.h"
#import "LLDebug.h"
#import "AdPageView.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@property (assign ,nonatomic) BOOL m_isShowAlertAppVersion;

@property (nonatomic, assign)BOOL           m_ifShowUnlockPassword;

@property (nonatomic, assign)BOOL           m_isFromBackShowOpenKeyView; // 第一次开启APP 特定位置不执行用

@property (strong ,nonatomic)HomeMainViewModel *m_viewModel;

//是否已经完成初始化app
@property (nonatomic, assign)BOOL           isCompleteInitApp;
//是否已经展示过新特性(广告页)
@property (nonatomic, assign)BOOL           isShowedNewFeature;
//信号量
@property (nonatomic, strong)dispatch_semaphore_t      semaphore;
//app初始化信息模型
@property (nonatomic, strong)HomePageModel *appInitModel;


//app初始化信息模型
@property (nonatomic, strong)Reachability *connetion;

@end

@implementation AppDelegate

void UncaughtExceptionHandler(NSException *exception){
    if (exception ==nil)return;
    NSArray *array = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name  = [exception name];
    NSDictionary *dict = @{@"appException":@{@"exceptioncallStachSymbols":array,@"exceptionreason":reason,@"exceptionname":name}};
    DLog(@"dict=%@",dict);
}
- (void)catchCrashLogs{
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    #ifdef DEBUG
         [[LLDebugTool sharedTool] startWorking];
    #else
    #endif
    //神策埋点初始化(涉及神策监听方法,所以一定要直接放在didFinishLaunchingWithOptions,不能放在回调中)
    NSString *userId = [kUserMessageManager getMessageManagerForObjectWithKey:KEY_USER_ID];
    [SensorsAnalyticsSDKHelper registerSensorsAnalyticsWithLaunchOptions:launchOptions distinctId:userId];
    
    [self registerThirdData];
    [self otherConfigure];
    
    self.semaphore = dispatch_semaphore_create(0);
    [self appNetwork];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    
    
    #ifdef DEBUG
            [self advertising];
       #else
       #endif


    
    return YES;
}

- (void)advertising{
    
    if (![kUserMessageManager checkUserLogin]) {
        return;
    }
    //加载广告
      AdPageView *adView = [[AdPageView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                                withTapBlock:^{
          BaseWebViewController *web = [BaseWebViewController new];
          UINavigationController *webVC = [[UINavigationController alloc]initWithRootViewController:web];

          web.url = @"http://112.74.53.99:9012/index.html";
          UIViewController *cureentVC = [UIViewController visibleViewController];
          [cureentVC presentViewController:webVC animated:NO completion:^{
          }];

      }];
}

- (void)appNetwork {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 监听网络状态改变的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appReachabilityChanged:) name:kReachabilityChangedNotification object:nil];
        
        // 创建Reachability
        self.connetion = [Reachability reachabilityForInternetConnection];
        // 开始监控网络(一旦网络状态发生改变, 就会发出通知kReachabilityChangedNotification)
        [self.connetion startNotifier];
        
        NetworkStatus status = [self.connetion currentReachabilityStatus];
        // 两种检测:路由与服务器是否可达  三种状态:手机流量联网、WiFi联网、没有联网
        if ((status == ReachableViaWWAN) || (status == kReachableVia2G) || (status == kReachableVia3G) || (status == kReachableVia4G) || (status == ReachableViaWiFi)) {
            [self applicationStart];
            //版本更新 模拟数据
            AppUpdateModel *model = [AppUpdateModel new];
            model.appTitle = @"温馨提示";
            model.appDesc = @"有新版本更新了";
            model.appV = @"V1.1.0";
            model.dialogRepeat = 1;
            model.upgradeWay = 1;
            model.url = @"http://www.daibei.net.cn:8005/static/upload/uploadApp";
//            [self setUpdateApp:model];
            //版本更新 接口
            [self checkAppUpdate];
        } else {
            NSLog(@"没网");
        }
        
        [[NSRunLoop currentRunLoop] run];
    });
}



// 处理网络状态改变
- (void)appReachabilityChanged:(NSNotification *)notification{
    NetworkStatus status = [self.connetion currentReachabilityStatus];
    // 两种检测:路由与服务器是否可达  三种状态:手机流量联网、WiFi联网、没有联网
    if ((status == ReachableViaWWAN) || (status == kReachableVia2G) || (status == kReachableVia3G) || (status == kReachableVia4G) || (status == ReachableViaWiFi)) {
//        [self applicationStart];
    } else {
        NSLog(@"没网");
    }
    
}

- (void)applicationStart {
        dispatch_semaphore_signal(self.semaphore);
    if (![kUserMessageManager checkUserLogin]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            TZLoginVC *view = [[TZLoginVC alloc]init];
            UINavigationController *LoginNav = [[UINavigationController alloc]initWithRootViewController:view];
            
            self.window.rootViewController = LoginNav;
            self.window.backgroundColor = [UIColor whiteColor];
            [self.window makeKeyAndVisible];
            
        });
        return ;
    } else {
//        dispatch_semaphore_signal(self.semaphore);
        //            [self readyToInitWindowNeedShowNewFeature:[self needShowNewFeature]];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            MainViewController *mainVC = [[MainViewController alloc]init];
            [mainVC initWithVC: nil];
            self.window.rootViewController = mainVC;
            self.window.backgroundColor    = [UIColor whiteColor];
            [self.window makeKeyAndVisible];
        });
    }
    
    
}


#pragma mark 界面
-(void)enterMainViewIndex:(NSInteger)index
{
//    [self readyToInitWindowNeedShowNewFeature:NO];
    ///跳过的话就加载首页
      MainViewController *mainVC = [[MainViewController alloc]init];
      [mainVC initWithVC: nil];
      
      self.window.rootViewController = mainVC;
      self.window.backgroundColor    = [UIColor whiteColor];
      [self.window makeKeyAndVisible];
}

///数据处理完成,初始化界面
- (void)readyToInitWindowNeedShowNewFeature:(BOOL)needShowNewFeature {
    HomePageModel *model = self.appInitModel;
    
    if (needShowNewFeature){
        //如果不是从登录进来的话,就要跳出新特性页
        NewFeatureVC *mainVC = [[NewFeatureVC alloc]init];
        self.isShowedNewFeature = YES;
        [mainVC initWithModel:model.startBaner andSkip:^{
            ///跳过的话就加载首页
            MainViewController *mainVC = [[MainViewController alloc]init];
            [mainVC initWithVC: model.bottomIcon];
            self.window.rootViewController = mainVC;
            self.window.backgroundColor    = [UIColor whiteColor];
            [self.window makeKeyAndVisible];
        } andEnter:^{
            ///进入的话就加载首页并跳转url
            MainViewController *mainVC = [[MainViewController alloc]init];
            [mainVC initWithVC: model.bottomIcon];
            self.window.rootViewController = mainVC;
            self.window.backgroundColor    = [UIColor whiteColor];
            [self.window makeKeyAndVisible];
            
            //设置跳转到指定的url
            BufferedNavigationController* vc = mainVC.selectedViewController;
            AdWebViewController *webVC = [[AdWebViewController alloc]init];
            [webVC showWebWithURL:model.startBaner.url
                   andProductIcon:@""
              andProductMaxAmount:@""
             andProductMerchartid:model.startBaner.mchId
                   andProductName:model.startBaner.mchName
                   andProductTags:@""
                  andProductTitle:model.startBaner.title
                    andProductUrl:model.startBaner.url
                  andFromPosition:@"启动页"
             andIsNeedSaveHistory:NO
              withSuperController:vc.topViewController];
            
            
            //埋点
            [SensorsAnalyticsSDKHelper startPageClickWithMchId:model.startBaner.mchId mchName:model.startBaner.mchName startupPageTitle:model.startBaner.title startupPageUrl:model.startBaner.url];
        }];
        
        self.window.rootViewController = mainVC;
        self.window.backgroundColor    = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
    } else {
        ///跳过的话就加载首页
        MainViewController *mainVC = [[MainViewController alloc]init];
        [mainVC initWithVC: model.bottomIcon];
        
        self.window.rootViewController = mainVC;
        self.window.backgroundColor    = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
    }
    
}


#pragma mark - 版本更新
- (void)checkAppUpdate {
    ///控制只走一次
    if (self.isCompleteInitApp){
        dispatch_semaphore_signal(self.semaphore);
        return;
    } else {
        self.isCompleteInitApp = !self.isCompleteInitApp;
    }
//    [self applicationStart];
//    return;
    // app 升级判断
    [UserViewModel appUpdatePath:appUpdatePath params:nil target:nil success:^(AppUpdateModel *model) {
        if (model.code == 200) {
            switch (model.upgradeWay) {
                case 0: //不升级
                {
//                    [self applicationStart];
                    break;
                }
                case 1: //建议升级
                {
                    ///获取建议升级的版本号
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    NSString *appVersion = [defaults objectForKey:@"appupdateVersion"];
                    if (model.dialogRepeat == 0) {
                        if (appVersion == nil) {
                            //第一次建议升级,需要弹框
                        } else {
//                            [self applicationStart];
                            break;
                        }
                    } else if (model.dialogRepeat == 1) {
                        
                    }
                    
                    /// 保存建议升级的版本号
                    [defaults setObject:model.appV forKey:@"appupdateVersion"];
                    [defaults synchronize];
                    
                    AppUpdateAlertView *alert = [[AppUpdateAlertView alloc]initWithModel:model cancelClosure:^{
                        [self applicationStart];
                    } sureUpdateClosure:^{
                        //跳转网页
                        [UIApplication.sharedApplication openURL:[NSURL URLWithString:model.url]];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            abort();
                        });
                    }];
                    
                    dispatch_semaphore_signal(self.semaphore);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [alert showAlertViewInViewController:self.window.rootViewController leftOrRightMargin:30];
                    });
                    break;
                    
                }
                    
                case 2: //强制升级
                {
                    AppUpdateAlertView *alert = [[AppUpdateAlertView alloc]initWithModel:model cancelClosure:^{
                    } sureUpdateClosure:^{
                        //跳转网页
                        [UIApplication.sharedApplication openURL:[NSURL URLWithString:model.url]];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            abort();
                        });
                    }];
                    
                    dispatch_semaphore_signal(self.semaphore);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [alert showAlertViewInViewController:self.window.rootViewController leftOrRightMargin:30];
                    });
                    break;
                    
                }
                case 3:
                    dispatch_semaphore_signal(self.semaphore);
                    abort();
                    break;
                default:
//                    [self applicationStart];
                    break;
            }
        }
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)setUpdateApp:(AppUpdateModel *)model{
    switch (model.upgradeWay) {
        case 0: //不升级
        {
            [self applicationStart];
            break;
        }
        case 1: //建议升级
        {
            ///获取建议升级的版本号
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *appVersion = [defaults objectForKey:@"appupdateVersion"];
            if (model.dialogRepeat == 0) {
                if (appVersion == nil) {
                    //第一次建议升级,需要弹框
    
                } else {
//                    [self applicationStart];
                    break;
                }
            } else if (model.dialogRepeat == 1) {
                
            }
            
            /// 保存建议升级的版本号
            [defaults setObject:model.appV forKey:@"appupdateVersion"];
            [defaults synchronize];
            
            AppUpdateAlertView *alert = [[AppUpdateAlertView alloc]initWithModel:model cancelClosure:^{
                [self applicationStart];
            } sureUpdateClosure:^{
                //跳转网页
                [UIApplication.sharedApplication openURL:[NSURL URLWithString:model.url]];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    abort();
                });
            }];
            
            dispatch_semaphore_signal(self.semaphore);
            dispatch_async(dispatch_get_main_queue(), ^{
                [alert showAlertViewInViewController:self.window.rootViewController leftOrRightMargin:30];
            });
            break;
            
        }
            
        case 2: //强制升级
        {
            AppUpdateAlertView *alert = [[AppUpdateAlertView alloc]initWithModel:model cancelClosure:^{
            } sureUpdateClosure:^{
                //跳转网页
                [UIApplication.sharedApplication openURL:[NSURL URLWithString:model.url]];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    abort();
                });
            }];
            
            dispatch_semaphore_signal(self.semaphore);
            dispatch_async(dispatch_get_main_queue(), ^{
                [alert showAlertViewInViewController:self.window.rootViewController leftOrRightMargin:30];
            });
            break;
            
        }
        case 3:
            dispatch_semaphore_signal(self.semaphore);
            abort();
            break;
        default:
//            [self applicationStart];
            break;
    }
}

#pragma 第三方
- (void)registerThirdData
{
    [self registerUMCommon];
    //    [self buglyData];
}

- (void)registerUMCommon
{
    //    [UMConfigure initWithAppkey: UMENG_AppKey channel:kChannel];
#if DEBUG
    [UMConfigure setLogEnabled:YES];//设置打开日志
#else
    [UMConfigure setLogEnabled:NO];//设置打开日志
#endif
    
    //    [MobClick event:@"friend_click"];
    
}

- (void)buglyData
{
    [Bugly startWithAppId:@"67379cd054"];
    
}

-(void)otherConfigure
{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark --------------- 友盟推送 ------------------
-(void)registUmengPushOptions:(NSDictionary *)launchOptions{
    
    // Push组件基本功能配置
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
    if (@available(iOS 10.0, *)) {
        [UNUserNotificationCenter currentNotificationCenter].delegate=self;
    } else {
        // Fallback on earlier versions
    }
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
        }else{
        }
    }];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    //    ZYJDlog(@"%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]                  stringByReplacingOccurrencesOfString: @">" withString: @""]                 stringByReplacingOccurrencesOfString: @" " withString: @""]);
    
    NSString *device_token  = [NSString stringWithFormat:@"%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]                  stringByReplacingOccurrencesOfString: @">" withString: @""]                 stringByReplacingOccurrencesOfString: @" " withString: @""]];
    
    DLog(@"DEVICE TOKEN===%@---%ld",device_token,deviceToken.length);
    
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end


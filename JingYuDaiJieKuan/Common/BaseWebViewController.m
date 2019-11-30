//
//  BaseWebViewController.m
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/4/9.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#define KJSToAPP_POPVC @"jsToAppPop" // 退出web 标识 与H5同步

#import "BaseWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "AssetsNoDataView.h"
#import <UShareUI/UShareUI.h>
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
#import "GFSharedView.h"
#import "AdWebViewController.h"
#import "preciseRecommendationWebVC.h"
#import "JingYuDaiJieKuan-Swift.h"

@interface BaseWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UINavigationControllerDelegate,UINavigationBarDelegate>

@property (nonatomic,strong)AssetsNoDataView *noDataView;

@property (nonatomic, strong) UIProgressView *progressView;//设置加载进度条

//完成的拼接后的url请求
@property (nonatomic, strong) NSURLRequest *URLRequest;

@end

@implementation BaseWebViewController

-(void)backToSuperView
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        //        NSURL *back = [self.webView.backForwardList backItem].URL;//后退的URL
        //        [self.webView loadRequest:[NSURLRequest requestWithURL:back]];
    }else{
        if (self.isShowBackView) {
               TZShowAlertView *alrt = [[TZShowAlertView alloc] initWithAlerTitle:@"\"帒呗\"能解燃眉之急" Content:@"您确定要离开？" buttonArray:@[@"狠心离开",@"留在这里"] blueButtonIndex:1 alertButtonBlock:^(NSInteger buttonIndex) {
                   if (buttonIndex == 0) {
                       [super backToSuperView];
                   }
               }];
            alrt.contentLabel.textColor = kBtnGrayColor;
            [alrt show];
           }else{
               [super backToSuperView];
           }
//        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)backClick{
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置网页的配置文件
    WKWebViewConfiguration * Configuration = [[WKWebViewConfiguration alloc]init];
    //允许视频播放
    //        Configuration.allowsAirPlayForMediaPlayback = YES;
    // 允许在线播放
    //        Configuration.allowsInlineMediaPlayback = YES;
    // 允许可以与网页交互，选择视图
    Configuration.selectionGranularity = YES;
    // web内容处理池
    Configuration.processPool = [[WKProcessPool alloc] init];
    //自定义配置,一般用于 js调用oc方法(OC拦截URL中的数据做自定义操作)
    WKUserContentController * UserContentController = [[WKUserContentController alloc]init];
    
    // 是否支持记忆读取
    Configuration.suppressesIncrementalRendering = YES;
    // 允许用户更改网页的设置
    Configuration.userContentController = UserContentController;
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH_AutoSize, SCREEN_HEIGHT_AutoSize) configuration:Configuration];
    
    //    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:Configuration];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    
    NSString * urlStr = self.url;
    
    ///判断是自己的网址才需要拼接token
    if ([self isOurWebsiteW:urlStr]) {
        if ([urlStr containsString:@"?"]) {
            //这是原本url就带有参数的情况,这个情况下,拼接"&userid=123"
            urlStr = [urlStr stringByAppendingFormat:@"&token=%@&userId=%@&channel=%@&tplKey=%@",[kUserMessageManager getUserToken],[kUserMessageManager getUserId],kChannel,kTplKey];
        }else {
            //这是原本url不带参数的情况,这个情况下,拼接"?userid=123"
            urlStr = [urlStr stringByAppendingFormat:@"?token=%@&userId=%@&channel=%@&tplKey=%@",[kUserMessageManager getUserToken],[kUserMessageManager getUserId],kChannel,kTplKey];
        }
    }
    
    self.URLRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.webView loadRequest:self.URLRequest];
    [self.view addSubview:self.webView];
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    kSelfWeak;
    self.noDataView = [[AssetsNoDataView alloc]initWithFrame:self.view.bounds];
    self.noDataView.refreshDataBlock = ^{
        [weakSelf.webView stopLoading];
        [weakSelf.webView loadRequest:weakSelf.URLRequest];
        weakSelf.noDataView.hidden = YES;
    };
    self.noDataView.tipsLabel.text = @"网页加载失败";
    [self.view addSubview:self.noDataView];
    self.noDataView.hidden = YES;
    
    [self.view addSubview:self.progressView];
    self.progressView.hidden = NO;
    
    [self.webView addObserver:self
                   forKeyPath:NSStringFromSelector(@selector(estimatedProgress))
                      options:0
                      context:nil];
    [self.webView addObserver:self
                   forKeyPath:@"title"
                      options:0
                      context:nil];
    //    [HUD showHUDInView:self.view title:nil];
    
    [self configUSharePlatforms];
    
    //    self.bottomBtnTitleStr = @"我知道了";
    if (!checkStrEmty(self.bottomBtnTitleStr)) {
        UIView *bottomView = [self addBottonViewBtn];
        self.webView.height = bottomView.top;
    }else{
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(@0);
        }];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:KJSToAPP_POPVC];

    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"getToken"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"getBasicParams"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"pushNewWebPage"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"copy2Clipboard"];
    //跳转到商户详情页面 (1.0.0)
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"pushMerchantDetailPage"];
    //跳转到主界面其他Tab页 (1.0.0)
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"pushMainPageTargetTab"];
    //跳转到精准推荐
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"pushAccurateRecommendationPage"];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //    if ([self.webView isLoading])
    //    {
    //        [self.webView stopLoading];
    //        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //    }
//    doOk()
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:KJSToAPP_POPVC];

    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"getToken"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"getBasicParams"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"pushNewWebPage"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"copy2Clipboard"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"pushMerchantDetailPage"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"pushMainPageTargetTab"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"pushAccurateRecommendationPage"];
}



//解决白屏的方法二: wkwebview白屏时有概率会调用这个方法
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    NSLog(@"白屏啦");
    [SVProgressHUD dismiss];
    [self.webView loadRequest:self.URLRequest];
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];

    self.webView.hidden = NO;
    self.progressView.hidden = NO;
    
    DLog(@"%s",__func__);
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    DLog(@"%s",__func__);
}

- (NSString *)noWhiteSpaceString {
    NSString *newString;
    //去除掉首尾的空白字符和换行字符
    newString = [newString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    newString = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    newString = [newString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符使用
    newString = [newString stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    可以去掉空格，注意此时生成的strUrl是autorelease属性的，所以不必对strUrl进行release操作！
    return newString;
}

///页面的回调
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    //神策APP打通H5
    if ([[SensorsAnalyticsSDK sharedInstance] showUpWebView:webView WithRequest:navigationAction.request enableVerify:NO]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    NSURL *url = navigationAction.request.URL;
    //其它需要允许的scheme也可以放在此处
    if ([url.scheme isEqualToString:@"weixin"] || [url.scheme isEqualToString:@"alipay"]) {
        if ( [[UIApplication sharedApplication] canOpenURL:url]) {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:nil];
            } else {
                [[UIApplication sharedApplication] openURL:url];
            }
            
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
        
        
    }
    
    //如果是打开的plist(下载安装ipa)或者mobileprovision(企业信任描述文件)的url,那么需要调到Safari浏览器".plist"
    if ([url.absoluteString containsString:@".plist"]||[url.absoluteString containsString:@".mobileprovision"]) {
        [[UIApplication sharedApplication] openURL:url];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.noDataView.hidden = YES;
    [SVProgressHUD dismiss];

    if (self.didFinishBlock) {
        self.didFinishBlock();
    }
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(nonnull NSError *)error
{
    [SVProgressHUD dismiss];
    DLog(@"%s",__func__);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.noDataView.hidden = NO;
    
}

//拦截执行网页中的JS方法    --   监听
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    kSelfWeak;
    if ([message.name isEqualToString:KJSToAPP_POPVC]) {
        NSLog(@"%@ -- %@", message.name, message.body);
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    //网页内部跳转  //getBasicParams
    if ([message.name isEqualToString:@"getToken"]) {
        NSString *token = [NSString stringWithFormat:@"getToken('%@')",[kUserMessageManager getMessageManagerForObjectWithKey:KEY_USER_TOKEN]];
    }
    
    //  2、获取基本参数
    if (([message.name isEqualToString:@"getBasicParams"])) {
        
    }
    
    //  3. 打开一个新的普通web页面
    if (([message.name isEqualToString:@"pushNewWebPage"])) {
        NSDictionary *dic = message.body;
        NSLog(@">>>>>>>%@%@>>>>>",[dic objectForKey:@"url"],[dic objectForKey:@"merchantId"]);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            BaseWebViewController *vc = [[BaseWebViewController alloc] init];
            vc.url = [NSString stringWithFormat:@"%@",[NSURL URLWithString:[dic objectForKey:@"url"]]?:@""];
            [self.navigationController pushViewController:vc animated:YES];
        });
    }
    
    // 4. 拷贝数据到到剪切板
    if (([message.name isEqualToString:@"copy2Clipboard"])) {
        NSDictionary *dic = message.body;
        
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = [dic objectForKey:@"content"];
    }
    
    //  5. 跳转到商户详情页面
    if (([message.name isEqualToString:@"pushMerchantDetailPage"])) {
        NSDictionary *dic = message.body;
        NSLog(@">>>>>>>%@%@>>>>>",[dic objectForKey:@"url"],[dic objectForKey:@"merchantId"]);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            AdWebViewController *vc = [[AdWebViewController alloc]init];
            [vc showWebWithURL:[dic objectForKey:@"url"]
                andProductIcon:@""
           andProductMaxAmount:@""
          andProductMerchartid:[NSString stringWithFormat:@"%@",[dic objectForKey:@"merchantId"]]
                andProductName:[dic objectForKey:@"mchName"]
                andProductTags:@""
               andProductTitle:@""
                 andProductUrl:[dic objectForKey:@"url"]
               andFromPosition:[dic objectForKey:@"position"]
          andIsNeedSaveHistory:YES
           withSuperController:self];
            
        });
        
    }
    
    if ([message.name isEqualToString:@"pushMainPageTargetTab"]) {
        NSDictionary *dic = message.body;
        NSLog(@">>>>>>>%@>>>>>",[dic objectForKey:@"position"]);
        NSString *position = [dic objectForKey:@"position"];
        //(0首页, 1贷款大全, 2必下款 3个人中心)
        UITabBarController *tabViewController = kAppDelegate.window.rootViewController;
        [tabViewController setSelectedIndex:position.integerValue];
        
    }
    
    //  5. 跳转到精准推荐
    if (([message.name isEqualToString:@"pushAccurateRecommendationPage"])) {
        NSDictionary *dic = message.body;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SensorsAnalyticsSDKHelper preciseRecommendationEventWithPosition:[dic objectForKey:@"position"]];
            
            preciseRecommendationWebVC *vc = [preciseRecommendationWebVC new];
            vc.url = [dic objectForKey:@"url"];
            [self.navigationController pushViewController:vc animated:YES];
        });
        
    }
    
}

- (void)shareWithParams:(NSDictionary *)tempDic{
    
    if (![tempDic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSString *url = [tempDic objectForKey:@"url"];
    NSString *title = [tempDic objectForKey:@"title"];
    NSString *imgUrl = [tempDic objectForKey:@"imgUrl"];
    NSString *description = [tempDic objectForKey:@"description"];
    
    [GFSharedView showSharedView:^(GFSharedItem *item) {
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建网页内容对象
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:description thumImage:imgUrl];
        //设置网页地址
        shareObject.webpageUrl = url;
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:item.type messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
        }];
    }];
}
//kvo 监听进度
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context{
    
    if ([keyPath isEqualToString:@"title"]){
        //监听web页面title的改变,来设置navitem的title
        if (!checkStrEmty(self.webView.title)){
            //如果不为空,跟着web的标题设置
            self.navigationItem.title = self.webView.title;
            
        }else{
            //如果是空直,那么就不赋值,原本是什么就是什么
        }
        return;
    }
    
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == self.webView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.webView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.webView.estimatedProgress
                              animated:animated];
        
        if (self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 [self.progressView setAlpha:0.0f];
                                 //                                 [self.progressView setHidden:YES];
                             }
                             completion:^(BOOL finished) {
                                 [self.progressView setProgress:0.0f animated:NO];
                             }];
        }
    }else{
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}
// 默认给 web 传值
- (NSString *)getToken
{
    NSString * latitude = ChangeNullData([kUserMessageManager getMessageManagerForObjectWithKey:@"latitude"]);
    NSString * longitude = ChangeNullData([kUserMessageManager getMessageManagerForObjectWithKey:@"longitude"]);
    
    NSDictionary *dict;
    if (!latitude || !longitude) {
        latitude = @"0";
        longitude = @"0";
    }
    NSString *phone = ChangeNullData([kUserMessageManager getMessageManagerForObjectWithKey:KEY_USER_PHONE]);
    if (latitude !=nil && longitude !=nil)
    {
        dict = @{@"token":[kUserMessageManager getUserToken]?:@"",@"platform":@"1",@"v":@"1.0.0",@"appid":@"appid_test",@"app_v":kApp_Version,@"latitude":latitude?:@"0",@"longitude":longitude?:@"0",@"phone":phone?:@"",@"unique_id":UNIQUE_ID,@"channel":@"App Store"};
    }
    else
    {
        dict = @{@"token":[kUserMessageManager getUserToken]?:@"",@"platform":@"1",@"v":@"1.0.0",@"appid":@"appid_test",@"app_v":kApp_Version,@"latitude":@"0",@"longitude":@"0",@"phone":phone?:@"",@"unique_id":UNIQUE_ID,@"channel":@"App Store"};
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paraStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    // 将JSON字符串转成无换行无空格字符串
    
    return  [self noWhiteSpaceString:paraStr];//[self toJsonWithDict:dict];//
}

- (NSString *)noWhiteSpaceString:(NSString *)newString {
    //去除掉首尾的空白字符和换行字符
    newString = [newString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    newString = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    newString = [newString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符使用
    newString = [newString stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    可以去掉空格，注意此时生成的strUrl是autorelease属性的，所以不必对strUrl进行release操作！
    return newString;
}

- (NSString *)toJsonWithDict:(NSDictionary *)dict {
    NSError *error;
    NSData *datas = [NSJSONSerialization dataWithJSONObject:dict
                                                    options:NSJSONWritingPrettyPrinted
                                                      error:&error];
    return [[NSString alloc] initWithData:datas encoding:NSUTF8StringEncoding];
}

-(UIProgressView *)progressView{
    if (!_progressView) {
        _progressView                   = [[UIProgressView alloc]
                                           initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame             = CGRectMake(0, 0, kScreenWidth, 2);
        
        [_progressView setTrackTintColor:[UIColor colorWithRed:240.0/255
                                                         green:240.0/255
                                                          blue:240.0/255
                                                         alpha:1.0]];
        _progressView.progressTintColor = UIColorHex(@"#3f85ff");
    }
    return _progressView;
}

#pragma mark - 网页弹窗
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:true completion:nil];
    
}

#pragma mark - 点击事件
- (void)addNavigationRightButton{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton addTarget:self action:@selector(backToSuperView) forControlEvents:UIControlEventTouchUpInside];
    CGSize buttonSize = CGSizeMake(64, 35);
    rightButton.frame = CGRectMake( 0, 0, buttonSize.width, buttonSize.height);
    [rightButton setTitle:@"注册" forState:UIControlStateNormal];
    rightButton.titleLabel.font = KFont(15);
    [rightButton setTitleColor:UIColorHex(@"#0c72e3") forState:UIControlStateNormal];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -20;
    UIBarButtonItem *rightBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItems=@[negativeSpacer,rightBarButtonItem];
}

-(void)dealloc{
    //    if (self.inviestmentDetail) {
    //
    //    }else{
    [self.webView removeObserver:self
                      forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    [self.webView removeObserver:self forKeyPath:@"title"];
    //    }
    
    [self clearDataStore];
}

//分享配置
- (void)configUSharePlatforms {
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx31a1b9b18c58516c" appSecret:@"d1f5678348a2011df76fc8aefdc5881f" redirectURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}


/// 清除缓存
- (void)clearDataStore {
    WKWebsiteDataStore *dataStore = WKWebsiteDataStore.defaultDataStore;
    NSSet *set = [NSSet setWithObjects:WKWebsiteDataTypeDiskCache
                  ,WKWebsiteDataTypeMemoryCache,WKWebsiteDataTypeCookies, nil];
    [dataStore fetchDataRecordsOfTypes:set completionHandler:^(NSArray<WKWebsiteDataRecord *> * _Nonnull records) {
        for (WKWebsiteDataRecord *obj in records) {
            [dataStore removeDataOfTypes:obj.dataTypes forDataRecords:records completionHandler:^{
                NSLog(@"Cookies for %@ deleted successfully",obj.displayName);
            }];
        };
    }];
}

/// 检查是不是我们的网址
- (BOOL)isOurWebsiteW: (NSString *)urlStr{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^http[s]?://.*orangeloan.jywhi.com/.*"]evaluateWithObject:urlStr] ||
    [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^http[s]?://.*orangedai.com/.*"]evaluateWithObject:urlStr];
}


#pragma mark - 底部返回按钮
- (UIView *)addBottonViewBtn{
    
    UIView *view = InsertView(self.view, CGRectMake(0, kScreenHeight-kNavBarH -56-iPhoneXDiffHeight()*2, kScreenWidth, 56+iPhoneXDiffHeight()*2), [UIColor whiteColor]);
    
    CGRect rect = CGRectMake(iPW(71), 8, kScreenWidth-iPW(70)*2, 40);
    UIButton *btn = InsertButtonWithType(view, rect, 0, self, @selector(bottomTapAction:), UIButtonTypeCustom);
    [btn setTitle:self.bottomBtnTitleStr forState:UIControlStateNormal];
    btn.titleLabel.font = kFontSize18;
    btn.layer.cornerRadius = 20.0f;
    btn.backgroundColor = Bg_Btn_Colorblue;
    
    return  view;
}

- (void)bottomTapAction:(UIButton *)ben{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end

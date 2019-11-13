//
//  SensorsSDKHelper.swift
//  TuandaiLoan
//
//  Created by yfm on 2018/12/19.
//  Copyright © 2018年 com.tuandaiwang.www. All rights reserved.
//
//  神策管理类
//

import Foundation

#if DEBUG
let SA_SERVER_URL = "https://juzidaistandalone.cloud.sensorsdata.cn:4006/sa?token=6e6141d14c0b4426"
#else
let SA_SERVER_URL = "https://juzidaistandalone.cloud.sensorsdata.cn:4006/sa?token=6e6141d14c0b4426"
#endif

class SensorsAnalyticsSDKHelper: NSObject {
    
    /// SDK实例
    private static var shared = SensorsAnalyticsSDK.sharedInstance()
    
    /// 配置神策SDK
    ///
    /// - Parameter launchOptions: APP启动参数
    @objc static func registerSensorsAnalytics(launchOptions: [UIApplication.LaunchOptionsKey: Any]?,
                                         distinctId: String?) {
        

        //1.初始化神策SDK
        let options = SAConfigOptions.init(serverURL: SA_SERVER_URL, launchOptions: launchOptions)
        shared = SensorsAnalyticsSDK.sharedInstance(withConfig: options)
        
        //2.打开自动采集, 并指定追踪哪些 AutoTrack 事件
        options.autoTrackEventType = [.eventTypeAppClick,
                                      .eventTypeAppStart,
                                      .eventTypeAppEnd,
                                      .eventTypeAppViewScreen]

        //3.配置
        //3.1 产品需求:每隔3秒发送一次
        options.flushInterval = 3*1000
        //3.2 每缓存 100 条数据，就发送一次
        options.flushBulkSize = 100
        //3.3 在 App 进入后台状态前，将本地缓存的数据发送到 Sensors Analytics
        shared?.flushBeforeEnterBackground = true
//        shared?.showDebugInfoView(false)
        //3.4 在 3G／4G／WI-FI 环境下，SDK 都会尝试发送数据
        shared?.setFlushNetworkPolicy([.type3G,
                                       .type4G,
                                       .typeWIFI])
//        4.设置公共属性（Properties)
         shared?.registerSuperProperties(["PlatformType": "APP"])

        ///清除公共参数缓存
//        shared?.clearSuperProperties()
        
        //4.1配置动态公共属性
        shared?.registerDynamicSuperProperties({ () -> [String : Any] in
            return ["isLogin": UserMessageManager.shared()?.checkUserLogin()];
        })
        
        //5.设置用户名
        if let _distinctId = distinctId {
            shared?.login(_distinctId)
        }

        ///打印调试日志
        #if DEBUG
        shared?.enableLog(true)
        #else
        shared?.enableLog(false)
        #endif
        
        //6.打通 App 与 H5
//        shared?.addWebViewUserAgentSensorsDataFlag()
        shared?.addWebViewUserAgentSensorsDataFlag(false);
        
        // 记录 AppInstall 激活事件
        shared?.trackInstallation("AppInstall")
    }

    /// 用户登录
    ///
    /// - Parameter distinctId: 唯一标识
    @objc static func trackLogin(distinctId: String?) {
        if let _distinctId = distinctId {
            shared?.logout()
            shared?.login(_distinctId)
        }
    }

    
    /// 用户退出登录
    @objc static func trackLogout() {
        shared?.logout()
    }

    
    ///首页banner点击
    @objc static func trackBannerClick(position: Double,
                                       title: String,
                                       url: String,
                                       mchId: String,
                                       mchName: String) {
        
        shared?.track("GuanjiaApp_banner_click",
                      withProperties: ["bannerPosition": position,
                                       "bannerTitle": title,
                                       "bannerUrl": url,
                                       "mchId": mchId,
                                       "mchName": mchName
            ])
    }
    
    ///首页金刚区
    @objc static func trackIconClick(position: Double,
                                       name: String,
                                       url: String) {
        
        shared?.track("GuanjiaApp_indexIcon_click",
                      withProperties: ["iconPositon": position,
                                       "iconName": name,
                                       "iconUrl": url,
                                       "mchId": "",
                                       "mchName": ""
            ])
    }
    
    ///tabBar点击
    @objc static func trackTabBarClick(tabBarItemName: String) {
        
        shared?.track("Bottom_click",
                      withProperties: ["userId": UserMessageManager.shared()?.userId,
                                       "iconName": tabBarItemName,
                                       "mchId": "",
                                       "mchName": ""
            ])
    }
    
    
    ///贷款大全页tab点击
    @objc static func trackProductItemTab(tabName: String) {
        
        shared?.track("Dkdq_tab_click",
                      withProperties: ["userId": UserMessageManager.shared()?.userId,
                                       "registSource": "",
                                       "tabName":tabName,
                                       "mchId": "",
                                       "mchName": ""
            ])
    }
    
    ///浮窗点击
    @objc static func trackRightControl(tabPositionId: String,
                                        title: String,
                                        url: String,
                                        mchId: String,
                                        mchName: String) {
        var tabPositionName = "首页"
        ///1-首页|2-贷款大全|3-我的
        switch tabPositionId {
        case "1":
            tabPositionName = "首页"
        case "2":
            tabPositionName = "贷款大全"
        case "3":
            tabPositionName = "我的"
        default:
            break
        }
      
        shared?.track("Floating_click",
                      withProperties: ["floatPosition": tabPositionName,
                                       "floatTitle": title,
                                       "floatUrl": url,
                                       "mchId": mchId,
                                       "mchName": mchName
            ])
    }
    
    ///弹窗点击
    @objc static func trackAdvertisement(tabPositionId: String,
                                        title: String,
                                        url: String,
                                        mchId: String,
                                        mchName: String) {
        var tabPositionName = "首页"
        ///1-首页|2-贷款大全|3-我的
        switch tabPositionId {
        case "1":
            tabPositionName = "首页"
        case "2":
            tabPositionName = "贷款大全"
        case "3":
            tabPositionName = "我的"
        default:
            break
        }
        
        shared?.track("pop_window_click",
                      withProperties: ["floatPosition": tabPositionName,
                                       "floatTitle": title,
                                       "floatUrl": url,
                                       "mchId": mchId,
                                       "mchName": mchName
            ])
    }
    
    ///挽留弹窗点击
    @objc static func trackAdWebView(custemName: String,
                                     isBrowse: Bool,
                                     mchId: String,
                                     mchName: String) {
        
        shared?.track("Detain_click",
                      withProperties: ["custName": custemName,
                                       "registSource": "",
                                       "browse":isBrowse,
                                       "mchId": mchId,
                                       "mchName": mchName
            ])
    }
    
    ///今日推荐点击(大卡片)
    @objc static func trackRecommend(title: String,
                                     url: String,
                                     mchId: String,
                                     mchName: String) {
        
        shared?.track("GuanjiaApp_cardBanner_click",
                      withProperties: ["bannerTitle": title,
                                       "bannerUrl": url,
                                       "mchId": mchId,
                                       "mchName": mchName
            ])
    }
    
    ///首页大瓷片点击
    @objc static func trackHomeBottomIcon(positionIndex: Double,
                                          title: String,
                                          url: String,
                                          mchId: String,
                                          mchName: String) {
        
        shared?.track("index_cipian_click",
                      withProperties: ["bannerPosition": positionIndex,
                                       "bannerTitle": title,
                                       "bannerUrl": url,
                                       "mchId": mchId,
                                       "mchName": mchName
            ])
    }
    
    ///商户广告H5加载完毕后的埋点
    @objc static func trackLoadiFinish(position: String,
                                       mchId: String,
                                       mchName: String) {
        
        shared?.track("LaodCustH5_click",
                      withProperties: ["userId": UserMessageManager.shared()?.userId,
                                       "position": position,
                                       "mchId": mchId,
                                       "mchName": mchName
            ])
    }
    
    ///商户H5停留时长
    @objc static func trackH5Stay(mchId: String,
                                      mchName: String,
                                      stayTime: NSInteger) {
        
        shared?.track("Cust_h5_time",
                      withProperties: ["userId": UserMessageManager.shared()?.userId,
                                       "mchId": mchId,
                                       "mchName": mchName,
                                       "stayTime": stayTime
            ])
    }
    
    ///倒计时广告页点击
    @objc static func startPageClick(mchId: String,
                                  mchName: String,
                                  startupPageTitle: String,
                                  startupPageUrl: String) {

        shared?.track("Start_page_click",
                      withProperties: ["userId": UserMessageManager.shared()?.userId,
                                       "mchId": mchId,
                                       "mchName": mchName,
                                       "startupPageTitle": startupPageTitle,
                                       "startupPageUrl": startupPageUrl
            ])
    }
    
    ///搜索事件采集
    @objc static func searchEvent(searchCount: String,
                                  searchContent: String) {
        
        shared?.track("Search",
                      withProperties: ["searchResult": searchCount,
                                       "searchContent": searchContent
            ])
    }
    
    ///商户点击
    @objc static func merchantClick(mchId: String,
                                     mchName: String,
                                     position: String,
                                     sort: String) {
        
        shared?.track("Merchant_click",
                      withProperties: ["mchId": mchId,
                                       "mchName": mchName,
                                       "position": position,
                                       "sort": sort
            ])
    }
    
    ///我的-设置中跳转控制器的点击位置
    @objc static func mySettingsEvent(position: String) {
        
        shared?.track("My_settings",
                      withProperties: ["position": position
            ])
    }
    
    ///我的-热门工具中跳转控制器的点击位置
    @objc static func myHotToolEvent(position: String) {
        
        shared?.track("My_hot_tool",
                      withProperties: ["position": position
            ])
    }
    
    ///贷款攻略点击
    @objc static func loanStrategy(articleTitle: String,
                                   articleType: String,
                                   position: String,
                                   stayTime: NSInteger) {
        
        shared?.track("Loan_strategy",
                      withProperties: ["articleTitle": articleTitle,
                                       "articleType": articleType,
                                       "position": position,
                                       "stayTime": stayTime
            ])
    }
    
    
    ///横幅点击
    @objc static func streamerClickEvent(mchId: String,
                                         mchName: String,
                                         streamerTitle: String,
                                         streamerUrl: String,
                                         position: String,
                                         sort: String) {
       
        shared?.track("Banner_click",
                      withProperties: ["userId": UserMessageManager.shared()?.userId,
                                       "mchId": mchId,
                                       "mchName": mchName,
                                       "streamerTitle": streamerTitle,
                                       "streamerUrl": streamerUrl,
                                       "position": position,
                                       "sort": sort
                                    ])
    }
    
    ///精准推荐-入口点击
    @objc static func preciseRecommendationEvent(position: String) {
        
        shared?.track("Recommended_entrance_click",
                      withProperties: ["userId": UserMessageManager.shared()?.userId,
                                       "position": position])
    }
    
    ///精准推荐-挽留弹窗
    @objc static func preciseRecommendationRetentionEvent(ifQuite: Bool) {
        
        shared?.track("Recommended_pop_up",
                      withProperties: ["userId": UserMessageManager.shared()?.userId,
                                       "ifQuite": ifQuite])
    }
    
}

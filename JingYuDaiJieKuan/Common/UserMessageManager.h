//
//  UserMessageManager.h
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/4/2.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserMessageManager : NSObject


@property(nonatomic,assign) BOOL  g_IfComeFromBackgroud;
@property(nonatomic,assign) BOOL  g_IfBeginOpenApp;
@property(nonatomic,assign) int  g_IfProductBuyLogin; // 1-转入 2-转出 3-从后台进入应用
@property(nonatomic,assign) int  m_IntMessageTime;

//注册验证码
@property(nonatomic,assign) int  g_TimeSecond;
@property(nonatomic,strong) NSTimer *g_Timer;
@property(nonatomic,copy) NSString *g_TimeTel;
@property(nonatomic, assign) BOOL g_TimeAnimalReset;

//忘记密码验证码
@property(nonatomic,assign) int  g_TimeSecond_forgetKey;
@property(nonatomic,strong) NSTimer *g_Timer_forgetKey;
@property(nonatomic,copy) NSString *g_TimeTel_forgetKey;
@property(nonatomic, assign) BOOL g_TimeAnimalReset_forgetKey;
//验证码登录
@property(nonatomic,assign) int  g_TimeSecond_codeLogin;
@property(nonatomic,strong) NSTimer *g_Timer_codeLogin;
@property(nonatomic,copy) NSString *g_TimeTel_codeLogin;
@property(nonatomic, assign) BOOL g_TimeAnimalReset_codeLogin;



@property(nonatomic,assign) int g_MenuClickItem;

@property(nonatomic,strong) NSString *g_StringShareURL;
// 红包开关
@property(nonatomic,assign) int g_IntHongbaoSwith;

// ip
@property(nonatomic,strong) NSString *g_StringIP;

//
@property(nonatomic,assign) int g_StateTradePasswordSet;
@property(nonatomic,assign) int g_State_bankBind;

@property(nonatomic,assign) int g_PushType;

@property (copy ,nonatomic) NSString *userId;

@property (copy ,nonatomic) NSString *toKen;

@property (copy ,nonatomic) NSString *phone;

@property (copy ,nonatomic) NSString *deviceToken;

@property (copy ,nonatomic) NSString *bank;


//初始化单例
+(UserMessageManager *)sharedUserMessageManager;

- (void)TimeBegin;
- (void)TimeBeginWithTel:(NSString *)tel;
//- (void)TimeBeginWithType:(kTimeSecondType )type WithTel:(NSString *)tel;
-(NSString *)getUserId;
-(NSString *)getUserToken;
- (NSString *)getDeviceToken;
- (NSString *)getUserPhone;
-(BOOL)checkUserLogin;
-(BOOL)bankCardAre;
-(BOOL)checkUserLoginAndLoginWithEventkey:(NSString *)eventkey;
- (BOOL)checkUserLoginAndRegisterWithEventkey:(NSString *)eventkey webType:(NSString *)webType;
- (BOOL)customerServiceWithEventkey:(NSString *)eventkey;

// push App登陆
-(void)checkAppLogin;

//    /user/logout   用户退出登录接口
- (void)userLogoutAppData;

/** 更新用户资料信息*/
- (void)updateUserDataUrl;

//存储需要银行卡信息
- (void)saveBankCardInfoWithBankName:(NSString *)bankname CardNo:(NSString *)cardno LastFourNo:(NSString *)lastfourno BankIconUrl:(NSString *)bankiconurl;
- (void)saveBankCardInfoWithBankID:(NSString *)bankId;
//删除存储银行卡信息
- (void)removeBankCardInfo;

//清除活动公告本地缓存
- (void)removeHuoDongGongGao;

//每次退出清空数据
- (void)removeDataWhenLogout;

//页点击统计
- (void)UMClickCountWithEventID:(NSString *)eventid  EventNumID:(NSString *)eventnumid;


-(void)setMessageManagerForObjectWithKey:(NSString *)key value:(id)value;
-(id)getMessageManagerForObjectWithKey:(NSString *)key;
-(void)setMessageManagerForBoolWithKey:(NSString *)key value:(BOOL)value;
-(BOOL)getMessageManagerForBoolWithKey:(NSString *)key;
-(void)setMessageManagerForIntegerWithKey:(NSString *)key value:(NSInteger)value;
-(NSInteger)getMessageManagerForIntegerWithKey:(NSString *)key;
-(void)setMessageManagerForFloatWithKey:(NSString *)key value:(CGFloat)value;
-(CGFloat)getMessageManagerForFloatWithKey:(NSString *)key;
-(void)removeMessageManagerForKey:(NSString *)key;


//判断密码是否规范
- (BOOL)JudgePasswordCorrect:(NSString *)Password;

//绘制虚线
- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

//UIColor 转 UIImage
- (UIImage*)createImageWithColor:(UIColor*)color;

//界面上移 or 恢复
- (void)changeViewWithType:(NSInteger )type iphone4Move:(CGFloat)ip4movenum iphoneMove:(CGFloat)ipmovenum moveView:(UIView *)moveview;

//限制输入框输入长度
- (void)limitInputWithTF:(UITextField *)tf Length:(NSInteger)length;

//修改部分字体色值
- (NSMutableAttributedString *)setAttributeWithText:(NSString *)text Color:(UIColor*)color Range:(NSRange)range;

//修改部分字体大小
- (NSMutableAttributedString *)setAttributeWithText:(NSString *)text Font:(UIFont*)font Range:(NSRange )range;



//获取id fa mac
- (NSString *)macString;
- (NSString *)idfaString;
- (NSString *)idfvString;



- (void)showAddBankCardNoViewControllerInNavigation:(UINavigationController *)navigationController ;
- (void)showAddOpenCityViewControllerInNavigation:(UINavigationController *)navigationController;
- (void)showForgetpwdControllerInNavigation:(UINavigationController *)navigationController;
- (void)showSetTradeKeyViewControllerInNavigation:(UINavigationController *)navigationController;
- (void)showSpecificSuccessViewControllerInNavigation:(UINavigationController *)navigationController;
@end

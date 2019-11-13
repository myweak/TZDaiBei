//
//  AppRelatedTips.h
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/19.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#ifndef AppRelatedTips_h
#define AppRelatedTips_h

/*------------------------- 用户信息 ------------------------*/

#define KEY_USER_TOKEN              @"token"
#define KEY_USER_PHONE              @"mobile"//注册手机号
#define KEY_HEAD_PORTRAIT           @"headImg"//头像image
#define KEY_NICK_NAME               @"nickName"//用户名字
#define KEY_USER_ID                 @"userID"//用户id

#define KEY_USER_EMail              @"mailbox"// 邮箱
#define KEY_USER_GENDER             @"gender"// 性别
#define KEY_USER_EDUCATION          @"education"//教育程度


#define USER_MOBILE                 @"mobile"//绑卡手机号
#define ARTICLEMOREURL              @"articleMoreUrl"//更多url
#define WILLBEEXHAUSTINGURL         @"url"//必下款
#define WATERMCHURL                 @"waterMchUrl"//放水新口子
#define TABBARICON                  @"tabbarIcon"//
#define REGURL                      @"regUrl"//服务条款url
#define PRIVACYPOLICYURL            @"privacyPolicyUrl"//隐私条款url

//启动配置的文案
///"我的"中间位置放水新口子文案
#define MYNEWPRODUCTMSG             @"myNewProductMsg"
///"我的"->"放水新口子"页面的title文案
#define MYNEWPRODUCTTITLE           @"myNewProductTitle"
///"首页"最新口子文案
#define INDEXNEWPRODUCTTITLE        @"indexNewProductTitle"

#define KEY_USER_LOGINPHONE         @"LoginPhone"
#define KEY_IS_BINDCARDNUM          @"bankcardNum"
#define KEY_USER_TRADEPASSWORD      @"UserTradePassword"
#define KEY_USER_IDENTITY_ID        @"UserIdentityID"
#define KEY_USER_IS_SET_PAYPWD      @"isSetPayPwd"
#define KEY_IS_BINDCARD             @"isBindBank"
#define SHARE_IS_LOCK               @"ShareIsLock"
#define SHARE_USER_NAME             @"username"
#define USER_RISK_ISRISK            @"risk_isRisk"
#define USERINDEX                   @"index"//点击tab
#define USERINDEXARRAY              @"indexArray"
#define USERITITLEARRAY             @"titleArray"
#define DEVICE_TOKEN                @"device_token"

/*------------------------- 重要通知 ------------------------*/

#define KEY_BIND_BANK_SUCCESS @"bindBankSuccess" //绑卡成功
#define KEY_MONEY_CHANGE @"moneyChange"         // 金额变动
#define KEY_LOGIN_SUCCESS @"LoginSuccess"       //登录成功 界面重布
#define MODIFY_NICKNAME @"ModifyNickname"       //登录成功 界面重布


/*------------------------- 短信类型 ------------------------*/
//     【"regiestCode"=>注册, "findPayCode"=>找回交易密码, "forgetCode"=>忘记密码, "rechargeCode"=>充值, "withdrawCode"=>提现】

#define SMS_REGIEST_CODE  @"regiestCode" //注册
#define SMS_FINDPAY_CODE  @"findPayCode" //支付
#define SMS_FORGET_CODE   @"forgetCode"  //忘记密码
#define SMS_RECHARGE_CODE @"rechargeCode"//充值
#define SMS_WITHDRAW_CODE @"withdrawCode"//提现

const static NSString *Gaode_APIKEY = @"81525f4435078db9682826da12b48e84";

/*------------------------- 手势密码 ------------------------*/
//手势密码key
#define KEY_SHOUSHI_KEY             @"ShouShiKey_"
#define KEY_USER_ISUNLOCK           @"IsUnlock"
#define KEY_IF_UNLOCK_OPEN          @"IfOpenUnlockPassword"
//指纹是否打开
#define KEY_FINGERSCAN_ISOPEN              @"FingerScanIsOpen"
#define KEY_FINGER_OPEN_ISPROMPT      @"FingerOpenIsPrompt"     //手势界面提示指纹开启 仅1次
#define kAppVersionShowIntoSmsOpen @"kAppVersionShowIntoSmsOpen"//是否弹出验证码框

/*--------------------------- 常量 ---------------------------*/

static NSString *kVersionSignkey   = @"&(*^*&%4678KJHfsaf";
static NSString *kCPUser           = @"kCPUser";
static NSString *kCPUserId         = @"kCPUserId";
static NSString *kCPToken          = @"kCPToken";
static NSString *kCPTokenUId          = @"kCPTokenUId";

static NSString *kSAVEURL          = @"kSAVEULR";

static NSString *TOUCH_SWITCH      = @"touchSwitch";   //指纹支付是否开启
static NSString *HAVE_TOUCH        = @"HAVE_TOUCH";    //是否有指纹密码

static NSString *PAN_SWITCH        = @"PanSwitch";     //滑动解锁是否开启
static NSString *HAVE_PANLOCK      = @"HAVE_PANLOCK";  //是滑动手势密码

static NSString *USER_TEL          = @"USER_TEL";

static NSString *KFirstLOGIN       = @"KFirstLogin";   //判断是不是跳过设置手势

/// Date

static NSString *const kDateFormatDefault    = @"yyyy-MM-dd HH:mm:ss";
static NSString *const kDateFormat_yyMdHm    = @"yy-MM-dd HH:mm";
static NSString *const kDateFormat_yyyyMdHm  = @"yyyy-MM-dd HH:mm";
static NSString *const kDateFormat_yMd       = @"yyyy-MM-dd";
static NSString *const kDateFormat_MdHms     = @"MM-dd HH:mm:ss";
static NSString *const kDateFormat_MdHm      = @"MM-dd HH:mm";
static NSString *const kDateFormatTime       = @"HH:mm:ss";
static NSString *const kDateFormat_Hm        = @"HH:mm";
static NSString *const kDateFormat_Md        = @"MM-dd";
static NSString *const kDateFormat_yyMd      = @"yy-MM-dd";
static NSString *const kDateFormat_YYMMdd    = @"yyyyMMdd";
static NSString *const kDateFormat_yyyyMdHms = @"yyyyMMddHHmmss";


static CGFloat const IQKeyboardDistanceFromTextField = 50;
static CGFloat const kTabbarHeight = 49;
static CGFloat const kSearchBarHeight = 45;
static CGFloat const kStatusBarHeight = 20;
static NSInteger const kPageSize = 10;
static NSInteger const kTextFieldMaxLength = 4;


static NSString *const kRefreshInvestDetailNotification  = @"kRefreshInvestDetailNotification";
static NSString *const kLoginNotification  = @"kLoginNotification";
static NSString *const kLogoutNotification = @"kLogoutNotification";
static NSString *const kCollectDataNotify  = @"kCollectDataNotify";

static NSString *const KBaseURL = @"BaseURL";

static NSString *const kloadfailedNotNetwork = @"网络异常";//@"当前网络不可用,请检查您的网络设置";
static NSString *const PASSWORD_WARNING = @"密码为6-16位数字、字母组合";
static NSString *const kHaveLocate      = @"kHaveLocate";
static NSString *const kSelectCity      = @"kSelectCity";
static NSString *const kSelectCityId    = @"kSelectCityId";
static NSString *const kAlphaNum        = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

#define KEY_FIRST_OPEN              @"AppFirstOpen"



#endif /* AppRelatedTips_h */

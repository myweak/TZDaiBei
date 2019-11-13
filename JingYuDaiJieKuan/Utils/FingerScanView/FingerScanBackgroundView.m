//
//  FingerScanBackgroundView.m
//  FingerScanDemo
//
//  Created by linshaokai on 16/9/5.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import "FingerScanBackgroundView.h"
#import "FingerScanManager.h"
#import "LoginVC.h"
//#import "HomeMainViewController.h"
@implementation FingerScanBackgroundView

-(instancetype)init
{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor whiteColor];
        [self customMainView];
    }
    return self;
}
//背景图
-(void)customMainView
{
    
    UIImageView *LogoImageV = [[UIImageView alloc]init];
    LogoImageV.frame = CGRectMake((kScreenWidth - kiP6WidthRace(92))/2, kiP6WidthRace(70), kiP6WidthRace(92), kiP6WidthRace(88));
    LogoImageV.image = [UIImage imageNamed:@""];
    
    [self addSubview:LogoImageV];
    
    UIImageView *FingerImageV = [[UIImageView alloc]init];
    FingerImageV.frame = CGRectMake((kScreenWidth - kiP6WidthRace(75))/2, CGRectGetMaxY(LogoImageV.frame) + kiP6WidthRace(70), kiP6WidthRace(75), kiP6WidthRace(75));
    FingerImageV.image = [UIImage imageNamed:@"FingerScanIcon"];
    [self addSubview:FingerImageV];
    
    UILabel *FingerLabel = [[UILabel alloc]init];
    FingerLabel.frame = CGRectMake((kScreenWidth - kiP6WidthRace(13*9))/2, CGRectGetMaxY(FingerImageV.frame) + kiP6WidthRace(27), kiP6WidthRace(13*9), kiP6WidthRace(14));
    FingerLabel.textColor = kHomeBlueColor;
    FingerLabel.text = @"点击唤醒指纹验证";
    FingerLabel.textAlignment = NSTextAlignmentCenter;
    FingerLabel.font = KFont(13);
    [self addSubview:FingerLabel];
 
    UIButton *click = [UIButton buttonWithType:UIButtonTypeCustom];
    click.frame = CGRectMake(CGRectGetMinX(FingerLabel.frame), CGRectGetMinY(FingerImageV.frame), CGRectGetWidth(FingerLabel.frame), CGRectGetMaxY(FingerLabel.frame) - CGRectGetMinY(FingerImageV.frame));
    [click addTarget:self action:@selector(checkAuthenticationClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:click];
    
    
    UIButton *otherLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    otherLogin.frame = CGRectMake((kScreenWidth - kiP6WidthRace(13*8))/2, kScreenHeight- 20 - kiP6WidthRace(35+40), kiP6WidthRace(13*8), kiP6WidthRace(40));
    [otherLogin setTitle:@"其他方式登入" forState:UIControlStateNormal];
    [otherLogin setTitleColor:kHomeBlueColor forState:UIControlStateNormal];
    otherLogin.titleLabel.font = KFont(13);
    [otherLogin addTarget:self action:@selector(otherLoginAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:otherLogin];
    
    __block typeof(self) weakself = self;
    if ([FingerScanManager sharedInstance].loginPasswordBlock == nil) {
        [FingerScanManager sharedInstance].loginPasswordBlock = ^(){
            
            [weakself otherLoginAction];

        };
    }
    
    
}
-(void)checkAuthenticationClick{
    [[FingerScanManager sharedInstance]checkAuthenticationClick];
}
- (void)otherLoginAction
{
    
    if ([kUserMessageManager getMessageManagerForObjectWithKey:[NSString stringWithFormat:@"%@%@",KEY_SHOUSHI_KEY,[kUserMessageManager getUserPhone]]]) {
        
        [self removeFromSuperview];
        
        [self showUnlockPasswordView];
        

    }
    else
    {
//        LoginVC *view = [[LoginVC alloc]init];
        
//        view.m_isFromFingerScan = YES;
        
//        UINavigationController *LoginNav = [[UINavigationController alloc]initWithRootViewController:view];
        
//        [[kAppDelegate getHomeViewController].navigationController.topViewController presentViewController:LoginNav animated:YES completion:^{
//            [self removeFromSuperview];
//        }];
    }
}


#pragma mark 显示手势登录界面
- (void)showUnlockPasswordView
{
    if ([[kUserMessageManager getMessageManagerForObjectWithKey:KEY_USER_ISUNLOCK] isEqualToString:@"1"]) {
        
        return;
    }
    
    
    //手势密码开启判断
    if (![NSString UnlockPasswordOpen])
    {
        return;
    }
    NSString *isLock=[[NSUserDefaults standardUserDefaults] objectForKey:SHARE_IS_LOCK];
    
    if ([isLock isEqualToString:@"0"])
    {
        
        return;
        
    }
    
    //重新进入前台，弹出手势解锁，而且点击退出无效。
    [UserMessageManager sharedUserMessageManager].g_IfComeFromBackgroud = YES;
    [UserMessageManager sharedUserMessageManager].g_IfProductBuyLogin = 3;
    
    // 登陆过才进行此步骤
    NSUserDefaults *userDefaluts = [NSUserDefaults standardUserDefaults];
    NSString *StringUserID = [userDefaluts objectForKey:KEY_USER_PHONE];
    
    
    //旧手势密码植入新key
    
    if (StringUserID !=nil) {
        
        
        if ([userDefaluts objectForKey:[NSString stringWithFormat:@"%@",[kUserMessageManager getUserPhone]]]!=nil)
        {
            NSString *keyString=[userDefaluts objectForKey:[NSString stringWithFormat:@"%@",[kUserMessageManager getUserPhone]]];
            DLog(@"KeyString=%@",keyString);
            if ([keyString intValue]>1000) {
                
                [userDefaluts setObject:[userDefaluts objectForKey:[NSString stringWithFormat:@"%@",[kUserMessageManager getUserPhone]]] forKey:[NSString stringWithFormat:@"%@%@",KEY_SHOUSHI_KEY,[kUserMessageManager getUserPhone]]];
                [userDefaluts setObject:nil forKey:[NSString stringWithFormat:@"%@",[kUserMessageManager getUserPhone]]];
                
            }
            else
            {
                [userDefaluts setObject:nil forKey:[NSString stringWithFormat:@"%@",[kUserMessageManager getUserPhone]]];
            }
            
        }
    }
    
    
    NSString *StringUnlockPassword = [userDefaluts objectForKey:[NSString stringWithFormat:@"%@%@",KEY_SHOUSHI_KEY,[kUserMessageManager getUserPhone]]];
    
    
    
    
    if (StringUserID != nil && StringUnlockPassword !=nil
        && ![StringUserID isEqualToString:@""] && [StringUnlockPassword intValue] > 0)
    {
        
        
//        GestureLoginViewController *view = [[GestureLoginViewController alloc]init];
//        view.isBackShow = NO;
//        UINavigationController *LoginNav = [[UINavigationController alloc]initWithRootViewController:view];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:LoginNav animated:YES completion:^{
//            }];
//        });
        
        
    }
    
}


@end

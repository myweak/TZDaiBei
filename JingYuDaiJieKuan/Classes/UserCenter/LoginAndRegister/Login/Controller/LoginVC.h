//
//  LoginVC.h
//  JingYuDaiJieKuan
//
//  Created by JY on 2018/3/29.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "SuperVC.h"

@interface LoginVC : SuperVC

@property (nonatomic, assign) BOOL          m_IsFromForgetKeyAutoToLogin;

@property (nonatomic, assign) BOOL          m_isFromFingerScan;

@property (nonatomic, assign) BOOL          m_isFromPassBtnOfGestrue;

@property (nonatomic, assign) BOOL          m_isFromRegister;
@end

//
//  TZShowWeiXinAndQQView.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/10/31.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

typedef NS_ENUM(NSInteger, TZShowWeiXinAndQQViewType)
{
    TZShowWeiXinAndQQViewType_weiXin = 0,  // 微信
    TZShowWeiXinAndQQViewType_QQ  = 1, // QQ
    
};

#define KCompany_weixin_num @"gh_6015de870fed"
#define KCompany_qq_num     @"3113205309"

#import "TZXibNibView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TZShowWeiXinAndQQView : TZXibNibView
@property (weak, nonatomic) IBOutlet UIImageView *appImageView; // app头像
@property (weak, nonatomic) IBOutlet UILabel *appNameLabel;// app名字
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;// 微信公众号：1xp or QQ号：1123499876
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;//操作提示

@property (weak, nonatomic) IBOutlet UIButton *m_CopyBtn; // 复制 联系账号
@property (weak, nonatomic) IBOutlet UIButton *closeBtn; // 取消

@property (nonatomic, assign) TZShowWeiXinAndQQViewType type;

@property (copy,nonatomic) void (^backCloseAtionBlock) (UIButton *btn);

@end

NS_ASSUME_NONNULL_END

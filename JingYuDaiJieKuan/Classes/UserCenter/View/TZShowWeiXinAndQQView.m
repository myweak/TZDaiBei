//
//  TZShowWeiXinAndQQView.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/10/31.
//  Copyright © 2019 Jincaishen. All rights reserved.
//
#define KCompany_weixin_num @"gh_6015de870fed"
#define KCompany_qq_num     @"3113205309"

#import "TZShowWeiXinAndQQView.h"

@implementation TZShowWeiXinAndQQView

- (void)awakeFromNib{
    [super awakeFromNib];
  
    self.appNameLabel.text = [NSString getMyApplicationName];
    NSString *iconStr = [NSString GetAppIconName];
    self.appImageView.image = R_ImageName(iconStr);
}

- (IBAction)closeBtn:(id)sender {
    !self.backCloseAtionBlock ? :self.backCloseAtionBlock(sender);
}


// 复制按钮
- (IBAction)numCopyBtn:(id)sender {
    if (self.type == TZShowWeiXinAndQQViewType_weiXin) {
        [UIPasteboard generalPasteboard].string = KCompany_weixin_num;
    }else  if (self.type == TZShowWeiXinAndQQViewType_QQ) {
        [UIPasteboard generalPasteboard].string = KCompany_qq_num;
    }
    [[ZXAlertView shareView] showMessage:@"复制成功"];

}

- (void)setType:(TZShowWeiXinAndQQViewType)type{
    _type = type;
    if (type == TZShowWeiXinAndQQViewType_weiXin) {
        self.appImageView.layer.cornerRadius = 12.0f;
        self.numberLabel.text = [NSString stringWithFormat:@"微信公众号：%@",KCompany_weixin_num];
        self.contentLabel.text = @"1.点击“复制”按钮复制官方微信号 \n2.打开微信App，并点击搜索框粘贴搜索 \n3.选择点击“帒呗”，并关注公众号即可";
        
    }else  if (type == TZShowWeiXinAndQQViewType_QQ) {
        self.appImageView.layer.cornerRadius = 30.0f;
        self.numberLabel.text = [NSString stringWithFormat:@"QQ号：%@",KCompany_qq_num];

        self.contentLabel.text = @"1.点击“复制”按钮复制官方QQ号 \n2.打开腾讯QQ App，并点击搜索框 \n3点击选择“找人/群”，粘贴搜索并添加即可";
    }
    
    self.contentLabel.paragraphSpacing = 8;
    [self.contentLabel reloadUIConfig];
}

@end

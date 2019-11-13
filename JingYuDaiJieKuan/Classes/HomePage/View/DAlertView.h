//
//  DAlertView.h
//  NewJingYuBao
//
//  Created by linshaokai on 16/7/5.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AlertViewBlock) (NSInteger type);//0 cancle  1 sure
@interface DAlertView : UIView

+(DAlertView *)initAlertViewWithTitle:(NSString *)title message:(NSString *)message  cancleButtonTitle:(NSString *)cancleButtonTitle sureButtonTitle:(NSString *)sureButtonTitle clickBlock:(AlertViewBlock)block;
-(void)show;
@end

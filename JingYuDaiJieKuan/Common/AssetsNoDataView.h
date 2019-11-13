//
//  AssetsNoDataView.h
//  NewJingYuBao
//
//  Created by air on 16/9/20.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssetsNoDataView : UIView
@property (strong ,nonatomic) UILabel *tipsLabel;
@property (nonatomic,copy)void (^refreshDataBlock)(void);

- (void)changeMessage:(NSString *)msg;

@end

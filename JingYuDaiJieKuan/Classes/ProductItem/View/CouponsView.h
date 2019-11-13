//
//  CouponsView.h
//  JingYuDaiJieKuan
//
//  Created by air on 2018/3/27.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MyInvestmentBlock)(NSInteger);


@interface CouponsView : UIView

@property (assign ,nonatomic, readonly) NSInteger selectedIndex;
//@property (nonatomic, strong)RACSubject              *subject;

//点击的第几个按钮
typedef void(^ClickButtonBlock)(NSInteger);
@property (nonatomic, strong) ClickButtonBlock clickButtonBlock;


//生成选项
- (instancetype)initWithNameAry:(NSArray *)nameAry;

@end

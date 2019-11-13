//
//  CMTPaoMaView.h
//  NewJingYuBao
//
//  Created by JY on 2019/1/23.
//  Copyright © 2019年 萤火虫. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <JhtMarquee/JhtHorizontalMarquee.h> // 横向
#import <JhtMarquee/JhtVerticalMarquee.h>  // 纵向

NS_ASSUME_NONNULL_BEGIN




@interface CMTPaoMaView : UIView
// 横向 跑马灯
@property (nonatomic, strong)JhtHorizontalMarquee *m_horizontalMarquee;

// 纵向 跑马灯
@property (nonatomic, strong)JhtVerticalMarquee *verticalMarquee;

@property (copy,nonatomic) void (^PaoMaDengBlock) (NSInteger);

//- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title;
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSMutableArray *)titleArray isShowIcon:(BOOL)isShowIcon;

@end

NS_ASSUME_NONNULL_END

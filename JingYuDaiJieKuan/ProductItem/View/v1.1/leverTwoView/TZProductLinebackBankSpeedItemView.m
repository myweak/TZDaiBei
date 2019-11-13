//
//  TZProductLinebackBankSpeedItemView.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/4.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZProductLinebackBankSpeedItemView.h"

@implementation TZProductLinebackBankSpeedItemView



// 快速通道 模块
+ (void)addBankSpeedItemViewWithAddSuperView:(UIView *)superView andTapIndexBlock:(void(^)(NSInteger index)) block{
    
    NSArray *bgArr =        @[@"bg_card_per",@"bg_card_com",@"bg_card_hou",@"bg_card_car",];
    NSArray *rightIconArr = @[@"icon_card_per",@"icon_card_com",@"icon_card_hou",@"icon_card_car",];
    NSArray *titleArr =     @[@"个人贷款",@"企业贷款",@"房贷借钱",@"车贷借钱",];
    NSArray *subTitleArr =  @[@"简单易申请",@"应急最省心",@"分期很轻松",@"工薪不头痛",];
    
    @weakify(self)
    
    
    NSInteger macCount = 4; // 最多显示
    
    CGFloat item_LR = 15.0f;
    CGFloat item_row = 15.0f;
    CGFloat item_column = 15.0f;
    NSInteger count_row = 2; // 每行
    
    CGFloat item_W = (CGFloat)(kScreenWidth - item_LR*2 -item_row )/count_row;
    CGFloat item_H = 60;
    
    for (UIView *view in superView.subviews) {
        if ([view isKindOfClass:[TZProductLinebackBankSpeedItemView class]]) {
            [view removeFromSuperview];
        }
    }
    
    [bgArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self)
        if (idx >= macCount) {
            return ;
        }
        NSInteger row = idx % count_row;
        NSInteger column = idx / count_row;
        
        TZProductLinebackBankSpeedItemView *itemView = [[TZProductLinebackBankSpeedItemView alloc] init];
        itemView.backgroundColor = [UIColor whiteColor];
        itemView.frame = CGRectMake(item_LR + row*(item_W+item_row), column * (item_column +item_H), item_W, item_H);
        itemView.layer.cornerRadius = 3.0f;
        itemView.layer.masksToBounds = YES;
        
        [superView addSubview:itemView];
        superView.height = itemView.bottom;
        
        //
        itemView.imageViewBg.image = R_ImageName([bgArr objectAtIndex:idx]);
        itemView.rightImageView.image = R_ImageName([rightIconArr objectAtIndex:idx]);
        itemView.titleLabel.text = [titleArr objectAtIndex:idx];
        itemView.subTitleLabel.text = [subTitleArr objectAtIndex:idx];
        
        [itemView handleTap:^(CGPoint loc, UIGestureRecognizer *tapGesture) {
            NSLog(@"筛选:%ld",idx);
            !block ?:block(idx);
        }];
        
    }];
}


@end

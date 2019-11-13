//
//  CouponsView.m
//  JingYuDaiJieKuan
//
//  Created by air on 2018/3/27.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "CouponsView.h"
#import "CustomButton.h"

@interface CouponsView ()
@property (strong ,nonatomic) NSArray *nameAry;
@property (strong ,nonatomic) NSMutableArray *btnAry;
@property (assign ,nonatomic) NSInteger selectedIndex;


@end
@implementation CouponsView

- (instancetype)initWithNameAry:(NSArray *)nameAry{
    if (self = [super init]) {
        _nameAry = nameAry;
        _btnAry = [[NSMutableArray alloc] init];
        [self createSubviews];
    }
    return self;
}
- (void)createSubviews{
    CGFloat width = (kScreenWidth *1.0)/ _nameAry.count;
    //TODO:用view存放。
    if (_nameAry.count == 2) {
        for (int i = 0; i < _nameAry.count; i++) {
            UIView *containView = [[UIView alloc] init];
            [self addSubview:containView];
            [containView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(i * width);
                make.top.bottom.equalTo(self);
                make.width.mas_equalTo(width);
            }];
            
            ClickButton *btn = [[ClickButton alloc] initWithTitle:_nameAry[i] cornerRadius:kiP6WidthRace(14)];
            
            btn.tag = i;
            if (i == 0) {
                [btn clickState];
            }
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [containView addSubview:btn];
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kiP6WidthRace(90));
                make.height.mas_equalTo(kiP6WidthRace(56/2));
                make.centerY.equalTo(self.mas_centerY);
                if (i ==0) {
                    make.right.equalTo(containView.mas_right).offset(-kiP6WidthRace(19));
                    
                }
                else
                {
                    make.left.equalTo(containView.mas_left).offset(kiP6WidthRace(19));
                }
            }];
            [_btnAry addObject:btn];
        }
        
    }
    else{
        
        for (int i = 0; i < _nameAry.count; i++) {
            UIView *containView = [[UIView alloc] init];
            [self addSubview:containView];
            [containView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(i * width);
                make.top.bottom.equalTo(self);
                make.width.mas_equalTo(width);
            }];
            
            ClickButton *btn = [[ClickButton alloc] initWithTitle:_nameAry[i] cornerRadius:kiP6WidthRace(14)];
            btn.tag = i;
            if (i == 0) {
                [btn clickState];
            }
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [containView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kiP6WidthRace(90));
                make.height.mas_equalTo(kiP6WidthRace(56/2));
                make.center.equalTo(containView);
            }];
            [_btnAry addObject:btn];
        }
    }
}

- (void)btnClick:(ClickButton *)btn{
    
    self.selectedIndex = btn.tag;
    
    if (self.clickButtonBlock) {
        self.clickButtonBlock(self.selectedIndex);
    }
}

@end


//
//  ProductItemHeadView.m
//  JingYuDaiJieKuan
//
//  Created by JY on 2019/6/29.
//  Copyright © 2019年 Jincaishen. All rights reserved.
//

#import "ProductItemHeadView.h"
#import "STListFilterView.h"
#import "JingYuDaiJieKuan-Swift.h"

@interface ProductItemHeadView ()<STListFilterViewDelegate>

@property (nonatomic, strong) UIView *m_headTitleView;

@property (nonatomic, strong) UIButton *m_chooseBtn;

@property (nonatomic, strong) STListFilterView *m_selectView;

@property (nonatomic, assign) BOOL isSelect;

@end


@implementation ProductItemHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = kColorWhite;
        [self initView];
    }
    return self;
}

#pragma initView
- (void)initView{
    
    [self addSubview:self.m_headTitleView];
    [self addSubview:self.m_selectView];

}

- (void)forChooseButtonArray:(NSArray *)sortList{
    
    NSInteger j = 0;
    for (int i = 0 ; i< sortList.count; i ++) {
        sortModel *model = sortList[i];
        if (![model.lfilterType isEqual: @"1"]) {continue;} ///如果不是1的话就不是排序按钮
        UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.m_headTitleView addSubview:chooseBtn];
        [chooseBtn setTitle:model.labelName forState:UIControlStateNormal];
        [chooseBtn setTitleColor:UIColorHex(@"#666666") forState:UIControlStateNormal];
        chooseBtn.titleLabel.font = KFont(16);
        [chooseBtn addTarget:self action:@selector(chooseButtonCkick:) forControlEvents:UIControlEventTouchUpInside];
        chooseBtn.tag = 100 + [model.lfilterId intValue];
        [chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kiP6WidthRace(kScreenWidth/4)*j);
            make.centerY.mas_equalTo(self.m_headTitleView);
            make.width.mas_equalTo(kiP6WidthRace(kScreenWidth/4));
            make.height.mas_equalTo(kiP6WidthRace(18));
        }];
        j = j+1;
        self.m_chooseBtn = chooseBtn;
    }
    
    UIButton *screening = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.m_headTitleView addSubview:screening];
    [screening setTitle:@"筛选" forState:UIControlStateNormal];
    [screening setTitleColor:UIColorHex(@"#666666") forState:UIControlStateNormal];
    screening.titleLabel.font = KFont(16);
    screening.tag = 10004;
    [screening addTarget:self action:@selector(choosefilterButton:) forControlEvents:UIControlEventTouchUpInside];
    [screening mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenWidth/4 * 3);
        make.centerY.mas_equalTo(self.m_headTitleView);
        make.width.mas_equalTo(kScreenWidth/4);
    }];
    [screening setImage:[UIImage imageNamed:@"screening_icon"] forState:UIControlStateNormal];
    // button标题的偏移量
    screening.titleEdgeInsets = UIEdgeInsetsMake(0, -screening.imageView.bounds.size.width+2, 0, screening.imageView.bounds.size.width);
    // button图片的偏移量
    screening.imageEdgeInsets = UIEdgeInsetsMake(0, screening.titleLabel.bounds.size.width, 0, -screening.titleLabel.bounds.size.width - kiP6WidthRace(10));
    
//    UIView *lineView = [[UIView alloc] init];
//    lineView.backgroundColor = UIColorHex(@"#949699");
//    [self.m_headTitleView addSubview:lineView];
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(screening).offset(10);
//        make.centerY.mas_equalTo(self.m_headTitleView);
//        make.width.mas_equalTo(kiP6WidthRace(1));
//        make.height.mas_equalTo(kiP6WidthRace(16));
//    }];
//    
}

#pragma func
/// 点击筛选按钮
- (void)choosefilterButton: (UIButton *)sender{
    [self clearState];
    [sender setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    
    if (self.isSelect) {
        self.m_selectView.hidden = YES;
    }else{
        self.m_selectView.hidden = NO;
    }
    self.isSelect = !self.isSelect;
    
    if (self.showFilterBlock) {
        self.showFilterBlock(self.isSelect);
    }

}

/// 点击排序按钮
- (void)chooseButtonCkick:(UIButton *)sender{
    [self clearState];
    self.m_selectView.hidden = YES;
    self.isSelect = NO;
    [sender setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    
    //埋点
    [SensorsAnalyticsSDKHelper trackProductItemTabWithTabName:sender.titleLabel.text];
    
    if (self.showFilterBlock) {
        self.showFilterBlock(self.isSelect);
    }
    
    if (self.chooseClickBlock) {
        self.chooseClickBlock([NSString stringWithFormat:@"%d",sender.tag - 100], 0, 0, 0, 0, YES);
    }
}

/// 清除按钮状态
- (void)clearState{
    //清除其他的按钮高亮
    for (int i = 0 ; i < self.sortListModel.list.count; i ++) {
        sortModel *model = self.sortListModel.list[i];
        
        if (![model.lfilterType isEqualToString:@"1"]){continue;}
        UIButton *btn = [self viewWithTag:100 + [model.lfilterId intValue]];
        [btn setTitleColor:UIColorHex(@"#666666") forState:UIControlStateNormal];
    }
    UIButton *btn = [self viewWithTag:10004];
    [btn setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
}

/// 重置控件的筛选及排序条件
- (void)reSetCondition{
    [self clearState];
    [self.m_selectView clickResetButton];
}

#pragma getter
- (UIView *)m_headTitleView{
    if (!_m_headTitleView) {
        _m_headTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kiP6WidthRace(44))];
        _m_headTitleView.userInteractionEnabled = YES;
//        [self addShadowToView:_m_headTitleView withColor:kColorSeparatorline];
    }
    
    return _m_headTitleView;
}

- (STListFilterView *)m_selectView{
    
    if (!_m_selectView) {
        _m_selectView = [[STListFilterView alloc] initWithFrame:CGRectMake(0, kiP6WidthRace(45), kScreenWidth, kiP6WidthRace(820/2))];
        _m_selectView.delegate = self;
        _m_selectView.userInteractionEnabled = YES;
        _m_selectView.hidden = YES;
        
        MJWeakSelf
        _m_selectView.filterClickBlock = ^(NSString *tags, NSInteger maxAmount, NSInteger mixAmount, NSInteger maxLimit, NSInteger mixLimit) {
            if (weakSelf.chooseClickBlock) {
                weakSelf.chooseClickBlock(tags, maxAmount, mixAmount, maxLimit, mixLimit, NO);
            }
            weakSelf.m_selectView.hidden = YES;
            weakSelf.isSelect = NO;
            
            if (weakSelf.showFilterBlock) {
                weakSelf.showFilterBlock(weakSelf.isSelect);
            }
        };
    }
    return _m_selectView;
}

/// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 1;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 5;
}

#pragma Setter
- (void)setSortListModel:(sortListModel *)sortListModel {
    _sortListModel = sortListModel;
    
    //设置排序按钮
     [self forChooseButtonArray:self.sortListModel.list];
    
    //设置筛选按钮
    self.m_selectView.sortListModel = sortListModel;
}

@end

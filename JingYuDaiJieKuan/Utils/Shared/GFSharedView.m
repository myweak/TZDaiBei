//
//  GFSharedView.m
//  GoldfishStocks
//
//  Created by 曹梦涛 on 2018/1/31.
//  Copyright © 2018年 goldfish. All rights reserved.
//

#import "GFSharedView.h"

@interface GFSharedView ()

@property(nonatomic, copy) GFSharedViewDidSelectItemBlock didSelectItemCallback;

@property(nonatomic, strong) UIView *sharedBGView;

@property(nonatomic, strong) NSArray *items;

@property(nonatomic, assign) CGFloat viewHeight;
@end

const static CGFloat kSharedItemMargin = 25.0;

@implementation GFSharedView

- (id)init {
    if (self = [super init]) {
        [self commontInit];
    }
    return self;
}

- (void)commontInit {
    
    UIView *bGView = [UIView new];
    bGView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissSharedView:)];
    [bGView addGestureRecognizer:tap];
    [self addSubview:bGView];
    [bGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    _sharedBGView = [UIView new];
    _sharedBGView.backgroundColor = UIColorHex(@"#f8f8f8");
    [self addSubview:_sharedBGView];
    
    self.items = [GFSharedItem items];
    UIView *leastItemView;
    CGFloat width = (kScreenWidth - 2*kSharedItemMargin)/4;
    CGSize size = CGSizeMake(width, 73);
    for (int i = 0 ; i < self.items.count; i++) {
        UIView *itemView = [UIView new];
        itemView.backgroundColor = [UIColor clearColor];
        [_sharedBGView addSubview:itemView];
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(size);
            if (leastItemView) {
                make.top.mas_equalTo(leastItemView.mas_top);
                make.left.mas_equalTo(leastItemView.mas_right).offset(0);
            } else {
                make.left.mas_equalTo(kSharedItemMargin);
                make.top.mas_equalTo(kiP6WidthRace(45));
            }
        }];
        [self configItem:itemView index:i];
        leastItemView = itemView;
    }
    
    UIButton *cancelButton = [UIButton new];
    [cancelButton addTarget:self action:@selector(cancelActionDone:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.titleLabel.font = KFont(13);
    [cancelButton setTitleColor:UIColorHex(@"#999999") forState:UIControlStateNormal];
    [cancelButton setTitle:@"分享" forState:UIControlStateNormal];
    [_sharedBGView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kiP6WidthRace(16));
        make.centerX.mas_equalTo(_sharedBGView);
        make.height.mas_equalTo(16);
    }];
    
    UIView *liftLine = [UIView new];
    liftLine.backgroundColor = UIColorHex(@"#e6e6e6");
    [_sharedBGView addSubview:liftLine];
    [liftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(15));
        make.right.mas_equalTo(cancelButton.mas_left).offset(kiP6WidthRace(-15));
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(cancelButton.mas_centerY);
    }];
    
    UIView *rightLine = [UIView new];
    rightLine.backgroundColor = UIColorHex(@"#e6e6e6");
    [_sharedBGView addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cancelButton.mas_right).offset(kiP6WidthRace(15));
        make.right.mas_equalTo(kiP6WidthRace(-15));
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(cancelButton.mas_centerY);
    }];
        
     _viewHeight = self.items.count > 3?(430+98)/2:(206+98+50)/2;
    
    [_sharedBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(kiP6WidthRace(140));
        make.bottom.mas_equalTo(_viewHeight);
    }];
}

- (void)configItem:(UIView*)itemView index:(NSInteger)index{
    GFSharedItem *item = self.items[index];
    UIButton *itemButton = [UIButton new];
    itemButton.tag = index;
    [itemButton addTarget:self action:@selector(sharedItemButtonActionDone:) forControlEvents:UIControlEventTouchUpInside];
    [itemButton setImage:[UIImage imageNamed:item.iconImageName] forState:UIControlStateNormal];
    [itemView addSubview:itemButton];
    [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
        make.centerX.mas_equalTo(itemView);
    }];
   
    UILabel *itemTitleLabel = [UILabel new];
    itemTitleLabel.textColor = UIColorHex(@"#616671");
    itemTitleLabel.font = KFont(12);
    itemTitleLabel.textAlignment = NSTextAlignmentCenter;
    itemTitleLabel.text = item.iconTitle;
    [itemView addSubview:itemTitleLabel];
    [itemTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(itemView);
        make.top.mas_equalTo(itemButton.mas_bottom).offset(10);
    }];
}

+ (void)showSharedView:(GFSharedViewDidSelectItemBlock)selectComplete {
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    GFSharedView *sView = [[GFSharedView alloc]init];
    sView.didSelectItemCallback = selectComplete;
    [window addSubview:sView];
    [sView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(window);
    }];
    [sView layoutIfNeeded];
    [sView show];
}
//action

- (void)show {
    [_sharedBGView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
        self.backgroundColor = UIColorHexSystem(0x373e56, 0.5);
    }];
}

- (void)dismiss{
    [_sharedBGView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_viewHeight);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)sharedItemButtonActionDone:(UIButton*)sender{
    GFSharedItem *item = self.items[sender.tag];
    if (self.didSelectItemCallback) {
        self.didSelectItemCallback(item);
        [self dismiss];
    }
}
- (void)cancelActionDone:(UIButton*)sender {
    [self dismiss];
}

- (void)dismissSharedView:(UIGestureRecognizer*)gesture {
    [self dismiss];
}

@end

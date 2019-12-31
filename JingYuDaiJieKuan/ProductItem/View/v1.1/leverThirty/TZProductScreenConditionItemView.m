//
//  TZProductScreenConditionItemView.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/12/27.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZProductScreenConditionItemView.h"

@implementation TZProductScreenConditionItemView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tagView.layer.masksToBounds = YES;
    self.tagView.layer.cornerRadius = 1.0f;
    self.tagView.layer.borderColor = KText_ColorGreen.CGColor;
    self.tagView.layer.borderWidth = 0.5f;
    
}


- (void)setModel:(TZProductOfflineInfoModel *)model{
    _model = model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.proIco] placeholderImage:Kimage_placeholder];
    self.titleLabel.text = model.title;
    NSString *keDai = @"可贷";
    NSString *feiLv = @"月费率";
    self.moneyLabel.text = [NSString stringWithFormat:@"%@ %@-%@万",keDai,model.minAmount,model.maxAmount];
    self.collarLabel.text = [NSString stringWithFormat:@"%@ %@%@",feiLv,model.monthlyRate,@"%"];
    self.timeLabel.text = [NSString stringWithFormat:@"%@ %@%@天",@"放款时长",model.lendingTime,model.lendingType];
    
    self.moneyLabel.keywords = keDai;
    self.collarLabel.keywords = feiLv;
    self.moneyLabel.keywordsColor = kBtnGrayColor;
    self.collarLabel.keywordsColor = kBtnGrayColor;
    [self.moneyLabel reloadUIConfig];
    [self.collarLabel reloadUIConfig];
    
    // 抵押标签
    TZProductOfflineInfoCollasModel *conditionModel = [model.labelInfo firstObject];
    self.tagView.hidden = checkStrEmty(conditionModel.labelName);
    self.tagView.layer.borderColor = [conditionModel.labelColor getColor].CGColor;
    
    self.conditonLabel.text = conditionModel.labelName;
    self.conditonLabel.textColor = [conditionModel.labelColor getColor];
}
@end

@implementation TZProductScreenConditionView
- (void)setTZProductScreenConditionItemViewWithArray:(NSArray <TZProductOfflineInfoModel *>*) arr{
    for (UIView *view in self.subviews) {
          if ([view isKindOfClass:[TZProductScreenConditionItemView class]]) {
              [view removeFromSuperview];
          }
      }
    @weakify(self)
    self.width = kScreenWidth;
    self.height = 0;
    [arr enumerateObjectsUsingBlock:^(TZProductOfflineInfoModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self)
        TZProductScreenConditionItemView *view = [[TZProductScreenConditionItemView alloc] init];
        view.frame = CGRectMake(0, 90*idx, kScreenWidth, 90);
        view.model = model;
        [self addSubview:view];
        self.height = view.bottom;
        
        // line
        [self addLine:CGRectMake(15, self.height-0.5, kScreenWidth-30, 0.5)];
        
        [view handleTap:^(CGPoint loc, UIGestureRecognizer *tapGesture) {
            @strongify(self)
            !self.backItemTapAction ? :self.backItemTapAction(model);
        }];
    }];
}
@end

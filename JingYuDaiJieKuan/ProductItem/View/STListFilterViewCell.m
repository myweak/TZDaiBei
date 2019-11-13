//
//  STListFilterViewCell.m
//  my
//
//  Created by soso-mac on 2016/11/21.
//  Copyright © 2016年 soso-mac. All rights reserved.
//

#import "STListFilterViewCell.h"
#import "UIColor+STMyIColor.h"
@implementation STListFilterViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        
//        _titleLab = [UILabel new];
//        _titleLab.frame = CGRectMake(0, 0, self.frame.size.width, kiP6WidthRace(33));
//        _titleLab.font = [UIFont systemFontOfSize:12];
//        _titleLab.textAlignment = NSTextAlignmentCenter;
//        _titleLab.textColor = [UIColor fromHexValue:0x555555 alpha:1];
//        [self.contentView addSubview:_titleLab];
//        ViewRadius(_titleLab, kiP6WidthRace(33)/2);
        [self.contentView addSubview:self.titleBtn];
        self.titleBtn.userInteractionEnabled = NO;
    }
    return self;
}

- (UIButton *)titleBtn{
    if (!_titleBtn) {
        _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleBtn.frame = CGRectMake(0, 0, self.frame.size.width, kiP6WidthRace(33));
        [_titleBtn setImage:R_ImageName(@"user_edite_y") forState:UIControlStateSelected];
        [_titleBtn setImage:R_ImageName(@"") forState:UIControlStateNormal];
        [_titleBtn setTitleColor:Bg_Btn_Colorblue forState:UIControlStateSelected];
        [_titleBtn setTitleColor:CP_ColorMBlack forState:UIControlStateNormal];
        _titleBtn.titleLabel.font = kFontSize12;
//        _titleBtn.layer.cornerRadius = 3.0f;
//        [_titleBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
//        [_titleBtn setBackgroundImage:[UIImage imageWithColor:[@"#e4e4e4" getColor]] forState:UIControlStateNormal];
        _titleBtn.backgroundColor = [UIColor clearColor];

    }
    return _titleBtn;
}

-(void)setFilterIndexPath:(NSIndexPath *)indexPath andfilterModel:(TZLoanDataModel *)model {
    _titleLab.text = model.dictValue;
    self.titleBtn.selected = model.isSelected;
    [self.titleBtn setTitle:model.dictValue forState:UIControlStateNormal];
    if (model.isSelected) {
        self.titleLab.textColor = Bg_Btn_Colorblue;
        self.layer.borderColor = Bg_Btn_Colorblue.CGColor;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 1.0f;
    } else {
        self.backgroundColor = [@"#e4e4e4" getColor];
        self.layer.borderColor = UIColorHex(@"0Xf2f2f2").CGColor;
        self.layer.borderWidth = 1.0f;
        self.titleLab.textColor = CP_ColorMBlack;
    }
}

@end

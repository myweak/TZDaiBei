//
//  STListFilterHeadView.m
//  my
//
//  Created by soso-mac on 2016/11/21.
//  Copyright © 2016年 soso-mac. All rights reserved.
//

#import "STListFilterHeadView.h"
#import "UIColor+STMyIColor.h"
@implementation STListFilterHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
     self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}
-(void)setFilterTitle:(NSString *)title andIndex:(NSInteger)index{
    _titleLab = [[UILabel alloc]init];
    _titleLab.backgroundColor = [UIColor whiteColor];
    _titleLab.userInteractionEnabled = YES;
    _titleLab.frame = CGRectMake(0, 0, self.frame.size.width , self.frame.size.height);
    _titleLab.textAlignment = NSTextAlignmentLeft;
    _titleLab.numberOfLines = 0;
    _titleLab.text = title;
    _titleLab.tag = index;
    _titleLab.textColor = [UIColor fromHexValue:0x333333 alpha:1];
    _titleLab.font = [UIFont systemFontOfSize:15];
    [self addSubview:_titleLab];
}
@end

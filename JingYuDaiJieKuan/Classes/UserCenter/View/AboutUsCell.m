//
//  AboutUsCell.m
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/7/3.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "AboutUsCell.h"

@implementation AboutUsCell

+ (instancetype)creatCellWithTableView:(UITableView *)tableView {
    AboutUsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        cell = [[AboutUsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self)];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}
- (void)initView
{
    [self addSubview:self.m_cooperationName];
    
    [self.m_cooperationName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(kiP6WidthRace(5));
    }];
}


- (UILabel *)m_cooperationName
{
    if (!_m_cooperationName) {
        _m_cooperationName = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"youxiang", KFont(14), UIColorHex(@"#b2b2b2"), NO);
        _m_cooperationName.numberOfLines = 0;
    }
    return _m_cooperationName;
}

@end

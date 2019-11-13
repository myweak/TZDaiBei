//
//  TheThirdHomePageCell.m
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/9/3.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TheThirdHomePageCell.h"

@implementation TheThirdHomePageCell

+ (instancetype)creatCellWithTableView:(UITableView *)tableView {
    TheThirdHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        cell = [[TheThirdHomePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self)];
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
    self.backgroundColor = UIColor.clearColor;
    [self.contentView addSubview:self.m_IconImage];
    
    [self.m_IconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kiP6WidthRace(15));
        make.top.equalTo(self.contentView);
        make.right.mas_equalTo(-kiP6WidthRace(15));
        make.height.mas_equalTo(kiP6WidthRace(255/2));
        make.bottom.equalTo(self.contentView);
    }];
 
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
}


- (UIImageView *)m_IconImage
{
    if (!_m_IconImage) {
        _m_IconImage = [[UIImageView alloc]init];
        _m_IconImage.layer.cornerRadius = 8;
        _m_IconImage.layer.masksToBounds = YES;
    }
    return _m_IconImage;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

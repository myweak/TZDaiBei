//
//  TheSecondHomePageCell.m
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/6/26.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TheThirdHomePageCell.h"
#import "HomePageModel.h"

@implementation TheThirdHomePageCell

+ (instancetype)creatCellWithTableView:(UITableView *)tableView {
    TheThirdHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        cell = [[TheThirdHomePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self)];
        cell.accessoryType=UITableViewCellAccessoryNone;
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
    [self.contentView addSubview:self.m_IconImage];
  
    [self.m_IconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(12);
        make.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-12);
        make.height.mas_equalTo(kiP6WidthRace(164));
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
}

- (UIImageView *)m_IconImage
{
    if (!_m_IconImage) {
        _m_IconImage = [[UIImageView alloc]init];
        _m_IconImage.contentMode = UIViewContentModeScaleAspectFit;
        _m_IconImage.layer.cornerRadius = 5;
        _m_IconImage.layer.masksToBounds = YES;
    }
    return _m_IconImage;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

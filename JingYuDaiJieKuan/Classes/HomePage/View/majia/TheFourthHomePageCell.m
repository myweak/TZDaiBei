//
//  TheFirstHomePageCell.m
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/6/26.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TheFourthHomePageCell.h"
#import "TheFourthHomePageSubCell.h"

@interface TheFourthHomePageCell()


/// 左视图
@property (strong, nonatomic) TheFourthHomePageSubCell *leftView;
/// 右视图
@property (strong, nonatomic) TheFourthHomePageSubCell *rightView;

@property (strong, nonatomic) NSArray *modelArray;

@end

@implementation TheFourthHomePageCell

+ (instancetype)creatCellWithTableView:(UITableView *)tableView withArray:(NSArray *)array {
    TheFourthHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        cell = [[TheFourthHomePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self)];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.contentView.backgroundColor = UIColor.whiteColor;
    }
    cell.modelArray = array;
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
    [self.contentView addSubview:self.leftView];
    [self.contentView addSubview:self.rightView];
  
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(12);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(kiP6WidthRace(150));
    }];
    
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftView);
        make.left.equalTo(self.leftView.mas_right).offset(12);
        make.right.equalTo(self.contentView).offset(-12);
        make.width.equalTo(self.leftView);
        make.bottom.equalTo(self.leftView);
        make.height.equalTo(self.leftView);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
}

- (TheFourthHomePageSubCell *)leftView {
    if (!_leftView) {
        _leftView = [[TheFourthHomePageSubCell alloc]init];
    }
    return _leftView;
}

- (TheFourthHomePageSubCell *)rightView {
    if (!_rightView) {
        _rightView = [[TheFourthHomePageSubCell alloc]init];
    }
    return _rightView;
}

- (void)setModelArray:(NSArray *)modelArray{
    _modelArray = modelArray;
    
    if (modelArray.count == 0) {return;}
    for (int i = 0; i <= 2 ; i++) {
        if (i == 0){
            self.leftView.model = modelArray[0];
            self.leftView.line.backgroundColor = [UIColor colorWithRed:243/255.0 green:194/255.0 blue:80/255.0 alpha:1.0];
        }else if(i ==1){
            self.rightView.model = modelArray[1];
            self.rightView.line.backgroundColor =  [UIColor colorWithRed:81/255.0 green:119/255.0 blue:213/255.0 alpha:1.0];
        }else {}
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

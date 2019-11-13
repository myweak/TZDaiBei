//
//  TheFourthHomePageSubCell.m
//  FenQiLe
//
//  Created by Dason on 2019/8/20.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TheFourthHomePageSubCell.h"
#import "HomePageModel.h"

@interface TheFourthHomePageSubCell()
/// 左视图
@property (strong, nonatomic) UIView *bgView;
/// 标签
@property (strong, nonatomic) UILabel *titleLbl;
/// 利率
@property (strong, nonatomic) UILabel *rateLbl;
/// 推荐原因
@property (strong, nonatomic) UILabel *recommendLbl;
/// 上线时间提醒
@property (strong, nonatomic) UILabel *updateTipLbl;
/// 第一个标签
@property (strong, nonatomic) UILabel *firstLbl;
@property (strong, nonatomic) UIView *firstLblBGView;
/// 第二个标签
@property (strong, nonatomic) UILabel *secondLbl;
@property (strong, nonatomic) UIView *secondLblBGView;

@end

@implementation TheFourthHomePageSubCell

- (instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.bgView];
        
        self.layer.cornerRadius = 5;
//        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithRed:237/255.0 green:239/255.0 blue:242/255.0 alpha:1.0].CGColor;
        [self addSubview:self.titleLbl];
        [self addSubview:self.line];
        [self addSubview:self.rateLbl];
        [self addSubview:self.recommendLbl];
        [self addSubview:self.updateTipLbl];
        [self addSubview:self.firstLblBGView];
        [self addSubview:self.firstLbl];
        [self addSubview:self.secondLblBGView];
        [self addSubview:self.secondLbl];
        
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)updateConstraints {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(12);
        make.left.equalTo(self).offset(12);
        make.right.equalTo(self).offset(-12);
        make.height.mas_equalTo(20);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLbl.mas_bottom).offset(4);
        make.left.equalTo(self.titleLbl);
        make.width.mas_equalTo(24);
        make.height.mas_equalTo(2);
    }];
    
    [self.rateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_bottom).offset(4);
        make.left.right.equalTo(self.titleLbl);
    }];
    
    [self.recommendLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rateLbl.mas_bottom);
        make.left.right.equalTo(self.titleLbl);
        make.height.mas_equalTo(28);
    }];
    
    [self.updateTipLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.recommendLbl.mas_bottom);
        make.left.right.equalTo(self.titleLbl);
        make.height.mas_equalTo(17);
    }];
    
    [self.firstLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.updateTipLbl.mas_bottom).offset(14);
        make.left.equalTo(self).offset(19);
        make.height.mas_equalTo(17);
    }];
    
    [self.firstLblBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstLbl).offset(-2);
        make.left.equalTo(self.firstLbl).offset(-6);
        make.bottom.equalTo(self.firstLbl).offset(2);
        make.right.equalTo(self.firstLbl).offset(6);
    }];
    
    [self.secondLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstLbl);
        make.left.equalTo(self.firstLbl.mas_right).offset(16);
        make.right.lessThanOrEqualTo(self).offset(-18);
        make.height.mas_equalTo(17);
    }];
    
    [self.secondLblBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondLbl).offset(-2);
        make.left.equalTo(self.secondLbl).offset(-6);
        make.bottom.equalTo(self.secondLbl).offset(2);
        make.right.equalTo(self.secondLbl).offset(6);
    }];
    
    [super updateConstraints];
}


#pragma mark -getter
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.shadowColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:234/255.0 alpha:0.2].CGColor;
        _bgView.layer.shadowOffset = CGSizeMake(0,0);
        _bgView.layer.shadowOpacity = 1;
        _bgView.layer.shadowRadius = 12;
    }
    return _bgView;
}


- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc]init];
        _titleLbl.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _titleLbl.font = [UIFont systemFontOfSize:14];
    }
    return _titleLbl;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor colorWithRed:243/255.0 green:194/255.0 blue:80/255.0 alpha:1.0];
    }
    return _line;
}

- (UILabel *)rateLbl {
    if (!_rateLbl) {
        _rateLbl = [[UILabel alloc]init];
        _rateLbl.textColor = [UIColor colorWithRed:220/255.0 green:29/255.0 blue:29/255.0 alpha:1.0];
        _rateLbl.font = [UIFont systemFontOfSize:20];
    }
    return _rateLbl;
}

- (UILabel *)recommendLbl {
    if (!_recommendLbl) {
        _recommendLbl = [[UILabel alloc]init];
        _recommendLbl.textColor = [UIColor colorWithRed:117/255.0 green:130/255.0 blue:155/255.0 alpha:1.0];
        _recommendLbl.font = [UIFont systemFontOfSize:12];
    }
    return _recommendLbl;
}

- (UILabel *)updateTipLbl {
    if (!_updateTipLbl) {
        _updateTipLbl = [[UILabel alloc]init];
        _updateTipLbl.textColor = [UIColor colorWithRed:117/255.0 green:130/255.0 blue:155/255.0 alpha:1.0];
        _updateTipLbl.font = [UIFont systemFontOfSize:12];
    }
    return _updateTipLbl;
}

- (UILabel *)firstLbl {
    if (!_firstLbl) {
        _firstLbl = [[UILabel alloc]init];
        _firstLbl.tag = 10000;
        _firstLbl.textColor =[UIColor colorWithRed:117/255.0 green:130/255.0 blue:155/255.0 alpha:1.0];
//        _firstLbl.backgroundColor = [UIColor colorWithRed:236/255.0 green:240/255.0 blue:245/255.0 alpha:1.0];
        _firstLbl.font = [UIFont systemFontOfSize:12];
        [_firstLbl setHidden:YES];
    }
    return _firstLbl;
}

- (UIView *)firstLblBGView {
    if (!_firstLblBGView) {
        _firstLblBGView = [[UIView alloc]init];
        _firstLblBGView.tag = 20000;
        _firstLblBGView.backgroundColor = [UIColor colorWithRed:236/255.0 green:240/255.0 blue:245/255.0 alpha:1.0];
        [_firstLblBGView setHidden:YES];
    }
    return _firstLblBGView;
}

- (UILabel *)secondLbl {
    if (!_secondLbl) {
        _secondLbl = [[UILabel alloc]init];
        _secondLbl.tag = 10001;
        _secondLbl.textColor =[UIColor colorWithRed:117/255.0 green:130/255.0 blue:155/255.0 alpha:1.0];
        _secondLbl.font = [UIFont systemFontOfSize:12];
        [_secondLbl setHidden:YES];
    }
    return _secondLbl;
}

- (UIView *)secondLblBGView {
    if (!_secondLblBGView) {
        _secondLblBGView = [[UIView alloc]init];
        _secondLblBGView.tag = 20001;
        _secondLblBGView.backgroundColor = [UIColor colorWithRed:236/255.0 green:240/255.0 blue:245/255.0 alpha:1.0];
        [_secondLblBGView setHidden:YES];
    }
    return _secondLblBGView;
}



- (void)setModel:(AdBannerModel *)model {
    _model = model;
    
    self.titleLbl.text = model.name;
//    self.line =
    self.rateLbl.text = [NSString stringWithFormat:@"%.2lf%@", [model.rate doubleValue] *100, @"%"];
    self.recommendLbl.text = model.txtDesc;
    
    NSInteger days =  [self timeSwitchTimestamp:model.lineDate];
    
    if (days == 0) {
        self.updateTipLbl.text = @"今天上新";
    }else if (days == 1)
    {
        self.updateTipLbl.text = @"昨日上新";
    } else
    {
        self.updateTipLbl.text = [NSString stringWithFormat:@"%ld天前上新",(long)days];
    }

    [self.firstLbl setHidden:YES];
    [self.firstLblBGView setHidden:YES];
    [self.secondLbl setHidden:YES];
    [self.secondLblBGView setHidden:YES];

    if (![self isBlankString:model.tags]) {
        NSArray *array = [model.tags componentsSeparatedByString:@","];//从字符A中分隔成2个元素的数组
        /// 最多是显示2个特性
        for (int i = 0 ; i < 2; i ++) {
            if (i == array.count) {break;}
            UILabel *label = [self viewWithTag:10000 + i];
            if (label != nil) {
                label.text = array[i];
                [label setHidden:NO];
                [label sizeToFit];
                
                UIView *bgView = [self viewWithTag:20000 + i];
                [bgView setHidden:NO];
            }
        }
    }
}

- (NSInteger)timeSwitchTimestamp:(NSString *)formatTime{
    
    NSDate *currentDate = [NSDate date];                            //实际上获得的是：UTC时间，协调世界时，亚州的时间与UTC的时差均为+8
    NSTimeZone *zone = [NSTimeZone systemTimeZone];                  //zone为当前时区信息  在我的程序中打印的是@"Asia/Shanghai"
    //    NSInteger interval = [zone secondsFromGMTForDate: currentDate];      //28800 //所在地区时间与协调世界时差距
    NSInteger interval = 0;
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:ss:mm"];
    //根据需求 选择date的方法
    NSString *replacedStr = [formatTime stringByReplacingOccurrencesOfString:@".000"withString:@""];
    //传入的时间转换成东八区时间
    NSDate * date = [[formatter dateFromString:replacedStr] dateByAddingTimeInterval:interval];
    
    ///当前东八区时间
    NSDate *localeDate = [currentDate dateByAddingTimeInterval: interval];
    
    //获取传入时间的年月日
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent1 = [calendar components:unitFlags fromDate:date];
    NSInteger year1 = [dateComponent1 year];
    NSInteger month1 = [dateComponent1 month];
    NSInteger day1 = [dateComponent1 day];
    
    //获取当前年月日
    NSDateComponents *dateComponent2 = [calendar components:unitFlags fromDate:localeDate];
    NSInteger year2 = [dateComponent2 year];
    NSInteger month2 = [dateComponent2 month];
    NSInteger day2 = [dateComponent2 day];
    
    NSDate *datec1 = [[formatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",year1,month1,day1]] dateByAddingTimeInterval:interval];
    NSDate *datec2 =  [[formatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",year2,month2,day2]] dateByAddingTimeInterval:interval];
    
    NSDateComponents *cmps = [calendar components:unitFlags fromDate:datec1 toDate:datec2 options:0];
    
    return cmps.day;
    
}

/// 是否空白字符串
- (BOOL)isBlankString:(NSString *)aStr {
    if (!aStr) {
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!aStr.length) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}

@end

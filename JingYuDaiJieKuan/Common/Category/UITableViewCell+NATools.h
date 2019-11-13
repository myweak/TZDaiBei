//
//  UITableViewCell+NATools.h
//  StraightPin
//
//  Created by Nathan Ou on 15/3/17.
//  Copyright (c) 2015年 CRZ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define m_blankCellReuseId @"m_blankCellReuseId"

@interface UITableViewCell (NATools)
@property (nonatomic, strong) UIView *viewContent;

+ (instancetype)blankWhiteCell;//白色无分割线
+ (instancetype)blankWhiteCellWithID:(NSString *)indentifier; //白色无分割线

+ (instancetype)blankCell;//灰色色无分割线
+ (instancetype)blankLineCell;//灰色有分割线


- (void)setInsetWithX:(CGFloat)xpoint;
+ (UITableViewCell *)setCustomCell:(Class)cellClass insetWithX:(NSInteger)insetWidth tableView:(UITableView *)tableView;
@end

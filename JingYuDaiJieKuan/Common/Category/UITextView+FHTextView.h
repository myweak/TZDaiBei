//
//  UITextView.h
//  FamilyHealth
//
//  Created by Transuner on 2017/3/8.
//  Copyright © 2017年 吴冰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (FHTextView)
@property (nonatomic,strong) UILabel *placeholderLabel;//占位符
@property (nonatomic,strong) UILabel *wordCountLabel;//计算字数

@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic,strong) NSString *placeholder;//占位符
@property (copy, nonatomic) NSNumber *limitLength;//限制字数
- (UIColor *)defaultPlaceholderColor;
@end

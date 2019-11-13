//
//  CustomButton.h
//  NewJingYuBao
//
//  Created by 暴走的狗 on 16/7/12.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton
@property (nonatomic, assign)BOOL  effective;//是否有效，用来处理是否置灰
- (instancetype)initWithTitle:(NSString *)title titleFont:(UIFont *)font effective:(BOOL)effective;
@end

@interface ClickButton : UIButton

- (instancetype)initWithTitle:(NSString *)title cornerRadius:(CGFloat )cornerRadius;

- (void)clickState;

- (void)resignClickState;

@end

@interface NextButton : UIButton

@property (nonatomic, assign)BOOL  effective;//是否有效，用来处理是否置灰
- (instancetype)initWithTitle:(NSString *)title effective:(BOOL)effective;


@end

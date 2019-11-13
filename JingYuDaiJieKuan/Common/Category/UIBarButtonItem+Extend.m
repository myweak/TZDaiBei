//
//  UIBarButtonItem+Extend.m
//  NewJingYuBao
//
//  Created by linshaokai on 16/6/24.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import "UIBarButtonItem+Extend.h"
#import "NSString+Extend.h"

#define kBarButtonTitleColor [UIColor blackColor]

@implementation UIBarButtonItem (Extend)

+ (UIBarButtonItem *)customBarButtonItemWithNornalImage:(NSString *)nornalImage
                                           seletedImage:(NSString *)seletedImage
                                                  title:(NSString *)title
                                                 target:(id)target
                                                 action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

    CGFloat fontSize = 15.0;
    [[button titleLabel]setFont:[UIFont systemFontOfSize:fontSize]];
    //kBarButtonTitleColor
    CGRect buttonFrame = [button frame];
    if (NotNullJudge(title)) {
        buttonFrame.size.width = [title calculateTextWidth:fontSize] + 30;
        buttonFrame.size.height = 30.0;
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:UIColorRGB(51, 137, 250) forState:UIControlStateNormal]; //UIColorHex(@"#666666")
    }else
    {
        buttonFrame.size = CGSizeMake(40, 40);
    }
    
    [button setFrame:buttonFrame];
    
    if (NotNullJudge(nornalImage)) {
        [button setImage:[UIImage imageNamed:nornalImage] forState:UIControlStateNormal];
    }
    if (NotNullJudge(seletedImage)) {
        [button setImage:[UIImage imageNamed:seletedImage] forState:UIControlStateHighlighted];
    }
    if (target && action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (iPhone6P_Pix) {
        button.imageEdgeInsets = UIEdgeInsetsMake(0, kiP6WidthRace(-20), 0, 0);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, kiP6WidthRace(15), 0, 0);
    }else if (iPhone6){
        button.imageEdgeInsets = UIEdgeInsetsMake(0, kiP6WidthRace(-10), 0, 0);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, kiP6WidthRace(15), 0, 0);
    }
  
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return buttonItem;
    
}


@end

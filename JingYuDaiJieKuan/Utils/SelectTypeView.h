//
//  SelectTypeView.h
//  Cunpiao
//
//  Created by weibin on 2016/11/7.
//  Copyright © 2016年 cwb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectTypeViewDelegate <NSObject>

@optional;

- (void)selectItem:(NSInteger)index;

- (void)dismissView;

@end

@interface SelectTypeView : UIView

- (instancetype)initWithFrame:(CGRect)frame title:(NSArray *)title selectNum:(NSInteger)selectNum;

@property (nonatomic, weak) id <SelectTypeViewDelegate> delegate;

@end

//
//  StarSliderView.h
//  GSYSlider
//
//  Created by apple on 2017/5/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol StarSLiderDelegate <NSObject>
@required
-(void)starSliderMoveWithCurrentNum:(int)starNum;

@end
@interface StarSliderView : UIView


/*currentStarNum：设置初始化当前星星等级。
   frame：大小。PSFrame的高度设置是无效的因为高度与一个星星的宽度相同
   nabled：是否可以滑动，NO一般用于已经评论的星级显示。
   distance :设置星星之间的距离*/
-(instancetype)initWithFrame:(CGRect)frame
       andWithCurrentStarNum:(int)currentStarNum
       andUserEnabled:(BOOL)nabled
       andWithDistance:(float)distance;

@property(nonatomic,assign)float distance;
@property(nonatomic,strong)id<StarSLiderDelegate>delegate;
@end

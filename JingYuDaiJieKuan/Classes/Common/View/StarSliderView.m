//
//  StarSliderView.m
//  GSYSlider
//
//  Created by apple on 2017/5/6.
//  Copyright © 2017年 apple. All rights reserved.
//
#define KStar_X 0
#import "StarSliderView.h"
@interface StarSliderView(){
    NSMutableArray *_imgViewArray;
    
}
@end

//设置星星个数
#define kStarsNum 5
//设置星星大小
#define kstarImgWitch (self.frame.size.width-_distance*(kStarsNum+1))/kStarsNum

@implementation StarSliderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.distance = 12;

    [self createView];
    [self highlightStarShow:0];

}

-(instancetype)initWithFrame:(CGRect)frame andWithCurrentStarNum:(int)currentStarNum andUserEnabled:(BOOL)nabled andWithDistance:(float)distance{
    self = [super initWithFrame:frame];
  
    if (self) {
        self.userInteractionEnabled = nabled;
        _distance =distance;
        [self createView];
      
        if (currentStarNum != 0 &&currentStarNum <= kStarsNum) {
            [self highlightStarShow:currentStarNum];
        }
    }
    return self;
}

#pragma mark - - 
-(void)createView{
    _imgViewArray = [NSMutableArray array];
    
    //默认状态
    for (int i = 0; i<kStarsNum; i++) {
        //
        UIImageView *imgViewNomal = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"comment_star"]];
        imgViewNomal.frame = CGRectMake(KStar_X+(kstarImgWitch+_distance)*i, (self.height-kstarImgWitch)/2.0f, kstarImgWitch,  kstarImgWitch);
        imgViewNomal.tag = i;
        [self addSubview:imgViewNomal];
        
        //
        UIImageView *imgViewSeleted = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"comment_star_thumd"]];
        imgViewSeleted.frame = CGRectMake(KStar_X+(kstarImgWitch+_distance)*i, (self.height-kstarImgWitch)/2.0f, kstarImgWitch,  kstarImgWitch);
        imgViewSeleted.hidden = YES;
        imgViewSeleted.tag = i;
        [self addSubview:imgViewSeleted];
        [_imgViewArray addObject:imgViewSeleted];
        
        
    }

    self.height = kstarImgWitch;
}

#pragma mark - -
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint pt = [[touches anyObject] locationInView:self];
    [self showStarSlider:pt.x];
    [self selectAnimal:pt.x];
}

#pragma mark - -
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint pt = [[touches anyObject] locationInView:self];
    [self showStarSlider:pt.x];
}

#pragma mark - -
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint pt = [[touches anyObject] locationInView:self];
    [self showStarSlider:pt.x];
    [self selectAnimal:pt.x];
}

#pragma mark - - 展示滑杆
-(void)showStarSlider:(float)pt{
    int num;
    
    //0*
    if (pt<_distance) {
        for (int i = 0; i<_imgViewArray.count; i++) {
            UIImageView *imgView = _imgViewArray[i];
            imgView.hidden = YES;
        }
        num = 0;
        
    //5*
    }else if (pt>=(kstarImgWitch*kStarsNum+_distance*kStarsNum)){
        for (int i = 0; i<_imgViewArray.count; i++) {
            UIImageView *imgView = _imgViewArray[i];
            imgView.hidden = NO;
        }
        num = kStarsNum;
        
    //1—5*
    }else{
        int  currentInt = pt/(kstarImgWitch+_distance);
        for (int i =0; i<=currentInt; i++) {
            UIImageView *imgView = _imgViewArray[i];
            imgView.hidden = NO;
        }
        for (int i = currentInt+1; i<=_imgViewArray.count-1; i++) {
            UIImageView *imgView = _imgViewArray[i];
            imgView.hidden = YES;
        }
        num = currentInt +1;
    }
    
    //
    if ( [_delegate respondsToSelector:@selector(starSliderMoveWithCurrentNum:)]) {
        [_delegate starSliderMoveWithCurrentNum:num];
    }
    
}

#pragma mark - - 简单动画效果
-(void)selectAnimal:(float)pt{
    UIImageView *imgViewanimal = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_star_evaluation_press"]];
    imgViewanimal.frame = CGRectMake(pt,0, 19, 19);
    imgViewanimal.alpha = 0.3;
    [self addSubview:imgViewanimal];
   
    [UIView animateWithDuration:0.5 animations:^{
        imgViewanimal.frame = CGRectMake(pt,-30, 19, 19);
        imgViewanimal.alpha = 0;
    }];
    [self performSelector:@selector(delayMethod:) withObject:imgViewanimal afterDelay:0.5];
}

//个人习惯喜欢延时操作也可以使用动画执行之后的操作
#pragma mark - - 动画延时
-(void)delayMethod:(UIView*)view{
    [view removeFromSuperview];
    view = nil;
}

#pragma mark - -
-(void)highlightStarShow:(int)currentInt{
    for (int i =0; i<=currentInt-1; i++) {
        UIImageView *imgView = _imgViewArray[i];
        imgView.hidden = NO;
    }
    for (int i = currentInt; i<=_imgViewArray.count-1; i++) {
        UIImageView *imgView = _imgViewArray[i];
        imgView.hidden = YES;
    }
}
@end

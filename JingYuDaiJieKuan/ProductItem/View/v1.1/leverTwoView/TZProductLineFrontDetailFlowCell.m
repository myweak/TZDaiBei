//
//  TZProductLineFrontDetailFlowCell.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2020/1/13.
//  Copyright © 2020 Jincaishen. All rights reserved.
//

#import "TZProductLineFrontDetailFlowCell.h"
@interface TZProductLineFrontDetailFlowCell ()
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
@implementation TZProductLineFrontDetailFlowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSInteger count = 5.0;
    CGFloat count_W = kScreenWidth - 30;
    CGFloat row_W = count_W/count;
    
    CGFloat row_centerX = row_W/2.0f-2;
    
    /*
     *画实线
     */
    CAShapeLayer *solidShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef solidShapePath =  CGPathCreateMutable();
    [solidShapeLayer setFillColor:kColorShortTerm.CGColor];
    [solidShapeLayer setStrokeColor:kColorShortTerm.CGColor];
    solidShapeLayer.lineWidth = 1.0f ;
    CGPathMoveToPoint(solidShapePath, NULL, row_centerX, 4);
    CGPathAddLineToPoint(solidShapePath, NULL, count_W - row_centerX - 2,4);
    [solidShapeLayer setPath:solidShapePath];
    CGPathRelease(solidShapePath);
    [self.lineView.layer addSublayer:solidShapeLayer];
    
    
    
    for (int i = 0; i<count; i++) {
        // 贝塞尔曲线(创建一个圆)
        UIBezierPath *path =  [[UIBezierPath alloc] init];;
        [path addArcWithCenter:CGPointMake(row_centerX +i*row_W, 4) radius:2 startAngle:0 endAngle:M_PI*2 clockwise:YES];

        //创建 shapeLayer
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.strokeColor = kColorShortTerm.CGColor;
        shapeLayer.fillColor = kColorShortTerm.CGColor;
        shapeLayer.lineWidth = 1;
        shapeLayer.path = path.CGPath;

        // 将layer添加进图层
        [self.lineView.layer addSublayer:shapeLayer];
        
//        //创建 shapeLayer
//        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//        shapeLayer.lineWidth = 1;
//        shapeLayer.frame = CGRectMake(row_centerX +i*row_W, 2, 4, 4);
//        shapeLayer.backgroundColor = [UIColor redColor].CGColor;
//        shapeLayer.cornerRadius = 2;
//        //给当前图层添加动画组
//        [shapeLayer addAnimation:[self pathBasicAnimateWithTime:i*2] forKey:@"aAlpha"];
//
//        // 将layer添加进图层
//        [self.lineView.layer addSublayer:shapeLayer];
        
        
    }
}

- (CAAnimationGroup *)pathBasicAnimateWithTime:(CGFloat)time
{
    //实例化CABasicAnimation
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        //从1开始
        scaleAnimation.fromValue = @1;
        //到3.5
        scaleAnimation.toValue = @2.5;
        //结束后不执行逆动画
        scaleAnimation.autoreverses = NO;
        //无限循环
        scaleAnimation.repeatCount = 1;
        //一次执行time秒
        scaleAnimation.duration = 2;

        //结束后从渲染树删除，变回初始状态
        scaleAnimation.removedOnCompletion = YES;
        scaleAnimation.fillMode = kCAFillModeForwards;

        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.fromValue = @1.7;
        opacityAnimation.toValue = @1;
        opacityAnimation.autoreverses = NO;
        opacityAnimation.repeatCount = 1;
        opacityAnimation.duration = 2;

        opacityAnimation.removedOnCompletion = YES;
        opacityAnimation.fillMode = kCAFillModeForwards;

        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration = 2;
        //结束后不执行逆动画
        group.autoreverses = YES;
        group.animations = @[scaleAnimation, opacityAnimation];
        group.repeatCount = 1;
 
    return group;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

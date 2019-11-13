//
//  ViewController.m
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/19.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "ViewController.h"

#import "UIView+TYAlertView.h"

/**
 * @abstract
 * 自动追踪(AutoTrack)中，实现该 Protocal 的 Controller 对象可以通过接口向自动采集的事件中加入属性
 *
 * @discussion
 * 属性的约束请参考 <code>track:withProperties:</code>
 */
@protocol SAAutoTracker
@required
-(NSDictionary *)getTrackProperties;
@end

@protocol SAScreenAutoTracker<SAAutoTracker>
@required
-(NSString *) getScreenUrl;
@end


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

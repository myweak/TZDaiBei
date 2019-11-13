//
//  TZProductLinebackBankFlowView.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/4.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZProductLinebackBankFlowView.h"
@interface TZProductLinebackBankFlowView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageA;
@property (weak, nonatomic) IBOutlet UIImageView *imageB;
@property (weak, nonatomic) IBOutlet UIImageView *imageC;

@end
@implementation TZProductLinebackBankFlowView
- (void)awakeFromNib{
    [super awakeFromNib];

    UIImage *img = [UIImage imageNamed:@"icon_turn"];
    
    self.imageA.image =  [UIImage imageWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationDown];
    self.imageB.image =  [UIImage imageWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationDown];;
    self.imageC.image =  [UIImage imageWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationRight];;

    
}


@end

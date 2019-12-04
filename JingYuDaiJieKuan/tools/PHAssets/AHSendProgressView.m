//
//  AHSendProgressView.m
//  AntHouse
//
//  Created by Nathan Ou on 2017/8/17.
//  Copyright © 2017年 Nathan Ou. All rights reserved.
//

#import "AHSendProgressView.h"

@interface AHSendProgressView ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIView *progressView;

@property (nonatomic, strong) UIView *progressBar;

@property (nonatomic, copy) void(^dismissFinishBlock)();

@end

@implementation AHSendProgressView

- (instancetype)init
{
    self = [super initWithFrame:[self keyWindow].bounds];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.4f];
        [self commonInit];
    }
    return self;
}

- (UIWindow *)keyWindow
{
    return [UIApplication sharedApplication].keyWindow;
}

- (void)commonInit
{
    [self setupSubviews];
}

- (void)setupSubviews
{
    CGFloat padding;
    
        padding = 60.f;

    
    CGSize contentSize = CGSizeMake(self.width-padding*2, 140.f);
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(padding, 0, contentSize.width, contentSize.height)];
    [content setCornerRadius:15.f];
    content.backgroundColor = [UIColor whiteColor];
    self.contentView = content;
    content.y = self.height/2.f;
    [self addSubview:content];
    
    CGFloat p_padding = 15.f;
    UIView *progressView = [[UIView alloc] initWithFrame:CGRectMake(p_padding, 0, contentSize.width-p_padding*2.f, 5.f)];
    progressView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.f];
    self.progressView = progressView;
    progressView.y = content.height/2.f;
    [progressView setCornerRadius:progressView.height/2.f];
    [content addSubview:progressView];
    
    UIView *progress = [[UIView alloc] initWithFrame:progressView.bounds];
    progress.backgroundColor = [UIColor blueColor];
    [progressView addSubview:progress];
    self.progressBar = progress;
    progress.width = 0.f;
    
    UILabel *bottomLabel = [[UILabel alloc] init];
    [bottomLabel setLabelWith:@"发送成功啦啦啦！！" color:[UIColor blackColor] font:[UIFont systemFontOfSize:13.f] aliment:NSTextAlignmentCenter];
    [bottomLabel sizeToFit];
    bottomLabel.text = nil;
    bottomLabel.x = content.width/2.f;
    bottomLabel.top = progressView.bottom+12.f;
    [content addSubview:bottomLabel];
    self.bottomTipLabel = bottomLabel;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setLabelWith:@"正在发送" color:[UIColor blackColor] font:[UIFont systemFontOfSize:14.f] aliment:NSTextAlignmentCenter];
    [titleLabel sizeToFit];
    titleLabel.x = bottomLabel.x;
    titleLabel.bottom = progressView.top-20.f;
    [content addSubview:titleLabel];
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    WEAKSELF;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.progressBar.width = progress*weakSelf.progressView.width;
        NSLog(@"-----> bar : %f  view : %f", weakSelf.progressBar.width, weakSelf.progressView.width);
    });
}

#pragma mark - Animaion

+ (AHSendProgressView *)showProgressView
{
    AHSendProgressView *progressView = [[AHSendProgressView alloc] init];
    progressView.alpha = 0.f;
    [[progressView keyWindow] addSubview:progressView];
    [UIView animateWithDuration:0.4 animations:^{
        progressView.alpha = 1.f;
    } completion:^(BOOL finished) {
        
    }];
    return progressView;
}

- (void)dismiss
{
    [self dismissWithCompletion:nil];
}

- (void)dismissWithCompletion:(void (^)(void))block
{
    self.dismissFinishBlock = block;
    [self waitToDismiss];
//    [self performSelector:@selector(waitToDismiss) withObject:nil afterDelay:1.f];
}

- (void)waitToDismiss
{
    WEAKSELF;
    dispatch_async(dispatch_get_main_queue(), ^{
//        [UIView animateWithDuration:0.3f animations:^{
//            weakSelf.alpha = 0.f;
//        } completion:^(BOOL finished) {
//            weakSelf.hidden = YES;
//            [weakSelf removeFromSuperview];
//            if (weakSelf.dismissFinishBlock) {
//                weakSelf.dismissFinishBlock();
//            }
//        }];
        weakSelf.hidden = YES;
        [weakSelf removeFromSuperview];
        if (weakSelf.dismissFinishBlock) {
            weakSelf.dismissFinishBlock();
        }
    });
}

@end

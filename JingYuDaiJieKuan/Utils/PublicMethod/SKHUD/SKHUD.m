//
//  HUD.m
//  hudDemo
//
//  Created by linshaokai on 2016/9/30.
//  Copyright © 2016年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import "SKHUD.h"
typedef enum
{
    HUDMessage = 0,
    HUDLoading = 1
    
}HUDStatus;
typedef enum
{
    HUDImage = 0,
    HUDDotLayer = 1,
    HUDGif = 2,
    HUDDefault = 3,
    HUDImageClearBg=4,
    HUDNoShow = -1,
    
}HUDLoadType;

#define MessageJudge(x) ![(x) isKindOfClass:[NSNull class]] && (x) != nil && ![(x) isEqualToString:@""]

#define UIColorSixteen(rgbValue,a) [UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(rgbValue & 0xFF))/255.0 alpha:a]

#define BGViewColor [UIColor clearColor]
//UIColorSixteen(0x000000,0.5)
#define loaderCornerRadius 5
#define loaderBackgroundColor UIColorSixteen(0x333333,0.7)
#define statusTextColor  [UIColor whiteColor]

#define kStatusTextFont 18

#define kBgMarginWidth 30

#define kTextMarginWidth 10

#define kTextMaxHeight 100

#define kHidenTime 2
#define kAnimalHiden 2.5


#define kDefaultLoadingWidth 100

#define kImageLoadingWidth 34
#define kIsImageAnimal 1


#define kLoadingText @"加载中..."



@interface SKHUD ()

@property (strong ,nonatomic) UILabel *messageLabel;
@property (strong ,nonatomic) UIView *bgContentView;
@property (strong ,nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong ,nonatomic) UIImageView *loadImageView;
@property (strong ,nonatomic) NSMutableArray *gifImageArray;
@property (nonatomic , strong) CAReplicatorLayer *replicatorLayer;
@property (assign ,nonatomic) HUDLoadType lastLoadType;
@end
@implementation SKHUD
{
    
}

+ (SKHUD *)sharedInstance
{
    static dispatch_once_t once = 0;
    static SKHUD *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[SKHUD alloc] init];
    });
    return sharedInstance;
}
#pragma mark - Initialization Methods
- (id)init
{
    if (self = [super init]) {
        self.backgroundColor = BGViewColor;
        _lastLoadType = -1;
        
    }
    return self;
}


-(void)createMessage:(NSString *)message loadType:(HUDLoadType)loadType status:(HUDStatus)status superView:(UIView *)superView isAutoDismissView:(BOOL)dismiss
{
    if (loadType != _lastLoadType) {
        [self removeView];
    }
    _lastLoadType = loadType;
    if (!superView) {
        return;
    }
    self.alpha = 1;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (status == HUDMessage && !MessageJudge(message)) {
            return ;
        }
        self.bgContentView.backgroundColor = loaderBackgroundColor;
        self.messageLabel.textColor = statusTextColor;
        CGFloat viewWidth = CGRectGetWidth(superView.bounds);
        CGFloat viewHeight = CGRectGetHeight(superView.bounds);
        CGSize size = [self calculateTextSize:kStatusTextFont string:message width:viewWidth];
        CGFloat contentWidth = 0.0;
        CGFloat contentHeight = 0.0;
        if (self->_loadImageView) {
            self->_loadImageView.hidden = YES;
        }
        if (self->_activityIndicatorView) {
            self->_activityIndicatorView.hidden = YES;
        }
        if (status == HUDMessage) {
            self.messageLabel.text = message;
            self.messageLabel.font = [UIFont systemFontOfSize:kStatusTextFont];
            self.bgContentView.backgroundColor = UIColorSixteen(0x000000, 1.0);
            self.messageLabel.textAlignment = NSTextAlignmentLeft;
            self.messageLabel.frame = CGRectMake(kTextMarginWidth, kTextMarginWidth, size.width, size.height);
            contentHeight = size.height + kTextMarginWidth * 2;
            contentWidth = size.width + kTextMarginWidth * 2;
            
        }else
        {
            self.messageLabel.font = [UIFont systemFontOfSize:14];
            self.messageLabel.text = message;
            self.messageLabel.textAlignment = NSTextAlignmentCenter;
            self.messageLabel.frame = CGRectMake(kTextMarginWidth, kDefaultLoadingWidth / 2.0 +  (kDefaultLoadingWidth / 2.0 - 20) / 2.0, kDefaultLoadingWidth - kTextMarginWidth * 2, 20);
            contentWidth = kDefaultLoadingWidth;
            contentHeight = kDefaultLoadingWidth;
            if (loadType == HUDDefault) {
                self.activityIndicatorView.hidden = NO;
                self.activityIndicatorView.frame = CGRectMake((kDefaultLoadingWidth - 20) / 2.0, (kDefaultLoadingWidth / 2.0 - 20) - 5, 20, 20);
                [self startAnimatView];
            }else
            {
                [self addLoadImageViewOrLayer:loadType];
                self.loadImageView.frame = CGRectMake((kDefaultLoadingWidth - kImageLoadingWidth) / 2.0, (kDefaultLoadingWidth / 2.0 - kImageLoadingWidth), kImageLoadingWidth, kImageLoadingWidth);
                self.loadImageView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                self.loadImageView.backgroundColor = [UIColor clearColor];
                self.loadImageView.layer.cornerRadius = 0;
                self.loadImageView.hidden = NO;
                if (loadType == HUDImage) {
                    self.loadImageView.animationImages = nil;
                    self.loadImageView.image = [UIImage imageNamed:@"load_2"];
                    if (kIsImageAnimal) {
                        [self animationWorkForImage];
                    }
                }
                else if(loadType == HUDImageClearBg){
                    self.loadImageView.animationImages = nil;
                    self.loadImageView.image = [UIImage imageNamed:@"load_1"];
                    self.bgContentView.backgroundColor = [UIColor clearColor];
                    self.loadImageView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                    if (kIsImageAnimal) {
                        [self animationWorkForImage];
                    }
                }
            
                else if (loadType == HUDDotLayer){
                    self.loadImageView.animationImages = nil;
                    self.loadImageView.image =nil;
                    self.loadImageView.backgroundColor = [UIColor whiteColor];
                    self.loadImageView.frame = CGRectMake(kImageLoadingWidth / 2.0, 0, 6, 6);
                    self.loadImageView.layer.cornerRadius = 3;
                    if (kIsImageAnimal) {
                        [self animationWork];
                    }
                }
                else
                {
                    self.loadImageView.image = nil;
                    self.bgContentView.backgroundColor = [UIColor whiteColor];
                    self.messageLabel.textColor = [UIColor blackColor];
                    self.loadImageView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                    self.loadImageView.animationImages = self.gifImageArray;
                    self.loadImageView.animationRepeatCount = GID_MAX;
                    self.loadImageView.animationDuration = 0.5;
                    [self.loadImageView startAnimating];
                    
                }
            }
        }
        self.bgContentView.frame = CGRectMake((viewWidth - contentWidth) / 2.0, (viewHeight - contentHeight) / 2.0, contentWidth, contentHeight);
        self.frame = superView.bounds;
        //        self.bgContentView.center = superView.center;
        [superView addSubview:self];
        if (dismiss) {
            [self performSelector:@selector(loadingViewHide) withObject:nil afterDelay:kHidenTime];
        }

    });
    
}
-(void)removeLoadingView
{
    [self removeView];
    if (self.superview) {
        [self removeFromSuperview];
    }
    
}
-(void)removeView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self stopAnimatView];
}
-(void)loadingViewHide
{
    if (self.alpha == 1)
    {
        
        [UIView animateWithDuration:kAnimalHiden delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState animations:^{
//            self.transform = CGAffineTransformScale(self.transform, 1.2, 1.2);
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeLoadingView];
        }];
    }
}

#pragma mark 界面初始化
-(UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textColor = statusTextColor;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:kStatusTextFont];
        [self.bgContentView addSubview:_messageLabel];
    }
    return _messageLabel;
}
-(UIView *)bgContentView
{
    if (!_bgContentView) {
        _bgContentView = [[UIView alloc]init];
        _bgContentView.backgroundColor = loaderBackgroundColor;
        _bgContentView.layer.cornerRadius = loaderCornerRadius;
        [self addSubview:_bgContentView];
    }
    return _bgContentView;
}
-(UIActivityIndicatorView *)activityIndicatorView
{
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self.bgContentView addSubview:_activityIndicatorView];
    }
    return _activityIndicatorView;
}
-(void)addLoadImageViewOrLayer:(HUDLoadType)current
{
    if (current != HUDDotLayer) {
        if (![self.loadImageView superview]) {
            [self.bgContentView.layer addSublayer:self.loadImageView.layer];
        }
    }else
    {
        if (_replicatorLayer && !_replicatorLayer.superlayer) {
            [self.bgContentView.layer addSublayer:_replicatorLayer];
        }
        [self.replicatorLayer addSublayer:self.loadImageView.layer];
        
    }
    
}
-(void)animationWork
{
     self.loadImageView.layer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 1;
    animation.repeatCount = MAXFLOAT;
    //从原大小变小时,动画 回到原状时不要动画
    animation.fromValue = @(1);
    animation.toValue = @(0.01);
    [self.loadImageView.layer addAnimation:animation forKey:nil];
}
-(void)animationWorkForImage
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1.68;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = GID_MAX;
    [self.loadImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
-(void)startAnimatView
{
    if (_lastLoadType == HUDDefault) {
        if (_activityIndicatorView && !_activityIndicatorView.hidden) {
            [_activityIndicatorView startAnimating];
        }
    }
}
-(CAReplicatorLayer *)replicatorLayer
{
    if (!_replicatorLayer) {
        _replicatorLayer = [CAReplicatorLayer layer];
        
        _replicatorLayer.frame = CGRectMake((kDefaultLoadingWidth - kImageLoadingWidth) / 2.0, (kDefaultLoadingWidth / 2.0 - kImageLoadingWidth), kImageLoadingWidth, kImageLoadingWidth);;
        
        _replicatorLayer.preservesDepth = YES;
        CGFloat count = 8;
        _replicatorLayer.instanceDelay = 1.0 / count;
        _replicatorLayer.instanceCount = count;
        //相对于_replicatorLayer.position旋转
        _replicatorLayer.instanceTransform = CATransform3DMakeRotation((2 * M_PI) / count, 0, 0, 1.0);
        [self.bgContentView.layer addSublayer:_replicatorLayer];
    }
    return _replicatorLayer;
}
-(void)stopAnimatView
{
    
    if (_lastLoadType != -1) {
        if (_lastLoadType == HUDImage || _lastLoadType == HUDDotLayer || _lastLoadType == HUDImageClearBg) {
            if (self.loadImageView && kIsImageAnimal) {
                [self.loadImageView.layer removeAllAnimations];
            }
            if (_lastLoadType == HUDDotLayer) {
                if (_replicatorLayer && _replicatorLayer.superlayer) {
                    [_replicatorLayer removeFromSuperlayer];
                }
            }
        }else if (_lastLoadType == HUDGif)
        {
            if (self.loadImageView && self.loadImageView.animating) {
                [self.loadImageView stopAnimating];
            }
        }else if (_lastLoadType == HUDDefault)
        {
            if (_activityIndicatorView && _activityIndicatorView.animating) {
                [_activityIndicatorView stopAnimating];
            }
        }
    }
}
-(UIImageView *)loadImageView
{
    if (!_loadImageView) {
        _loadImageView = [[UIImageView alloc]init];
//         [self.bgContentView addSubview:_loadImageView];
    }
    return _loadImageView;
}

-(NSMutableArray *)gifImageArray
{
    if (!_gifImageArray) {
        
        _gifImageArray = [NSMutableArray array];
        for (NSUInteger i = 1; i<=18; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%zd", i]];
            [_gifImageArray addObject:image];
        }
    }
    return _gifImageArray;
}
-(CGSize)calculateTextSize:(CGFloat)font string:(NSString *)content width:(CGFloat)viewWidth
{
    CGRect rect = [content boundingRectWithSize:CGSizeMake(viewWidth - (kiP6WidthRace(20) + kTextMarginWidth) * 2,kTextMaxHeight) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect.size;
}


#pragma mark - public Methods
+ (void)showLoadingDefaultInView:(UIView *)view
{
    [[SKHUD sharedInstance]createMessage:kLoadingText loadType:HUDDefault status:HUDLoading superView:view isAutoDismissView:NO];
}

+ (void)showLoadingImageInView:(UIView *)view
{
    [[SKHUD sharedInstance]createMessage:kLoadingText loadType:HUDImage status:HUDLoading superView:view isAutoDismissView:NO];
}
+(void)showLoadingImageInView:(UIView *)view withMessage:(NSString*)message
{
      [[SKHUD sharedInstance]createMessage:message loadType:HUDImage status:HUDLoading superView:view isAutoDismissView:NO];
}
+ (void)showLoadingImageClearBgInView:(UIView *)view withMessage:(NSString*)message
{
          [[SKHUD sharedInstance]createMessage:message loadType:HUDImageClearBg status:HUDLoading superView:view isAutoDismissView:NO];
}
+ (void)showLoadingGifInView:(UIView *)view
{
    [[SKHUD sharedInstance]createMessage:kLoadingText loadType:HUDGif status:HUDLoading superView:view isAutoDismissView:NO];
}
+ (void)showLoadingDotInView:(UIView *)view
{
    [[SKHUD sharedInstance]createMessage:kLoadingText loadType:HUDDotLayer status:HUDLoading superView:view isAutoDismissView:NO];
}
+(void)showLoadingDotInView:(UIView *)view withMessage:(NSString*)message
{
    [[SKHUD sharedInstance]createMessage:message loadType:HUDDotLayer status:HUDLoading superView:view isAutoDismissView:NO];
}
+ (void)showLoadingDotInWindow
{
    [[SKHUD sharedInstance]createMessage:kLoadingText loadType:HUDDotLayer status:HUDLoading superView:[[UIApplication sharedApplication].windows objectAtIndex:0] isAutoDismissView:NO];
}

+ (void)showLoadingDotInWindowWithMessage:(NSString *)message
{
    [[SKHUD sharedInstance]createMessage:message loadType:HUDDotLayer status:HUDLoading superView:[[UIApplication sharedApplication].windows objectAtIndex:0] isAutoDismissView:NO];
}


+ (void)showLoadingDefaultInWindow
{
    [[SKHUD sharedInstance]createMessage:kLoadingText loadType:HUDDefault status:HUDLoading superView:[[UIApplication sharedApplication].windows objectAtIndex:0] isAutoDismissView:NO];
}

+ (void)showLoadingImageInWindow
{
    [[SKHUD sharedInstance]createMessage:kLoadingText loadType:HUDImage status:HUDLoading superView:[[UIApplication sharedApplication].windows objectAtIndex:0] isAutoDismissView:NO];
}
+ (void)showLoadingImageInWindowWithMessage:(NSString *)message
{
    [[SKHUD sharedInstance]createMessage:message loadType:HUDImage status:HUDLoading superView:[[UIApplication sharedApplication].windows objectAtIndex:0] isAutoDismissView:NO];
}

+ (void)showLoadingGifInWindow
{
    [[SKHUD sharedInstance]createMessage:kLoadingText loadType:HUDGif status:HUDLoading superView:[[UIApplication sharedApplication].windows objectAtIndex:0] isAutoDismissView:NO];
}


+ (void)showMessageInView:(UIView *)view  withMessage:(NSString *)message
{
    [[SKHUD sharedInstance] createMessage:message loadType:HUDDefault status:HUDMessage superView:view isAutoDismissView:YES];
}
+ (void)showMessageInWindowWithMessage:(NSString *)message
{
    
    [[SKHUD sharedInstance] createMessage:message loadType:HUDDefault status:HUDMessage superView:[[UIApplication sharedApplication].windows objectAtIndex:0] isAutoDismissView:YES];
}
+ (void)showNetworkErrorMessageInView:(UIView *)view
{
    
    [[SKHUD sharedInstance] createMessage:@"当前网络不可用，请检查你的网络设置" loadType:HUDDefault status:HUDMessage superView:view isAutoDismissView:YES];
}
+ (void)dismiss
{
    [[SKHUD sharedInstance] removeLoadingView];
}
@end

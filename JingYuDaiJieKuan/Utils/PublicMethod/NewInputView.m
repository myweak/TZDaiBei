//
//  NewInputView.m
//  NewJingYuBao
//
//  Created by 暴走的狗 on 2017/3/3.
//  Copyright © 2017年 厦门吉才神金融信息有限公司. All rights reserved.
//

#import "NewInputView.h"
//读取图片
#define LoadImage(B)    [UIImage imageNamed:B]

@interface NewInputView ()<UITextFieldDelegate , CAAnimationDelegate>
{
    NSInteger   restTime;
    BOOL        isHiddenDel;
    BOOL        hasObserve; //用来判断是否移除通知
    BOOL        isAnimating; //正在执行动画
    NSString    *codeObserveKey;
}

@property (nonatomic, strong)UIFont         *leftLabelFont;
@property (nonatomic, strong)UIColor        *leftLabelColor;
@property (nonatomic, strong)UIFont         *tfFont;
@property (nonatomic, strong)UIImageView    *leftImage;
@property (nonatomic, assign)CGFloat        spacing;
@property (nonatomic, assign)CGFloat        leftSpacing;
@property (nonatomic, assign)BOOL           hasRightBtn;
@property (nonatomic, strong)NSTimer        *timer;

@property (nonatomic, strong) CAShapeLayer *m_layer;

@end

@implementation NewInputView


- (instancetype)initWithType:(NewInputType)type leftLabelName:(NSString *)leftLabelStr leftLabelFont:(UIFont*)leftFont leftLabelColor:(UIColor*)leftLabelColor leftImageStr:(NSString *)leftImageStr placeholder:(NSString *)placeholderStr tfFont:(UIFont *)tfFont spacing:(CGFloat)spacing leftSpacing:(CGFloat)leftSpacing hiddenDelBtn:(BOOL)isHidden codeObserveKey:(NSString *)codeobservekey{
    _leftLabelFont = leftFont;
    _leftLabelColor = leftLabelColor;
    _tfFont = tfFont;
    if (type == NewInformationInput) {
        return [self initInformationInputViewWithleftLabelName:leftLabelStr leftImage:leftImageStr placeholder:placeholderStr spacing:spacing leftSpacing:leftSpacing hiddenDelBtn:(BOOL)isHidden];
    }else if (type == NewPasswordInput){
        return [self initPasswordInputViewWithLeftLabelName:leftLabelStr leftImageName:leftImageStr placeholder:placeholderStr spacing:spacing leftSpacing:leftSpacing hiddenDelBtn:(BOOL)isHidden];
    }else{
        if (codeobservekey.length > 0) {
            codeObserveKey = codeobservekey;
        }
        return [self initVerificationCodeInputViewWithLeftLabelName:leftLabelStr leftImage:leftImageStr placeholder:placeholderStr spacing:spacing leftSpacing:leftSpacing hiddenDelBtn:(BOOL)isHidden];
    }
}


- (instancetype)initPasswordInputViewWithLeftLabelName:(NSString *)leftLabelStr leftImageName:(NSString *)leftImageStr placeholder:(NSString *)placeholderStr spacing:(CGFloat)spacing leftSpacing:(CGFloat)leftSpacing hiddenDelBtn:(BOOL)isHidden{
    if (self = [super init]) {
        hasObserve = NO;
        isHiddenDel = isHidden;
        _spacing = spacing;
        _leftSpacing = leftSpacing;
        _hasRightBtn = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self createLeftViewWith:leftLabelStr imageStr:leftImageStr];
        [self createRightBtn];
        [self createDelBtn];
        [self createTextFilePlaceholder:placeholderStr];
        [self createBottomLine];
        //        _inputTextFiled.secureTextEntry = YES;
    }
    return self;
}

- (instancetype)initInformationInputViewWithleftLabelName:(NSString *)leftLabelStr leftImage:(NSString *)leftImageStr placeholder:(NSString *)placeholderStr spacing:(CGFloat)spacing leftSpacing:(CGFloat)leftSpacing hiddenDelBtn:(BOOL)isHidden{
    if (self = [super init]) {
        hasObserve = NO;
        isHiddenDel = isHidden;
        _spacing = spacing;
        _leftSpacing = leftSpacing;
        self.backgroundColor = [UIColor whiteColor];
        [self createLeftViewWith:leftLabelStr imageStr:leftImageStr];
        [self createDelBtn];
        [self createTextFilePlaceholder:placeholderStr];
        [self createBottomLine];
    }
    return self;
}

- (instancetype)initVerificationCodeInputViewWithLeftLabelName:(NSString *)leftLabelStr leftImage:(NSString *)leftImageStr placeholder:(NSString *)placeholderStr spacing:(CGFloat)spacing leftSpacing:(CGFloat)leftSpacing hiddenDelBtn:(BOOL)isHidden{
    if (self = [super init]) {
        isHiddenDel = isHidden;
        _spacing = spacing;
        _leftSpacing = leftSpacing;
        _hasRightBtn = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self createLeftViewWith:leftLabelStr imageStr:leftImageStr];
        [self createVerficationCodeBtn];
        [self createDelBtn];
        [self createTextFilePlaceholder:placeholderStr];
        [self createBottomLine];
    }
    return self;
}


- (void)createLeftViewWith:(NSString *)contentStr imageStr:(NSString *)imageStr{
    if (StringHasDataJudge(contentStr)) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        if (_leftLabelColor) {
            _leftLabel.textColor = _leftLabelColor;
        }
        else
        {
            _leftLabel.textColor = UIColorRGB(31, 126, 233);
        }
        if (_leftLabelFont) {
            _leftLabel.font = _leftLabelFont;
        }
        else
        {
            _leftLabel.font = KFont(15);
        }
        
        
        [self addSubview:_leftLabel];
        _leftLabel.text = contentStr;
        [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left).offset(self.leftSpacing);
            make.bottom.equalTo(self.mas_bottom);
            make.width.mas_lessThanOrEqualTo(75);
        }];
        [self calculateLeftLabelWidth];
    }else{
        if (StringHasDataJudge(imageStr)) {
            UIImage *image = LoadImage(imageStr);
            _leftImage = [[UIImageView alloc] init];
            _leftImage.image = image;
            [self addSubview:_leftImage];
            [_leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(self.leftSpacing);
                make.centerY.equalTo(self.mas_centerY);
                
                if ([imageStr rangeOfString:@"_6"].location == NSNotFound) {
                    make.width.mas_equalTo(kWidthRace(image.size.width));
                    make.height.mas_equalTo(kWidthRace(image.size.height));
                }
                else
                {
                    make.width.mas_equalTo(kiP6WidthRace(image.size.width));
                    make.height.mas_equalTo(kiP6WidthRace(image.size.height));
                }
                
                
            }];
        }
    }
    
    
}

- (void)createBottomLine
{
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = kLastLineColor;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(self.leftSpacing);
        make.right.mas_offset(-self.leftSpacing);
        make.bottom.equalTo(self);
        make.height.mas_offset(0.5);
    }];
    
}

- (void)createDelBtn{
    
}

- (void)addHeadLineViewWithColor:(UIColor *)lineColor{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = lineColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)addFooterLineViewWithColor:(UIColor *)lineColor{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = lineColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)createRightBtn{
    if (_hasRightBtn) {
        _rightBtn = [[UIButton alloc] init];
        [_rightBtn setTitle:@"隐藏" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:kgrayTextColor forState:UIControlStateNormal];
        [_rightBtn.titleLabel setFont:KFont(13)];
        [self addSubview:_rightBtn];
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(- self.leftSpacing);
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_offset(kiP6WidthRace(28));
        }];
        @weakify(self);
        [[_rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            [self rightAction];
        }];
        
    }
}


- (void)createTextFilePlaceholder:(NSString *)placeholderStr{
    _inputTextFiled = [[UITextField alloc] init];
    _inputTextFiled.placeholder = placeholderStr;
    _inputTextFiled.delegate = self;
    if (_tfFont) {
        _inputTextFiled.font = _tfFont;
    }
    else
    {
        _inputTextFiled.font = KFont(14);
    }
    
    if (!isHiddenDel) {
        _inputTextFiled.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    [self addSubview:_inputTextFiled];
    [_inputTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.leftLabel) {
            make.left.equalTo(self.leftLabel.mas_right).offset(self.spacing);
        }
        if (self.leftImage) {
            make.left.equalTo(self.leftImage.mas_right).offset(self.spacing);
        }
        if (!self.leftImage &&  !self.leftLabel) {
            make.left.mas_offset(self.leftSpacing);
        }
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        if (self.hasRightBtn) {
            make.right.equalTo(self.rightBtn.mas_left).offset(- kiP6WidthRace(5));
        }
        else
        {
            make.right.mas_offset(- self.leftSpacing);
        }
        
        
        
    }];
    if (!isHiddenDel) {
        RAC(_delBtn,hidden) = [_inputTextFiled.rac_textSignal map:^id(NSString *text) {
            return text.length > 0 ? @(NO) : @(YES) ;
        }];
    }
    
    @weakify(self);
    [[self rac_signalForSelector:@selector(textFieldDidEndEditing:) fromProtocol:@protocol(UITextFieldDelegate)]subscribeNext:^(RACTuple *x) {
        @strongify(self);
        UITextField *tf = x.first;
        if (tf == self.inputTextFiled) {
            self.delBtn.hidden = YES;
        }
    }];
}

- (void)createVerficationCodeBtn{
    if (_hasRightBtn) {
        _rightBtn = [[UIButton alloc] init];
        [_rightBtn setTitleColor:kBlueMainColor forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = KFont(13);
        ViewRadius(_rightBtn, kiP6WidthRace(20)/2);
        _rightBtn.layer.masksToBounds = YES;
        _rightBtn.layer.borderColor = [kBlueMainColor CGColor];
        _rightBtn.layer.borderWidth = 0.5;
        [_rightBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self addSubview:_rightBtn];
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(- self.leftSpacing);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(kiP6WidthRace(20));
            make.width.mas_equalTo(kiP6WidthRace(80));
        }];
        if (codeObserveKey.length > 0) {
            [kUserMessageManager addObserver:self forKeyPath:codeObserveKey options:NSKeyValueObservingOptionNew context:nil];
        }
        
        hasObserve = YES;
    }
}

- (void)clearAction{
    _inputTextFiled.text = @"";
    _delBtn.hidden = YES;
}

- (void)rightAction{
    if (_inputTextFiled.secureTextEntry) {
        _inputTextFiled.secureTextEntry = NO;
        [_rightBtn setTitle:@"隐藏" forState:UIControlStateNormal];
    }else{
        _inputTextFiled.secureTextEntry = YES;
        [_rightBtn setTitle:@"显示" forState:UIControlStateNormal];
    }
}


- (void)calculateLeftLabelWidth{
    CGSize size = CGSizeMake(320,2000);
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attributes = @{ NSFontAttributeName : _leftLabel.font, NSParagraphStyleAttributeName : style };
    
    CGRect labelsize  = [_leftLabel.text boundingRectWithSize:size
                                                      options:opts
                                                   attributes:attributes
                                                      context:nil];
    
    [_leftLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(labelsize.size.width + 5);
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //////////////注册
    if ([keyPath isEqualToString:@"g_TimeSecond"])
    {
        NSString *StringTitle = [NSString stringWithFormat:@"%d",[kUserMessageManager g_TimeSecond]];
        _rightBtn.userInteractionEnabled = NO;
        [_rightBtn setTitle:StringTitle forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = KFont(11);
        _rightBtn.layer.borderColor = nil;
        _rightBtn.layer.borderWidth = 0;
        _rightBtn.layer.masksToBounds = NO;
        [_rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kiP6WidthRace(20));
        }];
        if (kUserMessageManager.g_TimeAnimalReset == YES) {
            [self.m_layer removeFromSuperlayer];
            self.m_layer = nil;
            isAnimating = NO;
            kUserMessageManager.g_TimeAnimalReset = NO;
        }
        //先画一个圆
        if (!self.m_layer) {
            CGRect rect = CGRectMake(0, 0, kiP6WidthRace(20), kiP6WidthRace(20));
            UIBezierPath *beizPath=[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:kiP6WidthRace(20)];
            self.m_layer=[CAShapeLayer layer];
            _m_layer.path=beizPath.CGPath;
            _m_layer.fillColor=[UIColor clearColor].CGColor;//填充色
            _m_layer.strokeColor=kBlueMainColor.CGColor;//边框颜色
            _m_layer.lineWidth=1.0f;
            _m_layer.lineCap=kCALineCapRound;//线框类型
            [_rightBtn.layer addSublayer:_m_layer];
        }
        
        if (!isAnimating) {
            isAnimating = YES;
            CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"strokeStart"];
            animation.fromValue=[NSNumber numberWithFloat:0.0f];
            animation.toValue=[NSNumber numberWithFloat:1];
            animation.duration=60.0;
            animation.delegate=self;
            animation.fillMode=kCAFillModeForwards;
            animation.removedOnCompletion=NO;
            animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            [_m_layer addAnimation:animation forKey:@"strokeStartanimation"];
        }
        
        if ([kUserMessageManager g_TimeSecond] == 0)
        {
            [_m_layer removeFromSuperlayer];
            _rightBtn.userInteractionEnabled = YES;
            [_rightBtn setTitle:@"重新发送" forState:UIControlStateNormal];
            _rightBtn.titleLabel.font = KFont(13);
            _rightBtn.layer.borderColor = kBlueMainColor.CGColor;
            _rightBtn.layer.borderWidth = 0.5;
            _rightBtn.layer.masksToBounds = YES;
            [_rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kiP6WidthRace(80));
            }];
        }
    }
    
    ////////////////////忘记密码
    if ([keyPath isEqualToString:@"g_TimeSecond_forgetKey"])
    {
        NSString *StringTitle = [NSString stringWithFormat:@"%d",[kUserMessageManager g_TimeSecond_forgetKey]];
        _rightBtn.userInteractionEnabled = NO;
        [_rightBtn setTitle:StringTitle forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = KFont(11);
        _rightBtn.layer.borderColor = nil;
        _rightBtn.layer.borderWidth = 0;
        _rightBtn.layer.masksToBounds = NO;
        [_rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kiP6WidthRace(20));
        }];
        if (kUserMessageManager.g_TimeAnimalReset_forgetKey == YES) {
            [self.m_layer removeFromSuperlayer];
            self.m_layer = nil;
            isAnimating = NO;
            kUserMessageManager.g_TimeAnimalReset_forgetKey = NO;
        }
        //先画一个圆
        if (!self.m_layer) {
            CGRect rect = CGRectMake(0, 0, kiP6WidthRace(20), kiP6WidthRace(20));
            UIBezierPath *beizPath=[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:kiP6WidthRace(20)];
            self.m_layer=[CAShapeLayer layer];
            _m_layer.path=beizPath.CGPath;
            _m_layer.fillColor=[UIColor clearColor].CGColor;//填充色
            _m_layer.strokeColor=kBlueMainColor.CGColor;//边框颜色
            _m_layer.lineWidth=1.0f;
            _m_layer.lineCap=kCALineCapRound;//线框类型
            [_rightBtn.layer addSublayer:_m_layer];
        }
        
        if (!isAnimating) {
            isAnimating = YES;
            CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"strokeStart"];
            DLog(@"%f",(1 - kUserMessageManager.g_TimeSecond_forgetKey/60.00));
            animation.fromValue=[NSNumber numberWithFloat:(1 - kUserMessageManager.g_TimeSecond_forgetKey/60.00)];
            animation.toValue=[NSNumber numberWithFloat:1];
            animation.duration=kUserMessageManager.g_TimeSecond_forgetKey;
            animation.delegate=self;
            animation.fillMode=kCAFillModeForwards;
            animation.removedOnCompletion=NO;
            animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            [_m_layer addAnimation:animation forKey:@"strokeStartanimation"];
        }
        
        if ([kUserMessageManager g_TimeSecond_forgetKey] == 0)
        {
            [_m_layer removeFromSuperlayer];
            _rightBtn.userInteractionEnabled = YES;
            [_rightBtn setTitle:@"重新发送" forState:UIControlStateNormal];
            _rightBtn.titleLabel.font = KFont(13);
            _rightBtn.layer.borderColor = kBlueMainColor.CGColor;
            _rightBtn.layer.borderWidth = 0.5;
            _rightBtn.layer.masksToBounds = YES;
            [_rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kiP6WidthRace(80));
            }];
        }
    }
    
    
    
    //////////////验证码登录
    if ([keyPath isEqualToString:@"g_TimeSecond_codeLogin"])
    {
        NSString *StringTitle = [NSString stringWithFormat:@"%d",[kUserMessageManager g_TimeSecond_codeLogin]];
        _rightBtn.userInteractionEnabled = NO;
        [_rightBtn setTitle:StringTitle forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = KFont(11);
        _rightBtn.layer.borderColor = nil;
        _rightBtn.layer.borderWidth = 0;
        _rightBtn.layer.masksToBounds = NO;
        [_rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kiP6WidthRace(20));
        }];
        if (kUserMessageManager.g_TimeAnimalReset_codeLogin == YES) {
            [self.m_layer removeFromSuperlayer];
            self.m_layer = nil;
            isAnimating = NO;
            kUserMessageManager.g_TimeAnimalReset_codeLogin = NO;
        }
        //先画一个圆
        if (!self.m_layer) {
            CGRect rect = CGRectMake(0, 0, kiP6WidthRace(20), kiP6WidthRace(20));
            UIBezierPath *beizPath=[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:kiP6WidthRace(20)];
            self.m_layer=[CAShapeLayer layer];
            _m_layer.path=beizPath.CGPath;
            _m_layer.fillColor=[UIColor clearColor].CGColor;//填充色
            _m_layer.strokeColor=kBlueMainColor.CGColor;//边框颜色
            _m_layer.lineWidth=1.0f;
            _m_layer.lineCap=kCALineCapRound;//线框类型
            [_rightBtn.layer addSublayer:_m_layer];
        }
        
        if (!isAnimating) {
            isAnimating = YES;
            CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"strokeStart"];
            animation.fromValue=[NSNumber numberWithFloat:(1 - kUserMessageManager.g_TimeSecond_codeLogin/60.00)];
            animation.toValue=[NSNumber numberWithFloat:1];
            animation.duration=kUserMessageManager.g_TimeSecond_codeLogin;
            animation.delegate=self;
            animation.fillMode=kCAFillModeForwards;
            animation.removedOnCompletion=NO;
            animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            [_m_layer addAnimation:animation forKey:@"strokeStartanimation"];
        }
        
        if ([kUserMessageManager g_TimeSecond_codeLogin] == 0)
        {
            [_m_layer removeFromSuperlayer];
            _rightBtn.userInteractionEnabled = YES;
            [_rightBtn setTitle:@"重新发送" forState:UIControlStateNormal];
            _rightBtn.titleLabel.font = KFont(13);
            _rightBtn.layer.borderColor = kBlueMainColor.CGColor;
            _rightBtn.layer.borderWidth = 0.5;
            _rightBtn.layer.masksToBounds = YES;
            [_rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kiP6WidthRace(80));
            }];
        }
    }
    
    
}

- (void)dealloc
{
    //    if (hasObserve) {
    //        if(codeObserveKey.length > 0)
    //        {
    //            [kUserMessageManager removeObserver:self forKeyPath:codeObserveKey context:nil];
    //        }
    //    }
}

#pragma mark layerdelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    DLog(@"animationDidStop");
    
    isAnimating = NO;
    self.m_layer = nil;
    
    if (flag == YES) {
        
        if ([codeObserveKey isEqualToString:@"g_TimeSecond"]) {
            kUserMessageManager.g_TimeTel = nil;
        }
        else if ([codeObserveKey isEqualToString:@"g_TimeSecond_forgetKey"])
        {
            kUserMessageManager.g_TimeTel_forgetKey = nil;
        }
        else if ([codeObserveKey isEqualToString:@"g_TimeSecond_codeLogin"]) {
            kUserMessageManager.g_TimeTel_codeLogin = nil;
        }
    }
}



- (void)deallocObserveWithKey:(NSString *)codeobservekey
{
    if(codeobservekey.length > 0)
    {
        [kUserMessageManager removeObserver:self forKeyPath:codeobservekey context:nil];
    }
}


@end

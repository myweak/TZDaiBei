//
//  PayPasswordView.m
//  PayPasswordDemo
//
//  Created by fireflies on 2018/3/31.
//  Copyright © 2018年 高磊. All rights reserved.
//

#import "PayPasswordView.h"

//密码位数
static NSInteger const kDotsNumber = 6;

//假密码点点的宽和高  应该是等高等宽的正方形 方便设置为圆
static CGFloat const kDotWith_height = 10;

@interface PayPasswordView ()<UITextFieldDelegate>

//默认密码
@property (nonatomic,strong,readonly) NSString *password;

@property (nonatomic, assign)CGRect defaultRect;

@end


@implementation PayPasswordView
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _password = @"211326";
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI:frame];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldBeginEditAction:) name:UITextFieldTextDidBeginEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidEditAction:) name:UITextFieldTextDidEndEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardDidShow:)
                                                     name:UIKeyboardDidShowNotification
                                                   object:nil];
        
    }
    return self;
}
-(void)initWithUI:(CGRect)frame
{
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.passwordField];
    
    [self addDotsViews];
    
//    [self.passwordField becomeFirstResponder];
}


#pragma mark == private method
- (void)addDotsViews
{
    //密码输入框的宽度
    CGFloat passwordFieldWidth = CGRectGetWidth(self.passwordField.frame);
    //六等分 每等分的宽度
    CGFloat password_width = passwordFieldWidth / kDotsNumber;
    //密码输入框的高度
    CGFloat password_height = CGRectGetHeight(self.passwordField.frame);
    
    for (int i = 0; i < kDotsNumber; i ++)
    {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(i * password_width, 0, 1, password_height)];
        line.backgroundColor = UIColorFromRGB(0xdddddd);
        [self.passwordField addSubview:line];
        
        //假密码点的x坐标
        CGFloat dotViewX = (i + 1)*password_width - password_width / 2.0 - kDotWith_height / 2.0;
        CGFloat dotViewY = (password_height - kDotWith_height) / 2.0;
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(dotViewX, dotViewY, kDotWith_height, kDotWith_height)];
        dotView.backgroundColor = UIColorFromRGB(0x222222);
        [dotView setCornerRadius:kDotWith_height/2.0];
        dotView.hidden = YES;
        [self.passwordField addSubview:dotView];
        [self.passwordDotsArray addObject:dotView];
    }
}

- (void)cleanPassword
{
    _passwordField.text = @"";
    
    [self setDotsViewHidden];
}

//将所有的假密码点设置为隐藏状态
- (void)setDotsViewHidden
{
    for (UIView *view in _passwordDotsArray)
    {
        [view setHidden:YES];
    }
}
-(void)keyboardDidShow:(NSNotification *)notifi
{
    DLog(@"---keyboardDidShow--");
    if (self.keyboardBeginChangeBlock) {
        self.keyboardBeginChangeBlock();
    }
}
-(void)textFieldBeginEditAction:(NSNotification *)notifi
{
    DLog(@"---textFieldBeginEditAction--");
    if (self.keyboardBeginChangeBlock) {
        self.keyboardBeginChangeBlock();
    }
}

-(void)textFieldDidEditAction:(NSNotification *)notifi
{
    if (self.keyboardEndChangeBlock) {
        self.keyboardEndChangeBlock();
    }
}

#pragma mark == UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //删除键
    if (string.length == 0)
    {
        return YES;
    }
    
    if (_passwordField.text.length >= kDotsNumber)
    {
        return NO;
    }
    
    return YES;
}

#pragma mark == event response
- (void)passwordFieldDidChange:(UITextField *)field
{
    [self setDotsViewHidden];
 
    
    for (int i = 0; i < _passwordField.text.length; i ++)
    {
        if (_passwordDotsArray.count > i )
        {
            UIView *dotView = _passwordDotsArray[i];
            [dotView setHidden:NO];
        }
    }

    if (_passwordField.text.length == 6)
    {
//        NSString *password = _passwordField.text;
//        if ([password isEqualToString:_password])
//        {
//            DLog(@" 打印信息  密码正确");
//
//        }
//        else
//        {
//            DLog(@" 密码错误，请重新输入");
//            [self cleanPassword];
//        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(inputPasswordContent:)]) {
            [self.delegate inputPasswordContent:field.text];
        }
    }
}


#pragma mark == 懒加载
- (GLTextField *)passwordField
{
    if (nil == _passwordField)
    {
        // CGRectMake(0, 10, 44 * 6, 44)
        _passwordField = [[GLTextField alloc] initWithFrame:self.bounds];
        _passwordField.delegate = (id)self;
        _passwordField.backgroundColor = [UIColor whiteColor];
        //将密码的文字颜色和光标颜色设置为透明色
        //之前是设置的白色 这里有个问题 如果密码太长的话 文字和光标的位置如果到了第一个黑色的密码点的时候 就看出来了
        _passwordField.textColor = [UIColor clearColor];
        _passwordField.tintColor = [UIColor clearColor];
        [_passwordField setBorderColor:UIColorFromRGB(0xdddddd) width:1];
        _passwordField.keyboardType = UIKeyboardTypeNumberPad;
        _passwordField.secureTextEntry = YES;
        [_passwordField addTarget:self action:@selector(passwordFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _passwordField;
}

- (NSMutableArray *)passwordDotsArray
{
    if (nil == _passwordDotsArray)
    {
        _passwordDotsArray = [[NSMutableArray alloc] initWithCapacity:kDotsNumber];
    }
    return _passwordDotsArray;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

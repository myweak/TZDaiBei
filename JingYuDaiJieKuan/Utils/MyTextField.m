//
//  MyTextField.m
//  CarpFinancial
//
//  Created by weibin on 15/12/11.
//  Copyright © 2015年 cwb. All rights reserved.
//

#import "MyTextField.h"

@interface MyTextField ()<UITextFieldDelegate>

@end

@implementation MyTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.delegate = self;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textFiledEditChanged:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (void)textFiledEditChanged:(NSNotification *)notif
{
    DLog(@">>>>>>>>>>>>>>>>");
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    DLog(@"%@     textField>>>>>",textField.text);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //明文切换密文后避免被清空
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField == self && textField.isSecureTextEntry) {
        textField.text = toBeString;
        return NO;
    }
    return YES;
}

- (void)deleteBackward
{
    [super deleteBackward];
    
    if (_keyBoardDelegate && [_keyBoardDelegate respondsToSelector:@selector(deleteBackward)])
    {
        [_keyBoardDelegate deleteBackward];
    }
}

@end

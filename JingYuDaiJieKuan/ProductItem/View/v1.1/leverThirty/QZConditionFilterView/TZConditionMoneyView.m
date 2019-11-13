//
//  TZConditionMoneyView.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/7.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZConditionMoneyView.h"

@implementation TZConditionMoneyView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.userInteractionEnabled = YES;
    @weakify(self)
    [self.allMoneyLabel handleTap:^(CGPoint loc, UIGestureRecognizer *tapGesture) {
        @strongify(self)
        !self.backTapBtnActionBlock ?:self.backTapBtnActionBlock(self.allMoneyLabel.text);
    }];
    self.textField.delegate =self;
    [self.textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self handleTap:^(CGPoint loc, UIGestureRecognizer *tapGesture) {
        @strongify(self)
        [self.textField becomeFirstResponder];
    }];
}


-(void)textFieldChange:(UITextField *)textField{
    CGFloat text = [textField.text floatValue];
    if (text>0 && text<0.1) {
        textField.text = @"0.1";
        showMessage(@"最小筛选金额0.1万元");
    }else if (text>1000) {
        textField.text = @"1000";
        showMessage(@"最高筛选金额1000万元");
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    if (checkStrEmty(text)) {
//        return YES;
//    }
//    NSError *error;
//    // @"^[0-9]*$"
//    NSString *press = @"(([0]|(0[.]\\d{0,3}))|([1-9]\\d{0,6}(([.]\\d{0,2})?)))?";
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:press options:0 error:&error];
//
//    if (!error) {
//        NSTextCheckingResult *match = [regex firstMatchInString:text options:0 range:NSMakeRange(0, [text length])];
//        if (!match )  {
//            return NO;
//        }
//    }
    return YES;
//    return [text inputShouldNumberText];

}


- (IBAction)tapBtnAction:(id)sender {
    NSString *title = self.textField.text;
    if ([self.textField.text floatValue] <0.1) {
        showMessage(@"最低筛选金额0.1万元");
        return;
    }
    !self.backTapBtnActionBlock ?:self.backTapBtnActionBlock(title);
    
}



-(void)dismiss
{
    [UIView animateWithDuration:0.1 animations:^{
        self.height=0;
    }];
}

@end

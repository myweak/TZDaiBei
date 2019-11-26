//
//  TZProductLinebackBankHeadView.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/2.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZProductLinebackBankHeadView.h"

@implementation TZProductLinebackBankHeadView
- (void)awakeFromNib{
    [super awakeFromNib];
    
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.moneyTextField.placeholder attributes:@{NSForegroundColorAttributeName:UIColorRGBA(255, 255, 255, 0.5),NSFontAttributeName:self.moneyTextField.font}];
        self.moneyTextField.attributedPlaceholder = attrString;
    [self.moneyTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:(UIControlEventEditingChanged)];
    self.moneyTextField.delegate = self;
    
}
-(void)textFieldChange:(UITextField *)textField{
    CGFloat text = [textField.text floatValue];
   if (text>100000000) {
        textField.text = @"100000000";
        showMessage(@"最高可贷额度为100000000元");
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (checkStrEmty(text)) {
        return YES;
    }
    return [NSString JudgeWithdawalMoney:text];
}

- (IBAction)tapBtnAcion:(id)sender {
    !self.backBtnTapAction ?:self.backBtnTapAction((UIButton *)sender);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

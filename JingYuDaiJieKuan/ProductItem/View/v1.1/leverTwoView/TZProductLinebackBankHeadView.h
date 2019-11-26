//
//  TZProductLinebackBankHeadView.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/2.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZXibNibView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TZProductLinebackBankHeadView : TZXibNibView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
@property (nonatomic, copy) void (^backBtnTapAction)(UIButton *btn);
@end

NS_ASSUME_NONNULL_END

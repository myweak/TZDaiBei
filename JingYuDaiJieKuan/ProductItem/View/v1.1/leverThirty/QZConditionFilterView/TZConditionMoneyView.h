//
//  TZConditionMoneyView.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/7.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZXibNibView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TZConditionMoneyView : TZXibNibView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *allMoneyLabel;

@property (nonatomic, copy) void(^backTapBtnActionBlock)(NSString *title);

-(void)dismiss;
@end

NS_ASSUME_NONNULL_END

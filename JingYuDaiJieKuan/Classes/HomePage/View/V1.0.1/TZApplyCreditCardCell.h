//
//  TZApplyCreditCardCell.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/12/17.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TZApplyCreditCardCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabelA;
@property (weak, nonatomic) IBOutlet UILabel *tagLabelB;
@property (weak, nonatomic) IBOutlet UILabel *tagLabelC;
@property (weak, nonatomic) IBOutlet UILabel *tagLabelD;
@property (weak, nonatomic) IBOutlet UILabel *tagLabelE;
@property (nonatomic, copy) void (^backTapBtnActionBlock)(UIButton *btn);
@end

NS_ASSUME_NONNULL_END

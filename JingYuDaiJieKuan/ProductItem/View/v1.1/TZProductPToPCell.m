//
//  TZProductPToPCell.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/1.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZProductPToPCell.h"

@interface TZProductPToPCell ()
@property (weak, nonatomic) IBOutlet UIImageView *linshiImageView;

@end

@implementation TZProductPToPCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.linshiImageView.hidden = ![TZUserDefaults getBoolValueInUDWithKey:KCheck_app];
}

- (IBAction)leftTapAcion:(id)sender {
    !self.backBtnTapAcionBlock ?: self.backBtnTapAcionBlock(0);
}

- (IBAction)rightTapAcion:(id)sender {
    !self.backBtnTapAcionBlock ?: self.backBtnTapAcionBlock(1);

}
- (IBAction)rightBottomTapAcion:(id)sender {
    if ([TZUserDefaults getBoolValueInUDWithKey:KCheck_app]) {
        return;
    }
    !self.backBtnTapAcionBlock ?: self.backBtnTapAcionBlock(2);

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

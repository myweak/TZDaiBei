//
//  TZMyFutureMoneyDetailCommentCell.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/30.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZMyFutureMoneyDetailCommentCell.h"

@implementation TZMyFutureMoneyDetailCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.selected = YES;
    NSString *key = @"银行下款短信";
    self.notifyLabel.keywords = key;
    self.notifyLabel.keywordsColor = UIColorHex(@"#db4848");
    self.notifyLabel.underlineStr = key;
    [self.notifyLabel reloadUIConfig];
    self.starView.delegate = self;
    self.commentTextView.placeholder = @"对本次服务还满意吗？留下你的宝贵意见吧";
    @weakify(self)
   __weak NAAssetsManager *assetManager = [NAAssetsManager shareManager];
    assetManager.maxPhotoNum = 1;
    assetManager.didFinishPickAssetsBlock = ^{
        @strongify(self)
        [assetManager getImageWithAsserts:[assetManager.currentAssets objectAtIndex:0] size:self.photoImageView.size completion:^(UIImage *image, NSData *imageData) {
            [self.photoImageView setImage:image];
        }];        
    };
    [self.photoImageView handleTap:^(CGPoint loc, UIGestureRecognizer *tapGesture) {
        [assetManager showImagePickerSheet];
    }];
}

-(void)starSliderMoveWithCurrentNum:(int)starNum{
    NSString *title = @"";
    if (starNum == 1) {
        title = @"非常不满意";
    }else if (starNum == 2) {
        title = @"不满意";
    }else if (starNum == 3) {
        title = @"一般";
    }else if (starNum == 4) {
        title = @"不满意";
    }else if (starNum == 5) {
        title = @"非常满意";
    }
    self.starLabel.text = title;
    !self.backOnTapAction ? :self.backOnTapAction(starNum);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  AdWebViewController.h
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/5.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "BaseWebViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AdWebViewController : BaseWebViewController

- (void)showWebWithURL:(NSString *)url
        andProductIcon:(NSString *)icon
   andProductMaxAmount:(NSString *)maxAmount
  andProductMerchartid:(NSString *)merchartid
        andProductName:(NSString *)name
        andProductTags:(NSString *)tags
       andProductTitle:(NSString *)title
         andProductUrl:(NSString *)productUrl
       andFromPosition:(NSString *)fromPosition
  andIsNeedSaveHistory:(BOOL)isNeedSaveHistory
   withSuperController:(UIViewController *)superVC;

@end

NS_ASSUME_NONNULL_END

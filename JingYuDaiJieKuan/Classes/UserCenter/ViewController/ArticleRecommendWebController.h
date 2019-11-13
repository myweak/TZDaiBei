//
//  ArticleRecommendWebController.h
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/29.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "BaseWebViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArticleRecommendWebController : BaseWebViewController

- (void)showWebWithURL:(NSString *)url
        andTitle:(NSString *)title
       andFromPosition:(NSString *)fromPosition
   withSuperController:(UIViewController *)superVC;

@end

NS_ASSUME_NONNULL_END

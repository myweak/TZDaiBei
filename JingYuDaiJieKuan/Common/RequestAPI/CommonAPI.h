//
//  CommonAPI.h
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/4.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonAPI : NSObject
/**  版本升级更新接口 */
UIKIT_EXTERN NSString *const appUpdatePath;

/**  （首页，贷款大全，我的）三个页面的弹窗和悬浮广告获取接口,1-首页|2-贷款大全|3-我的 */
UIKIT_EXTERN NSString *const advDialogPath;

@end

NS_ASSUME_NONNULL_END

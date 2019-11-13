//
//  HomeMainViewModel.h
//  JingYuDaiJieKuan
//
//  Created by JY on 2019/6/3.
//  Copyright © 2019年 Jincaishen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeMainViewModel : NSObject

@property (nonatomic, strong) NSString *m_codeText;

@property (nonatomic, strong) RACSignal *m_codeInputSignal;

- (void)bindKeyInputSignal;

@property (strong ,nonatomic) RACCommand *appVersionCommand;
-(void)bindAppVersionCommandWithSuccess:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

@property (strong ,nonatomic) RACCommand *systemAdsCommand;
-(void)systemAdsCommandWithSuccess:(HttpSuccessBlock)success failure:
    (HttpFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END

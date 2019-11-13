//
//  HomeMainViewModel.m
//  JingYuDaiJieKuan
//
//  Created by JY on 2019/6/3.
//  Copyright © 2019年 Jincaishen. All rights reserved.
//

#import "HomeMainViewModel.h"

@implementation HomeMainViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)bindKeyInputSignal
{
    @weakify(self);

    [_m_codeInputSignal subscribeNext:^(id x) {
        @strongify(self);
        self.m_codeText = x;
    }];
}


-(void)bindAppVersionCommandWithSuccess:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    self.appVersionCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [[HttpManager requestWithPropertyEntity:[HomeAPIParameter getAppVersion]]doNext:success];
    }];
    [self.appVersionCommand.errors subscribeNext:failure];
    
}


-(void)systemAdsCommandWithSuccess:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    self.systemAdsCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [[HttpManager requestWithPropertyEntity:[HomeAPIParameter getySystemAdsWithCode:self.m_codeText]]doNext:success];
    }];
    [self.systemAdsCommand.errors subscribeNext:failure];
    
}

@end

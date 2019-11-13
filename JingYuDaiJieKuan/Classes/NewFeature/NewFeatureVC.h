//
//  NewFeatureVC.h
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/8.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "SuperVC.h"
#import "HomePageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewFeatureVC : SuperVC

//@property(nonatomic,strong)NSArray *imageNames;

//@property(nonatomic,strong)StartBannerModel *model;

- (void)initWithModel: (StartBannerModel *)model
              andSkip:(void (^)(void))skipBlock
             andEnter:(void (^)(void))enterBlock;
//
//-(void)requestUpdateVersionPath:(NSString *)path
//                         params:(NSMutableDictionary *)params
//                         target:(id)target
//                        success:(void (^)(LnitialModel *model))success
//                        failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END

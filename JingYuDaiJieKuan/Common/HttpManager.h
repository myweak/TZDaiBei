//
//  HttpManager.h
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/22.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusModel.h"
#import "HttpPropertyEntity.h"

typedef void (^HttpSuccessBlock)(id model);

typedef void (^HttpSuccessResponseBlock)(id model);

typedef void (^HttpFailureBlock)(NSError *error);

@interface HttpManager : NSObject

@property (nonatomic,strong)Class responseObject;
//请求回调时指定的线程,不指定的话就是主线程
@property (nonatomic, strong, nullable) dispatch_queue_t completionQueue;

SINGLETON_FOR_HEADER(HttpManager)

-(NSUInteger)getWithPath:(NSString *)api
                  params:(NSDictionary *)params
                 success:(HttpSuccessBlock)success
                 failure:(HttpFailureBlock)failure;

-(NSUInteger)getWithPath:(NSString *)api
                  params:(NSDictionary *)params
             customClass:(HttpPropertyEntity *)entity
                 success:(HttpSuccessBlock)success
                 failure:(HttpFailureBlock)failure;

-(NSUInteger)postWithPath:(NSString *)api
                   params:(NSDictionary *)params
          isNotEncryption:(BOOL)isNotEncryption
              customClass:(HttpPropertyEntity *)entity
                  success:(HttpSuccessResponseBlock)success
                  failure:(HttpFailureBlock)failure;

-(NSUInteger)sendMediaWithPath:(NSString *)api
                        params:(NSDictionary *)params
                        medias:(id)medias
                       success:(HttpSuccessBlock)success
                       failure:(HttpFailureBlock)failure;

+(RACSignal *)requestWithPropertyEntity:(HttpPropertyEntity *)entity ;
+(AFSecurityPolicy *)customSecurityPolicy;

/**
 *  上传图片
 *
 *  @param image   要上传的image
 *  @param show    是否显示菊花器
 *  @param success 成功 或 失败 回调
 */

- (void) uploadOSSServicesImage:(UIImage *)image
                        showHUD:(BOOL)show
                        success:(void (^)(id, BOOL))success;
@end

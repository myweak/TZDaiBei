//
//  HttpManager.m
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/22.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "HttpManager.h"
#import <AFNetworking/AFNetworking.h>
#import "DesEncrypt.h"
#import "DataHelper.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import "HUDManager.h"
#import "NetworkAddressType.h"
#import "StatusModel.h"
#import "MessageCenterModel.h"
#import "HomeFourEarningsModel.h"


#define kRequestTimeOut 60

@interface HttpManager ()
@property (strong ,nonatomic)AFHTTPSessionManager *sessionManager;
@property (copy ,nonatomic) NSString *footUrl;
@end

@implementation HttpManager

SYNTHESIZE_SINGLETON_ARC_FOR_CLASS(HttpManager);

// 见过蠢的，就是没见过这么蠢，无力吐槽
-(instancetype)init
{
    if (self = [super init]) {
        //        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:SERVER_URL]];
        //        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",nil];
        [_sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
    }
    return self;
}

- (void)setCompletionQueue:(dispatch_queue_t)completionQueue{
    _completionQueue = completionQueue;
    _sessionManager.completionQueue = completionQueue;
}

+(RACSignal *)requestWithPropertyEntity:(HttpPropertyEntity *)entity
{
    if (entity.requestType == 0) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:entity.param];
        NSDictionary *md_dict = dict[@"md_param"];
        [dict removeObjectForKey:@"md_param"];
        entity.param = dict;
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            
            [[HttpManager sharedHttpManager] getWithPath:entity.requestApi params:entity.param  success:^(id JSON) {
                id object = [entity.responseObject yy_modelWithJSON:JSON];
                
                [subscriber sendNext:object];
                [subscriber sendCompleted];
                if (md_dict) {
                    [[HttpManager sharedHttpManager] postWithPath:@"app.stats" params:md_dict isNotEncryption:entity.isNotEncryption success:^(id model) {
                        
                    } failure:^(NSError *error) {
                        
                    }];
                }
                
            } failure:^(NSError *error) {
                [subscriber sendError:error];
            }];
            return nil;
        }];
    }else if (entity.requestType == 1)
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:entity.param];
        NSDictionary *md_dict = dict[@"md_param"];
        [dict removeObjectForKey:@"md_param"];
        entity.param = dict;
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [[HttpManager sharedHttpManager] postWithPath:entity.requestApi params:entity.param  isNotEncryption:entity.isNotEncryption  success:^(id JSON) {
                DLog("%@---%@-----\nclass===%@",entity.requestApi,JSON,[entity.responseObject class]);
                id object = [entity.responseObject yy_modelWithJSON:JSON];
                if ([NSStringFromClass(entity.responseObject) isEqualToString:@"HomeFourEarningsModel"] ) {
                    ((HomeFourEarningsModel *)object).productCode = [entity.param objectForKey:@"productcode"];
                }
                [subscriber sendNext:object];
                
                [subscriber sendCompleted];
                if (md_dict) {
                    
                    [[HttpManager sharedHttpManager] postWithPath:@"app.stats" params:md_dict isNotEncryption:entity.isNotEncryption success:^(id model) {
                        
                    } failure:^(NSError *error) {
                        
                    }];
                }
                
                
            } failure:^(NSError *error) {
                if ([NSStringFromClass(entity.responseObject) isEqualToString:@"HomeFourEarningsModel"] ) {
                    error = [NSError errorWithDomain:[entity.param objectForKey:@"productcode"] code:1001 userInfo:nil];
                }
                [subscriber sendError:error];
            }];
            return nil;
        }];
    }else
    {
        return  nil;
    }
}



-(NSUInteger)getWithPath:(NSString *)api
                  params:(NSDictionary *)params
             customClass:(HttpPropertyEntity *)entity
                 success:(HttpSuccessBlock)success
                 failure:(HttpFailureBlock)failure
{
    NSString *requestUrl = [self returnHttpUrlString:api];
    _sessionManager.requestSerializer.timeoutInterval = kRequestTimeOut;
    NSURLSessionDataTask *dataTask = [_sessionManager GET:requestUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DLog(@"Get方法名--\nmethod = %@\n",api);
        NSData *responseData;
        if ([api isEqualToString:@"img.verify.create"]) {
            responseData = responseObject;
            
        }else{
            responseData = [responseObject yy_modelToJSONData];
            
        }
        
        //        id dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //
        NSString *josn = [responseObject yy_modelToJSONString];
        DLog(@"\nrequestUrl= %@ ,\n------>api= %@ ,\njson=%@",requestUrl,api,josn);
        
        //        id dict = [HttpManager ensResponseData:responseData];
        if ([responseObject isKindOfClass:[NSError class]]) {
            failure(responseObject);
        }else
        {
            if ([api isEqualToString:@"img.verify.create"]) {
                success(responseObject);
            }else{
                
                id obj = [entity.responseObject yy_modelWithJSON:responseObject];
                success(obj);
            }
        }
        
        
        
        //        id dict = [HttpManager ensResponseData:responseObject];
        
        //
        //        if ([[responseObject valueForKey:@"code"] intValue] != 200 ) {
        ////            failure(responseData);
        //        }else
        //        {
        ////            success(responseData);
        //        }
        //
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        
    }];
    
    return dataTask.taskIdentifier;
}
-(NSUInteger)getWithPath:(NSString *)api
                  params:(NSDictionary *)params
                 success:(HttpSuccessBlock)success
                 failure:(HttpFailureBlock)failure
{
    NSString *requestUrl = [self returnHttpUrlString:api];
    _sessionManager.requestSerializer.timeoutInterval = kRequestTimeOut;
    NSURLSessionDataTask *dataTask = [_sessionManager GET:requestUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        id dict = [HttpManager ensResponseData:[responseObject yy_modelToJSONData]];
        if ([dict isKindOfClass:[NSError class]]) {
            failure(dict);
        }else
        {
            success(dict);
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        
    }];
    
    return dataTask.taskIdentifier;
}


-(NSUInteger)postWithPath:(NSString *)api params:(NSDictionary *)params isNotEncryption:(BOOL)isNotEncryption success:(HttpSuccessBlock)success  failure:(HttpFailureBlock)failure
{
    NSString *requestUrl = [self returnHttpUrlString:api];
    _sessionManager.requestSerializer.timeoutInterval = kRequestTimeOut;
    [_sessionManager.requestSerializer setValue:[self setupHttpHeaderStringWithUrl:requestUrl] forHTTPHeaderField:@"code"];
    if (!isNotEncryption) {
        if (params) {
            
            params = [HttpManager postParamEncryption:params footUrl:api];
            
        }else
        {
            
            params = [DataHelper setupPostParams:params footUrl:api];
        }
    }
    
    NSURLSessionDataTask *dataTask = [_sessionManager POST:requestUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dict = [HttpManager ensResponseData:responseObject];
        if ([dict isKindOfClass:[NSError class]]) {
            failure(dict);
        }else
        {
            success(dict);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog("%@",error.description);
        failure(error);
        
    }];
    
    return dataTask.taskIdentifier;
}


-(NSUInteger)sendMediaWithPath:(NSString *)api params:(NSDictionary *)params medias:(id)medias success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    _sessionManager.requestSerializer.timeoutInterval = kRequestTimeOut * 1.5;
    
    NSURLSessionDataTask *dataTask = [ _sessionManager POST:api parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (UIImage *image in medias) {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.7) name:@"" fileName:@"identiferCard.jpg" mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        
    }];
    
    return dataTask.taskIdentifier;
}


#pragma mark 地址初始化
-(NSString *)returnHttpUrlString:(NSString *)api
{
    NSMutableString *urlStr;
    //    if (isTrueEnvironment)
    //    {
    urlStr = [[NSMutableString alloc]initWithString:SERVER_URL];
    if (![urlStr hasSuffix:@"/"]) {
        [urlStr appendString:@"/"];
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",urlStr,api];
    _footUrl = url;
    //        if (api) {
    //            [urlStr appendFormat:@"%@",api];
    //        }
    //    }else
    //    {
    //        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"NetworkEnvironment" ofType:@"plist"];
    //
    //        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    //
    //        NSString *url;
    //
    //        NSString *netType = [[NSUserDefaults standardUserDefaults] objectForKey:@"NetworkEnvironmentType"];
    //        //    HTTPS_type = [netType integerValue]+ 1;
    //        if([netType integerValue] == CPDevType)
    //        {
    //            url = dic[@"NetworkEnvironmentDev"];
    //            _httpsType = 1;
    //        }
    //        else if ([netType integerValue] == CPTestType)
    //        {
    //            url = dic[@"NetworkEnvironmentJinr"];
    //            _httpsType = 2;
    //
    //        }
    //        else if ([netType integerValue] == CPOnlineType)
    //        {
    //            url = dic[@"NetworkEnvironmentNpre"];
    //            _httpsType = 3;
    //
    //        }
    //        else if ([netType integerValue] == CPLineType)
    //        {
    //            url = dic[@"NetworkEnvironmentPre"];
    //            _httpsType = 4;
    //
    //        }
    //
    //        urlStr = [[NSMutableString alloc]initWithString:url];
    //        if (![urlStr hasSuffix:@"/"]) {
    //            [urlStr appendString:@"/"];
    //        }
    //
    //        _footUrl = api;
    //
    //        [PublicMethodManager footUrl:_footUrl];
    ////        if (api) {
    ////            [urlStr appendFormat:@"%@",api];
    ////        }
    //
    //    }
    return url;
}



/**
 *  设置请求头code的字段数据
 *
 *  @param url
 *
 *  @return
 */
-(NSString *)setupHttpHeaderStringWithUrl:(NSString *)url
{
    NSDate *requestDate = [NSDate date];
    NSTimeInterval timestamp=[requestDate timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%0.f", timestamp];
    
    NSString *stringCode = [NSString stringWithFormat:@"%@%@%@",[OpenUDID value],url,timeString];
    
    NSDictionary *dataDictory = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 stringCode,@"code",nil];
    return [HttpManager paramsTransFromDES:dataDictory];
    
}

#pragma mark post  数据加密
+(NSDictionary *)postParamEncryption:(NSDictionary *)param footUrl:(NSString *)footUrl
{
    return [DataHelper setupPostParams:param footUrl:footUrl];
    //    return @{@"sign":[HttpManager MD5:[HttpManager jsonString:param]],@"data":[HttpManager jsonString:param]};
    
}

+ (NSString *)jsonString:(id)objc {
    NSData *data = [NSJSONSerialization dataWithJSONObject:objc options:nil error:nil];
    return [[NSString alloc] initWithData:data
                                 encoding:NSUTF8StringEncoding];
}
+ (NSString *)MD5:(NSString *)string  {
    
    NSString *md51 = @"98040e3735acce4080a5b021de4f030f";
    md51 = [NSString stringWithFormat:@"%@%@",string,md51];
    
    return [[HttpManager md5:md51] uppercaseString];
}

+ (NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15] ];
}

#pragma mark 加密字典
+(NSString *)paramsTransFromDES:(NSDictionary *)desDictionary
{
    NSMutableString *stringJson =  [[NSMutableString alloc] initWithString:[DataHelper dictionaryToJson:desDictionary]];
    
    NSUInteger zhengshu=stringJson.length / 8;
    NSUInteger yushu=stringJson.length % 8;
    
    if (yushu!=0)
    {
        NSUInteger cha=( zhengshu + 1) * 8 - stringJson.length;
        for (NSUInteger i = 0; i < cha; i++) {
            [stringJson appendString:@" "];
        }
    }
    const char *charDes = [DesEncrypt sharedDesEncrypt]->encryptText([stringJson UTF8String]);
    NSString * stringDes = [[NSString alloc] initWithUTF8String:charDes];
    
    return stringDes;
}

#pragma mark 解密请求回来参数
+(id)ensResponseData:(NSData *)responseData
{
    NSDictionary *responseDistionary = nil;
    if (responseData) {
        NSError *error = nil;
        responseDistionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            DLog(@"请求数据问题====%@",error);
            return error;
        }
    }else
    {
        return  nil;
    }
    if (responseDistionary != nil && [responseDistionary isKindOfClass:[NSDictionary class]]) {
        
        BOOL is_encry = [[responseDistionary objectForKey:@"is_encry"]boolValue];
        if (is_encry) {
            NSString *cipherJSON = [responseDistionary objectForKey:@"cipher"];
            if (cipherJSON != nil) {
                const char *stringData = [DesEncrypt sharedDesEncrypt]->decryptText([cipherJSON UTF8String]);
                NSString * strNSString = [[NSString alloc] initWithUTF8String:stringData];
                DLog(@"json=%@",strNSString);
                NSData *jsonData = [strNSString dataUsingEncoding:NSUTF8StringEncoding];
                if (jsonData) {
                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                    return dict;
                }
            }
        }else
        {
            NSString *json = [HttpManager jsonString:responseDistionary];
            DLog(@"json=%@",json);
            if ([[responseDistionary valueForKey:@"code"]intValue] == 105002 || [[responseDistionary valueForKey:@"code"]intValue] == 105001) {// 105001：token 错误 ； 105001：token失效
                [kUserMessageManager removeDataWhenLogout];
                
                if ([kUserMessageManager checkUserLoginAndLoginWithEventkey:nil]) {
                    
                }
            }
            // 这里可能不要了
            else if ([[responseDistionary valueForKey:@"code"]intValue] == 1000503 || [[responseDistionary valueForKey:@"code"]intValue] == 1000501) {
                [kUserMessageManager removeDataWhenLogout];
                
                if ([kUserMessageManager checkUserLoginAndLoginWithEventkey:nil]) {
                    
                }
            }else if ([[responseDistionary valueForKey:@"code"]intValue] == 1000301){
                
                //                [[NSNotificationCenter defaultCenter]postNotificationName:@"isBanktype" object:nil];
                
            }
            return responseDistionary;
        }
    }
    return  responseDistionary;
}
#pragma mark https
+(AFSecurityPolicy *)customSecurityPolicy{
    
    NSString *cerPath = nil;//证书的路径
    if (HTTPS_type == 1) {
        cerPath = [[NSBundle mainBundle] pathForResource:@"jrdev32_jingyubank_Develop" ofType:@"cer"];
    }else if (HTTPS_type == 2){
        cerPath = [[NSBundle mainBundle] pathForResource:@"api_jinr_Public" ofType:@"cer"];
    }else if (HTTPS_type == 3){
        cerPath = [[NSBundle mainBundle] pathForResource:@"apinpre_jinr_com" ofType:@"cer"];
    }else
    {
        cerPath = [[NSBundle mainBundle] pathForResource:@"apipre_jinr_PublicTest" ofType:@"cer"];
    }
    if (cerPath == nil) {
        return nil;
    }
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = NO;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];
    
    return securityPolicy;
}

#pragma mark ---------------
-(NSUInteger)postWithPath:(NSString *)api
                   params:(NSDictionary *)params
          isNotEncryption:(BOOL)isNotEncryption
              customClass:(HttpPropertyEntity *)entity
                  success:(HttpSuccessResponseBlock)success
                  failure:(HttpFailureBlock)failure
{
    // begin 04.19
    Reachability * reach = [Reachability reachabilityForInternetConnection];
    DLog(@"---网络-----%ld",reach.currentReachabilityStatus);
    if (reach.currentReachabilityStatus == NotReachable ) {
        NSDictionary *dict = @{@"code":@"1000500",@"msg":kloadfailedNotNetwork};
        id obj = [entity.responseObject yy_modelWithJSON:dict];
        success(obj);
        return 0;
    }
    // end
    
    // 请求 url 的切换
    NSString *configureType = @"";
#if isTrueEnvironment
    // 发布
    configureType = @"NetworkEnvironmentPublish";
#else
    configureType = @"NetworkEnvironmentJinrDev";
#endif
    NSMutableString *urlStr;
    //    if (isTrueEnvironment)
    //    {
    urlStr = [[NSMutableString alloc]initWithString:SERVER_URL];
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",urlStr,api];
    //    NSString *requestUrl = [NetworkAddressType configureRequestBaseURLType:urlStr];
    _sessionManager.requestSerializer.timeoutInterval = kRequestTimeOut;
    if ([api isEqualToString:@"img.verify.create"]) {
        _sessionManager.responseSerializer = [AFImageResponseSerializer serializer];
    }
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain",@"image/png",@"text/javascript",nil];
    [_sessionManager.requestSerializer setValue:kChannel forHTTPHeaderField:@"channel"];
    [_sessionManager.requestSerializer setValue:kApp_Version forHTTPHeaderField:@"version"];
    [_sessionManager.requestSerializer setValue:kClientType forHTTPHeaderField:@"clientType"];
    [_sessionManager.requestSerializer setValue:[kUserMessageManager getUserToken] forHTTPHeaderField:@"token"];
    [_sessionManager.requestSerializer setValue:kTplKey forHTTPHeaderField:@"tplKey"];
    
    if (!isNotEncryption) {
        
        params = [HttpManager postParamEncryption:params footUrl:api];
    }
    __block NSString *methodString  = api;
    NSString *jsonStr = [params yy_modelToJSONString];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    NSURLSessionDataTask *dataTask = [_sessionManager POST:requestUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DLog(@"POST方法名--\nmethod = %@\n",methodString);
        NSData *responseData;
        if ([api isEqualToString:@"img.verify.create"]) {
            responseData = responseObject;
            
        }else{
            responseData = [responseObject yy_modelToJSONData];
            
        }
        
        //        id dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //
        NSString *josn = [responseObject yy_modelToJSONString];
        DLog(@"\nrequestUrl= %@ ,\n------>api= %@ ,\nparams=%@ ,\njson=%@",requestUrl,api,jsonStr,josn);
        
        id dict = [HttpManager ensResponseData:responseData];
        if ([responseObject isKindOfClass:[NSError class]]) {
            failure(responseObject);
        }else
        {
            if ([api isEqualToString:@"img.verify.create"]) {
                success(responseObject);
            }else{
                
                id obj = [entity.responseObject yy_modelWithJSON:responseObject];
                success(obj);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog("error=%@--\nmethod = %@",error.description,methodString);
        failure(error);
        
    }];
    
    return dataTask.taskIdentifier;
}



-(void)dealloc
{
    DLog(@"*******释放==%s==*********",object_getClassName(self));
}

@end

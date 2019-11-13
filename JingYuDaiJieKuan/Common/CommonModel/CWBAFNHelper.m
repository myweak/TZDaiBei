//
//  CWBAFNHelper.m
//  CPMerchant
//
//  Created by weibin on 16/9/2.
//  Copyright © 2016年 cwb. All rights reserved.
//

#import "CWBAFNHelper.h"
#import "AFNetworking.h"
#import "HUDManager.h"
#import "SuperVC.h"
#import "UUIDHelper.h"
#import "AESCrypt.h"
#import <CommonCrypto/CommonDigest.h>

#define kHUDTime 20

@implementation CWBAFNHelper

static CWBNetworkStatus _status;
static BOOL _isNetwork;

#pragma mark - 开始监听网络
+ (void)startMonitoringNetwork
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown:
                _status ? _status(CWBAFNStatusUnknown) : nil;
                _isNetwork = NO;
                DLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                _status ? _status(CWBAFNStatusNotReachable) : nil;
                _isNetwork = NO;
                DLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                _status ? _status(CWBAFNStatusReachableViaWWAN) : nil;
                _isNetwork = YES;
                DLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                _status ? _status(CWBAFNStatusReachableViaWiFi) : nil;
                _isNetwork = YES;
                DLog(@"WIFI");
                break;
        }
    }];
    
    [manager startMonitoring];
}

+ (void)checkNetworkStatusWithBlock:(CWBNetworkStatus)status
{
    status ? _status = status : nil;
}

+ (BOOL)currentNetworkStatus
{
    return _isNetwork;
}

static AFHTTPSessionManager *_manager;

//单例
+ (AFHTTPSessionManager *)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
        [_manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", nil]];
    });
    
    return _manager;
}

- (instancetype)init
{
    if ((self = [super init]))
    {
        _manager = [AFHTTPSessionManager manager];
        [_manager.requestSerializer setTimeoutInterval:kHUDTime];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//        [_manager.requestSerializer setHTTPShouldUsePipelining:YES];
        AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;
        _manager.responseSerializer = response;
        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
//        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    return self;
}

//+ (AFHTTPSessionManager *)sharedManager
//{
//    _manager = [AFHTTPSessionManager manager];
//    [_manager.requestSerializer setTimeoutInterval:kHUDTime];
//    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    return _manager;
//}

#pragma mark - 请求有缓存
+ (AFHTTPSessionManager *)postDataResponsePath:(NSString *)path
                                        params:(NSMutableDictionary *)params
                                        isPost:(BOOL)isPost
                                    networkHUD:(NetworkHUD)networkHUD
                                 responseCache:(HttpRequestCache)responseCache
                                        target:(id)target
                                       success:(void (^)(id responseObject))success
                                       failure:(void (^)(NSError *error))failure
{
    return [self postDataResponsePath:path urlHostType:1 params:params isPost:isPost isRefresh:NO networkHUD:networkHUD responseCache:responseCache target:target success:success failure:failure];
}

#pragma mark - 带其他路径 urlHostType:字段串类型 方便扩展 1:正常url 2：深圳url
+ (AFHTTPSessionManager *)postDataResponsePath:(NSString *)path
                                   urlHostType:(NSInteger)urlHostType
                                        params:(NSMutableDictionary *)params
                                        isPost:(BOOL)isPost
                                     isRefresh:(BOOL)isRefresh
                                    networkHUD:(NetworkHUD)networkHUD
                                 responseCache:(HttpRequestCache)responseCache
                                        target:(id)target
                                       success:(void (^)(id responseObject))success
                                       failure:(void (^)(NSError *error))failure
{
    
    [self sharedManager].requestSerializer.timeoutInterval = 15.f;
    
    [[self sharedManager].responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain",@"text/html", nil]];

    if (networkHUD > 2 && !isRefresh)
    {
        [HUDManager showHUD:MBProgressHUDModeCustomView onTarget:target hide:YES afterDelay:kHUDTime enabled:NO message:@""];
    }
    
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.requestSerializer.timeoutInterval = kHUDTime;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"NetworkEnvironment" ofType:@"plist"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    NSString *url;
    
    url = @"http://baike.baidu.com/api";
//    url = [NSString stringWithFormat:@"%@/%@",url,path];
    path = [NSString stringWithFormat:@"%@/%@",url,path];
    // 鉴权
//    params = [self addGETBaseParameter:params path:url urlHostType:urlHostType];
    
    DLog(@"url==%@/\nparams==%@\n",url,params);
    
    if(isPost)
    {
        kSelfWeak;
        
        [[self sharedManager] POST:[[NSURL URLWithString:[NSString stringWithFormat:@"%@",url] relativeToURL:[self sharedManager].baseURL] absoluteString] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (!responseObject) {
                return ;
            }
            NSDictionary *dic = [NSDictionary changeType:(NSDictionary *)responseObject];
            
            NSString *response = [dic jsonEncodedKeyValueString];
            
            if ([dic[@"code"] integerValue] == 00000 && params[@"opact"]) {
                if ([params[@"opact"] isEqualToString:@"oauth/walletPay/pay"]) {
                    [[NSUserDefaults standardUserDefaults] setObject:response?:@"" forKey:@"CPJAVAWALTERPAY"];
                }
                
            }
            
            DLog(@"url==%@\nresponse==%@",url,response);
            
            [weakSelf handleResponse:dic networkHUD:networkHUD];
            
            if(dic)  {
                success(dic);
            }
            
            responseCache ? [CWBAFNCache saveHttpCache:dic forKey:path] : nil;
            
            DLog(@"%@:网络缓存大小cache = %.6fKB",path,[CWBAFNCache getAllHttpCacheSize] / 1024.0f);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           
//            if (target && [target respondsToSelector:@selector(stopCPHeadAnimation)])
//            {
//                [target performSelector:@selector(stopCPHeadAnimation)];
//            }

            DLog(@"error==%@",error);
            
            responseCache ? responseCache([CWBAFNCache getHttpCacheForKey:path]) : nil;
            
            NSDictionary *dic = [weakSelf getErrorDictionary:error];
            [weakSelf handleResponse:dic networkHUD:networkHUD];
            
            failure(error);
        }];
    }
    else
    {
        kSelfWeak;
        DLog(@"----->%@",[NSURL URLWithString:[NSString stringWithFormat:@"%@",url] relativeToURL:[self sharedManager].baseURL]);
        [[self sharedManager] GET:[[NSURL URLWithString:[NSString stringWithFormat:@"%@",path] relativeToURL:[self sharedManager].baseURL] absoluteString] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSString *response = [weakSelf dictionaryToJson:responseObject];
            
            DLog(@"response==%@",response);
            
            [weakSelf handleResponse:responseObject networkHUD:networkHUD];
            
            if(responseObject)  {
                success(responseObject);
            }
            
            responseCache ? [CWBAFNCache saveHttpCache:responseObject forKey:path] : nil;
            
            DLog(@"%@:网络缓存大小cache = %.6fKB",path,[CWBAFNCache getAllHttpCacheSize] / 1024.0f);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            responseCache ? responseCache([CWBAFNCache getHttpCacheForKey:path]) : nil;
            
            //NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            
            //NSDictionary *dic = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
            //DLog(@"error--%@",dic);
            
            if(error.code == -1009)
            {
                [iToast alertWithTitle:error.localizedDescription];
            }
            if(error.code == -1001)
            {
                [iToast alertWithTitle:error.localizedDescription];
            }
            
            NSDictionary *dic = [weakSelf getErrorDictionary:error];
            [weakSelf handleResponse:dic networkHUD:networkHUD];
            
            failure(error);
        }];
    }
    
    if (target && [target respondsToSelector:@selector(addNet:)])
    {
        [target performSelector:@selector(addNet:) withObject:_manager];
    }
    
    return _manager;
}

+ (void)handleResponse:(NSDictionary *)response networkHUD:(NetworkHUD)networkHUD
{
    if (networkHUD > 2)
        [HUDManager hiddenHUD];
    
    NSString *msg = [response objectForKey:@"msg"]?:@"";
    NSString *code = [response objectForKey:@"code"]?:@"";
    
    if([code integerValue] == -1009)
    {
        [iToast alertWithTitle:kloadfailedNotNetwork];
        return ;
    }
    if([code integerValue] == -1001)
    {
        [iToast alertWithTitle:@"请求超时！"];
        return ;
    }
    
    if ([code integerValue] ==1007||[code integerValue] == 1008||[code integerValue] == 1517 || [msg isEqualToString:@"token不能为空"]||[code integerValue] == 1010||[code integerValue] == 1016) {
        return;
    }
    
    if(networkHUD > 1 && [msg isKindOfClass:[NSString class]] && ![msg isBlank] && [code integerValue] != 1000)
    {
        if ([code integerValue] == 3840 || [msg isEqualToString:@"未能读取数据，因为它的格式不正确"])
        {
            [iToast alertWithTitle:@"网络异常！"];
        }
        else if(![msg isEqualToString:@"手机号已被注册"] || networkHUD != 8)
        {
            [iToast alertWithTitle:msg];
        }
    }
    
    if([msg isEqualToString:@"无效的token"] || [code integerValue] == 1044   || [code integerValue] == 1043)
    {
        if(GetDataManager.isLogin)
        {
//            [GetAPPDelegate logined];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CP_LOGOUT_INDEX" object:nil];
    }
}

+ (NSDictionary*)getErrorDictionary:(NSError *)error
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSString stringWithFormat:@"%ld",(long)error.code], @"code",
            [NSString stringWithFormat:@"%@",error.localizedDescription],@"msg",
            nil];
}

//鉴权
+ (NSMutableDictionary *)addGETBaseParameter:(NSMutableDictionary *)parmeter path:(NSString *)path urlHostType:(NSInteger)type
{
    NSMutableDictionary *allParmeter = [NSMutableDictionary dictionaryWithDictionary:parmeter];
    
    NSString *timestampStr = [NSString stringWithFormat:@"%ld", (long)([[NSDate date] timeIntervalSince1970])];
    
    //验签
    NSArray *arr = [allParmeter allKeys];
    arr = [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2];
        return result==NSOrderedDescending;
    }];
    
    NSMutableString *requeststr = [NSMutableString string];
    for (NSInteger i = 0; i < arr.count; i ++)
    {
        NSString *temp = [allParmeter objectForKey:arr[i]];
        if(i == arr.count - 1)
            [requeststr appendString:[NSString stringWithFormat:@"%@=%@",arr[i],temp]];
        else
            [requeststr appendString:[NSString stringWithFormat:@"%@=%@&",arr[i],temp]];
    }
    
    NSArray *array = [path componentsSeparatedByString:@"https://"];
    if(array.count > 0)
    {
        NSString *url = [NSString stringWithFormat:@"%@ios:%@",array.count>1?array[1]:@"",timestampStr];
        
        DLog(@"request_str=%@",url);
        
        NSString *encryptedUrl = [AESCrypt encrypt:url password:kVersionSignkey];
        
        DLog(@"encryptedUrl=%@",encryptedUrl);
        
        if(GetDataManager.isLogin)
        {
            [_manager.requestSerializer setValue:GetDataManager.token
                              forHTTPHeaderField:@"Token"];
            
            DLog(@"===token====%@",GetDataManager.token);
        }
        
        [_manager.requestSerializer setValue:@"ios"
                          forHTTPHeaderField:@"Channel"];
        
        [_manager.requestSerializer setValue:encryptedUrl
                          forHTTPHeaderField:@"Sign"];
        
        [_manager.requestSerializer setValue:@""
                          forHTTPHeaderField:@"Accept-Encoding"];
    }
    
    NSString *udid = [UUIDHelper getUUID];
    udid = [udid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [allParmeter setValue:udid forKey:@"device_sn"];
    
    [allParmeter setValue:@"1" forKey:@"os_type"];
    
    NSString *cityId = [[NSUserDefaults standardUserDefaults] objectForKey:kSelectCityId];
    
    CLLocationCoordinate2D coordinate = GetDataManager.coordinate;
    NSString *location = [NSString stringWithFormat:@"%f,%f",coordinate.longitude, coordinate.latitude];
    [allParmeter setValue:[NSString stringWithFormat:@"%f",coordinate.longitude] forKey:@"lon"];
    [allParmeter setValue:[NSString stringWithFormat:@"%f", coordinate.latitude] forKey:@"lat"];
    
    [allParmeter setValue:location forKey:@"coordinates"];
    [allParmeter setValue:location forKey:@"coordinate"];
    
    [allParmeter setValue:cityId forKey:@"cityId"];
    [allParmeter setValue:cityId forKey:@"city_id"];
    
    return allParmeter;
}

+ (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark - 上传图片文件

+ (NSURLSessionTask *)uploadWithURL:(NSString *)URL
                         parameters:(NSDictionary *)parameters
                             images:(NSArray<UIImage *> *)images
                               name:(NSString *)name
                           fileName:(NSString *)fileName
                           mimeType:(NSString *)mimeType
                           progress:(HttpProgress)progress
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure
{
    
    return [[self sharedManager] POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //压缩-添加-上传图片
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData name:name fileName:[NSString stringWithFormat:@"%@%lu.%@",fileName,(unsigned long)idx,mimeType?mimeType:@"jpeg"] mimeType:[NSString stringWithFormat:@"image/%@",mimeType?mimeType:@"jpeg"]];
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        progress ? progress(uploadProgress) : nil;
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success ? success(responseObject) : nil;
        DLog(@"responseObject = %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure ? failure(error) : nil;
        DLog(@"error = %@",error);
    }];
}

#pragma mark - 下载文件
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(HttpProgress)progress
                              success:(void (^)(id responseObject))success
                              failure:(void (^)(NSError *error))failure
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    NSURLSessionDownloadTask *downloadTask = [[self sharedManager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        progress ? progress(downloadProgress) : nil;
        DLog(@"下载进度:%.2f%%",100.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        
        DLog(@"downloadDir = %@",downloadDir);
        
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        failure && error ? failure(error) : nil;
        
    }];
    
    //开始下载
    [downloadTask resume];
    
    return downloadTask;
}

#pragma mark -- JAVA请求接口

#pragma mark -- JAVA请求接口
+ (AFHTTPSessionManager *)postJDataResponsePath:(NSString *)path
                                         params:(NSMutableDictionary *)params
                                         isPost:(BOOL)isPost
                                     networkHUD:(NetworkHUD)networkHUD
                                  responseCache:(HttpRequestCache)responseCache
                                         target:(id)target
                                        success:(void (^)(id responseObject))success
                                        failure:(void (^)(NSError *error))failure {
   return [self postDataResponsePath:path urlHostType:1 params:params isPost:isPost isRefresh:NO networkHUD:networkHUD responseCache:responseCache target:target success:success failure:failure];
}
#pragma mark -- JAVA其他路径请求
+ (AFHTTPSessionManager *)postJDataResponsePath:(NSString *)path
                                    urlHostType:(NSInteger)urlHostType
                                         params:(NSMutableDictionary *)params
                                         isPost:(BOOL)isPost
                                      isRefresh:(BOOL)isRefresh
                                     networkHUD:(NetworkHUD)networkHUD
                                  responseCache:(HttpRequestCache)responseCache
                                         target:(id)target
                                        success:(void (^)(id responseObject))success
                                        failure:(void (^)(NSError *error))failure {
    [self sharedManager].requestSerializer.timeoutInterval = 15.f;
    [[self sharedManager].responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", nil]];
    
    if (networkHUD > 2 && !isRefresh)
        [HUDManager showHUD:MBProgressHUDModeCustomView onTarget:target hide:YES afterDelay:kHUDTime enabled:NO message:@""];
    
    NSString *url = @"";
    
    params = [CWBAFNHelper getMD5Parameter:params];
    
    kSelfWeak;
    
    [[self sharedManager] POST:[[NSURL URLWithString:[NSString stringWithFormat:@"%@",url] relativeToURL:[self sharedManager].baseURL] absoluteString] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (!responseObject) {
            return ;
        }
        
        NSDictionary *dic = [NSDictionary changeType:(NSDictionary *)responseObject];
        
        NSString *response = [dic jsonEncodedKeyValueString];
        DLog(@"url==%@\nresponse==%@",url,response);
        
        [weakSelf handleResponse:dic networkHUD:networkHUD];
        
        if(dic)  {
            success(dic);
        }
        
        responseCache ? [CWBAFNCache saveHttpCache:dic forKey:path] : nil;
        
        DLog(@"%@:网络缓存大小cache = %.6fKB",path,[CWBAFNCache getAllHttpCacheSize] / 1024.0f);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        DLog(@"error==%@",error);
        
        responseCache ? responseCache([CWBAFNCache getHttpCacheForKey:path]) : nil;
        
        NSDictionary *dic = [weakSelf getErrorDictionary:error];
        [weakSelf handleResponse:dic networkHUD:networkHUD];
        
        failure(error);
    }];
    
    return _manager;
}
+ (NSMutableDictionary *)getMD5Parameter:(NSDictionary *)params {
    
    NSArray *keys = [params allKeys];
    
    NSArray *sortArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result == NSOrderedDescending;
    }];
    
    NSMutableArray *values = [NSMutableArray array];
    
    for (NSString *value in sortArray) {
        [values addObject:[params objectForKey:value]];
    }
    
    NSMutableArray *signArray = [NSMutableArray array];
    
    for (int i = 0; i < sortArray.count; i++) {
        NSString *keyValueStr = [NSString stringWithFormat:@"%@%@",sortArray[i],values[i]];
        [signArray addObject:keyValueStr];
    }
    
    NSString *md5String = [signArray componentsJoinedByString:@""];
    
    md5String = [CWBAFNHelper md5:@""];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:params];
    
    
    return dict;
}
#pragma mark -- 文件加密
+ (NSString *)md5:(NSString *)key {
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *fileName = [[NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]] uppercaseString];
    return fileName;
}

@end

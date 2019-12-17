//
//  LoginModel.m
//  JingYuDaiJieKuan
//
//  Created by xiaoguo on 2019/6/29.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "LoginModel.h"

@implementation  MLoginModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"icon":@"icon",
             @"introduce":@"introduce",
             @"tags":@"tags",
             @"maxAmount":@"maxAmount",
             @"name":@"name",
             @"url":@"url",
             @"img":@"img",
             @"lineDate":@"lineDate",
             @"message":@"message",
             @"sort":@"sort",
             };
}
@end

@implementation LoginModel

SINGLETON_FOR_CLASS(LoginModel)
//fh_CodingImplementation
- (void)encodeWithCoder:(NSCoder *)coder
{
    unsigned int outCount = 0;
    Ivar * vars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar var = vars[i];
        const char * name = ivar_getName(var);
        NSString * key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        if (value) {
            [coder encodeObject:value forKey:key];
        }
    }
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super init]) {
        unsigned int outCount = 0;
        Ivar * vars = class_copyIvarList([self class], &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar var = vars[i];
            const char * name = ivar_getName(var);
            NSString * key = [NSString stringWithUTF8String:name];
            id value = [coder decodeObjectForKey:key];
            if (value) {
                [self setValue:value forKey:key];
            }
        }
    }
    return self;
}

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"token":@"data.token",
             @"headImg":@"data.headImg",
             @"nickName":@"data.nickName",
             @"userId":@"data.userId",
             
              @"education":@"data.education",
              @"gender":@"data.gender",
              @"mailbox":@"data.mailbox",
              @"mobile":@"data.mobile",
              @"type":@"data.type",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"list" : [MLoginModel class]
             };
}


- (void)saveUserData{
    NSLog(@"用户保存成功...");
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSError *error;

//    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:self
//                             requiringSecureCoding:NO
//                                             error:&error];
//    if (error){
//
//    }
    NSData         * userData = [NSKeyedArchiver archivedDataWithRootObject:self];
    [defaults setObject:userData forKey:KUserData];
    [defaults synchronize];
}

- (LoginModel *)readUserData {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSData         * userData = [defaults objectForKey:KUserData];
    if (userData) {
        LoginModel * User = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        return User;
    }
    else
        return nil;
}
- (void)removeUserData{
    NSLog(@"用户数据删除成功...");
    _userModel = nil;
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:KUserData];
    [defaults synchronize];
}
- (LoginModel *)userModel{
    if (_userModel == nil) {
        _userModel = [[LoginModel sharedLoginModel] readUserData];
    }
    return _userModel;
}


@end

@implementation  LoginBannerModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"id":@"data.id",
             @"img":@"data.img",
             @"photoIphonex":@"data.photoIphonex",
             @"sort":@"data.sort",
             @"title":@"data.title",
             @"url":@"data.url",
             };
}
@end

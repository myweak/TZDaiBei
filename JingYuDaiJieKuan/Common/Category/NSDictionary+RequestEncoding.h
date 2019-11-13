//
//  NSDictionary+RequestEncoding.h
//  CarpFinancial
//
//  Created by weibin on 16/2/26.
//  Copyright © 2016年 cwb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (RequestEncoding)

- (NSString *) jsonEncodedKeyValueString;
- (NSString *) plistEncodedKeyValueString;

+ (instancetype)dictionaryWithObjects:(const id[])objects forKeys:(const id[])keys count:(NSUInteger)cnt;

+ (id)changeType:(id)myObj;

@end

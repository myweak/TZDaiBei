//
//  NSMutableArray+Additions.m
//  AntHouse
//
//  Created by 飞礼科技 on 2018/1/24.
//  Copyright © 2018年 Nathan Ou. All rights reserved.
//

#import "NSMutableArray+Additions.h"
#import <objc/runtime.h>

@implementation NSMutableArray (Additions)

+(void)load{
    static dispatch_once_t oncnToken;
    dispatch_once(&oncnToken, ^{
        id obj = [[self alloc] init];
        [obj exchangeMethod:@selector(addObject:) withMethod:@selector(safeAddObject:)];
        [obj exchangeMethod:@selector(objectAtIndex:) withMethod:@selector(safeObjectAtIndex:)];
    });
}

-(void)safeAddObject:(id)object{
    if (object == nil || object == NULL) {
        NSLog(@"⚠️⚠️⚠️⚠️⚠️⚠️⚠️'-[__NSArrayM addObject:]: object cannot be nil'");
    }else{
        [self safeAddObject:object];
    }
}

- (id)safeObjectAtIndex:(NSInteger)index
{
    if(index<[self count]){
        return [self safeObjectAtIndex:index];
    }else{
        NSLog(@"⚠️⚠️⚠️⚠️⚠️⚠️⚠️'index is beyond bounds'");
    }
    return nil;
}

- (void)exchangeMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    Class cls = [self class];
    
    Method originalMethod = class_getInstanceMethod(cls, origSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
    
    BOOL didAddMethod = class_addMethod(cls,
                                        origSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(cls,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end

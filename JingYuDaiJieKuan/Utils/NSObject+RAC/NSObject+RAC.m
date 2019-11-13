//
//  NSObject+RAC.m
//  YBaby
//
//  Created by Cullen on 2016/11/1.
//  Copyright © 2016年 Cullen. All rights reserved.
//

#import "NSObject+RAC.h"
#import <objc/runtime.h>
static const void *racSignalsKey = &racSignalsKey;
static const void *deallocSignalsKey = &deallocSignalsKey;

@implementation NSObject (RAC)

-(NSHashTable *)racSignals
{
    NSHashTable *signals = objc_getAssociatedObject(self, racSignalsKey);
    if(!signals)
    {
        signals = [NSHashTable weakObjectsHashTable];
        self.racSignals = signals;
    }
    return signals;
}

-(void)setRacSignals:(NSHashTable *)racSignals
{
    objc_setAssociatedObject(self, racSignalsKey, racSignals, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSHashTable *)deallocSignals
{
    NSHashTable *signals = objc_getAssociatedObject(self, deallocSignalsKey);
    if(!signals)
    {
        signals = [NSHashTable weakObjectsHashTable];
        self.deallocSignals = signals;
    }
    return signals;
}

-(void)setDeallocSignals:(NSHashTable *)deallocSignals
{
    objc_setAssociatedObject(self, deallocSignalsKey, deallocSignals, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)addSignalToList:(id)signal
{
    NSHashTable *signals = self.racSignals;
    [signals addObject:signal];
    self.racSignals = signals;
    
    for(RACDisposable *signal in self.deallocSignals)
    {
        [signal dispose];
    }
    [self.deallocSignals removeAllObjects];
    
    RACDisposable *deallocSignal = [self.rac_willDeallocSignal subscribeCompleted:^{
        
        for(RACDisposable *signal in signals)
        {
            [signal dispose];
        }
    }];
    NSHashTable *deallocSignals = self.deallocSignals;
    [deallocSignals addObject:deallocSignal];
    self.deallocSignals = deallocSignals;
}

@end

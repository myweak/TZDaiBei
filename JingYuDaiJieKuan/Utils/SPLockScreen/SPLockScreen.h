//
//  SPLockScreen.h
//  SuQian
//
//  Created by Suraj on 24/9/12.
//  Copyright (c) 2012 Suraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPLockScreen;

@protocol LockScreenDelegate <NSObject>

- (void)lockScreen:(SPLockScreen *)lockScreen didEndWithPattern:(NSNumber *)patternNumber numberArray:(NSMutableArray *)numberArray;
- (void)changeScreenState:(SPLockScreen *)lockScreen didEndTouchCellList:(int)index;
- (void)StartUnlockAgain;

@end

@interface SPLockScreen : UIView

@property (nonatomic, assign) id<LockScreenDelegate> delegate;

@property (nonatomic) BOOL allowClosedPattern;			// Set to YES to allow a closed pattern, a complex type pattern; NO by default
@property (nonatomic, assign) float m_floatRadius;


// Init Method

- (id)initWithDelegate:(id<LockScreenDelegate>)lockDelegate;

- (void)resetScreen;

- (void)SetFailedView;

@end

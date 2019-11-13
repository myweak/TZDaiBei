//
//  SPLine.m
//  SuQian
//
//  Created by Suraj on 25/9/12.
//  Copyright (c) 2012 Suraj. All rights reserved.
//

#import "SPLine.h"

#define kLineColor			[UIColor colorWithRed:94.0/255.0 green:183.0/255.0 blue:226.0/255.0 alpha:1.0]

@implementation SPLine

- (id)initWithFromPoint:(CGPoint)A toPoint:(CGPoint)B AndIsFullLength:(BOOL)isFullLength;
{
    self.color = kLineColor;
	self.fromPoint = A;
	self.toPoint = B;
	self.isFullLength = isFullLength;
	return self;
}

@end

//
//  SPLockScreen.m
//  SuQian
//
//  Created by Suraj on 24/9/12.
//  Copyright (c) 2012 Suraj. All rights reserved.
//

#import "SPLockScreen.h"
#import "NormalCircle.h"
#import "SPLockOverlay.h"

#define kSeed									23
#define kAlterOne							1234
#define kAlterTwo							4321
#define kTagIdentifier				22222
#define kLineFailedColor   [UIColor colorWithRed:252.0/255.0 green:18.0/255.0 blue:30.0/255.0 alpha:1.0]

@interface SPLockScreen()
{
    NSMutableArray *m_ArrayCircleSelected;
    BOOL m_IfShouldCleanView;
    BOOL m_IfLineNoTouchPoint;
    
    // 记录最后一个经过的点
    int  m_IntLastCellPoint;
}

@property (nonatomic, strong) NormalCircle *selectedCell;
@property (nonatomic, strong) SPLockOverlay *overLay;
@property (nonatomic) NSInteger oldCellIndex,currentCellIndex;
@property (nonatomic, strong) NSMutableDictionary *drawnLines;
@property (nonatomic, strong) NSMutableArray *finalLines, *cellsInOrder;

- (void)resetScreen;

@end

@implementation SPLockScreen
@synthesize delegate,selectedCell,overLay,oldCellIndex,currentCellIndex,drawnLines,finalLines,cellsInOrder,allowClosedPattern;
@synthesize m_floatRadius;

- (id)init{
	CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
	self = [super initWithFrame:frame];
    m_floatRadius = 30;
	if (self) {
        m_ArrayCircleSelected = [[NSMutableArray alloc] init];
        
		[self setNeedsDisplay];
		[self setUpTheScreen];
		[self addGestureRecognizer];
	}
	return self;
}

- (id)initWithDelegate:(id<LockScreenDelegate>)lockDelegate
{
	self = [self init];
	self.delegate = lockDelegate;
	
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
	frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
    m_floatRadius = 30;
    self = [super initWithFrame:frame];
    if (self) {
			[self setNeedsDisplay];
			[self setUpTheScreen];
			[self addGestureRecognizer];
    }
    return self;
}

- (void)setUpTheScreen{
	CGFloat radius = self.m_floatRadius;
	CGFloat gap = (self.frame.size.width - 6 * radius )/4;
	CGFloat topOffset = radius;
    
    // Add an overlay view
    self.overLay = [[SPLockOverlay alloc]initWithFrame:self.frame];
    [self.overLay setUserInteractionEnabled:NO];
    [self addSubview:self.overLay];
	
	for (int i=0; i < 9; i++) {
		NormalCircle *circle = [[NormalCircle alloc]initwithRadius:radius];
		int column =  i % 3;
		int row    = i / 3;
		CGFloat x = (gap + radius) + (gap + 2*radius)*column;
		CGFloat y = (row * gap + row * 2 * radius) + topOffset;
		circle.center = CGPointMake(x, y);
		circle.tag = (row+kSeed)*kTagIdentifier + (column + kSeed);
		[self addSubview:circle];
	}
	self.drawnLines = [[NSMutableDictionary alloc]init];
	self.finalLines = [[NSMutableArray alloc]init];
	self.cellsInOrder = [[NSMutableArray alloc]init];
	
	// set selected cell indexes to be invalid
	self.currentCellIndex = -1;
	self.oldCellIndex = self.currentCellIndex;
}

#pragma - helper methods

- (NSInteger )indexForPoint:(CGPoint)point
{
    if (m_ArrayCircleSelected == nil)
    {
        m_ArrayCircleSelected = [[NSMutableArray alloc] init];
    }
	for(UIView *view in self.subviews)
	{
		if([view isKindOfClass:[NormalCircle class]])
		{
			if(CGRectContainsPoint(view.frame, point)){
				NormalCircle *cell = (NormalCircle *)view;
				
				if(cell.selected == NO)	{
					[cell highlightCell];
					self.currentCellIndex = [self indexForCell:cell];
					self.selectedCell = cell;
                    [m_ArrayCircleSelected addObject:cell];
                    // 触发delegate
                    if ([self.delegate respondsToSelector:@selector(changeScreenState:didEndTouchCellList:)])
                    {
                        [self.delegate changeScreenState:self didEndTouchCellList:self.currentCellIndex];
                    }
				}
				
				else if (cell.selected == YES && self.allowClosedPattern == YES) {
					self.currentCellIndex = [self indexForCell:cell];
					self.selectedCell = cell;
				}
				
				int row = (int)view.tag/kTagIdentifier - kSeed;
				int column = view.tag % kTagIdentifier - kSeed;
				return row * 3 + column;
			}
		}
	}
	return -1;
}

- (NSInteger) indexForCell:(NormalCircle *)cell
{
	if([cell isKindOfClass:[NormalCircle class]] == NO || [cell.superview isEqual:self] == NO) return -1;
	else
		return (cell.tag/kTagIdentifier - kSeed)*3 + (cell.tag % kTagIdentifier - kSeed);
}

- (NormalCircle *)cellAtIndex:(NSInteger)index
{
	if(index<0 || index > 8) return nil;
	return (NormalCircle *)[self viewWithTag:((index/3+kSeed)*kTagIdentifier + index % 3 + kSeed)];
}

- (NSNumber *) uniqueLineIdForLineJoiningPoint:(NSInteger)A AndPoint:(NSInteger)B
{
	return @(labs(A+B)*kAlterOne + labs(A-B)*kAlterTwo);
}

- (void)handlePanAtPoint:(CGPoint)point
{
	self.oldCellIndex = self.currentCellIndex;
	NSInteger cellPos = [self indexForPoint:point];
    
    if (cellPos >= 0)
    {
        m_IntLastCellPoint = (int)cellPos;
    }
	
	if(cellPos >=0 && cellPos != self.oldCellIndex)
    {
        BOOL n_IfExist = NO;
        for (NSNumber *number in self.cellsInOrder)
        {
            if ([number intValue] == self.currentCellIndex)
            {
                n_IfExist = YES;
            }
        }
        if (!n_IfExist)
        {
            [self.cellsInOrder addObject:@(self.currentCellIndex)];
        }
    }
	
	if(cellPos < 0 && self.oldCellIndex < 0) return;
	
	else if(cellPos < 0) {
        m_IfLineNoTouchPoint = NO;
		SPLine *aLine = [[SPLine alloc]initWithFromPoint:[self cellAtIndex:self.oldCellIndex].center toPoint:point AndIsFullLength:NO];
        //aLine.color = [UIColor colorWithRed:252.0/255.0 green:6.0/255.0 blue:6.0/255.0 alpha:0.3];
		[self.overLay.pointsToDraw removeAllObjects];
		[self.overLay.pointsToDraw addObjectsFromArray:self.finalLines];
		[self.overLay.pointsToDraw addObject:aLine];
		[self.overLay setNeedsDisplay];
	}
	else if(cellPos >=0 && self.currentCellIndex == self.oldCellIndex) return;
	else if (cellPos >=0 && self.oldCellIndex == -1) return;
	else if(cellPos >= 0 && self.oldCellIndex != self.currentCellIndex)
	{
		// two situations: line already drawn, or not fully drawn yet
		NSNumber *uniqueId = [self uniqueLineIdForLineJoiningPoint:self.oldCellIndex AndPoint:self.currentCellIndex];
		
		if(![self.drawnLines objectForKey:uniqueId])
		{
            m_IfLineNoTouchPoint = YES;
			SPLine *aLine = [[SPLine alloc]initWithFromPoint:[self cellAtIndex:self.oldCellIndex].center toPoint:self.selectedCell.center AndIsFullLength:YES];
			[self.finalLines addObject:aLine];
			[self.overLay.pointsToDraw removeAllObjects];
			[self.overLay.pointsToDraw addObjectsFromArray:self.finalLines];
			[self.overLay setNeedsDisplay];
			[self.drawnLines setObject:@(YES) forKey:uniqueId];
		}
		else return;
	}
}

- (void)endPattern
{
	if ([self.delegate respondsToSelector:@selector(lockScreen:didEndWithPattern:numberArray:)])
    {
		[self.delegate lockScreen:self didEndWithPattern:[self patternToUniqueId] numberArray:self.cellsInOrder];
    }
//	[self resetScreen];
    m_IfShouldCleanView = YES;
}

- (NSNumber *)patternToUniqueId
{
	long finalNumber = 0;
	long thisNum;
    // 假如数组最后一位和记录中的内容不一样
//    NSLog(@"count = %d",[self.cellsInOrder count]);
    if ([self.cellsInOrder count] > 1)
    {
        int n_intLast = [[self.cellsInOrder objectAtIndex:([self.cellsInOrder count]-1)] intValue];
        if (n_intLast != m_IntLastCellPoint)
        {
            [self.cellsInOrder addObject:@(m_IntLastCellPoint)];
        }
    }
    for(int i = (int)self.cellsInOrder.count - 1 ; i >= 0 ; i--){
		thisNum = ([[self.cellsInOrder objectAtIndex:i] integerValue] + 1) * pow(10, (self.cellsInOrder.count - i - 1));
		finalNumber = finalNumber + thisNum;
	}
	return @(finalNumber);
}

// 重置界面
- (void)resetScreen
{
	for(UIView *view in self.subviews)
	{
        if([view isKindOfClass:[NormalCircle class]])
        {
            [view removeFromSuperview];
//			[(NormalCircle *)view resetCell];
        }
	}
	[self.finalLines removeAllObjects];
	[self.drawnLines removeAllObjects];
	[self.cellsInOrder removeAllObjects];
	[self.overLay.pointsToDraw removeAllObjects];
	[self.overLay setNeedsDisplay];
	self.oldCellIndex = -1;
	self.currentCellIndex = -1;
	self.selectedCell = nil;
    
//    CGFloat radius = 30;
    if (iPhone6Plus)
    {
        self.m_floatRadius=35;
    }
    
    
    CGFloat gap = (self.frame.size.width - 6 * self.m_floatRadius )/4;
    CGFloat topOffset = self.m_floatRadius;
    for (int i=0; i < 9; i++) {
        NormalCircle *circle = [[NormalCircle alloc]initwithRadius:self.m_floatRadius];
        int column =  i % 3;
        int row    = i / 3;
        CGFloat x = (gap + self.m_floatRadius) + (gap + 2*self.m_floatRadius)*column;
        CGFloat y = (row * gap + row * 2 * self.m_floatRadius) + topOffset;
        circle.center = CGPointMake(x, y);
        circle.tag = (row+kSeed)*kTagIdentifier + (column + kSeed);
        [self addSubview:circle];
        circle = nil;
    }
}

- (void)SetFailedView
{
    for (SPLine *line in self.finalLines)
    {
        line.color = kLineFailedColor;
    }
    [self.overLay.pointsToDraw removeAllObjects];
    [self.overLay.pointsToDraw addObjectsFromArray:self.finalLines];
    [self.overLay setNeedsDisplay];
    
    for (NormalCircle *circle in m_ArrayCircleSelected)
    {
        for (UIImageView *view in circle.subviews)
        {
            if ([view isKindOfClass:[UIImageView class]])
            {
                [view setImage:[UIImage imageNamed:@"t-2"]];

            }
        }
    }
    [m_ArrayCircleSelected removeAllObjects];
    m_ArrayCircleSelected = nil;
}

#pragma - Gesture Handler

- (void)addGestureRecognizer
{
	UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(gestured:)];
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestured:)];
	[self addGestureRecognizer:pan];
	[self addGestureRecognizer:tap];
}

- (void)gestured:(UIGestureRecognizer *)gesture
{
    if (m_IfShouldCleanView)
    {
        [self.delegate StartUnlockAgain];
        [self resetScreen];
        m_IfShouldCleanView = NO;
    }
	CGPoint point = [gesture locationInView:self];
	if([gesture isKindOfClass:[UIPanGestureRecognizer class]])
    {
		if(gesture.state == UIGestureRecognizerStateEnded )
        {
			if(self.finalLines.count > 0)
            {
                // 假设最后一次划线没有到达圆点，则删除
                [self.overLay.pointsToDraw removeAllObjects];
                [self.overLay.pointsToDraw addObjectsFromArray:self.finalLines];
                [self.overLay setNeedsDisplay];
                [self endPattern];
            }
			else [self resetScreen];
		}
		else [self handlePanAtPoint:point];
	}
	else
    {
		NSInteger cellPos = [self indexForPoint:point];
		self.oldCellIndex = self.currentCellIndex;
		if(cellPos >=0) {
			[self.cellsInOrder addObject:@(self.currentCellIndex)];
			[self performSelector:@selector(endPattern) withObject:nil afterDelay:0.3];
		}
	}
}
@end

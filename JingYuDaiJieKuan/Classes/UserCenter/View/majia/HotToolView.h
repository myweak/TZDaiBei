//
//  HootToolView.h
//  DKSTableCollcetionView
//
//  Created by aDu on 2017/10/10.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotToolView;
@protocol HotToolViewDelegate <NSObject>

/**
 * 点击UICollectionViewCell的代理方法
 */
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content andIsWeb: (BOOL)isWeb cooperation:(NSString *)cooperation;
@end

@interface HotToolView : UIView

@property (nonatomic, weak) id<HotToolViewDelegate> delegate;

- (void)personalCenterHotToolsData;

@end

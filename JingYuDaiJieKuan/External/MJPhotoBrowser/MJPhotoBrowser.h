//
//  MJPhotoBrowser.h
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.

#import <UIKit/UIKit.h>

//图片浏览器选择类型
typedef enum {
    SendToFriend,
    SendToHXCircle
} ImageActionSheetSelectType;

@protocol MJPhotoBrowserDelegate;
@interface MJPhotoBrowser : UIViewController <UIScrollViewDelegate>
// 代理
@property (nonatomic, weak) id<MJPhotoBrowserDelegate> delegate;
// 所有的图片对象
@property (nonatomic, strong) NSArray *photos;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;

// 显示
- (void)show;
// 隐藏
-(void)hide;

@end

@protocol MJPhotoBrowserDelegate <NSObject>

//图片操作方法
- (void)photoBrowserImageOperateType:(ImageActionSheetSelectType)type image:(UIImage *)image;

@optional
// 切换到某一页图片
- (void)photoBrowser:(MJPhotoBrowser *)photoBrowser didChangedToPageAtIndex:(NSUInteger)index;
@end
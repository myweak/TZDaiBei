//
//  NAAssetsManager.h
//  MiZi
//
//  Created by Nathan Ou on 2018/8/1.
//  Copyright © 2018年 Simple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTAssetsPickerController.h"
#import "AHSendProgressView.h"

@interface NAAssetsManager : NSObject

@property (nonatomic, strong) NSMutableArray<PHAsset*> *currentAssets;

@property (nonatomic, strong) AHSendProgressView *currentProgressView;

/**
 完成选择Assets的回调
 */
@property (nonatomic, copy) void(^didFinishPickAssetsBlock)(void);

@property (nonatomic, copy) void(^didCancelPickAssetsBlock)(void);

/**
 是否显示 生成进度条 AHSendProgressView  默认：yes;
 */
@property (nonatomic, assign) BOOL isShowProgress;

/**
 仅选择图片或者视频，默认是 imageOnly = YES;
 */
@property (nonatomic, assign) BOOL videoOnly;
@property (nonatomic, assign) BOOL imageOnly;

/**
 最大照片选择数 默认是 6 张
 */
@property (nonatomic, assign) NSInteger maxPhotoNum;

+ (instancetype)shareManager;

- (void)pickAssetsFromAblum; // 相册选择

- (void)pickImageFromCamera; // 相机拍照

- (void)showImagePickerSheet; // 弹出选择Sheet

/**
 重新设置
 清空 currentAssets
 */
- (void)reset;


/**
 根据Asset获取图片

 @param asset
 @param size 返回图片的宽高
 @param block 成功回调
 */
- (void)getImageWithAsserts:(PHAsset *)asset
                       size:(CGSize)size
                 completion:(void(^)(UIImage *image, NSData *imageData))block;


/**
 跳转到浏览图片的页面
 */
- (void)goToImagePageControllerWithIndex:(NSInteger)index;
//-(void)getImageArray:(NSMutableArray *)imageArray;


- (void)uploadCurrentAssetsWithCompletion:(void(^)(BOOL succeed, id imageDatas, id videoDatas))block;

@end

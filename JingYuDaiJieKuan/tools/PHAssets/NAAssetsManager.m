//
//  NAAssetsManager.m
//  MiZi
//
//  Created by Nathan Ou on 2018/8/1.
//  Copyright © 2018年 Simple. All rights reserved.
//

#import "NAAssetsManager.h"
#import "CTAssetsPageViewController.h"
#import "PHImageManager+CTAssetsPickerController.h"
//#import "WkkeeperQiniuManager.h"

@interface NAAssetsManager () <CTAssetsPickerControllerDelegate>

@property (nonatomic, strong) PHImageRequestOptions *requestOptions;

@end

@implementation NAAssetsManager

+ (instancetype)shareManager
{
    static NAAssetsManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NAAssetsManager alloc] init];
    });
    return manager;
}
-(instancetype)init{
    if ([super init]) {
        self.isShowProgress = YES;
        self.imageOnly = YES;
        self.maxPhotoNum = 6;
    }
    return self;
}

- (NSMutableArray *)currentAssets
{
    if (!_currentAssets) {
        _currentAssets = [NSMutableArray array];
    }
    return _currentAssets;
}

#pragma mark - Picker

- (void)pickAssetsFromAblum
{
    WEAKSELF;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // init picker
            CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
            
            // set delegate
            picker.delegate = weakSelf;
            picker.selectedAssets = [weakSelf.currentAssets mutableCopy];
            if (self.imageOnly)
                [self setImageOnlyForPicker:picker];
            else if (self.videoOnly)
                [self setVideoOnlyForPicker:picker];
            
            // to present picker as a form sheet in iPad
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                picker.modalPresentationStyle = UIModalPresentationFormSheet;
            
            // present picker
            UIViewController *m_controller = [UIViewController visibleViewController];
            [m_controller presentViewController:picker animated:YES completion:nil];
            
        });
    }];
}

- (void)setImageOnlyForPicker:(CTAssetsPickerController *)picker
{
    NSPredicate *predicateMediaType = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeImage];
    NSCompoundPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[predicateMediaType]];
    picker.assetsFetchOptions = [[PHFetchOptions alloc] init];
    picker.assetsFetchOptions.predicate = compoundPredicate;
}

- (void)setVideoOnlyForPicker:(CTAssetsPickerController *)picker
{
    NSPredicate *predicateMediaType = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeVideo];
    NSCompoundPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[predicateMediaType]];
    picker.assetsFetchOptions = [[PHFetchOptions alloc] init];
    picker.assetsFetchOptions.predicate = compoundPredicate;
}

#pragma mark - Camera

- (void)pickImageFromCamera
{
    if (self.currentAssets.count >= self.maxPhotoNum) {
        [iToast showCenter_ToastWithText:
         [NSString stringWithFormat:@"最多只能选择%ld张照片", (long)self.maxPhotoNum] ];
        if (self.didCancelPickAssetsBlock) {
            self.didCancelPickAssetsBlock();
        }
        return;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.editing = YES;
    imagePickerController.delegate = (id)self;
    
    UIViewController *m_controller = [UIViewController visibleViewController];
    [m_controller presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - Image picker delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    WEAKSELF;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (status != PHAuthorizationStatusAuthorized) {
                [iToast showCenter_ToastWithText:@"请允许访问您的相册"];
                return ;
            }
            
            __block NSString *localId = nil;
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
                localId = [[assetChangeRequest placeholderForCreatedAsset] localIdentifier];
            } completionHandler:^(BOOL success, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [picker dismissViewControllerAnimated:YES completion:^{
                        if (!success) {
                            NSLog(@"Error creating asset: %@", error);
                        } else {
                            PHFetchResult* assetResult = [PHAsset fetchAssetsWithLocalIdentifiers:@[localId] options:nil];
                            PHAsset *asset = [assetResult firstObject];
                            if (asset) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [weakSelf.currentAssets addObject:asset];
                                    [weakSelf didFinishPickAssets];
                                });
                            }
                        }
                    }];
                });
            }];
            
        });
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Assets

// implement should select asset delegate
- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset
{
    NSInteger max = self.maxPhotoNum;
    if (picker.selectedAssets.count >= max)
    {
        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"温馨提示"
                                            message:[NSString stringWithFormat:@"最多只能选择%ld张照片", (long)max]
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action =
        [UIAlertAction actionWithTitle:@"好的"
                                 style:UIAlertActionStyleDefault
                               handler:nil];
        
        [alert addAction:action];
        
        [picker presentViewController:alert animated:YES completion:nil];
    }
    
    // limit selection to max
    return (picker.selectedAssets.count < max);
}

#pragma mark - Assets Delegate

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    self.currentAssets = [NSMutableArray array];
    [self.currentAssets addObjectsFromArray:assets];
    [self didFinishPickAssets];
}

- (void)assetsPickerControllerDidCancel:(CTAssetsPickerController *)picker
{
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Commons

- (void)reset
{
    [self.currentAssets removeAllObjects];
    self.videoOnly = NO;
    self.imageOnly = YES;
}

#pragma mark - 获取图片
- (void)getImageWithAsserts:(PHAsset *)asset
                       size:(CGSize)size
                 completion:(void (^)(UIImage *, NSData *))block
{
    
    if (!self.requestOptions) {
        self.requestOptions = [[PHImageRequestOptions alloc] init];
        self.requestOptions.resizeMode   = PHImageRequestOptionsResizeModeExact;
        self.requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        self.requestOptions.synchronous = YES;
        self.requestOptions.networkAccessAllowed = YES;
    }
    
    PHImageManager *manager = [PHImageManager defaultManager];
    UIScreen *screen    = UIScreen.mainScreen;
    CGFloat scale       = screen.scale;
    CGSize targetSize = CGSizeMake(size.width * scale, size.height * scale);
    
    [manager ctassetsPickerRequestImageForAsset:asset
                                     targetSize:targetSize
                                    contentMode:PHImageContentModeAspectFit
                                        options:self.requestOptions
                                  resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
        UIImage *image = [UIImage imageWithData:imageData];
                                      CGSize timageSize = CGSizeMake(1500, 1500);
                                      if (image.size.width >= timageSize.width && image.size.height >= timageSize.height) {
                                          image = [image zipImageWithSize:timageSize];
                                      }
//                                      imageData = UIImageJPEGRepresentation(image, 0.5);
                                      
                                      if (block) {
                                          block(image, imageData);
                                      }
                                  }];
}

#pragma mark - 图片Nav
- (void)goToImagePageControllerWithIndex:(NSInteger)index
{
    CTAssetsPageViewController *vc = [[CTAssetsPageViewController alloc] initWithAssets:self.currentAssets];
    vc.pageIndex = index;
    vc.hidesBottomBarWhenPushed = YES;
    [[UIViewController visibleViewController].navigationController pushViewController:vc animated:YES];
}


#pragma mark - 选择

- (void)showImagePickerSheet
{
    WEAKSELF
    NSArray *titles = @[@"拍照",@"相册"];
    [[[ACActionSheet alloc]initWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil
                       otherButtonTitles:titles actionSheetBlock:^(NSInteger buttonIndex) {
                           if (buttonIndex == 0)  {
                               // 拍照
                               [weakSelf pickImageFromCamera];
                           } else if (buttonIndex == 1){
                               [weakSelf pickAssetsFromAblum];
                           } else {
                               if (weakSelf.didCancelPickAssetsBlock) {
                                   weakSelf.didCancelPickAssetsBlock();
                               }
                           }
                           
                       }] showWithBlackBg];
}

- (void)didFinishPickAssets{
    
    if (self.didFinishPickAssetsBlock) {
        self.didFinishPickAssetsBlock();
    }
}

#pragma mark - 上传图片
- (void)uploadCurrentAssetsWithCompletion:(void (^)(BOOL, id, id))block
{
    AHSendProgressView *progressView = nil;
    if (self.isShowProgress) {
        progressView = [AHSendProgressView showProgressView];
    }
    progressView.progress = 0.f;
    self.currentProgressView = progressView;
    
//    [WkkeeperQiniuManager sharedManager].currenProgressBlock = nil;
    
    if (self.currentAssets.count > 0) {
        
        if (self.currentAssets.count == 1 && [(PHAsset *)self.currentAssets.firstObject mediaType] == PHAssetMediaTypeVideo) {
            // 视频
            [self uploadVideoAsset:self.currentAssets.firstObject completion:block];
            return;
        }
        
//        NSMutableArray *imageDatasArray = [NSMutableArray arrayWithCapacity:self.currentAssets.count];
        NSMutableArray *imageDatasArray = [NSMutableArray arrayWithCapacity:10];
        
        dispatch_group_t asset_group = dispatch_group_create();
        
        WEAKSELF;
        for (PHAsset *asset in self.currentAssets) {
            
            dispatch_group_enter(asset_group);
            
            PHImageManager *manager = [PHImageManager defaultManager];
            UIScreen *screen    = UIScreen.mainScreen;
            CGFloat scale       = screen.scale;
            CGSize targetSize = CGSizeMake(CGRectGetWidth(screen.bounds) * scale, CGRectGetHeight(screen.bounds) * scale);
            
            [manager ctassetsPickerRequestImageForAsset:asset
                                             targetSize:targetSize
                                            contentMode:PHImageContentModeAspectFit
                                                options:self.requestOptions
                                          resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
                UIImage *image = [UIImage imageWithData:imageData];
                                              CGSize timageSize = CGSizeMake(2000, 2000);
                                              if (image.size.width >= timageSize.width && image.size.height >= timageSize.height) {
                                                  image = [image zipImageWithSize:timageSize];
                                              }
//                                              imageData = UIImageJPEGRepresentation(image, 0.3);
                                              [imageDatasArray addObject:imageData];
                                              
                                              dispatch_group_leave(asset_group);
                                          }];
        }
        
        dispatch_group_notify(asset_group, dispatch_get_main_queue(), ^{
            WEAKSELF;
            weakSelf.currentProgressView.totalProgress = 0.f;
//            [[WkkeeperQiniuManager sharedManager] setCurrenProgressBlock:^(CGFloat progress){
//                if (progress==1.0) {
//                    weakSelf.currentProgressView.totalProgress = weakSelf.currentProgressView.totalProgress+progress;
//                    weakSelf.currentProgressView.progress = weakSelf.currentProgressView.totalProgress*0.82f/((CGFloat)weakSelf.currentAssets.count);
//                }else
//                {
//                    weakSelf.currentProgressView.progress = (weakSelf.currentProgressView.totalProgress+progress)*0.82f/((CGFloat)weakSelf.currentAssets.count);
//                }
//                NSLog(@"----> assets progress : %f", progress);
//                weakSelf.currentProgressView.bottomTipLabel.text = [NSString stringWithFormat:@"%d%%", (int)(weakSelf.currentProgressView.progress*100)];
//            }];
//            [[WkkeeperQiniuManager sharedManager] uploadImagesWithDataArray:imageDatasArray withProgressView:progressView completion:^(BOOL success, NSMutableArray *paths) {
//                if (success) {
//                    if (block) {
//                        block(YES, paths, nil);
//                    }
//                }else{
//                    [progressView dismiss];
//                    [iToast  showCenter_ToastWithText:@"出错啦，再试一次哈！"];
//                }
//            }];
        });
        
    }else
    {
        if (block) {
            block(YES, nil, nil);
        }
    }
}

#pragma mark - 上传视频
- (void)uploadVideoAsset:(PHAsset *)asset completion:(void (^)(BOOL, id, id))block
{
    WEAKSELF;
    PHImageManager *manager = [PHImageManager defaultManager];
    
    UIScreen *screen    = UIScreen.mainScreen;
    CGFloat scale       = screen.scale;
    CGSize targetSize = CGSizeMake(CGRectGetWidth(screen.bounds) * scale, CGRectGetHeight(screen.bounds) * scale);
    
//    [[WkkeeperQiniuManager sharedManager] setCurrenProgressBlock:^(CGFloat progress){
//        NSLog(@"----> Progress : %f", progress);
//        weakSelf.currentProgressView.progress = progress*0.2f;
//        weakSelf.currentProgressView.bottomTipLabel.text = [NSString stringWithFormat:@"%d%%",(int)(progress*100*0.2f)];
//    }];
    
    [manager ctassetsPickerRequestImageForAsset:asset
                                     targetSize:targetSize
                                    contentMode:PHImageContentModeAspectFit
                                        options:self.requestOptions
                                  resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
        UIImage *image = [UIImage imageWithData:imageData];
                                                                        image = [image zipImageWithSize:CGSizeMake(1024, 1024)];
                                                                        
                                                                        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
                                                                        options.version = PHImageRequestOptionsVersionCurrent;
                                                                        options.deliveryMode = PHVideoRequestOptionsDeliveryModeFastFormat;
                                                                        
                                                                        [manager requestAVAssetForVideo:asset
                                                                                                options:options
                                                                                          resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                                                                                              AVURLAsset* myAsset = (AVURLAsset*)asset;
                                                                                              NSData * data = [NSData dataWithContentsOfFile:myAsset.URL.relativePath];
                                                                                              
                                                                                              if (data) {
                                                                                                  
//                                                                                                  NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
                                  //                                                                [[WkkeeperQiniuManager sharedManager] uploadImageWithData:imageData completion:^(BOOL img_success, NSString *img_fileUrl) {
                                  //
                                  //                                                                    if (img_success) {
                                  //                                                                        [[WkkeeperQiniuManager sharedManager] setCurrenProgressBlock:^(CGFloat progress){
                                  //                                                                            NSLog(@"----> Progress : %f", progress);
                                  //                                                                            weakSelf.currentProgressView.progress = 0.2f+progress*0.7f;
                                  //                                                                            weakSelf.currentProgressView.bottomTipLabel.text = [NSString stringWithFormat:@"%d%%",(int)(weakSelf.currentProgressView.progress*100)];
                                  //                                                                        }];
                                  //                                                                        [[WkkeeperQiniuManager sharedManager] uploadVideoData:data completion:^(BOOL success, NSString *fileUrl) {
                                  //
                                  //                                                                            if (success) {
                                  //                                                                                if (block) {
                                  //                                                                                    block(YES, @{@"path":img_fileUrl}, @{@"path":fileUrl});
                                  //                                                                                }
                                  //                                                                            }else{
                                  //                                                                                [weakSelf.currentProgressView dismiss];
                                  //                                                                                [iToast  showCenter_ToastWithText:@"出错啦，再试一次哈！"];
                                  //                                                                            }
                                  //                                                                        }];
                                  //                                                                    }else{
                                  //                                                                        [weakSelf.currentProgressView dismiss];
                                  //                                                                        [iToast  showCenter_ToastWithText:@"出错啦，再试一次哈！"];
                                  //                                                                    }
                                  //                                                                }];
                                                                                              }else{
                                                                                                  [weakSelf.currentProgressView dismiss];
                                                                                                  [iToast  showCenter_ToastWithText:@"出错啦，再试一次哈！"];
                                                                                              }
                                                                                          }];
                                                                    }];
}

@end

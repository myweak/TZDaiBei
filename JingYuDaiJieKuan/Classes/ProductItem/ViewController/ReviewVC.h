//
//  ReviewVC.h
//  JingYuDaiJieKuan
//
//  Created by JY on 2018/4/10.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "SuperVC.h"

@interface ReviewVC : SuperVC
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy)NSString *projectId;

@end

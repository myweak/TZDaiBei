//
//  STListFilterView.h
//  my
//
//  Created by soso-mac on 2016/11/21.
//  Copyright © 2016年 soso-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductItemModel.h"
#import "TZProductScreenConditionProvinceModel.h"

@protocol STListFilterViewDelegate <NSObject>

@optional
-(void)g_setSelecetFilter:(id)result;
@required
@end

@interface STListFilterView : UIView
@property(assign,nonatomic)id<STListFilterViewDelegate>delegate;
@property (strong,nonatomic)sortListModel *sortListModel;
@property (strong,nonatomic)TZProductScreenConditionDateModel *condiTionListModel;
// 筛选回调
@property (copy,nonatomic) void (^backFilterClickBlock) (NSInteger tags
,TZProductScreenConditionDateModel *model
, TZLoanDataModel *workModel
, TZLoanDataModel *typeModel);

// 筛选回调
@property (copy,nonatomic) void (^filterClickBlock) (NSString *tags
                                                    , NSInteger maxAmount
                                                    , NSInteger mixAmount
                                                    , NSInteger maxLimit
                                                    , NSInteger mixLimit);
/// 重置筛选条件
- (void)clickResetButton;

-(void)dismiss;
- (void)reloadData;
@end

//
//  TZChooseProvinceAndCityView.h
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/7.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZProductScreenConditionProvinceModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TZChooseProvinceAndCityTableViewDelegate <NSObject>

@optional
// 选中筛选项触发
- (void)TZChooseProvinceAndCityTableViewDelegateWithCityModel:(TZCityModel *)model andIndex:(NSInteger)index;
@end

@interface TZChooseProvinceAndCityTableView : UITableView

- (instancetype)initWithFrame:(CGRect)frame andDataArr:(NSArray *)arr;

@property (nonatomic,weak) id<TZChooseProvinceAndCityTableViewDelegate> sortDelegate;
/** 选中的数据*/
@property (nonatomic,strong) NSMutableArray *sortArr;
/** 选中的cell
 *  对外接口 可能会有用的情况
 *  参数为需要被选中的cell显示的string
 */
@property (nonatomic,copy) NSString *selectedCell;

@property (nonatomic,strong) NSArray *dateArray;
@property (nonatomic,strong) NSArray *subDateArray;
@property (nonatomic,strong) NSArray *currentArray;


/** didSelect处理好数据调用此方法*/
-(void)bindChoseArraySort:(NSArray *)sortAry;

-(void)dismiss;


- (void)postConditonProvinceUrl;





NS_ASSUME_NONNULL_END

@end

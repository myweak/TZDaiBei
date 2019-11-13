//
//  TZChooseProvinceAndCityView.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/7.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZChooseProvinceAndCityTableView.h"
#import "QZSortCell.h"
#import "UIView+Extension.h"
#import "QZSortHeaderView.h"
#import "ProductItemViewModel.h"

@interface TZChooseProvinceAndCityTableView()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _selectedIndex;   // 记录被选中的cell
}
@property (nonatomic, strong) QZSortHeaderView *headerView;

@end

@implementation TZChooseProvinceAndCityTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _dateArray = [[NSMutableArray alloc] init];
        _subDateArray = [[NSMutableArray alloc] init];
        
        self.backgroundColor=[UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[QZSortCell class] forCellReuseIdentifier:@"cell"];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self postConditonProvinceUrl];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andDataArr:(NSArray *)arr{
    TZChooseProvinceAndCityTableView *tab =  [self initWithFrame:frame];
    tab.currentArray = arr;
    return tab;
}


- (QZSortHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[QZSortHeaderView alloc] init];
        _headerView.userInteractionEnabled = YES;
        [_headerView addLine_bottom];
        @weakify(self)
        [_headerView.mianLabel handleTap:^(CGPoint loc, UIGestureRecognizer *tapGesture) {
            @strongify(self)
            self.headerView.mainBotttomLineView.hidden = NO;
            self.headerView.subLabel.text = @"";
            self.currentArray = self.dateArray;
            [self reloadData];
        }];
        _headerView.backTapBtnActionBlock = ^(UIButton * _Nonnull btn) {
          @strongify(self)
            // 回调处理
            if (self.sortDelegate && [self.sortDelegate respondsToSelector:@selector(TZChooseProvinceAndCityTableViewDelegateWithCityModel:andIndex:)]) {
                TZCityModel *model = [TZCityModel new];
                model.quxianName = btn.currentTitle;
                [self.sortDelegate TZChooseProvinceAndCityTableViewDelegateWithCityModel:model andIndex:-1];
            }
        };
    }
    return _headerView;
}


#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _currentArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    QZSortCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [QZSortCell sortCell];
    }
    if (indexPath.row == _selectedIndex) {
        cell.markView.hidden = NO;
        cell.textLabel.textColor = UIColorFromRGB(0x39bae8);
    }else{
        cell.markView.hidden = YES;
        cell.textLabel.textColor = UIColorFromRGB(0x333333);
    }
    id  obj = _currentArray[indexPath.row];
    NSString *title = @"";
    if ([obj isKindOfClass:[TZProvinceModel class]]) {
        TZProvinceModel *model = (TZProvinceModel*)obj;
        title = model.cityName;

    }else if ([obj isKindOfClass:[TZCityModel class]]) {
        TZCityModel *model = (TZCityModel*)obj;
        title = model.quxianName;
        
    }else if ([obj isKindOfClass:[NSString class]]) {
        title = obj;
    }
    cell.textLabel.text = title;

    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id  obj = _currentArray[indexPath.row];

    // reset other cells color
    for (NSInteger i = 0; i < _currentArray.count; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        QZSortCell *cell = [tableView cellForRowAtIndexPath:path];
        cell.markView.hidden = YES;
        cell.textLabel.textColor = UIColorFromRGB(0x333333);
    }
    
    QZSortCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.markView.hidden = NO;
    cell.textLabel.textColor = UIColorFromRGB(0x39bae8);
    NSArray *arr = @[_currentArray[indexPath.row]];
    _selectedIndex = indexPath.row;
 
    if ([obj isKindOfClass:[TZProvinceModel class]]) {
        TZProvinceModel *model = (TZProvinceModel*)obj;
        self.headerView.mianLabel.text = model.cityName;
        self.headerView.mainBotttomLineView.hidden = YES;
        self.headerView.subLabel.text = @"";
            [self postConditonCityUrlWithCityId:model.cityid block:^{
                [self reloadData];
            }];
        
    }else if ([obj isKindOfClass:[TZCityModel class]]) {
        TZCityModel *model = (TZCityModel*)obj;
        self.headerView.subLabel.text  = model.quxianName;
        // 回调处理
        if (self.sortDelegate && [self.sortDelegate respondsToSelector:@selector(TZChooseProvinceAndCityTableViewDelegateWithCityModel:andIndex:)]) {
            [self.sortDelegate TZChooseProvinceAndCityTableViewDelegateWithCityModel:model andIndex:indexPath.row];
        }
    }else if ([obj isKindOfClass:[NSString class]]) {
        
    }
    
    

    
    
}

-(void)dismiss
{
    [UIView animateWithDuration:0.1 animations:^{
        self.height=0;
    }];
}

#pragma mark - lazyLoad


#pragma mark - 设置默认显示
- (void)setSelectedCell:(NSString *)selectedCell
{
    // 显示View之前会给sortView.selectedCell赋值 继而处理选中cell reload
    _selectedCell = selectedCell;
    // 处理默认显示
    
//    if ([self.dateArray containsObject:selectedCell]) {
//        self.currentArray = self.dateArray;
//    }else if ([self.subDateArray containsObject:selectedCell]){
//        self.currentArray = self.subDateArray;
//    }
    
    _selectedIndex = [self.currentArray indexOfObject:_selectedCell];
    if ([_selectedCell isEqualToString:@""] || _selectedCell == nil){
        _selectedIndex = 0;
    }
    
    [self reloadData];
}

- (void)setCurrentArray:(NSArray *)currentArray{
    _currentArray = currentArray;
    self.height = MIN(currentArray.count, 8) * 44;
}





// 城市
- (void)postConditonCityUrlWithCityId:(NSString *)cityId block:(void(^)(void)) succeess{
    @weakify(self)
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(1) forKey:@"cityId"];
    NSString *strName =  [[NSString stringWithFormat:@"%@/%@",API_getTwoTierCities_path,cityId] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [ProductItemViewModel conditionPath:strName params:nil target:self modelClass:[TZProductScreenConditionCityModel class] success:^(id  _Nonnull model) {
        @strongify(self)
//        NSMutableArray *arr = [NSMutableArray array];
        TZProductScreenConditionCityModel *models = (TZProductScreenConditionCityModel *)model;
//        [models.list enumerateObjectsUsingBlock:^(TZCityModel  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [arr addObject:obj.quxianName];
//        }];
        self.currentArray = models.list;
        succeess();
        //        self.conditionFilterView.dataAry11 = arr;
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
// 省份
- (void)postConditonProvinceUrl{
    @weakify(self)
    [ProductItemViewModel conditionPath:API_getFirstTierCities_path params:nil target:self modelClass:[TZProductScreenConditionProvinceModel class] success:^(id  _Nonnull model) {
        @strongify(self)
//        NSMutableArray *arr = [NSMutableArray array];
        TZProductScreenConditionProvinceModel *models = (TZProductScreenConditionProvinceModel *)model;
//        [models.list enumerateObjectsUsingBlock:^(TZProvinceModel  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [arr addObject:obj.cityName];
//        }];
        //        self.provinceArr = models.list;
        //        self.conditionFilterView.dataAry1 = arr;
        //        self.conditionFilterView.dataAry11 = arr;
        //        self.selectedCell = [NSString stringWithFormat:@"%@",_dataSource1.firstObject];
         self.dateArray = models.list;
        self.currentArray = models.list;
        [self reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}



@end

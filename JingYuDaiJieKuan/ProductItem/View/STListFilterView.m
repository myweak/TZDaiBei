
//
//  STListFilterView.m
//  my
//
//  Created by soso-mac on 2016/11/21.
//  Copyright © 2016年 soso-mac. All rights reserved.
//

#import "STListFilterView.h"
#import "STListFilterViewCell.h"
#import "STListFilterHeadView.h"
#import "STlistFilterFootView.h"
#import "UIColor+STMyIColor.h"

@interface STListFilterView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,STlistFilterFootViewDelegte>{
    NSArray *filterAry;
    BOOL isFilter;
    NSMutableArray *amountAry;
    NSMutableArray *limitAry;
    NSMutableArray *tagAry;
}
@property(strong,nonatomic)UICollectionView *filterCollectionV;
@property(strong,nonatomic)UICollectionViewFlowLayout *filterFlowL;
@property (nonatomic, strong)UIView * createBottomView;



@end

@implementation STListFilterView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
      
        [self addTheCollectionView];
        
        [self addSubview:self.createBottomView];
        [self.createBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(kiP6WidthRace(44));
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
    }
    return self;
}
-(void)addTheCollectionView{
    _filterFlowL = [UICollectionViewFlowLayout new];
    _filterFlowL.minimumInteritemSpacing = 1.f;
    [_filterFlowL setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _filterCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:_filterFlowL];
    _filterCollectionV.backgroundColor = [UIColor whiteColor];
    _filterCollectionV.delegate = self;
    _filterCollectionV.dataSource = self;
    
    [_filterCollectionV registerClass:[STListFilterViewCell class] forCellWithReuseIdentifier:@"FilterCell"];
    
    [_filterCollectionV registerClass:[STListFilterHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FilterHeadView"];
    
     [_filterCollectionV registerClass:[STlistFilterFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FilterFootView"];
    
    [self addSubview:_filterCollectionV];
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self                                                                                    action:@selector(handleSwipe:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [_filterCollectionV addGestureRecognizer:recognizer];
}

#pragma mark --Setter

- (void)setCondiTionListModel:(TZProductScreenConditionDateModel *)condiTionListModel{
    _condiTionListModel = condiTionListModel;
    amountAry = [[NSMutableArray alloc] initWithArray: condiTionListModel.occupation];
    limitAry =[[NSMutableArray alloc] initWithArray: condiTionListModel.typesOfMortgage];

    filterAry = [[NSArray alloc]initWithObjects:amountAry,limitAry, nil];
    //设置筛选按钮
    [self.filterCollectionV reloadData];
    
}

#pragma mark --UICollectionView dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return filterAry.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [filterAry[section] count];
}
//每个单元格的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    STListFilterViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FilterCell" forIndexPath:indexPath];
    TZLoanDataModel *model = filterAry[indexPath.section][indexPath.row];
    [cell setFilterIndexPath:indexPath andfilterModel:model];
   
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.frame.size.width/3 - kiP6WidthRace(20), kiP6WidthRace(33));
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 20, 5, 20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
        if (section == 0) {
            return CGSizeMake(self.frame.size.width,kiP6WidthRace(44));
        }else{
    return CGSizeMake(self.frame.size.width,kiP6WidthRace(44));
        }
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *reusableView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FilterHeadView" forIndexPath:indexPath];
        
        for (UIView *view in reusableView.subviews) {
            [view removeFromSuperview];
        }
        
      
        
        STListFilterHeadView *headerView = [STListFilterHeadView new];
        headerView.frame = CGRectMake(0, 0, self.frame.size.width, kiP6WidthRace(44));
        [headerView setFilterTitle:@[@"职业身份",@"抵押类型"][indexPath.section] andIndex:indexPath.section];
        headerView.titleLab.left = 15;
        [headerView.titleLab addLine_top];
        [reusableView addSubview:headerView];
        reusableView.backgroundColor = [UIColor whiteColor];
        headerView.backgroundColor = [UIColor whiteColor];

        
        return reusableView;
    }else if(kind == UICollectionElementKindSectionFooter){
            UICollectionReusableView *reusableView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FilterFootView" forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor whiteColor];
        for (UIView *view in reusableView.subviews) {
            [view removeFromSuperview];
        }
        
            STlistFilterFootView *footerView = [STlistFilterFootView new];
            footerView.frame = CGRectMake(0, 0, self.frame.size.width, 60);
            footerView.delegate = self;
            [footerView setAddBtn];
            footerView.backgroundColor = [UIColor redColor];
            [reusableView addSubview:footerView];
        return reusableView;
    }
    return nil;
}

- (UIView *)createBottomView {
    if (!_createBottomView) {
        _createBottomView = [[UIView alloc] initWithFrame:CGRectZero];
        //resetButton
        UIButton *resetButton = [[UIButton alloc] init];
        [resetButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [resetButton addTarget:self action:@selector(clickResetButton) forControlEvents:UIControlEventTouchUpInside];
        [resetButton.titleLabel setFont:KFont(16)];
        [resetButton setTitleColor:UIColorHex(@"#666666") forState:UIControlStateNormal];
        NSString *resetString = @"重置";
        if ([resetString isEqualToString:@"sZYFilterReset"]) {
            resetString = @"Reset";
        }
        [resetButton setTitle:resetString forState:UIControlStateNormal];
        [resetButton setBackgroundColor:[UIColor whiteColor]];
        [_createBottomView addSubview:resetButton];
        [resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(kScreenWidth/2);
        }];
        //commitButton
        UIButton *commitButton = [[UIButton alloc] init];
        [commitButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [commitButton addTarget:self action:@selector(clickCommitButton:) forControlEvents:UIControlEventTouchUpInside];
        [commitButton.titleLabel setFont:KFont(16)];
        [commitButton setTitleColor:UIColorHex(@"#ffffff") forState:UIControlStateNormal];
        NSString *commitString = @"确定";
        if ([commitString isEqualToString:@"sZYFilterCommit"]) {
            commitString = @"Commit";
        }
        [commitButton setTitle:commitString forState:UIControlStateNormal];
        [commitButton setBackgroundColor:UIColorHex(@"0x3a80ff")];
        [_createBottomView addSubview:commitButton];
        [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(resetButton.mas_right);
            make.width.mas_equalTo(kScreenWidth/2);
        }];

        [self addShadowToView:_createBottomView withColor:kColorSeparatorline];
    }
    return _createBottomView;
}

/// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 1;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 5;
}

/// 确定按钮
- (void)clickCommitButton:(id)sender {
    
    TZLoanDataModel *amountModel;
    for (TZLoanDataModel *model in amountAry) {
        if (model.isSelected) { amountModel = model;}
    }
    
    TZLoanDataModel *limitModel;
    for (TZLoanDataModel *model in limitAry) {
        if (model.isSelected) { limitModel = model;}
    }
    self.condiTionListModel.occupation = amountAry;
    self.condiTionListModel.typesOfMortgage = limitAry;
    
    if (self.backFilterClickBlock) { // 数据回调
        self.backFilterClickBlock(0, self.condiTionListModel,amountModel, limitModel);
    }
    
    
}

/// 重置筛选条件
- (void)clickResetButton{
    
    for (NSInteger i = 0; i<filterAry.count; i++) {
        for (NSInteger j = 0; j<[filterAry[i] count]; j++) {
            TZLoanDataModel *model = filterAry[i][j];
            if (j == 0){
                model.isSelected = YES;
            } else {
                model.isSelected = NO;
            }
        }
    }
    [self.filterCollectionV reloadData];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 3) {
         return CGSizeMake(self.frame.size.width,60);
    }
    return  CGSizeMake(self.frame.size.width,0);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    //可以多选
    if (indexPath.section ==2) {
        ///反选此次点击的item
        TZLoanDataModel *model = filterAry[indexPath.section][indexPath.row];
        model.isSelected = !model.isSelected;
        
        if (indexPath.item == 0) {
            //全部清空
            NSArray *ary = filterAry[indexPath.section];
            //循环清空状态
            for (NSInteger i = 1; i < ary.count ; i++){
                TZLoanDataModel* model = ary[i];
                model.isSelected = NO;
            }
        } else {
            //操作"不限"标签,当有选择其他标签时清空"不限",没有选择任何一个标签是自动选择"不限"标签
            NSArray *ary = filterAry[indexPath.section];
            BOOL isSelectedOther = NO;
            for (NSInteger i = 0; i < ary.count ; i++){
                TZLoanDataModel* model = ary[i];
                isSelectedOther = isSelectedOther || model.isSelected;
                //如果已知是选择了的话,就直接可以跳出循环了
                if (isSelectedOther) { break; }
            }
            TZLoanDataModel *model = filterAry[indexPath.section][0];
            model.isSelected = !isSelectedOther;
        }
     
    } else {
        //单选
        ///勾上此次点击的item
        TZLoanDataModel *model = filterAry[indexPath.section][indexPath.row];
        model.isSelected = YES;
        
        //循环清空其他状态
        for (NSInteger i = 0; i < [filterAry[indexPath.section]count] ; i++){
            if (i == indexPath.item) { continue; }
            TZLoanDataModel* model = filterAry[indexPath.section][i];
            model.isSelected = NO;
        }
     
    }
   

    // 刷新section
     NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:indexPath.section];
    [self.filterCollectionV reloadSections:indexSet];
  
}

#pragma STlistFilterFootViewDelegte

-(void)g_setFinished{
    if (_delegate && [_delegate respondsToSelector:@selector(g_setSelecetFilter:)]) {
        [_delegate g_setSelecetFilter:nil];
    }
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)recognizer {
    if (_delegate && [_delegate respondsToSelector:@selector(g_setSelecetFilter:)]) {
        [_delegate g_setSelecetFilter:nil];
    }
};


-(void)dismiss
{
    [UIView animateWithDuration:0.1 animations:^{
        self.height=0;
    }];
}

- (void)reloadData{
    [self.filterCollectionV reloadData];
}

@end

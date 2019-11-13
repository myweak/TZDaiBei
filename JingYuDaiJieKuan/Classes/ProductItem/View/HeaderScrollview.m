//
//  HeaderScrollview.m
//  ScrollviewDemo
//
//  Created by zzq on 2018/2/8.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import "HeaderScrollview.h"
#import "LookWeCollectionViewCell.h"

#define BottomLineColor [UIColor colorWithRed:247.0/255 green:247.0/255 blue:250.0/255 alpha:1]

@interface HeaderScrollview ()


/**<#添加注释#>**/
@property (nonatomic, strong) UICollectionView *mainCollectionView;

/**记录当前选择的 indexpath**/
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@end


@implementation HeaderScrollview

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpCollectionView];
    }
    return self;
}

//默认值设置为第一个
- (NSIndexPath *)currentIndexPath{
    if (!_currentIndexPath) {
        _currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    return _currentIndexPath;
}

- (void)setUpCollectionView{
    
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    //2.初始化collectionView
    _mainCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    [self addSubview:_mainCollectionView];
    _mainCollectionView.backgroundColor = [UIColor clearColor];
    _mainCollectionView.showsHorizontalScrollIndicator = NO;
//    //3.注册collectionViewCell
    [_mainCollectionView registerClass:[LookWeCollectionViewCell class] forCellWithReuseIdentifier:@"LookWeCollectionViewCell"];

    //4.设置代理
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    
    UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width,0.5)];
    bottomLine.backgroundColor = BottomLineColor;
    
    [self addSubview:bottomLine];
 
}

//设置一屏最多展示4个
- (CGFloat)getItemWidth{
    
    NSInteger maxCount = 4;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if (self.dataSource.count> maxCount) {
        return screenWidth/maxCount;
    }else{
        return  screenWidth/self.dataSource.count;
    }
}


#pragma mark -- 处理滑屏事件
- (void)scrollCollectionItemToDesWithDesIndex:(NSInteger)index{
    
    NSIndexPath *desIndexpath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.mainCollectionView  scrollToItemAtIndexPath:desIndexpath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    self.currentIndexPath = desIndexpath;
    [self.mainCollectionView reloadData];
    
}


#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"LookWeCollectionViewCell";
    LookWeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.m_titleLb.textColor = [UIColor blackColor];
    cell.m_lineView.hidden = YES;
    if (indexPath == self.currentIndexPath) {
        cell.m_titleLb.textColor = [UIColor colorWithRed:63.0/255 green:167.0/255 blue:1.0 alpha:1];
        
        cell.m_lineView.hidden = NO;
    }
    cell.m_titleLb.text = self.dataSource[indexPath.row];
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake([self getItemWidth], self.frame.size.height);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentIndexPath = indexPath;
    [collectionView reloadData];
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(header_disSelectRowAtIndexPath:)]) {
        [self.delegate header_disSelectRowAtIndexPath:indexPath];
    }
}


@end

//
//  QZFilterDataTableView.m
//  QZConditionFilterViewDemo
//
//  Created by MrYu on 16/9/21.
//  Copyright © 2016年 yu qingzhu. All rights reserved.
//

#import "QZFilterDataTableView.h"
#import "QZSortCell.h"
#import "UIView+Extension.h"

@interface QZFilterDataTableView()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _selectedIndex;   // 记录被选中的cell
}
@end

@implementation QZFilterDataTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _dateArray = [[NSMutableArray alloc] init];

        self.backgroundColor=[UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[QZSortCell class] forCellReuseIdentifier:@"cell"];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andDataArr:(NSArray *)arr{
    QZFilterDataTableView *tab =  [self initWithFrame:frame];
    tab.dateArray = arr;
    return tab;
}




-(void)bindChoseArraySort:(NSArray *)sortAry andIndex:(NSInteger) index
{
    [self.sortArr removeAllObjects];
    [self.sortArr addObjectsFromArray:sortAry];
    if (self.sortDelegate && [self.sortDelegate respondsToSelector:@selector(choseSort:andIndex:)]) {
        [self.sortDelegate choseSort:self.sortArr andIndex:index];
    }
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dateArray.count;
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
    cell.textLabel.text = _dateArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // reset other cells color
    for (NSInteger i = 0; i < _dateArray.count; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        QZSortCell *cell = [tableView cellForRowAtIndexPath:path];
        cell.markView.hidden = YES;
        cell.textLabel.textColor = UIColorFromRGB(0x333333);
    }
    
    QZSortCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.markView.hidden = NO;
    cell.textLabel.textColor = UIColorFromRGB(0x39bae8);
    NSArray *arr = @[_dateArray[indexPath.row]];
    _selectedIndex = indexPath.row;

    [self bindChoseArraySort:arr andIndex:indexPath.row]; // 回掉处理
}

-(void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.height=0;
    }];
}

#pragma mark - lazyLoad

- (NSMutableArray*)sortArr
{
    if (!_sortArr) {
        _sortArr = [NSMutableArray array];
    }
    return _sortArr;
}

#pragma mark - 设置默认显示
- (void)setSelectedCell:(NSString *)selectedCell
{
    // 显示View之前会给sortView.selectedCell赋值 继而处理选中cell reload
    _selectedCell = selectedCell;
    // 处理默认显示
    
    
    _selectedIndex = [self.dateArray indexOfObject:_selectedCell];
    if ([_selectedCell isEqualToString:@""] || _selectedCell == nil){
        _selectedIndex = 0;
    }
    
    [self reloadData];
}

- (void)setDateArray:(NSArray *)dateArray{
    _dateArray = dateArray;
    self.height = MIN(dateArray.count, 8) * 44;
}





@end

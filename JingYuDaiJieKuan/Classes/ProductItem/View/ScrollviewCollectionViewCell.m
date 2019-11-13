//
//  ScrollviewCollectionViewCell.m
//  JingYuDaiJieKuan
//
//  Created by JY on 2018/4/2.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "ScrollviewCollectionViewCell.h"
#import "CouponsCell.h"
@interface ScrollviewCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource>


@end


@implementation ScrollviewCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self initWithUI];
    }
    return self;
}

-(void)initWithUI
{
    [self addSubview:self.m_tableView];
}

- (void)setDataSource:(NSMutableArray *)dataSource{
    
    _dataSource = dataSource;
    [self.m_tableView reloadData];
}
#pragma getter
- (UITableView *)m_tableView
{
    if (!_m_tableView) {
        _m_tableView = InsertTableView(nil, CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.frame)), self, self, UITableViewStylePlain, UITableViewCellSeparatorStyleSingleLine);
        if (IS_iPhoneX) {
            _m_tableView.height = self.height;
        }
        
        if ([_m_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [_m_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([_m_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [_m_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return _m_tableView;
}

#pragma mark -- UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1: self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return KWidth(100);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
   CouponsCell *cell = [CouponsCell creatCellWithTableView:tableView];
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return section == 0 ? 0.01:10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(bodyCollection_didSelectRowWith:)]) {
            [self.delegate bodyCollection_didSelectRowWith:indexPath];
        }
        
    }
}


@end

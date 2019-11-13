//
//  RootCell.m
//  DKSTableCollcetionView
//
//  Created by aDu on 2017/10/10.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import "RootTableCell.h"
#import "RootCollectionCell.h"
#import "UserViewModel.h"


#define K_Cell @"cell"
@interface RootTableCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat heightED;

@property (nonatomic, strong) NSMutableArray *m_dataAry;

@end

@implementation RootTableCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self.heightED = 0;
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.collectionView];
        self.collectionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.contentView.frame.size.height);
        [self personalCenterHotToolsData];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
}



///personal/center/hot/tools/   热门工具
- (void)personalCenterHotToolsData
{
    [UserViewModel personalCenterHotToolsPath:personalCenterHotTools params:nil target:self success:^(HotToolListModel *model) {
        if (model.code == 200) {
            [self.m_dataAry addObjectsFromArray:model.list];
            //手动添加浏览历史
            HotToolModel *historyModel = [[HotToolModel alloc]init];
            historyModel.icon = @"user_history";
            historyModel.name = @"浏览记录";
            [self.m_dataAry addObject:historyModel];

            HotToolModel *aboutUs = [[HotToolModel alloc]init];
            aboutUs.icon = @"cooperation";
            aboutUs.name = @"商务合作";
            [self.m_dataAry addObject:aboutUs];
            
            HotToolModel *customeService = [[HotToolModel alloc]init];
            customeService.icon = @"customeService";
            customeService.name = @"专属客服";
            [self.m_dataAry addObject:customeService];
        }
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark ====== UICollectionViewDelegate ======
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.m_dataAry.count == 0) {
        return 1;
    } else {
        return self.m_dataAry.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RootCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:K_Cell forIndexPath:indexPath];
    if (self.m_dataAry.count >0) {
        LUserModel *model = self.m_dataAry[indexPath.row];
        cell.m_label.text = model.name;
        if ([model.name isEqualToString:@"浏览记录"]||[model.name isEqualToString:@"商务合作"]||[model.name isEqualToString:@"专属客服"]){
            cell.m_imageView.image = [UIImage imageNamed:model.icon];
        }else{
            [cell.m_imageView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
        }
    }
   
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemAtIndexPath:withContent:andIsWeb:cooperation:)]) {
        
        LUserModel *model =self.m_dataAry[indexPath.row];
//        [self.delegate didSelectItemAtIndexPath:indexPath withContent:model.url andIsWeb:@"浏览记录"
        if ([model.name isEqualToString:@"浏览记录"]||[model.name isEqualToString:@"商务合作"]||[model.name isEqualToString:@"专属客服"]) {
            [self.delegate didSelectItemAtIndexPath:indexPath withContent:model.url andIsWeb:NO cooperation:model.name];
        } else {
            [self.delegate didSelectItemAtIndexPath:indexPath withContent:model.url andIsWeb:YES cooperation:model.name];
        }
    }
}

#pragma mark ====== init ======
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - 50) / 4;
        layout.itemSize = CGSizeMake(width, 60);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[RootCollectionCell class] forCellWithReuseIdentifier:K_Cell];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (void)setDataAry:(NSArray *)dataAry {
//    [self.collectionView reloadData];
    self.heightED = 0;
//    _dataAry = self.dataAry;
}

- (NSMutableArray *)m_dataAry
{
    if (!_m_dataAry) {
        _m_dataAry = [[NSMutableArray alloc] init];
    }
    return _m_dataAry;
}
@end

//
//  ReviewVC.m
//  JingYuDaiJieKuan
//
//  Created by JY on 2018/4/10.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "ReviewVC.h"
#import "ReviewCollectionViewCell.h"
#import "TransactionRecordsModel.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
static NSString *ReviewCollectionViewCellID = @"ReviewCollectionViewCellID";

@interface ReviewVC ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *m_dataArray;

@end

@implementation ReviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"审核资料";
     self.view.frame = self.view.bounds;
    [self initView];
    [self projectGetProductCheckDattumPathData];
   
}

- (void)initView
{
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[ReviewCollectionViewCell class] forCellWithReuseIdentifier:ReviewCollectionViewCellID];
}

- (void)projectGetProductCheckDattumPathData
{
    kSelfWeak;
     NSMutableDictionary *dic = (NSMutableDictionary *)@{@"productId":self.projectId};
    [CustomLoadingView showLoadingView:self.view];
    [TransactionRecordsModel projectGetProductCheckDattumPath:projectGetProductCheckDattum params:dic target:self success:^(TransactionRecordsListModel *model) {
        
        [weakSelf.m_dataArray removeAllObjects];
        
        if (model.code == 200) {
            if (model.list && [model.list isKindOfClass:[NSArray class]]) {
                
                [weakSelf.m_dataArray addObjectsFromArray:model.list];
            }
        
            [weakSelf.collectionView reloadData];
        }else
        {
            weakSelf.m_dataArray= nil;
        }
        [CustomLoadingView hiddenLoadingView:weakSelf.view];

    } failure:^(NSError *error) {
        [CustomLoadingView hiddenLoadingView:weakSelf.view];

    }];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _m_dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ReviewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ReviewCollectionViewCellID forIndexPath:indexPath];
    TransactionListDataModel *model = self.m_dataArray[indexPath.row];
    [cell getCellData:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ReviewCollectionViewCell *cell = (ReviewCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    NSMutableArray *photos = [NSMutableArray array];
    for(int i = 0;i < self.m_dataArray.count;i ++)
    {
        TransactionListDataModel *model = self.m_dataArray[i];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:model.value];
        photo.srcImageView = cell.m_imageView;
        [photos addObject:photo];
    }
    browser.photos = photos;
    browser.currentPhotoIndex = indexPath.row;
    [browser show];
}

#pragma getter

- (NSMutableArray *)m_dataArray
{
    if (!_m_dataArray) {
        _m_dataArray = [[NSMutableArray alloc] init];
    }
    return _m_dataArray;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        CGFloat padding = 10;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10, padding, 0, padding);
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 10;
        CGFloat w = (kScreenWidth -20 - 10*1)/2;
        layout.itemSize = CGSizeMake(w,w);
        
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kBodyHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

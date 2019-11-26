//
//  QZConditionFilterView.m
//  QZConditionFilterViewDemo
//
//  Created by MrYu on 16/9/21.
//  Copyright © 2016年 yu qingzhu. All rights reserved.
//

#import "QZConditionFilterView.h"
#import "QZFilterDataTableView.h"
#import "UIView+Extension.h"
#import "TZChooseProvinceAndCityTableView.h"

@interface QZConditionFilterView()<STListFilterViewDelegate,QZFilterDataTableViewDelegate,TZChooseProvinceAndCityTableViewDelegate>
{
    // 第1组筛选 按钮
    UIButton *_dataSource1Btn;
    // 第2组筛选 按钮
    UIButton *_dataSource2Btn;
    // 第3组筛选 按钮
    UIButton *_dataSource3Btn;
    // 第3组筛选 按钮
    UIButton *_dataSource4Btn;
    // 选中的按钮
    UIButton *_selectBtn;
    // 下拉黑色半透明背景
    UIView *_bgView;
    
    // 对应三个下拉框
    TZChooseProvinceAndCityTableView *_filterTableView1;
    QZFilterDataTableView *_filterTableView2;
    
    
    
    
    
    
    
    BOOL _isShow;
}

@property (nonatomic,strong) FilterBlock filterBlock;
// 筛选 View
@property (nonatomic, strong) STListFilterView *m_selectView;
// 存储 tableView didSelected数据 数据来源：FilterDataTableView
@property (nonatomic, strong) NSArray *dataSource1;
@property (nonatomic, strong) NSArray *dataSource2;
@property (nonatomic, strong) NSArray *dataSource3;
@property (nonatomic, strong) NSArray *dataSource4;
@end


@implementation QZConditionFilterView

+(instancetype)conditionFilterViewWithFilterBlock:(FilterBlock)filterBlock
{
    QZConditionFilterView *conditionFilter = [[QZConditionFilterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [conditionFilter createSubView];
    conditionFilter.filterBlock=filterBlock;
    [conditionFilter addLine_bottom];
    return conditionFilter;
}

- (void)createSubView
{
    self.backgroundColor=[UIColor whiteColor];
    _isShow = NO;
    
    CGFloat tapItem_W = (SCREEN_WIDTH-1)/4.0f;
    
    // 不用设置默认显示数据，在外边设置 bindChoseArray重置就会刷新
    _dataSource1Btn = [self buttonWithLeftTitle:@"" titleColor:CP_ColorMBlack Font:[UIFont systemFontOfSize:14] backgroundColor:[UIColor whiteColor] RightImageName:@"PR_filter_choice" Frame:CGRectMake(0, 0, tapItem_W, 40)];
    [_dataSource1Btn setTitleColor:Bg_Btn_Colorblue forState:UIControlStateSelected];
    [_dataSource1Btn setImage:[UIImage imageNamed:@"PR_filter_choice_top"] forState:UIControlStateSelected];
    [_dataSource1Btn addTarget:self action:@selector(filterChoseData:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_dataSource1Btn];
    
//    UILabel *middleLine=[[UILabel alloc] initWithFrame:CGRectMake(_dataSource1Btn.x+_dataSource1Btn.width, 8 , 0.5, 24)];
//    middleLine.backgroundColor=UIColorFromRGB(0xe6e6e6);
//    [self addSubview:middleLine];
    
    _dataSource2Btn = [self buttonWithLeftTitle:@"" titleColor:CP_ColorMBlack Font:[UIFont systemFontOfSize:14] backgroundColor:[UIColor whiteColor] RightImageName:@"PR_filter_choice" Frame:CGRectMake(_dataSource1Btn.x+_dataSource1Btn.width+0.5, 0, tapItem_W, 40)];
    [_dataSource2Btn setTitleColor:Bg_Btn_Colorblue forState:UIControlStateSelected];
    [_dataSource2Btn setImage:[UIImage imageNamed:@"PR_filter_choice_top"] forState:UIControlStateSelected];
    [_dataSource2Btn addTarget:self action:@selector(filterChoseData:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_dataSource2Btn];
    
//
//    UILabel *middleLine2=[[UILabel alloc] initWithFrame:CGRectMake(_dataSource2Btn.x+_dataSource2Btn.width, 8 , 0.5, 24)];
//    middleLine2.backgroundColor=UIColorFromRGB(0xe6e6e6);
//    [self addSubview:middleLine2];
    
    _dataSource3Btn = [self buttonWithLeftTitle:@"" titleColor:CP_ColorMBlack Font:[UIFont systemFontOfSize:14] backgroundColor:[UIColor whiteColor] RightImageName:@"PR_filter_choice" Frame:CGRectMake(_dataSource2Btn.x+_dataSource2Btn.width+0.5, 0, tapItem_W, 40)];
    [_dataSource3Btn setTitleColor:Bg_Btn_Colorblue forState:UIControlStateSelected];
    [_dataSource3Btn setImage:[UIImage imageNamed:@"PR_filter_choice_top"] forState:UIControlStateSelected];
    [_dataSource3Btn addTarget:self action:@selector(filterChoseData:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_dataSource3Btn];
    
    
//    UILabel *middleLine3=[[UILabel alloc] initWithFrame:CGRectMake(_dataSource3Btn.x+_dataSource3Btn.width, 8 , 0.5, 24)];
//    middleLine3.backgroundColor=UIColorFromRGB(0xe6e6e6);
//    [self addSubview:middleLine3];
    
    _dataSource4Btn = [self buttonWithLeftTitle:@"" titleColor:CP_ColorMBlack Font:[UIFont systemFontOfSize:14] backgroundColor:[UIColor whiteColor] RightImageName:@"tz_cho_nor" Frame:CGRectMake(_dataSource3Btn.x+_dataSource3Btn.width+0.5, 0, tapItem_W, 40)];
    [_dataSource4Btn setTitleColor:Bg_Btn_Colorblue forState:UIControlStateSelected];
    [_dataSource4Btn setImage:[UIImage imageNamed:@"tz_cho_sel"] forState:UIControlStateSelected];
    [_dataSource4Btn addTarget:self action:@selector(filterChoseData:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_dataSource4Btn];
    
    
    
//    UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5)];
//    bottomLine.backgroundColor=UIColorFromRGB(0xe6e6e6);
//    [self addSubview:bottomLine];
    
    _dataSource1Btn.tag = 1;
    _dataSource2Btn.tag = 2;
    _dataSource3Btn.tag = 3;
    _dataSource4Btn.tag = 4;
    _dataSource1Btn.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    _dataSource2Btn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    _dataSource3Btn.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    _dataSource4Btn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    _dataSource4Btn.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    
}



-(UIButton *)buttonWithLeftTitle:(NSString *)title titleColor:(UIColor *)titleColor Font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor RightImageName:(NSString *)imageName Frame:(CGRect)frame
{
    
    titleColor=titleColor?:[UIColor blackColor];
    font=font?:[UIFont systemFontOfSize:13.0];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    btn.backgroundColor=backgroundColor;
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:font}];
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat space = 5;
    
    CGFloat edgeSpace = (btn.width-(titleSize.width+image.size.width+space))/2+titleSize.width+space;
    
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, -edgeSpace)];
    [btn setImage:image forState:UIControlStateNormal];
    
    CGFloat titleSpace =-image.size.width-space*2;
    if((int)SCREEN_HEIGHT%736 != 0)
    {
        titleSpace =-image.size.width-3*space;
    }
    
    [btn.titleLabel setContentMode:UIViewContentModeCenter];
    [btn.titleLabel setFont:font];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0,
                                             titleSpace,
                                             0.0,
                                             0.0)];
    [btn setTitle:title forState:UIControlStateNormal];
    
    return btn;
}

- (void)filterChoseData:(UIButton *)btn
{
    btn.selected=!btn.selected;
    if (btn.selected) {
        [self showWithData:self.dataAry1 button:btn];
        _selectBtn=btn;
    }else{
        [self dismiss];
    }
}


#pragma mark - 显示下拉框
-(void)showWithData:(NSArray *)type button:(UIButton *)btn
{
    [self prepareUIWithBtn:btn];
    _isShow=YES;
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    if (_selectBtn && _selectBtn != btn) {
        _selectBtn.selected=NO;
    }
}
- (void)prepareUIWithBtn:(UIButton *)btn
{
    @weakify(self)
    
    [_filterTableView1 dismiss];
    [_filterTableView2 dismiss];
    self.m_selectView.hidden =YES;
    _filterTableView3.hidden = YES;

    CGFloat star_top = kNavBarH+ self.bottom;
    [self prepareBgView];
    if (btn == _dataSource1Btn) {
        if (!_filterTableView1) {
            _filterTableView1 = [[TZChooseProvinceAndCityTableView alloc] initWithFrame:CGRectMake(0, star_top, self.width, 0)];
            _filterTableView1.sortDelegate = self;
        }
        
        //        _filterTableView1.currentArray = self.dataAry1;
        _filterTableView1.selectedCell = [NSString stringWithFormat:@"%@",_dataSource1.firstObject];
        [[UIApplication sharedApplication].keyWindow addSubview:_filterTableView1];
        [_filterTableView1 setCurrentArray:_filterTableView1.currentArray];
        [_filterTableView1 reloadData];
        
//        [_filterTableView2 dismiss];
        //        [_filterTableView3 dismiss];
    }else if (btn == _dataSource2Btn){
        _filterTableView2 = [[QZFilterDataTableView alloc] initWithFrame:CGRectMake(0, star_top, self.width, 0)];
        _filterTableView2.sortDelegate = self;
        _filterTableView2.dateArray = self.dataAry2;
        if (_dataSource2.count == 0) {
            _dataSource2 = @[@"不限期限"];
        }
        _filterTableView2.selectedCell = [NSString stringWithFormat:@"%@",_dataSource2.firstObject];
        
        [[UIApplication sharedApplication].keyWindow addSubview:_filterTableView2];
//        [_filterTableView1 dismiss];
        //        [_filterTableView3 dismiss];
        
    }else if (btn == _dataSource3Btn){
        _filterTableView3 = [[TZConditionMoneyView alloc] initWithFrame:CGRectMake(0, star_top, self.width, 97)];
        _filterTableView3.backTapBtnActionBlock = ^(NSString *title) {
            @strongify(self)
            [self choseSort:@[title] andIndex:0];
            
        };
        _filterTableView3.hidden = NO;
        
        dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self)
            [self.filterTableView3.textField becomeFirstResponder];

        });
        [[UIApplication sharedApplication].keyWindow addSubview:_filterTableView3];
//        [_filterTableView1 dismiss];
//        [_filterTableView2 dismiss];
        return;
    }else if (btn == _dataSource4Btn){
        
        self.m_selectView.hidden = NO;
        self.m_selectView.top = star_top;
        self.m_selectView.height = iPH(330);
        self.m_selectView.condiTionListModel = [self.condiTionListModel copy];
        [[UIApplication sharedApplication].keyWindow addSubview:self.m_selectView];
        
    }
    [_filterTableView3.textField resignFirstResponder];
}

#pragma mark - 准备灰色背景图
- (void)prepareBgView
{
    if (_bgView)  return;
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavBarH +self.y+self.height, self.width, SCREEN_HEIGHT-(self.y+self.height))];
    _bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [_bgView addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow addSubview:_bgView];
    
}

#pragma mark - 从外部传入条件
-(void)choseSortFromOutsideWithFirstSort:(NSArray *)firstAry WithSecondSort:(NSArray *)secondAry WithThirdSort:(NSArray *)thirdAry WithFourthSort:(NSArray *)fourthAry
{
    if (firstAry != nil) {
        [self changeBtn:_dataSource1Btn Text:[NSString stringWithFormat:@"%@",firstAry.firstObject] Font:[UIFont systemFontOfSize:14] ImageName:@"PR_filter_choice"];
        _dataSource1 = firstAry;
    }
    if (secondAry != nil) {
        [self changeBtn:_dataSource2Btn Text:[NSString stringWithFormat:@"%@",secondAry.firstObject] Font:[UIFont systemFontOfSize:14] ImageName:@"PR_filter_choice"];
        _dataSource2 = secondAry;
    }
    
    if (thirdAry != nil) {
        [self changeBtn:_dataSource3Btn Text:[NSString stringWithFormat:@"%@",thirdAry.firstObject] Font:[UIFont systemFontOfSize:14] ImageName:@"PR_filter_choice"];
        _dataSource3 = thirdAry;
    }
    
    [self dismiss];
    BOOL isFilter = YES;
    if (self.filterBlock) {
        self.filterBlock(isFilter,_dataSource1,_dataSource2,_dataSource3,_dataSource4);
    }
    
}

#pragma mark - TZChooseProvinceAndCityTableViewDelegate q地区 选择筛选项
-(void)TZChooseProvinceAndCityTableViewDelegateWithCityModel:(TZCityModel *)model andIndex:(NSInteger)index{
    [self choseSort:@[model.quxianName] andIndex:index];
}

#pragma mark - QZFilterDataTableViewDelegate 选择筛选项
-(void)choseSort:(NSArray *)sortAry andIndex:(NSInteger)index
{
    if (_dataSource1Btn.selected) {
        // 改变btn显示的数据
        [self changeBtn:_dataSource1Btn Text:[NSString stringWithFormat:@"%@",sortAry.firstObject] Font:[UIFont systemFontOfSize:14] ImageName:@"PR_filter_choice"];
        // 存储显示的数据
        _dataSource1 = sortAry;
    }else if (_dataSource2Btn.selected){
        [self changeBtn:_dataSource2Btn Text:[NSString stringWithFormat:@"%@",sortAry.firstObject] Font:[UIFont systemFontOfSize:14] ImageName:@"PR_filter_choice"];
        _dataSource2 = sortAry;
    }else if (_dataSource3Btn.selected){
        [self changeBtn:_dataSource3Btn Text:[NSString stringWithFormat:@"%@",sortAry.firstObject] Font:[UIFont systemFontOfSize:14] ImageName:@"PR_filter_choice"];
        _dataSource3 = sortAry;
    }else if (_dataSource4Btn.selected){
        _dataSource4 = sortAry;
    }
    
    
    [self dismiss];
    // 选择筛选条件，直接开始网络请求
    BOOL isFilter = YES;
    if (self.filterBlock) {
        self.filterBlock(isFilter,_dataSource1,_dataSource2,_dataSource3,_dataSource4);
    }
}
#pragma mark - 刷新标题布局 （相当于手动给值请求）
-(void)bindChoseArrayDataSource1:(NSArray *)dataSource1Ary DataSource2:(NSArray *)dataSource2Ary DataSource3:(NSArray *)dataSource3Ary DataSource4:(NSArray *)dataSource4Ary

{
    
    BOOL isFilter = YES;
    
    // 第一次赋初值调用还没有进行过didSelect，所有都为空值,不是筛选
    if (_dataSource1.count==0 && _dataSource2.count ==0 && _dataSource3.count==0 && _dataSource4.count==0 ) {
        isFilter=NO;
        NSLog(@"iS Filter is NO");
    }
    
    // 取传过来的值，传过来什么请求就请求什么
    NSArray *tempDataSource1 = [NSArray arrayWithArray:dataSource1Ary];
    NSArray *tempDataSource2 = [NSArray arrayWithArray:dataSource2Ary];
    NSArray *tempDataSource3 = [NSArray arrayWithArray:dataSource3Ary];
    NSArray *tempDataSource4 = [NSArray arrayWithArray:dataSource4Ary];
    
    
    // 改变 按键 值
    [self changeTitleWithData1:tempDataSource1 Data2:tempDataSource2 Data3:tempDataSource3 Data4:tempDataSource4];
    
    [self dismiss];
    
    if(self.filterBlock)
    {
        self.filterBlock(isFilter,tempDataSource1,tempDataSource2,tempDataSource3,tempDataSource4);
    }
}
-(void)dismiss
{
    [_filterTableView1 dismiss];
    [_filterTableView2 dismiss];
    _filterTableView3.hidden = YES;

    _m_selectView.hidden = YES;
    //    [_filterTableView3 dismiss];
    //    [_m_selectView dismiss];
    
    _dataSource1Btn.selected=NO;
    _dataSource2Btn.selected=NO;
    _dataSource3Btn.selected=NO;
    _dataSource4Btn.selected=NO;
    
    _selectBtn=nil;
    _isShow=NO;
    [_bgView removeFromSuperview];
    _bgView=nil;
    //    _filterTableView1.sortDelegate=nil;
    _filterTableView2.sortDelegate=nil;
    
    //    _filterTableView4.sortDelegate=nil;
    
    //    [_filterTableView1 removeFromSuperview];
    [_filterTableView2 removeFromSuperview];
    //    [_filterTableView3 removeFromSuperview];
    //    [_filterTableView4 removeFromSuperview];
    
    //    _filterTableView1=nil;
    _filterTableView2=nil;
    _filterTableView3=nil;
    //    _filterTableView4=nil;
    
}

#pragma mark - 选择后重新显示筛选条件
-(void)changeTitleWithData1:(NSArray *)dataAry1 Data2:(NSArray *)dataAry2 Data3:(NSArray *)dataAry3  Data4:(NSArray *)dataAry4
{
    NSString *data1Str = [dataAry1 firstObject];
    NSString *data2Str = [dataAry2 firstObject];
    NSString *data3Str = [dataAry3 firstObject];
    NSString *data4Str = [dataAry4 firstObject];
    
    [self changeBtn:_dataSource1Btn Text:data1Str Font:[UIFont systemFontOfSize:14] ImageName:@"PR_filter_choice"];
    [self changeBtn:_dataSource2Btn Text:data2Str Font:[UIFont systemFontOfSize:14] ImageName:@"PR_filter_choice"];
    [self changeBtn:_dataSource3Btn Text:data3Str Font:[UIFont systemFontOfSize:14] ImageName:@"PR_filter_choice"];
    [self changeBtn:_dataSource4Btn Text:data4Str Font:[UIFont systemFontOfSize:14] ImageName:@"tz_cho_nor"];
    
}

#pragma mark - 改按钮文字重新排列
-(void)changeBtn:(UIButton *)btn Text:(NSString *)title Font:(UIFont *)font ImageName:(NSString *)imageName;
{
    btn.width=(SCREEN_WIDTH-1)/4;
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:font}];
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat space = 5;
    
    //    CGFloat edgeSpace = (btn.width-(titleSize.width+image.size.width+space))+titleSize.width+space;
    CGFloat edgeSpace = titleSize.width*1.5+space*5;
    
    // 90 - 60
    // 78 - 50
    CGFloat edge = -edgeSpace;
    //    if (titleSize.width > 4*[UIFont convertFontSize:13.0]) {
    //        edge = -edgeSpace-titleSize.width/1.5;
    //    }
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0.0, edge)];
    [btn setImage:image forState:UIControlStateNormal];
    
    CGFloat titleSpace =-image.size.width-space*2;
    if((int)SCREEN_HEIGHT%736 != 0)
    {
        titleSpace =-image.size.width-2*space;
    }
    
    [btn.titleLabel setContentMode:UIViewContentModeCenter];
    [btn.titleLabel setFont:font];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0,
                                             titleSpace,
                                             0.0,
                                             0.0)];
    [btn setTitle:title forState:UIControlStateNormal];
    
}

- (NSDictionary*)keyValueDic
{
    if (!_keyValueDic) {
        NSDictionary *keyValueDic=[[NSDictionary alloc] init];
        keyValueDic = @{
                        @"key1":@"value1",
                        @"key2":@"value2",
                        @"key3":@"value3",
                        @"key4":@"value4",
                        @"key5":@"value5",
                        };
        _keyValueDic = keyValueDic;
    }
    return _keyValueDic;
}





- (STListFilterView *)m_selectView{
    
    if (!_m_selectView) {
        _m_selectView = [[STListFilterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, iPH(330))];
        _m_selectView.delegate = self;
        _m_selectView.userInteractionEnabled = YES;
        
        @weakify(self)
        _m_selectView.backFilterClickBlock = ^(NSInteger tags, TZProductScreenConditionDateModel *model, TZLoanDataModel *workModel, TZLoanDataModel *typeModel) {
            @strongify(self)
            self.condiTionListModel = model;
            self.m_selectView.hidden = YES;
            [self choseSort:@[workModel,typeModel] andIndex:0];
        };
    }
    return _m_selectView;
}





@end

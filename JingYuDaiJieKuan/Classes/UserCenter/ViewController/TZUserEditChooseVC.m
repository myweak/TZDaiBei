//
//  TZUserEditChooseVC.m
//  JingYuDaiJieKuan
//
//  Created by TianZe on 2019/11/1.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "TZUserEditChooseVC.h"
#import "TZUserEditChooseCell.h"
#import "UserViewModel.h"

@interface TZUserEditChooseVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong ,nonatomic) UITableView *m_tableView;
@property (strong ,nonatomic) NSArray *titleArr;
@property (nonatomic, copy) NSString * chooseTitle;
@end

@implementation TZUserEditChooseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.type == TZUserEditChooseVCType_gender) {
        self.chooseTitle = aUser.gender;
    }else{
        self.chooseTitle = aUser.education;
    }
    
    
    [self initWithUI];
    [self setNavBarRightBtn];
    [self bindSignal];
    
}

- (NSArray *)titleArr{
    if (self.type == TZUserEditChooseVCType_gender) {
        return @[@"男",
                 @"女", ];
    }
    
    return @[@"小学",
             @"初中",
             @"高中",
             @"大专",
             @"本科",
             @"研究生",
             @"博士", ];
}
- (void)setNavBar{
    
}

- (void)bindSignal{
    
}

-(void)initWithUI
{
    [self.view addSubview:self.m_tableView];
    
}

- (UITableView *)m_tableView{
    if (!_m_tableView) {//UITableViewStyleGrouped
        _m_tableView = InsertTableView(nil, CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.view.frame)), self, self, UITableViewStyleGrouped, UITableViewCellSeparatorStyleSingleLine);
        _m_tableView.height = self.view.height;
        _m_tableView.rowHeight = UITableViewAutomaticDimension;
        _m_tableView.estimatedRowHeight = 120;
        
        
        if ([_m_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [_m_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_m_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [_m_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        [_m_tableView registerNibString:NSStringFromClass([TZUserEditChooseCell class]) cellIndentifier:TZUserEditChooseCell_ID];
        
        _m_tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
    }
    return _m_tableView;
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//返回头分组标题高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.titleArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TZUserEditChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:TZUserEditChooseCell_ID forIndexPath:indexPath];
    
    NSString *title = self.titleArr[indexPath.row] ;
    cell.mainTitleLabel.text = title;
    cell.chooseImageView.hidden = ![title isEqualToString:self.chooseTitle];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = self.titleArr[indexPath.row] ;
    self.chooseTitle = title;
    [self.m_tableView reloadData];
    
}


- (void)setNavBarRightBtn{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 24);
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = kFontSize14;
    rightBtn.backgroundColor = Bg_Btn_Colorblue;
    rightBtn.layer.cornerRadius = 2.0f;
    [rightBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}


- (void)saveClick{
    
    if(checkStrEmty(self.chooseTitle)){
        [[ZXAlertView shareView] showMessage:@"请选择"];
        return;
    }
    
    if (self.type == TZUserEditChooseVCType_gender) {
        [self postUserUpdateGenderUrl];
        
    }else  if (self.type == TZUserEditChooseVCType_education) {
        [self postUserUpdateEducationPathUrl];
    }
    
}


- (void)postUserUpdateGenderUrl{
    kSelfWeak;
    NSString *strName =  [self.chooseTitle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *name = [NSString stringWithFormat:@"%@%@",userUpdateGender,strName];
    [UserViewModel userUpdateGenderPath:name params:nil target:self success:^(UserModel *model) {
        if (model.code == 200) {
            showMessage(@"修改成功");
            aUser.gender = self.chooseTitle;
            [aUser saveUserData];
            
            //            [kUserMessageManager setMessageManagerForObjectWithKey:KEY_USER_GENDER value:self.chooseTitle];
            if (self.saveSuccessBlock) {
                weakSelf.saveSuccessBlock(self.chooseTitle);
            }
            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:KEY_USER_GENDER object:nil];
        }else{
            [[ZXAlertView shareView] showMessage:model.msg?:@""];
        }
    } failure:^(NSError *error) {
        
    }];
}


- (void)postUserUpdateEducationPathUrl{
    kSelfWeak;
    NSString *strName =  [self.chooseTitle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *name = [NSString stringWithFormat:@"%@%@",userUpdateEducation,strName];
    
    [UserViewModel userUpdateEducationPath:name params:nil target:self success:^(UserModel *model) {
        if (model.code == 200) {
            showMessage(@"修改成功");
            aUser.education = self.chooseTitle;
            [aUser saveUserData];
            if (self.saveSuccessBlock) {
                weakSelf.saveSuccessBlock(self.chooseTitle);
            }
            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:KEY_USER_EDUCATION object:nil];
        }else{
            [[ZXAlertView shareView] showMessage:model.msg?:@""];
        }
    } failure:^(NSError *error) {
        
    }];
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

//
//  AdvertisementHelper.m
//  JingYuDaiJieKuan
//
//  Created by Dason on 2019/7/4.
//  Copyright © 2019 Jincaishen. All rights reserved.
//

#import "AdvertisementHelper.h"
#import "ProductItemViewModel.h"
#import "JingYuDaiJieKuan-Swift.h"

@interface AdvertisementHelper () {}
/// 1-首页|2-贷款大全|3-我的
@property (nonatomic, copy) NSString *posId;
@property (nonatomic, weak) UIViewController *superVC;

@property (nonatomic, strong) UIView *rightControl;

@property (nonatomic, strong) advertisementDialogModel *rightControlModel;

@end

@implementation AdvertisementHelper

#pragma mark - getter

- (UIView *)rightControl {
    if (!_rightControl) {
        _rightControl = [UIView new];
    }
    return _rightControl;
}


//获取广告弹窗
- (void)getAdvDialogWithPosId:(NSString *)posId SuperVC: (UIViewController *)superVC {
    self.posId = posId;
    self.superVC = superVC;
    NSString *path = [NSString stringWithFormat:@"%@/%@",advDialogPath, posId];
    kSelfWeak;
    [ProductItemViewModel advertisementDialogPath:path params:nil target:self success:^(advertisementDialogListModel * _Nonnull modelList) {
        if (modelList.code == 200) {
            [self genAdvData:modelList];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)genAdvData:(advertisementDialogListModel *)modelList{
    NSMutableArray<advertisementDialogModel*> *dialogModel = [NSMutableArray new];
    NSMutableArray<advertisementDialogModel*> *rightControlModel = [NSMutableArray new];
    NSString *date = [self getCurrentDate];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *currentDate = [defaults objectForKey:[NSString stringWithFormat:@"ADcurrentDate%@", self.posId]];
    for (NSInteger i = 0; i < modelList.list.count; i++){
        advertisementDialogModel *model = modelList.list[i];
        //是否需要显示
        if (model.triggerWay == 1) {
            if ([currentDate isEqualToString:date]) {
                continue;
            } else {
                //不一样证明这个日期还没打开过APP,需要显示
            }
        } else if (model.triggerWay == 3) {
            if (currentDate == nil) {
                //没有记录,第一次安装,需要显示
            } else {
                continue;
            }
        }
        
        /// 保存弹窗时间
        [defaults setObject:date forKey:[NSString stringWithFormat:@"ADcurrentDate%@", self.posId]];
        [defaults synchronize];
        
        
        if (model.dialogType == 1) {
            //弹窗
            [dialogModel addObject:model];
        } else if(model.dialogType == 2) {
            //右浮窗控件
            [rightControlModel addObject:model];
        }
    }
    
    //完成数据组装
    //        弹窗
    [self showDialog:dialogModel];
    //悬浮
    [self insertRightControl:rightControlModel];
}

- (void)showDialog:(NSArray<advertisementDialogModel *>*)modelList {
    if (modelList.count <= 0) {return;}
    AdvertisementAlertView *alert = [[AdvertisementAlertView alloc]initWithImages:modelList cancelButtonClosure:^{
    } showAdvClosure:^(NSInteger index) {
        advertisementDialogModel *model = modelList[index];
        
        NSString *fromPosition = [NSString stringWithFormat:@"弹窗%ld",index + 1];
        
        if ([self.posId isEqualToString:@"1"]) {
            fromPosition = [NSString stringWithFormat: @"首页-%@",fromPosition];
        } else if ([self.posId isEqualToString:@"2"]) {
            fromPosition = [NSString stringWithFormat: @"贷款大全-%@",fromPosition];
        } else if ([self.posId isEqualToString:@"3"]) {
            fromPosition = [NSString stringWithFormat: @"我的-%@",fromPosition];
        } else {}
        
        AdWebViewController *targetVC = [AdWebViewController new];
            [targetVC showWebWithURL:model.url
                      andProductIcon:@""
                 andProductMaxAmount:@""
                andProductMerchartid:model.mchId
                      andProductName:model.mchName
                      andProductTags:@""
                     andProductTitle:@""
                       andProductUrl:model.url
                     andFromPosition:fromPosition
                andIsNeedSaveHistory:YES
                 withSuperController:self.superVC];
        
        [SensorsAnalyticsSDKHelper trackAdvertisementWithTabPositionId:self.posId title:model.title url:model.url mchId:model.mchId mchName:model.mchName];
    }];

    if ([self.superVC isViewLoaded] && self.superVC.view.window) {
        //如果因为界面快速切换导致controller不是当前显示的VC,那么就不显示了.
        //如果已经添加过了那就不再show
        if (self.superVC.presentedViewController == nil){
            [alert showAlertViewInViewController:self.superVC leftOrRightMargin:30];
        }
    }
}

- (void)insertRightControl:(NSArray<advertisementDialogModel *>*)modelList {
    //如果已经添加了,那么就删除再添加
    [self.rightControl removeFromSuperview];
    
    if (modelList.count <= 0) {return;}
    //button
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"closeGray"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(removeRightControl) forControlEvents:UIControlEventTouchUpInside];
    //image
    UIImageView *imgView = [UIImageView new];
    [imgView setUserInteractionEnabled:YES];
    [imgView sd_setImageWithURL:[NSURL URLWithString:modelList.firstObject.photo]];
    self.rightControlModel = modelList.firstObject;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action: @selector(rightControlJumpToWeb)];
    [imgView addGestureRecognizer:tap];
    
    [self.superVC.view addSubview:self.rightControl];
    [self.rightControl addSubview:btn];
    [self.rightControl addSubview:imgView];
    
    [self.rightControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.superVC.view).offset(-10);
        make.bottom.equalTo(self.superVC.view).offset(-20);
        make.height.mas_equalTo(kScreenWidth/5 + 20);
        make.width.mas_equalTo(kScreenWidth/5);
                                
    }];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.rightControl);
        make.height.width.mas_equalTo(20);
    }];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_bottom);
        make.left.bottom.right.equalTo(self.rightControl);
    }];
    
}

///浮窗跳转web
- (void)rightControlJumpToWeb {
    
    NSString *fromPosition = @"浮窗";
    
    if ([self.posId isEqualToString:@"1"]) {
        fromPosition = @"首页-浮窗";
    } else if ([self.posId isEqualToString:@"2"]) {
        fromPosition = @"贷款大全-浮窗";
    } else if ([self.posId isEqualToString:@"3"]) {
        fromPosition = @"我的-浮窗";
    } else {}
    
    AdWebViewController *targetVC = [AdWebViewController new];
    [targetVC showWebWithURL:self.rightControlModel.url
              andProductIcon:@""
         andProductMaxAmount:@""
        andProductMerchartid:self.rightControlModel.mchId
              andProductName:self.rightControlModel.mchName
              andProductTags:@""
             andProductTitle:@""
               andProductUrl:self.rightControlModel.url
             andFromPosition:fromPosition
        andIsNeedSaveHistory:YES
         withSuperController:self.superVC];
    
    
    //埋点
    [SensorsAnalyticsSDKHelper trackRightControlWithTabPositionId:self.posId title:self.rightControlModel.title url:self.rightControlModel.url mchId:self.rightControlModel.mchId mchName:self.rightControlModel.mchName];
}

- (void)removeRightControl {
    [self.rightControl removeFromSuperview];
}

- (NSString *)getCurrentDate {
    NSDate *date = [NSDate date];                            //实际上获得的是：UTC时间，协调世界时，亚州的时间与UTC的时差均为+8
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];                  //zone为当前时区信息  在我的程序中打印的是@"Asia/Shanghai"
    
    NSInteger interval = [zone secondsFromGMTForDate: date];      //28800 //所在地区时间与协调世界时差距
    
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];  //加上时差，得到本地时间
    
    //get seconds since 1970
    
    NSTimeInterval intervalWith1970 = [localeDate timeIntervalSince1970];     //本地时间与1970年的时间差（秒数）
    
    int daySeconds = 24 * 60 * 60;                                            //每天秒数
    
    NSInteger allDays = intervalWith1970 / daySeconds;                        //这一步是为了舍去后面的时分秒
    
    localeDate = [NSDate dateWithTimeIntervalSince1970:allDays * daySeconds];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    fmt.dateFormat = @"yyyy-MM-dd";   //创建日期格式（年-月-日）
    
    return [fmt stringFromDate:localeDate];       //得到当地当时的时间（年月日）
}
@end

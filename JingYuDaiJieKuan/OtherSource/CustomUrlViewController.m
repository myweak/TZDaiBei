//
//  CustomUrlViewController.m
//  JingYuDaiJieKuan
//
//  Created by fireflies on 2018/3/27.
//  Copyright © 2018年 Jincaishen. All rights reserved.
//

#import "CustomUrlViewController.h"

@interface CustomUrlViewController ()

@property (nonatomic,strong)UITextField *textField;

@property (nonatomic,strong)UITextView *textView;

@end

@implementation CustomUrlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"save" style:UIBarButtonItemStylePlain target:self action:@selector(addAction)];
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(10.0, 10.0, kScreenWidth - 20.0, 40.0)];
    self.textField.placeholder = @"key:";
    self.textField.backgroundColor = kLySeparatorColor;
    [self.view addSubview:self.textField];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(10.0, 60.0, kScreenWidth - 20.0, 100.0)];
    self.textView.backgroundColor = kLySeparatorColor;
    [self.view addSubview:self.textView];
}

-(void)addAction
{
    DLog(@"key:%@,value:%@",self.textField.text,self.textView.text);
    self.textField.text = [NSString stringBySpaceTrim:self.textField.text];
    if ([self.textField.text isBlank]) {
        DLog(@"字符串为空");
        [iToast alertWithTitle:@"字符串为空或者有空格"];
        return;
    }else{
        [self saveDataToplist];
        if (self.addUrlBlock) {
            self.addUrlBlock(self.textField.text,self.textView.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)saveDataToplist
{
    NSString *filePath1 = [[NSBundle mainBundle] pathForResource:@"NetworkEnvironment" ofType:@"plist"];
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath1];
    [dataDictionary setObject:self.textView.text forKey:self.textField.text];
    [dataDictionary writeToFile:filePath1 atomically:YES];
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

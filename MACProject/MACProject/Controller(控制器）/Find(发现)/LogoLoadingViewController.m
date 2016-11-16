//
//  LogoLoadingViewController.m
//  MACProject
//
//  Created by MacKun on 2016/11/16.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "LogoLoadingViewController.h"

#import "LoadingView.h"

@interface LogoLoadingViewController ()

@end

@implementation LogoLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view.
}
-(void)initUI{
    self.title = @"加载动画";
    [self.view addSubview:[[LoadingView alloc] initWithFrame:self.view.bounds]];
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

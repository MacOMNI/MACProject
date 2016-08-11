//
//  NearViewController.m
//  MACProject
//
//  Created by MacKun on 16/8/11.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "NearViewController.h"

@interface NearViewController ()

@end

@implementation NearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
    // Do any additional setup after loading the view from its nib.
}
-(void)initUI{
 self.title=@"云周边";
}
-(void)initData{
    
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

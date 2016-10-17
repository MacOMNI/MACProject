//
//  RandomViewController.m
//  MACProject
//
//  Created by MacKun on 16/10/17.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "RandomViewController.h"

@interface RandomViewController ()

@end

@implementation RandomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"暂未开放";
    self.view.backgroundColor = [UIColor RandomColor];
    // Do any additional setup after loading the view.
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

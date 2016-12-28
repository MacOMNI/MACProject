//
//  WaveViewController.m
//  MACProject
//
//  Created by MacKun on 2016/12/27.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "WaveViewController.h"
#import "MACWaveView.h"
@interface WaveViewController ()

@end

@implementation WaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)initUI{
    self.title = @"波浪动画";

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"kebiao_back"]];
    MACWaveView *waveView = [[MACWaveView alloc]initWithFrame:CGRectMake(0, appHeight-300, appWidth, 300)];
    [self.view addSubview:waveView];
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

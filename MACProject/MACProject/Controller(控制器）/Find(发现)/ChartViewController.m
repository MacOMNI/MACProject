//
//  ChartViewController.m
//  MACProject
//
//  Created by MacKun on 2017/1/16.
//  Copyright © 2017年 com.mackun. All rights reserved.
//

#import "ChartViewController.h"
#import "MACChartView.h"
#import "GraphChartView.h"
@interface ChartViewController ()
@property (nonatomic,strong) MACChartView *chartView;
@property (nonatomic,strong) GraphChartView *graphChartView;
@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)initUI{
    self.title = @"基础图表";
    [self.view addSubview:self.chartView];
    [self.view addSubview:self.graphChartView];
}
-(MACChartView *)chartView{
    if (!_chartView) {
        _chartView = [[MACChartView alloc]initWithFrame:CGRectMake(10, 80, self.view.frame.size.width-20, 250)];
        _chartView.percentArr = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@"",@""]];//等分
    };
    
    return _chartView;
}
-(GraphChartView *)graphChartView{
    if (!_graphChartView) {
        _graphChartView = [[GraphChartView alloc]initWithFrame:CGRectMake(10, 345, self.view.frame.size.width-20, 300)];
        _graphChartView.arrayX = @[@"07",@"08",@"09",@"10",@"11",@"12"];
        _graphChartView.arrayY = @[@"20",@"40",@"60",@"80",@"100"];
        _graphChartView.arrayValue = @[@"15",@"35",@"80",@"45",@"20",@"90"];
    }
    
    return _graphChartView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

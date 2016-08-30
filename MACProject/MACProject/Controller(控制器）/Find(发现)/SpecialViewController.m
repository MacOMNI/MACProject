//
//  SpecialViewController.m
//  MACProject
//
//  Created by MacKun on 16/8/29.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "SpecialViewController.h"
#import "SpecailShowViewController.h"
@interface SpecialViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *_names;
    NSArray *_classArr;

}
@property(nonatomic,strong) UITableView *tableView;
@end

@implementation SpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
    // Do any additional setup after loading the view.
}
-(void)initUI{
    self.title = @"乱象动画";
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
-(void)initData{
    _names = @[@"EAGestureGuideView(引导用户使用)",@"BasicControl(基础控件)"];
    _classArr = @[@"SpecailShowViewController",@"BasicShowViewController"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _names.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _names[indexPath.row] ;
    
    cell.backgroundColor = [UIColor whiteColor] ;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UIViewController *vc = [[NSClassFromString(_classArr[indexPath.row]) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
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

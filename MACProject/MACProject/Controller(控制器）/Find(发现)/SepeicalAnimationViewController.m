//
//  SepeicalAnimationViewController.m
//  MACProject
//
//  Created by MacKun on 16/8/30.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "SepeicalAnimationViewController.h"

@interface SepeicalAnimationViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_nameArr;
    NSArray *_classArr;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SepeicalAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
    // Do any additional setup after loading the view from its nib.
}
-(void)initUI{
    self.title = @"乱象动画";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
-(void)initData{
    _nameArr = @[@"POPNumberAnimation(数字动画)",@"LoadingView(加载logo动画)",@"WaveView(波浪动画)"];
    _classArr = @[@"POPNumberViewController",@"LogoLoadingViewController",@"WaveViewController"];
}

#pragma mark tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _nameArr.count;
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
    cell.textLabel.text = _nameArr[indexPath.row] ;
    
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


@end

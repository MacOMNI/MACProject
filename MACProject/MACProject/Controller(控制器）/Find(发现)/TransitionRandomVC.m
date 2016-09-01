//
//  TransitionRandomVC.m
//  MACProject
//
//  Created by MacKun on 16/8/25.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "TransitionRandomVC.h"

@interface TransitionRandomVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_names;

}

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation TransitionRandomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
    // Do any additional setup after loading the view.
}
-(void)initUI{
    self.title = @"转场动画";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
-(void)initData{
    _names = @[@"Fade",
               @"Push",@"Push",@"Push",@"Push",
               @"Reveal",@"Reveal",@"Reveal",@"Reveal",
               @"MoveIn",@"MoveIn",@"MoveIn",@"MoveIn",
               @"Cube",@"Cube",@"Cube",@"Cube",
               @"suckEffect",
               @"oglFlip",@"oglFlip",@"oglFlip",@"oglFlip",
               @"rippleEffect",
               @"pageCurl",@"pageCurl",@"pageCurl",@"pageCurl",
               @"pageUnCurl",@"pageUnCurl",@"pageUnCurl",@"pageUnCurl",
               @"CameraIrisHollowOpen",
               @"CameraIrisHollowClose"];

}
#pragma mark - tableView



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return WXSTransitionAnimationTypeSysCameraIrisHollowClose;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return section == 0 ? @"present" : @"push";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = indexPath.row < WXSTransitionAnimationTypeSysCameraIrisHollowClose ? _names[indexPath.row] : @"转场动画";
    
    cell.backgroundColor = [UIColor whiteColor] ;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor=[UIColor RandomColor];
         typeof(vc) __weak weakVC = vc;
        [vc.view addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
           [weakVC dismissViewControllerAnimated:YES completion:nil];
        }];
        [self wxs_presentViewController:vc makeTransition:^(WXSTransitionProperty *transition) {
            transition.animationType = indexPath.row + 1;
            transition.isSysBackAnimation = (int)rand()%2 < 1 ?  YES : NO;
        } completion:nil];
        
    }else{
        
        UIViewController *vc = [[UIViewController alloc] init];
        vc.title=@"转场动画";
        vc.view.backgroundColor=[UIColor RandomColor];
        [self.navigationController wxs_pushViewController:vc makeTransition:^(WXSTransitionProperty *transition) {
            transition.animationType = indexPath.row + 1;
            //            transition.isSysBackAnimation = (int)rand()%2 < 1 ?  YES : NO;
        }];
        
    }
    
    
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

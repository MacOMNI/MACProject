//
//  SOFViewController.m
//  MACProject
//
//  Created by MacKun on 16/8/24.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "SOFViewController.h"
#import "FriendsMessageCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "YYFPSLabel.h"
@interface SOFViewController ()<MACTableViewDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{
    
}
@property(nonatomic,strong) MACTableView *tableView;

@end

@implementation SOFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
    // Do any additional setup after loading the view.
}
-(void)initUI{
    self.title  = @"朋友圈";
    self.tableView = [[MACTableView alloc]initWithFrame: self.view.bounds];
    self.tableView.macTableViewDelegate = self;
    //self.tableView.isShowEmpty = NO;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[FriendsMessageCell class] forCellReuseIdentifier:@"FriendsCell"];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[YYFPSLabel alloc]initWithFrame:CGRectMake(0, 5, 60, 30)]];
}
-(void)initData{
    [self.tableView reloadData];
}
#pragma mark macTableViewDelegate
-(void)loadDataRefreshOrPull:(MACRefreshState)state{
    if (state==MACRefreshing) {
        
    }else if (state==MACPulling){
        
    }
    [self.tableView endLoading];
}

#pragma mark TableView delegate datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 20;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendsMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsCell" forIndexPath:indexPath];
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
       cell.indexPath      = indexPath;
//    if (cell) {
//        cell=[[FriendsMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FriendsCell"];
//    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat Height = [tableView fd_heightForCellWithIdentifier:@"FriendsCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        // configurations
        [self configureCell:cell atIndexPath:indexPath];
        
    }];
    return Height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma  mark  configureCell
- (void)configureCell:(FriendsMessageCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    cell.model = nil;
}
#pragma  mark scrollDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
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

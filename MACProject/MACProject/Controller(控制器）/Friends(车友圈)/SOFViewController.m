//
//  SOFViewController.m
//  MACProject
//
//  Created by MacKun on 16/8/24.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "SOFViewController.h"

@interface SOFViewController ()<MACTableViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    
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
    self.tableView = [[MACTableView alloc]initWithFrame: self.view.bounds];
    self.tableView.macTableViewDelegate = self;
    self.tableView.isShowEmpty = NO;
    [self.view addSubview:self.tableView];
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
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsCell"];
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return GTFixHeightFlaot(15.f);
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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

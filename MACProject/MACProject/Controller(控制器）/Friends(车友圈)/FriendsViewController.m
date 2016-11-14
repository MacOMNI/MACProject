//
//  FriendsViewController.m
//  MACProject
//
//  Created by MacKun on 16/8/11.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "FriendsViewController.h"
#import "FriendsCell.h"
#import "ContactsVC.h"
#import "SOFViewController.h"
@interface FriendsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_titleArr;
    NSMutableArray *_iconArr;
    NSMutableArray *_classArr;

}
@property (strong, nonatomic)  UITableView *tableView;

@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
    // Do any additional setup after loading the view from its nib.
}
-(void)initUI{
    self.title = @"朋友圈";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.rowHeight = 49.f;
    [self.tableView registerNib:[FriendsCell loadNib] forCellReuseIdentifier:@"FriendsCell"];
    [self.view addSubview:self.tableView];
}
-(void)initData{
    _titleArr = [[NSMutableArray alloc]initWithArray:@[@[@"车友圈",@"我的车友"],@[@"我的奖品",@"我的消息"]]];
    _iconArr = [[NSMutableArray alloc]initWithArray:@[@[@"user_identify_icon",@"user_introduce_icon"],@[@"user_phone_icon",@"user_registerTime_icon"]]];
    _classArr = [[NSMutableArray alloc]initWithArray:@[@[@"SOFViewController",@"ContactsVC"],@[@"RandomViewController",@"MessageViewController"]]];
   // [self.tableView reloadData];
}
#pragma mark TableView delegate datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titleArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_titleArr arrayWithIndex:section].count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendsCell *cell   = [tableView dequeueReusableCellWithIdentifier:@"FriendsCell"];
    cell.nameLabel.text = [_titleArr arrayWithIndex:indexPath.section][indexPath.row];
    cell.imgView.image  = [UIImage imageNamed:[_iconArr arrayWithIndex:indexPath.section][indexPath.row]];
    cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return GTFixHeightFlaot(15.f);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *viewController = [[NSClassFromString([_classArr arrayWithIndex:indexPath.section][indexPath.row]) alloc] init];

    [self.navigationController pushViewControllerHideTabBar:viewController animated:YES];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

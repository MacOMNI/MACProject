//
//  FindViewController.m
//  MACProject
//
//  Created by MacKun on 16/8/11.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "FindViewController.h"
#import "FriendsCell.h"
@interface FindViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *titleArr;
    NSMutableArray *iconArr;
    NSMutableArray *classArr;
    
}
@property (strong, nonatomic)  UITableView *tableView;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
    // Do any additional setup after loading the view from its nib.
}
-(void)initUI{
    self.title                     = @"发现";
    self.tableView                 = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.rowHeight       = 49.f;
    [self.tableView registerNib:[FriendsCell loadNib] forCellReuseIdentifier:@"FriendsCell"];
    [self.view addSubview:self.tableView];
}
-(void)initData{
    titleArr = [[NSMutableArray alloc]initWithArray:@[@[@"转场动画",@"基础动画",@"移动动画",@"乱象动画"],@[@"基础控件",@"乱象控件"]]];
    iconArr = [[NSMutableArray alloc]initWithArray:@[@[@"MoreMyAlbum",@"MoreMyBankCard",@"MoreMyFavorites",@"MyCardPackageIcon"],@[@"ff_IconShake",@"MoreSetting"]]];
    classArr = [[NSMutableArray alloc]initWithArray:@[@[@"TransitionRandomVC",@"RandomViewController",@"MMAnimationViewController",@"SepeicalAnimationViewController"],@[@"BasicShowViewController",@"SpecialViewController"]]];
    // [self.tableView reloadData];
}
#pragma mark TableView delegate datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return titleArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [titleArr arrayWithIndex:section].count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendsCell *cell   = [tableView dequeueReusableCellWithIdentifier:@"FriendsCell"];
    cell.nameLabel.text = [titleArr arrayWithIndex:indexPath.section][indexPath.row];
    cell.imgView.image  = [UIImage imageNamed:[iconArr arrayWithIndex:indexPath.section][indexPath.row]];
    cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return GTFixHeightFlaot(15.f);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *viewController = [[NSClassFromString([classArr arrayWithIndex:indexPath.section][indexPath.row]) alloc]init];
    [self.navigationController pushViewControllerHideTabBar:viewController animated:YES];
    
    
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

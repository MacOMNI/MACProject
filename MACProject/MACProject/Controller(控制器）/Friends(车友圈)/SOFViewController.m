//
//  SOFViewController.m
//  MACProject
//
//  Created by MacKun on 16/8/24.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "SOFViewController.h"
#import "MessageHeadView.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "YYFPSLabel.h"
#import "CommentCell.h"
#import "FriendsMessageModel.h"
@interface SOFViewController ()<MACTableViewDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{
    
}
@property (nonatomic,strong) MACTableView *tableView;
@property (nonatomic,strong) NSMutableArray<FriendsMessageModel *> *dataArr;
@end

@implementation SOFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
    // Do any additional setup after loading the view.
}
-(void)initUI{
    self.title                      = @"朋友圈";
    _tableView                      = [[MACTableView alloc]initWithFrame: self.view.bounds style:UITableViewStyleGrouped];
    _tableView.macTableViewDelegate = self;
    _tableView.delegate             = self;
    _tableView.tableHeaderView      = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.sectionHeaderHeight  = UITableViewAutomaticDimension;
    [_tableView registerClass:[MessageHeadView class] forHeaderFooterViewReuseIdentifier:@"messageHeadView"];
    [self.tableView registerClass:[CommentCell class] forCellReuseIdentifier:@"commentCell"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[YYFPSLabel alloc]initWithFrame:CGRectMake(0, 5, 60, 30)]];
    [self.view addSubview:_tableView];

}
-(void)initData{
    _dataArr = [NSMutableArray arrayWithCapacity:20];
    FriendsMessageModel *model = [FriendsMessageModel new];
    for (NSInteger i = 0; i < 20; i++) {
        model.commentHeight = [MessageHeadView caculateHeight:nil];
        [_dataArr addObject:model];
    }

    [_tableView reloadData];
}
#pragma mark macTableViewDelegate
-(void)loadDataRefreshOrPull:(MACRefreshState)state{
    if (state==MACRefreshing) {
        
    }else if (state==MACPulling){
        
    }
    [_tableView endLoading];
}

#pragma mark TableView delegate datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 20;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:@"commentCell" cacheByIndexPath:indexPath configuration:^(id cell) {
         CommentCell *fdCell = (CommentCell *)cell;
        [self configureCell:fdCell atIndexPath:indexPath];

    }];

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return _dataArr[section].commentHeight;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MessageHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"messageHeadView"];
    headView.model = nil;
    return headView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
//#pragma  mark  configureCell
- (void)configureCell:(CommentCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    //cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    cell.model = nil;
}
-(void)configureHeadView:(MessageHeadView *)headView atIndexPath:(NSIndexPath *)indexPath{
    headView.model = nil;
}
//#pragma  mark scrollDelegate
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    
//}
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

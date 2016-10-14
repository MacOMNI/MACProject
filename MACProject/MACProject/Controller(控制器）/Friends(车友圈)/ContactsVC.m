//
//  ContactsVC.m
//  WeiSchoolTeacher
//
//  Created by MacKun on 15/12/14.
//  Copyright © 2015年 MacKun. All rights reserved.
//

#import "ContactsVC.h"
#import "HeadView.h"
#import "QRScanViewController.h"
#import "ContactsCell.h"
#import "GroupModel.h"
#import "MACRefreshHeader.h"
#import "BaseService.h"
@interface ContactsVC ()<UITableViewDataSource,UITableViewDelegate,HeadViewDelegate,ContactDelegate>{
    NSMutableArray *groupArr;
    NSArray *dataArr;
    NSMutableArray *friendsArr;
    NSMutableArray *fansArr;

    NSMutableArray *footArr;
}

@end

@implementation ContactsVC


-(void)dealloc{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
    
}
-(void)initUI{
     self.title = @"我的车友";
    [self setRightBarItemImage:[UIImage imageNamed:@"contact_add"] title:@"添加"];
    [self.headView setHeight:appWidth/4.0];
    self.headView.backgroundColor      = [UIColor appBackGroundColor];
    self.tableView.sectionFooterHeight = 0.5;
    
    _tableView.tableFooterView        = [UIView new];

    self.tableView.dataSource         = self;
    self.tableView.delegate           = self;
    self.tableView.estimatedRowHeight = 60.0f;
    self.tableView.separatorStyle     = UITableViewCellSeparatorStyleSingleLine;

    self.tableView.mj_header          = [MACRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
     //马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
}

-(void)rightBarItemAction:(UITapGestureRecognizer *)gesture{
    [self.view showMessage:@"点击添加"];
}
-(void)initData{
    //以我的关注和我的粉丝为例
    dataArr = @[@"我的关注",@"我的粉丝"];
    fansArr = [NSMutableArray array];
    friendsArr = [NSMutableArray array];
   groupArr = [NSMutableArray array];
    footArr = [NSMutableArray array];
    for (NSInteger i = 0;i< dataArr.count ; i++) {
        HeadView *headView = [HeadView headViewWithTableView:self.tableView];
        headView.name = dataArr[i];
        headView.headViewDelegate = self;
        headView.section = i;
        UIView *view = [UIView new];
        [view setBackgroundColor:[UIColor appLineColor]];
        [footArr addObject:view];
        [groupArr addObject:headView];
    }
}
-(void)groupRefresh:(NSNotification *)nof
{
   // [_tableView.header beginRefreshing];
    [self loadData];
}
-(void)loadData{
    NSDictionary *dic=@{
                        @"YHBH":@"5560dcc2-e9fe-4cd4-bae7-95e036ac56e4",//[UserAuth shared].userid,
                        };
    [BaseService POSTWithCacheNormal:@"Teach/App/getAttentionAndFans.aspx" parameters:dic completionBlock:^(NSInteger stateCode, NSMutableArray *result, NSError *error) {
        switch (stateCode) {
            case 200:
            {
                [friendsArr removeAllObjects];
                [fansArr removeAllObjects];
                for(id obj in result){
                    //自定义code
                    GroupModel *model=[GroupModel mj_objectWithKeyValues:obj];
                    if (model.Mark==0) {
                        [friendsArr addObject:model];
                    }else{
                        [fansArr addObject:model];
                    }
                }
                DLog(@"请求成功");
            }
                break;
            case 0:
            {
                DLog(@"请求失败");
            }
                break;
            default:
                break;
        }
            [_tableView.mj_header endRefreshing];
            [_tableView reloadData];
    } cacheBlock:^(NSInteger stateCode, NSMutableArray *result, NSError *error) {
        if (stateCode==200) {
            {
                [friendsArr removeAllObjects];
                [fansArr removeAllObjects];
                for(id obj in result){
                    //自定义code
                    GroupModel *model=[GroupModel mj_objectWithKeyValues:obj];
                    if (model.Mark==0) {
                        [friendsArr addObject:model];
                    }else{
                        [fansArr addObject:model];
                    }
                }
                DLog(@"请求成功");
            }
                [_tableView.mj_header endRefreshing];
                [_tableView reloadData];
        }
    }];
}
#pragma mark tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     HeadView *headView=groupArr[section];
    if (headView.isExend){
        if (section==0) {
            return friendsArr.count;
        }else return fansArr.count;
    }
    return  0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return groupArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"contactsCell";
    ContactsCell *cell = (ContactsCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = (ContactsCell *)[ContactsCell nibCell];
//        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ContactsCell" owner:self options:nil];
//        cell = (ContactsCell *)[nib objectAtIndex:0];
        cell.contactDelegate = self;
        //cell.selectionStyle =  UITableViewCellSelectionStyleGray;
    }
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    cell.row = indexPath.row;
    cell.idx = indexPath.section;

    if (indexPath.section==0) {
        cell.contactStatus = friendsArr[indexPath.row];
    }else cell.contactStatus = fansArr[indexPath.row];
   
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return groupArr[section];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return footArr[section];
}
#pragma mark tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DLog(@"点击cell");
}

#pragma mark headView delegate

-(void)clickHeadView:(NSInteger)section{
    //DLog(@"clickHeadView %ld",section);
    [self.tableView reloadData];
//    NSIndexSet * nd=[[NSIndexSet alloc]initWithIndex:section];
//    [self.tableView reloadSections:nd withRowAnimation:UITableViewRowAnimationNone];
//    [self.tableView reloadSections:nd withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma cell delegate
-(void)clickCellAcatvor:(ContactsCell *)cell{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark action 点击事件
- (IBAction)openClassAction:(id)sender {
   
}

- (IBAction)qrScanAction:(id)sender {
    QRScanViewController *scanVC = [[QRScanViewController alloc]init];
    scanVC.title = @"扫一扫";
    [scanVC doneScanBlock:^(id assetDicArray) {
        NSString *strResultWithBase64 = [NSString stringWithFormat:@"%@", assetDicArray];
        strResultWithBase64 = [strResultWithBase64 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSData *data = [[NSData alloc]initWithBase64EncodedString:strResultWithBase64 options:0];
        NSString *strResult = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
       [scanVC showAlertMessage:strResult title:@"扫描内容" clickArr:@[@"确定",@"取消"] click:^(NSInteger index) {
           switch (index) {
               case 0:{
                   
               }break;
               case 1:{
                   
               }break;
               default:
                   break;
           }
           [scanVC.navigationController popViewControllerAnimated:YES];
       }];
    }];
    
    [self.navigationController pushViewControllerHideTabBar:scanVC animated:YES];

}

@end

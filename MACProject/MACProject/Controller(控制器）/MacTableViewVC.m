//
//  MacTableViewVC.m
//  MACProject
//
//  Created by MacKun on 16/8/4.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "MacTableViewVC.h"
#import "MACTableView.h"
#import "TableViewCell.h"
#import "UITableView+CellClass.h"
@interface MacTableViewVC ()<MACTableViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray <CellDataAdapter *> *dataArr;
}
@property (weak, nonatomic) IBOutlet MACTableView *tableView;
@end

@implementation MacTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
    // Do any additional setup after loading the view from its nib.
}
-(void)initUI{
    self.title=@"MACTableView";
    self.tableView.macTableViewDelegate=self;
    self.tableView.isLoadMore=NO;
    self.tableView.isRefresh=NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableViewCell"];
    [self setRightBarItemWithString:@"新增"];
}
-(void)initData{
    dataArr=[NSMutableArray array];
    NSArray *strings = @[
                         @"AFNetworking is a delightful networking library for iOS and Mac OS X. It's built on top of the Foundation URL Loading System, extending the powerful high-level networking abstractions built into Cocoa. It has a modular architecture with well-designed, feature-rich APIs that are a joy to use. Perhaps the most important feature of all, however, is the amazing community of developers who use and contribute to AFNetworking every day. AFNetworking powers some of the most popular and critically-acclaimed apps on the iPhone, iPad, and Mac. Choose AFNetworking for your next project, or migrate over your existing projects—you'll be happy you did!",
                         
                         @"黄色的树林里分出两条路，可惜我不能同时去涉足，我在那路口久久伫立，我向着一条路极目望去，直到它消失在丛林深处。但我却选了另外一条路，它荒草萋萋，十分幽寂，显得更诱人、更美丽，虽然在这两条小路上，都很少留下旅人的足迹，虽然那天清晨落叶满地，两条路都未经脚印污染。呵，留下一条路等改日再见！但我知道路径延绵无尽头，恐怕我难以再回返。也许多少年后在某个地方，我将轻声叹息把往事回顾，一片树林里分出两条路，而我选了人迹更少的一条，从此决定了我一生的道路。",
                         
                         @"★タクシー代がなかったので、家まで歩いて帰った。★もし事故が発生した场所、このレバーを引いて列车を止めてください。（丁）为了清楚地表示出一个短语或句节，其后须标逗号。如：★この薬を、夜寝る前に一度、朝起きてからもう一度、饮んでください。★私は、空を飞ぶ鸟のように、自由に生きて行きたいと思った。*****为了清楚地表示词语与词语间的关系，须标逗号。标注位置不同，有时会使句子的意思发生变化。如：★その人は大きな音にびっくりして、横から飞び出した子供にぶつかった。★その人は、大きな音にびっくりして横から飞び出した子供に、ぶつかった。",
                         
                         @"Two roads diverged in a yellow wood, And sorry I could not travel both And be one traveler, long I stood And looked down one as far as I could To where it bent in the undergrowth; Then took the other, as just as fair, And having perhaps the better claim, Because it was grassy and wanted wear; Though as for that the passing there Had worn them really about the same, And both that morning equally lay In leaves no step had trodden black. Oh, I kept the first for another day! Yet knowing how way leads on to way, I doubted if I should ever come back. I shall be telling this with a sigh Somewhere ages and ages hence: Two roads diverged in a wood, and I- I took the one less traveled by, And that has made all the difference. ",
                         
                         @"Star \"https://github.com/YouXianMing\" :)"
                         ];
    [GCDQueue executeInMainQueue:^{
        
        NSMutableArray *indexPaths = [NSMutableArray array];
        
        for (int i = 0; i < strings.count; i++) {
            
            NSString *stringStr    = strings[i];
            
             CGFloat height=[TableViewCell cellHeightWithData:stringStr];
            CellDataAdapter *adapter = [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"TableViewCell" data:stringStr
                                                                                    cellHeight:height
                                                                                      cellType:0];
            [dataArr addObject:adapter];
            [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        
    } afterDelaySecs:0.5f];

    
}
-(void)rightBarItemAction:(UITapGestureRecognizer *)gesture{
    [GCDQueue executeInMainQueue:^{
        
        NSMutableArray *indexPaths = [NSMutableArray array];
       // NSInteger cnt = dataArr.count;
        for (NSInteger i = dataArr.count,j=0; j <5; i++,j++) {
            
            NSString *stringStr    = dataArr[j].data;
            
            CGFloat height=[TableViewCell cellHeightWithData:stringStr];
            CellDataAdapter *adapter = [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"TableViewCell" data:stringStr
                                                                                    cellHeight:height
                                                                                      cellType:0];
            [dataArr addObject:adapter];
            [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        
    } afterDelaySecs:0.5f];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TableView delegate datasource
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueAndLoadContentReusableCellFromAdapter:dataArr[indexPath.row] indexPath:indexPath];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return dataArr[indexPath.row].cellHeight+1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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

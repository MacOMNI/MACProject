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
#import "ChatKeyBoard.h"

#import "YYImage.h"
#import "NSDictionary+JKBlock.h"
@interface SOFViewController ()<MACTableViewDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,ChatKeyBoardDataSource,ChatKeyBoardDelegate>{
     CGFloat _tapLocationY;//当前点击cell所在屏幕位置
    CGFloat _tableViewCurrentOffsetY;//tableView 当前的 offsetY
    BOOL _isNeedUpdateOffset;//是否需要更新 offset

}
/** 聊天键盘 */
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;
@property (nonatomic,strong) MACTableView *tableView;
@property (nonatomic,strong) NSMutableArray<FriendsMessageModel *> *dataArr;
@property (nonatomic,strong) CommentModel *selectedCommentModel;
@property (nonatomic,strong) NSIndexPath *selectedIndexPath;

@property (nonatomic,strong) YYTextSimpleEmoticonParser *parser;


@end

@implementation SOFViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setEnable:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
       // [[SDWebImageManager sharedManager].imageCache clearDisk];
        //注册键盘出现NSNotification
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification object:nil];
        
        
        //注册键盘隐藏NSNotification
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
    // Do any additional setup after loading the view.
}
-(void)initUI{
    self.title                             = @"朋友圈";
    _tableView                             = [[MACTableView alloc]initWithFrame: self.view.bounds style:UITableViewStyleGrouped];
    _tableView.macTableViewDelegate        = self;
   // _tableView.separatorStyle       = UITableViewCellSeparatorStyleNone;

    _tableView.tableHeaderView             = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.sectionHeaderHeight         = UITableViewAutomaticDimension;
    [_tableView registerClass:[MessageHeadView class] forHeaderFooterViewReuseIdentifier:@"messageHeadView"];
    [_tableView registerClass:[CommentCell class] forCellReuseIdentifier:@"commentCell"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[YYFPSLabel alloc]initWithFrame:CGRectMake(0, 5, 60, 30)]];
    [self.view addSubview:_tableView];

    self.chatKeyBoard = [ChatKeyBoard keyBoard];
    self.chatKeyBoard.keyBoardStyle        = KeyBoardStyleComment;
    self.chatKeyBoard.delegate             = self;
    self.chatKeyBoard.dataSource           = self;
    self.chatKeyBoard.placeHolder          = @"说点什么~~";
    self.chatKeyBoard.allowMore            = NO;
    self.chatKeyBoard.allowVoice           = NO;
   // self.chatKeyBoard.associateTableView   = _tableView;
    [self.view addSubview:self.chatKeyBoard];
    [self.chatKeyBoard keyboardDownForComment];
}
-(void)initData{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"MessageJSON" ofType:@"json"]]];
  NSString *str  = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    _dataArr = [FriendsMessageModel mj_objectArrayWithKeyValuesArray:[str jsonStringToDictionary]];
    FriendsMessageModel *model = [FriendsMessageModel new];
    for (NSInteger i = 0; i < _dataArr.count; i++) {
        model               = _dataArr[i];
        model.commentHeight = [MessageHeadView caculateHeight:model];
    }

    [_tableView reloadData];
}
#pragma mark macTableViewDelegate
-(void)loadDataRefreshOrPull:(MACRefreshState)state{
    if (state == MACRefreshing) {
        
    }else if (state == MACPulling){
        
    }
    [_tableView endLoading];
}

#pragma mark TableView delegate datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr[section].conmentArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
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
    headView.parser = self.parser;
    headView.model = _dataArr[section];
    return headView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentCell *fdCell       = [tableView cellForRowAtIndexPath:indexPath];
    _selectedIndexPath        = indexPath;
    _selectedCommentModel     = fdCell.model;
    _chatKeyBoard.placeHolder = [NSString stringWithFormat:@"回复:%@",fdCell.model.userName];
    //self.chatKeyBoard.hidden = NO ;
    _isNeedUpdateOffset       = YES;

    CGRect rect               = [fdCell convertRect:fdCell.commentLabel.frame toView:self.view];
    _tapLocationY             = rect.origin.y + rect.size.height;
    _tableViewCurrentOffsetY   = tableView.contentOffset.y;
    [self.chatKeyBoard keyboardUpforComment];

    
}
//#pragma  mark  configureCell
- (void)configureCell:(CommentCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    //cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    cell.parser = self.parser;
    cell.model = _dataArr[indexPath.section].conmentArray[indexPath.row];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.chatKeyBoard keyboardDownForComment];
}
#pragma mark YYLabel 
-(YYTextSimpleEmoticonParser *)parser{
    if (!_parser) {
        
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"face" ofType:@"plist"];
        NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        NSMutableDictionary *mapper = [NSMutableDictionary new];
        [data jk_each:^(id k, id v) {
            NSString *key = k;
            NSString *value = v;
            mapper[key] = [self imageWithName:value];
        }];
        
        _parser = [YYTextSimpleEmoticonParser new];
        _parser.emoticonMapper = mapper;
    }
    return _parser;
}
- (UIImage *)imageWithName:(NSString *)name {
    YYImage *image = [YYImage imageWithData:UIImagePNGRepresentation(name.macImage)];
    //YYImage *image = [YYImage imageWithCGImage:[UIImage imageNamed:name].CGImage];
    image.preloadAllAnimatedImageFrames = YES;
    return image;
}

#pragma mark --keyBoard notifaction

- (void)keyboardWillShow:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue        = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyboardHeight = [aValue CGRectValue].size.height;
    if (keyboardHeight == 0) return;
    if (_isNeedUpdateOffset) {
        DLog(@"LocationHeight = %lf  offset = %lf",_tapLocationY+_tableViewCurrentOffsetY,keyboardHeight+_tapLocationY+_tableViewCurrentOffsetY);
        if (appHeight-_tapLocationY < keyboardHeight+kChatToolBarHeight) {
            [_tableView setContentOffset:CGPointMake(0, keyboardHeight+kChatToolBarHeight+_tapLocationY-appHeight+_tableViewCurrentOffsetY) animated:YES];
        }else{
            [_tableView setContentOffset:CGPointMake(0, _tableViewCurrentOffsetY) animated:YES];

        }
    }
}
- (void)keyboardWillHide:(NSNotification *)notification{
    _isNeedUpdateOffset = NO;
}
#pragma mark -- ChatKeyBoardDataSource
- (NSArray<MoreItem *> *)chatKeyBoardMorePanelItems
{
    MoreItem *item1 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item2 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item3 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    MoreItem *item4 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item5 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item6 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    MoreItem *item7 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item8 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item9 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    return @[item1, item2, item3, item4, item5, item6, item7, item8, item9];
}
- (NSArray<ChatToolBarItem *> *)chatKeyBoardToolbarItems
{
    ChatToolBarItem *item1 = [ChatToolBarItem barItemWithKind:kBarItemFace normal:@"face" high:@"face_HL" select:@"keyboard"];
    
    ChatToolBarItem *item2 = [ChatToolBarItem barItemWithKind:kBarItemVoice normal:@"voice" high:@"voice_HL" select:@"keyboard"];
    
    ChatToolBarItem *item3 = [ChatToolBarItem barItemWithKind:kBarItemMore normal:@"more_ios" high:@"more_ios_HL" select:nil];
    
    ChatToolBarItem *item4 = [ChatToolBarItem barItemWithKind:kBarItemSwitchBar normal:@"switchDown" high:nil select:nil];
    
    return @[item1,item2,item3,item4];
}

- (NSArray<FaceThemeModel *> *)chatKeyBoardFacePanelSubjectItems
{
    NSMutableArray *subjectArray = [NSMutableArray array];
    
    NSArray *sources = @[@"face"];
    
    for (int i = 0; i < sources.count; ++i)
    {
        NSString *plistName = sources[i];
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        NSDictionary *faceDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        NSArray *allkeys = faceDic.allKeys;
        
        FaceThemeModel *themeM = [[FaceThemeModel alloc] init];
        themeM.themeStyle = FaceThemeStyleCustomEmoji;
        themeM.themeDecribe = [NSString stringWithFormat:@"f%d", i];
        
        NSMutableArray *modelsArr = [NSMutableArray array];
        
        for (int i = 0; i < allkeys.count; ++i) {
            NSString *name = allkeys[i];
            FaceModel *fm = [[FaceModel alloc] init];
            fm.faceTitle = name;
            fm.faceIcon = [faceDic objectForKey:name];
            [modelsArr addObject:fm];
        }
        themeM.faceModels = modelsArr;
        
        [subjectArray addObject:themeM];
    }
    
    return subjectArray;
}
#pragma mark 发送文本
-(void)chatKeyBoardSendText:(NSString *)text{
    if (_selectedIndexPath && _selectedCommentModel) {
        NSIndexPath *indexPath = _selectedIndexPath;
        CommentModel *model    = _selectedCommentModel;
        CommentModel *sendModel = [CommentModel new];
        sendModel.userName = @"麦克坤";
        sendModel.toUserName = model.userName;
        sendModel.contentMessage = text;
        [_dataArr[indexPath.section].conmentArray addObject:sendModel];
        
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        NSIndexPath *insertIndexPath = [NSIndexPath indexPathForRow:_dataArr[indexPath.section].conmentArray.count-1 inSection:_selectedIndexPath.section];
        [indexPaths addObject: insertIndexPath];
        [_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        //_chatKeyBoard.hidden = YES;
        [self.chatKeyBoard keyboardDownForComment];

    }
   }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

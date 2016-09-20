//
//  ChatKeyBoardViewController.m
//  MACProject
//
//  Created by MacKun on 16/9/20.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "ChatKeyBoardViewController.h"
#import "ChatKeyBoard.h"

#import "MoreItem.h"
#import "ChatToolBarItem.h"
#import "FaceSourceManager.h"
@interface ChatKeyBoardViewController ()<ChatKeyBoardDelegate, ChatKeyBoardDataSource>

/** 聊天键盘 */
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;
@property (weak, nonatomic) IBOutlet UILabel *voiceState;
@property (weak, nonatomic) IBOutlet UILabel *sendText;
@end

@implementation ChatKeyBoardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    /****************************************************************
     *  关于初始化方法 （这三个初始化方法用一个就行）
     *
     *  1，如果只是一个带导航栏的页面，且导航栏透明。
     或者根本就没有导航栏
     *
     *  使用  [ChatKeyBoard keyBoard];
     [ChatKeyBoard keyBoardWithNavgationBarTranslucent:YES]
     *       [ChatKeyBoard keyBoardWithParentViewBounds:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)]
     *
     *
     *  2，如果只是一个带导航栏的页面，导航栏不透明
     
     * 使用  [ChatKeyBoard keyBoardWithNavgationBarTranslucent:NO]
     [ChatKeyBoard keyBoardWithParentViewBounds:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)]
     *
     *
     *  3, 如果页面顶部还有一些标签栏，类似腾讯视频、今日头条、网易新闻之类的
     *
     * 请使用  [ChatKeyBoard keyBoardWithParentViewBounds:bounds]
     传入子视图控制器的bounds
     *
     ******************************************************************/
    self.title = @"ChatKeyBoard";
    self.chatKeyBoard = [ChatKeyBoard keyBoard];
   // [ChatKeyBoard keyBoardWithNavgationBarTranslucent:NO];
   // [ChatKeyBoard keyBoardWithParentViewBounds:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    //    self.chatKeyBoard = [ChatKeyBoard keyBoardWithParentViewBounds:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:NO];
    self.chatKeyBoard.delegate = self;
    self.chatKeyBoard.dataSource = self;
    
    self.chatKeyBoard.keyBoardStyle = KeyBoardStyleComment;
    
    self.chatKeyBoard.placeHolder = @"说点什么";
    [self.view addSubview:self.chatKeyBoard];
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
    
    return @[item1, item2, item3, item4];
}

- (NSArray<FaceThemeModel *> *)chatKeyBoardFacePanelSubjectItems
{
    return [FaceSourceManager loadFaceSource];
}


- (IBAction)switchBar:(UISwitch *)sender
{
    self.chatKeyBoard.allowSwitchBar = sender.on;
}
- (IBAction)closekeyboard:(id)sender {
    
    [self.chatKeyBoard keyboardDownForComment];
}
- (IBAction)beginComment:(id)sender {
    [self.chatKeyBoard keyboardUpforComment];
}

- (IBAction)switchVoice:(UISwitch *)sender
{
    self.chatKeyBoard.allowVoice = sender.on;
}

- (IBAction)switchFace:(UISwitch *)sender
{
    self.chatKeyBoard.allowFace = sender.on;
}

- (IBAction)switchMore:(UISwitch *)sender
{
    self.chatKeyBoard.allowMore = sender.on;
}

#pragma mark -- 语音状态
- (void)chatKeyBoardDidStartRecording:(ChatKeyBoard *)chatKeyBoard
{
    self.voiceState.text = @"正在录音";
}
- (void)chatKeyBoardDidCancelRecording:(ChatKeyBoard *)chatKeyBoard
{
    self.voiceState.text = @"已经取消录音";
}
- (void)chatKeyBoardDidFinishRecoding:(ChatKeyBoard *)chatKeyBoard
{
    self.voiceState.text = @"已经完成录音";
}
- (void)chatKeyBoardWillCancelRecoding:(ChatKeyBoard *)chatKeyBoard
{
    self.voiceState.text = @"将要取消录音";
}
- (void)chatKeyBoardContineRecording:(ChatKeyBoard *)chatKeyBoard
{
    self.voiceState.text = @"继续录音";
}


#pragma mark -- 更多
- (void)chatKeyBoard:(ChatKeyBoard *)chatKeyBoard didSelectMorePanelItemIndex:(NSInteger)index
{
    NSString *message = [NSString stringWithFormat:@"选择的ItemIndex %zd", index];
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"ItemIndex" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertV show];
}

#pragma mark -- 发送文本
- (void)chatKeyBoardSendText:(NSString *)text
{
    self.sendText.text = text;
}


@end

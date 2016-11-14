//
//  MACTableView.m
//  MACTableView
//  https://github.com/azheng51714/MACTableView
//  Created by MacKun on 16/10/21.
//  Copyright © 2016年 MacKun All rights reserved.
//


#import "MACTableView.h"
#import "MJRefresh.h"
#import "MJRefreshAutoFooter.h"
#import "UIScrollView+EmptyDataSet.h"
#import "MACRefreshGifHeader.h"

@interface MACTableView()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>{
    
}

/**  当前访问的page 下标*/
@property (nonatomic,assign) NSInteger page;
@end

@implementation MACTableView


//-(instancetype)init{
//    if (self = [super init]) {
//        [self initUI];
//    }
//    return self;
//}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        [self initUI];
    }
    
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self =[super initWithFrame:frame style:style]) {
        [self initUI];
    }
    
    return self;
}
-(void)initUI{
    //self.tableHeaderView                = [UIView new];
    self.tableFooterView                = [UIView new];
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator   = NO;
    
    self.macCanLoadState                = MACCanLoadAll;
    self.emptyTitle                     = @"";
    self.emptySubtitle                  = @"";
    self.emptyAtrtibutedTitle           = nil;
    self.emptyAtrtibutedSubtitle        = nil;
    self.emptyImage                     = nil;
    self.emptyColor                     = [UIColor whiteColor];
    
    self.showEmpty                      = YES;
    
    
    self.page                           = 0;
}
#pragma  mark public methods
-(void)setMacTableViewDelegate:(id<MACTableViewDelegate>)macTableViewDelegate{
    _macTableViewDelegate = macTableViewDelegate;
    self.dataSource       = (id<UITableViewDataSource>)macTableViewDelegate;
    self.delegate         = (id<UITableViewDelegate>)macTableViewDelegate;
}
-(void)setMacCanLoadState:(MACCanLoadState)macCanLoadState{
    _macCanLoadState = macCanLoadState;
    switch (_macCanLoadState) {
        case MACCanLoadAll:{
            [self setRefreshHeader];
            [self setRefreshFooter];
        }break;
        case MACCanLoadRefresh:{
            [self setRefreshHeader];
            self.mj_footer = nil;
        }break;
        case MACCanLoadNone:{
            self.mj_header = nil;
            self.mj_footer = nil;
        }break;
    }
}
-(void)beginLoading{
    //[self.mj_header beginRefreshing];
    [self.mj_header beginRefreshingWithCompletionBlock:^{
        if (_showEmpty) {
            self.emptyDataSetDelegate = self;
            self.emptyDataSetSource   = self;
        }
    }];
}
-(void)endLoading{
    if([self.mj_header isRefreshing]){
        [self.mj_header endRefreshingWithCompletionBlock:^{
            [self mac_reloadData];
        }];
    }
    if ([self.mj_footer isRefreshing])
        [self.mj_footer endRefreshingWithCompletionBlock:^{
            [self mac_reloadData];
        }];
}
-(void)noMoreData{
    if ([self.mj_footer isRefreshing])
        [self.mj_footer endRefreshingWithNoMoreData];
}
-(NSNumber *)getCurrentPage{
    return [NSNumber numberWithInteger:++self.page];
}
#pragma mark private methods
-(void)setRefreshHeader{//设置RefreshHeader
    if (className) {
       MJRefreshGifHeader  *gifHeaer = [[NSClassFromString(className) alloc] init];
        [gifHeaer setRefreshingTarget:self refreshingAction:@selector(refreshData)];
        self.mj_header = gifHeaer;
    }else{
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self  refreshData];
        }];
    }
    self.mj_header.multipleTouchEnabled = NO;
}
-(void)setRefreshFooter{//设置RefreshFooter
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self pullData];
    }];
    self.mj_footer.multipleTouchEnabled = NO;
    self.mj_footer.hidden = YES;
}
-(BOOL)isEmptyTableView{//判断当前tableView是否为空
    id<UITableViewDataSource> src = self.dataSource;
    NSInteger sections = 1;
    if (src && [src respondsToSelector: @selector(numberOfSectionsInTableView:)]) {
        sections = [src numberOfSectionsInTableView:self];
    }
    for (NSInteger i = 0; i < sections; ++i) {
        NSInteger rows = [src tableView:self numberOfRowsInSection:i];
        if (rows > 0) {
            return NO;
        }
    }
    
    return YES;
}

-(void)mac_reloadData{
    [self reloadData];
    if (self.macCanLoadState == MACCanLoadAll && [self isEmptyTableView]) {
        self.mj_footer.hidden = YES;
    }else if(self.macCanLoadState == MACCanLoadAll){
        self.mj_footer.hidden = NO;
    }
}
-(void)refreshData{//下拉刷新
    if (self.mj_footer.state == MJRefreshStateNoMoreData) {
        [self.mj_footer resetNoMoreData];
    }
    if (_macTableViewDelegate && [_macTableViewDelegate respondsToSelector:@selector(loadDataRefreshOrPull:)]) {
        self.page = 0;
        [_macTableViewDelegate loadDataRefreshOrPull:MACRefreshing];
    }
}
-(void)pullData{//加载更多
    if (_macTableViewDelegate && [_macTableViewDelegate respondsToSelector:@selector(loadDataRefreshOrPull:)]) {
        [_macTableViewDelegate loadDataRefreshOrPull:MACPulling];
    }
}

#pragma mark - DZNEmptyDataSetSource Methods
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.emptyAtrtibutedTitle) {
        return self.emptyAtrtibutedTitle;
    }
    NSString *text =self.emptyTitle;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.emptyAtrtibutedSubtitle) {
        return self.emptyAtrtibutedSubtitle;
    }
    NSString *text = self.emptySubtitle;
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:17.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    return nil;
    //    NSString *text = nil;
    //    UIFont *font = nil;
    //    UIColor *textColor = nil;
    //    text = @"点击界面重新加载";
    //    font = [UIFont boldSystemFontOfSize:16.0];
    //    textColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
    //    NSMutableDictionary *attributes = [NSMutableDictionary new];
    //    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    //    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    //
    //    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    return nil;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return self.emptyImage;
}
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
    return self.emptyColor;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -20.0f;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 0.0f;
}
#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}



- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}


@end

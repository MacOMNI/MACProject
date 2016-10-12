//
//  MACTableView.m
//  WeSchoolTeacher
//
//  Created by MacKun on 16/3/1.
//  Copyright © 2016年 solloun. All rights reserved.
//

#import "MACTableView.h"
#import "MACRefreshHeader.h"
#import "MJRefreshAutoFooter.h"

@interface MACTableView()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>{
    
}
/**
 *  是否第一次加载就展示空白页 默认为YES
 */
@property(nonatomic,assign)BOOL firstShowEmpty;

@end


@implementation MACTableView


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        [self initUI];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self initUI];
        self.firstShowEmpty = NO;
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self =[super initWithFrame:frame style:style];
    if (self) {
        [self initUI];
        self.firstShowEmpty = NO;
    }
    return self;
}
-(void)initUI{
    self.tableFooterView                = [UIView new];
    self.titleForEmpty                  = @"咋没数据呢,刷新试试~~";
    self.descriptionForEmpty            = @"您的数据被程序猿搬走咯~~";
    self.imageNameForEmpty              = @"placeholder_dropbox";
    self.firstShowEmpty                 = YES;
    self.isRefresh                      = YES;
    self.isLoadMore                     = YES;
    self.isShowEmpty                    = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator   = NO;
   // self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.page                           = 0;
}
-(void)setMacTableViewDelegate:(id<MACTableViewDelegate>)macTableViewDelegate{
    _macTableViewDelegate = macTableViewDelegate;
    self.dataSource       = (id<UITableViewDataSource>)macTableViewDelegate;
    self.delegate         = (id<UITableViewDelegate>)macTableViewDelegate;
}
-(void)setIsRefresh:(BOOL)isRefresh{
    _isRefresh = isRefresh;
    if (isRefresh) {
        // header
        [self  setMj_header:
         [MACRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)]];
        [self.mj_header setMultipleTouchEnabled:NO];
    }else{
        [self setMj_header:nil];
    }
}
-(void)setIsShowEmpty:(BOOL)isShowEmpty{
    _isShowEmpty = isShowEmpty;
    if (isShowEmpty) {
        self.emptyDataSetDelegate=self;
        self.emptyDataSetSource=self;
    }
//    } else{
//        self.emptyDataSetDelegate=nil;
//        self.emptyDataSetSource=nil;
//    }
}
-(void)setIsLoadMore:(BOOL)isLoadMore{
    _isLoadMore = isLoadMore;
    if (isLoadMore) {
        if (self.mj_footer==nil) {
            [self setMj_footer:[MJRefreshAutoNormalFooter
                                footerWithRefreshingBlock:^{
                                    // 加载下一页在这
                                    [self showWaiting];
                                    
                                    if (_macTableViewDelegate && [_macTableViewDelegate respondsToSelector:@selector(loadDataRefreshOrPull:)]) {
//                                        if (self.mj_footer.state==MJRefreshStateIdle) {
//                                            return ;
//                                        }
                                      //  MJRefreshState state=self.mj_footer.state;
                                        [_macTableViewDelegate loadDataRefreshOrPull:MACPulling];
                                    }
                                    
                                }]
             ];
        }
        [self.mj_footer setMultipleTouchEnabled:NO];
    }else{
        [self setMj_footer:nil];
    }
}
-(void)beginLoading{
    [self.mj_header beginRefreshing];
}
-(void)endLoading{
    [self hideHUD];
    if([self.mj_header isRefreshing])
    [self.mj_header endRefreshing];
    if ([self.mj_footer isRefreshing])
    [self.mj_footer endRefreshing];
}
//-(void)noMoreData{
//    [self showWaiting];
//    if ([self.mj_footer isRefreshing])
//        [self.mj_footer endRefreshingWithNoMoreData];
//}
-(void)refreshData{
    [self showWaiting];
    if (self.mj_footer.state == MJRefreshStateNoMoreData) {
        [self.mj_footer resetNoMoreData];
    }
    if (_macTableViewDelegate && [_macTableViewDelegate respondsToSelector:@selector(loadDataRefreshOrPull:)]) {
        self.page = 0;
        [_macTableViewDelegate loadDataRefreshOrPull:MACRefreshing];
    }
}
-(NSNumber *)getCurrentPage{
    return [NSNumber numberWithInteger:++self.page];
}
#pragma mark - DZNEmptyDataSetSource Methods
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text           = self.titleForEmpty;

    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text                     = self.descriptionForEmpty;

    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode            = NSLineBreakByWordWrapping;
    paragraph.alignment                = NSTextAlignmentCenter;

    NSDictionary *attributes           = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (!self.imageNameForEmpty || [self.imageNameForEmpty isBlank]) {
        return nil;
    }
    return [UIImage imageNamed:self.imageNameForEmpty];
}
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -20.0f;
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 0.0f;
}
#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    if (self.firstShowEmpty) {
        self.firstShowEmpty = NO;
        
        return NO;
    }
    
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];

    animation.fromValue         = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue           = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];

    animation.duration          = 0.25;
    animation.cumulative        = YES;
    animation.repeatCount       = MAXFLOAT;
    
    return animation;
}


@end

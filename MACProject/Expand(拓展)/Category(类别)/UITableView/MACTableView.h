//
//  MACTableView.h
//  WeSchoolTeacher
//
//  Created by MacKun on 16/3/1.
//  Copyright © 2016年 solloun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"
#import "CellDataAdapter.h"
typedef NS_ENUM(NSInteger, MACRefreshState) {

    /** 下拉刷新的状态 */
    MACRefreshing,
    /** pull刷新中的状态 */
    MACPulling,
};

@protocol MACTableViewDelegate <NSObject>

@optional

/**
 *  获取数据
 *
 *  @param state MACRefreshing为Refresh MACPulling 为 Pull
 */
-(void)loadDataRefreshOrPull:(MACRefreshState)state;

@end

@interface MACTableView : UITableView
/**
 *  macTableView delegate
 */
@property (nonatomic,weak) id<MACTableViewDelegate> macTableViewDelegate;
/**
 *  是否支持下拉刷新 默认为YES
 */
@property (nonatomic,assign) BOOL isRefresh;
/**
 *  是否可以加载更多 默认为YES
 */
@property (nonatomic,assign) BOOL isLoadMore;
/**
 *  当前访问的page 下标
 */
@property (nonatomic,assign) NSInteger page;

/**
 *  是否展示空白页 默认为YES
 */
@property(nonatomic,assign)BOOL isShowEmpty;


/**
 *  空白页的标题 默认为 “" 为空不显示
 */
@property(nonatomic,copy) NSString *titleForEmpty;
/**
 *  空白页的副标题 默认为 “" 为空不显示
 */
@property(nonatomic,copy) NSString *descriptionForEmpty;
/**
 *  空白页展位图名称 默认为 “img_placehoder_icon" 为空或nil无图片
 */
@property(nonatomic,copy) NSString *imageNameForEmpty;

/**
 *  CellDataAdapter arr
 */
@property(nonatomic,strong) NSMutableArray *cellDataArr;

/**
 *
 *  获取当下访问接口下标
 */
-(NSNumber *)getCurrentPage;
/**
 *  开始加载
 */
-(void)beginLoading;
/**
 *  结束刷新
 */
-(void)endLoading;
///**
// *  提示无更多数据
// */
//-(void)noMoreData;
@end

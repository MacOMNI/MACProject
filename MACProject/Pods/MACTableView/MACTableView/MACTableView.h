//
//  MACTableView.h
//  MACTableView
//  https://github.com/azheng51714/MACTableView
//  Created by MacKun on 16/10/21.
//  Copyright © 2016年 MacKun All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MACRefreshState) {
    
    MACRefreshing = 0, /** 下拉刷新的状态 */
    MACPulling,        /** pull 加载更多刷新中的状态 */
};

typedef NS_ENUM(NSInteger,MACCanLoadState){
    
    MACCanLoadNone = 0,/**不支持下拉和加载更多*/
    MACCanLoadRefresh, /**只支持下拉刷新*/
    MACCanLoadAll,     /** 同时支持下拉和加载更多*/
};

@protocol MACTableViewDelegate <NSObject>

@optional

/**@param state MACRefreshing 下拉刷新 MACPulling 为 Pull 加载更多*/
-(void)loadDataRefreshOrPull:(MACRefreshState)state;

@end

@interface MACTableView : UITableView<NSCoding>

@property (nonatomic,weak) id<MACTableViewDelegate> macTableViewDelegate;//MACTableView delegate

/** 是否展示空白页 默认为YES*/
@property(nonatomic,assign,getter = isShowEmpty)BOOL showEmpty;
/** MACTableView 加载支持，默认同时支持下拉和加载更多*/
@property (nonatomic,assign) IBInspectable MACCanLoadState macCanLoadState;
/**空白页的标题 默认为 “" 为空,不显示*/
@property(nonatomic,copy) IBInspectable NSString *emptyTitle;
/**  空白页的副标题 默认为 “" 为空,不显示*/
@property(nonatomic,copy) IBInspectable NSString *emptySubtitle;
/**  空白页展位图名称 默认为 nil,不显示*/
@property(nonatomic,strong) IBInspectable UIImage *emptyImage;
/**  空白页背景颜色,默认白色*/
@property(nonatomic,strong) IBInspectable UIColor *emptyColor;

/**空白页的标题 默认为 nil,显示emptyTitle*/
@property(nonatomic,copy) IBInspectable NSAttributedString *emptyAtrtibutedTitle;
/**  空白页的副标题 默认为 nil,emptySubtitle*/
@property(nonatomic,copy) IBInspectable NSAttributedString *emptyAtrtibutedSubtitle;

/** 获取当下访问接口Page下标 默认从1开始 以来代替控制器计算Page*/
-(NSNumber *)getCurrentPage;
/** 开始加载*/
-(void)beginLoading;
/**结束加载，并刷新数据*/
-(void)endLoading;
/**提示无更多数据*/
-(void)noMoreData;
@end


//
//  MACScrollView.h
//  WeSchoolTeacher
//
//  Created by MacKun on 16/3/28.
//  Copyright © 2016年 com.soullon.WeSchoolTeacher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"
@interface MACScrollView : UIScrollView<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

/**
 *  是否展示空白页 默认为NO不展示
 */
@property(nonatomic,assign)BOOL isShowEmpty;
///**
// *  是否第一次加载就展示空白页
// */
//@property(nonatomic,assign)BOOL firstShowEmpty;
/**
 *  空白页的标题 默认为 “您的请求数据为空" 为空不显示
 */
@property(nonatomic,copy) NSString *titleForEmpty;
/**
 *  空白页的副标题 默认为 “亲，咋没有数据呢，刷新试试~~" 为空不显示
 */
@property(nonatomic,copy) NSString *descriptionForEmpty;
/**
 *  空白页展位图名称 默认为 “placeholder_none" 为空不显示
 */
@property(nonatomic,copy) NSString *imageNameForEmpty;


@end

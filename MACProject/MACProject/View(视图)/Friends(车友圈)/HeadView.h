//
//  HeadView.h
//  WeiSchoolTeacher
//
//  Created by MacKun on 16/1/12.
//  Copyright © 2016年 MacKun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HeadViewDelegate <NSObject>

@optional
- (void)clickHeadView:(NSInteger)section;

@end
@interface HeadView : UITableViewHeaderFooterView

/**
 *  数据源
 */
@property(nonatomic,strong)NSMutableArray *group;
/**
 *  群组名称
 */
@property(nonatomic,copy)NSString *name;
/**
 *  section下标
 */
@property(nonatomic,assign)NSInteger section;

/**
 *  是否展开
 */
@property(nonatomic,assign,getter=isExend)BOOL opened;

@property(nonatomic,weak)id<HeadViewDelegate>headViewDelegate;

+ (instancetype)headViewWithTableView:(UITableView *)tableView;
@end

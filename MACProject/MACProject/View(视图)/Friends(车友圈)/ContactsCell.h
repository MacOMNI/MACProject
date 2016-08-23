//
//  ContactsCell.h
//  WeSchoolStudent
//
//  Created by MacKun on 15/10/9.
//  Copyright © 2015年 safiri. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ContactDelegate;
#import "GroupModel.h"
@interface ContactsCell : UITableViewCell
/**
 *  用户类型
 */
@property (weak, nonatomic) IBOutlet UIImageView *imgType;
/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *avctar;
/**
 *  联系人的状态
 */
@property (nonatomic,copy) GroupModel* contactStatus;
/**
 *  联系人的类型 0 我的关注 1 我的粉丝
 */
@property (nonatomic,assign) NSInteger idx;
/**
 *  联系人的下标
 */
@property (nonatomic,assign) NSInteger row;
/**
 *  委托
 */
@property(nonatomic,weak) id<ContactDelegate>  contactDelegate;

@end

@protocol ContactDelegate <NSObject>
/**
 *  点击头像 跳转到 个人信息界面
 */
-(void)clickCellAcatvor:(ContactsCell *)cell;

@end
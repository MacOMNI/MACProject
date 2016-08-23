//
//  GroupModel.h
//  WeiSchoolTeacher
//
//  Created by MacKun on 16/1/12.
//  Copyright © 2016年 MacKun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupModel : NSObject
/**
 *  用户编号
 */
@property(nonatomic,copy) NSString* userid;
/**
 *  姓名
 */
@property(nonatomic,copy) NSString* XM;
/**
 *  照片
 */
@property(nonatomic,copy) NSString* ZP;
/**
 *  用户标示（Mark 0：我的关注 1： 我的粉丝）
 */
@property(nonatomic,assign) NSInteger Mark;
/**
 *  用户身份类型 1 学生 2 家长 3 老师
 */
@property(nonatomic,copy) NSString* YHSF;


@end

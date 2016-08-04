//
//  UserModel.h
//  MACProject
//
//  Created by MacKun on 16/4/18.
//  Copyright © 2016年 com.soullon.MACProject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
//YHBH：用户编号
//YHMM :用户密码
//XM：姓名
//ZP:照片
//XBM：性别
//RYH:账号
//LXDH：联系电话
//DZYX:邮箱
//CSRQ:出生日期
//GRJJ:个人简介
/**
 *  用户编号
 */
@property(nonatomic,copy) NSString *YHBH;
/**
 *  用户密码
 */
@property(nonatomic,copy) NSString *YHMM;
/**
 *  姓名
 */
@property(nonatomic,copy) NSString *XM;
/**
 *  照片
 */
@property(nonatomic,copy) NSString *ZP;
/**
 *  性别
 */
@property(nonatomic,copy) NSString *XBM;
/**
 *  账号
 */
@property(nonatomic,copy) NSString *RYH;
/**
 *  单位编号
 */
@property(nonatomic,copy) NSString *DWBH;
/**
 *  单位名称
 */
@property(nonatomic,copy) NSString *unit_name;
/**
 *  身份证
 */
@property(nonatomic,copy) NSString *SFZJH;
/**
 *  注册时间
 */
@property(nonatomic,copy) NSString *CJSJ;
/**
 *  YHSF:1_学生,2_家长,3_教师,4_其他
 */
@property(nonatomic,copy) NSString *YHSF;
/**
 *  联系电话
 */
@property(nonatomic,copy) NSString *LXDH;
/**
 *  邮箱
 */
@property(nonatomic,copy) NSString *DZYX;
/**
 *  出生日期
 */
@property(nonatomic,copy) NSString *CSRQ;
/**
 *  个人简介
 */
@property(nonatomic,copy) NSString *GRJJ;
@end

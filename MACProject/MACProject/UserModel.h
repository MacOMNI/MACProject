//
//  UserModel.h
//  MACProject
//
//  Created by MacKun on 16/4/18.
//  Copyright © 2016年 com.soullon.MACProject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

/**
 *  用户编号
 */
@property(nonatomic,copy) NSString *YHBH;
/**
 *  用户密码
 */
//@property(nonatomic,copy) NSString *YHMM;
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

@end

//
//  UserAuthNew.h
//  WeSchoolTeacher
//
//  Created by wangzijian on 16/3/23.
//  Copyright © 2016年 solloun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface UserAuth : NSObject
/**
 *  用户昵称
 */
@property(nonatomic, strong, readonly) NSString *userName;



/**
 *  用户id
 */
@property(nonatomic, strong, readonly) NSString *userid;

/**
 *  用户信息
 */
@property(nonatomic, strong, readonly)UserModel  *userInfo;

/**
 *  用户是否登录
 */
@property(nonatomic, assign, readonly) BOOL isLogin;

+ (UserAuth *)shared;

/**
 *  保存用户信息
 *
 *  @param userInfo 用户信息
 */
+ (void)saveUserInfo:(UserModel*)userInfo;

/**
 *  保存用户名
 *
 *  @param userName 用户名
 */
+ (void)saveUserName:(NSString*)userName;

/**
 *  保存用户id
 *
 *  @param userId 用户id
 */
+ (void)saveUserId:(NSString*)userId;

/**
 *  清空用户信息
 */
+ (void)clean;
@end

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
 *  用户密码
 */
@property(nonatomic, strong, readonly) NSString *passWord;

/**
 *  用户id
 */
@property(nonatomic, strong, readonly) NSString *userid;

/**
 *  用户信息
 */
@property(nonatomic, strong, readonly)UserModel  *userInfo;

/**
 *  暂时RYH
 */
@property(nonatomic, strong, readonly) NSString *sid;

/**
 *  用户是否登录
 */
@property(nonatomic, assign, readonly) BOOL isLogin;

/**
 *  曾经访问的城市名称
 */
@property(nonatomic, strong, readonly) NSString *visitedCityName;
/**
 *  曾经访问的学校名称
 */
@property(nonatomic, strong, readonly) NSString *schoolName;
/**
 *  曾经访问的学校编号
 */
@property(nonatomic, strong, readonly) NSString *schoolCode;
/**
 *  使用者身份
 */
@property(nonatomic, strong, readonly) NSString *userIdentify;
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
 *  保存密码 输入的密码
 *
 *  @param passWord 密码
 */
+ (void)savePassWord:(NSString*)passWord;

/**
 *  保存sessionId
 *
 *  @param sid sessionId
 */
+ (void)saveSid:(NSString*)sid;
/**
 *  保存曾经访问的城市
 *
 *  @param cityName 城市名称
 */
+ (void)saveVistedCityName:(NSString *) cityName;
/**
 *  保存学校名称
 *
 *  @param schoolName 学校名
 */
+ (void)saveSchoolName:(NSString *) schoolName;
/**
 *  保存学校编号
 *
 *  @param schoolCode 保存学校编号
 */
+ (void)saveSchoolCode:(NSString *) schoolCode;
/**
 *  保存用户身份  :1_学生,2_家长,3_教师,4_其他
 *
 *  @param userIdentify 身份信息
 */
+ (void)saveUserIdentify:(NSString *) userIdentify;
/**
 *  清空用户信息
 */
+ (void)clean;
@end

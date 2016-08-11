//
//  UserAuthNew.m
//  WeSchoolTeacher
//
//  Created by wangzijian on 16/3/23.
//  Copyright © 2016年 solloun. All rights reserved.
//
#import <CommonCrypto/CommonCryptor.h>
#import "UserAuth.h"
#import "NSUserDefaults+SecureAdditions.h"
/**
 *  APP_名称
 */
static NSString * APP_NAME = @"appName_Teacher";
/**
 *  用户名
 */
static NSString * kUserName = @"app_TeacherUserName";

/**
 *  用户密码
 */
static NSString * kPassword = @"app_TeacherPassword";

/**
 *  用户id
 */
static NSString * kUserId = @"app_TeacherUserId";

/**
 *  用户信息
 */
static NSString * kUserInfo = @"app_TeacherUserInfo";

/**
 *  sessionId
 */
static NSString * kSessionId = @"app_TeacherSessionId";

/**
 *  配置城市名称
 */
static NSString * kCityName = @"app_TeacherBaseUrl";
/**
 *  配置学校名称
 */
static NSString * kSchoolName = @"app_SchoolName";
/**
 *  配置学校编码
 */
static NSString * kSchoolCode = @"app_SchoolCode";
/**
 *  身份
 */
static NSString * kUserIdentify = @"app_UserIdentify";
/**
 *  securityAuthKey
 */
static NSString *securityAuthKey = @"!@#MacProject123_";


@interface UserAuth ()

@end

@implementation UserAuth

+ (UserAuth *) shared{
    static UserAuth *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[UserAuth alloc]init];
        //[[NSUserDefaults standardUserDefaults] setSecret:@"WeSchoolTeacher"];
    });
    return obj;
}

- (BOOL)isLogin{
    if (self.userInfo){
        return YES;
    }
    return NO;
}
#pragma  mark get
- (UserModel*)userInfo{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    id userInfoStr = [userInfo secretObjectForKey:kUserInfo];
    UserModel *model;
    if ([userInfoStr isKindOfClass:[NSDictionary class]]) {
        model=[UserModel mj_objectWithKeyValues:userInfoStr];
    }else{
        NSArray *arr=(NSArray *)userInfoStr;
        model=[UserModel mj_objectWithKeyValues:arr[0]];
    }
    return model;
}

- (NSString*)userName{
    NSUserDefaults *userName = [NSUserDefaults standardUserDefaults];
    NSString *userNameStr = [userName secretStringForKey:kUserName];
    return userNameStr;
}
-(NSString *)visitedCityName{
    NSUserDefaults *passWord = [NSUserDefaults standardUserDefaults];
    NSString *pwdStr = [passWord secretStringForKey:kCityName];
    return pwdStr;
}


- (NSString*)userid{
    NSUserDefaults *userid = [NSUserDefaults standardUserDefaults];
    NSString *useridStr = [userid secretStringForKey:kUserId];
    if(!useridStr)
    {
        useridStr=@"";
    }
    return useridStr;
}

#pragma mark save


+ (void)saveUserInfo:(UserModel*)dictionary{
    NSUserDefaults *save = [NSUserDefaults standardUserDefaults];
    //id obj=dictionary.mj_JSONObject;
    id dic=dictionary.mj_JSONObject;
    [save setSecretObject:dic forKey:kUserInfo];
    
}

+ (void)saveUserName:(NSString*)userName{
    NSUserDefaults *save = [NSUserDefaults standardUserDefaults];
    //[save setObject:userName forKey:kUserName];
    [save setSecretObject:userName forKey:kUserName];
    
}

+ (void)saveUserId:(NSString*)userId{
    NSUserDefaults *save = [NSUserDefaults standardUserDefaults];
    [save setSecretObject:userId forKey:kUserId];
    
}


#pragma mark other methods

+ (void)clean{
    NSUserDefaults *clean = [NSUserDefaults standardUserDefaults];
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [clean removePersistentDomainForName:appDomain];
    [clean synchronize];
    //  [SSKeychain deletePasswordForService:kUrlStr account:APP_NAME];
}


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
    if(error) {
        return nil;
    }
    return dic;
}

+ (NSString*)jsonStringWithObject:(id)object{
    if (object == nil) {
        return nil;
    }
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end
//
//  BaseService.h
//  WeiSchoolTeacher
//
//  Created by MacKun on 15/12/11.
//  Copyright © 2015年 MacKun. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  HTTP访问回调
 *
 *  @param urlString 状态码 0 访问失败   200 正常  500 空 其他异常
 *  @param result    返回数据 nil 为空
 *  @param error     错误描述
 */
typedef void(^ResultBlock)(NSInteger stateCode, NSMutableArray* result, NSError *error);
//block不是self的属性或者变量时，在block内使用self也不会循环引用：

@interface BaseService : NSObject

/**
 *  普通的访问请求(有提示，带判断网络状态)
 *
 *  @param URLString    接口地址
 *  @param parameters   字典参数
 *  @param requestBlock 回调函数
 */
+ (void)POST:(NSString *)URLString  parameters:(id)parameters result:(ResultBlock)requestBlock;
/**
 *  普通的访问请求(无提示，不带判断网络状态)
 *
 *  @param URLString    接口地址
 *  @param parameters   字典参数
 *  @param requestBlock 回调函数
 */
+ (void)POSTWithNormal:(NSString *)URLString  parameters:(id)parameters result:(ResultBlock)requestBlock;

/**
 *  访问请求(有提示带缓存，带判断网络状态)
 *
 *  @param URLString    请求地址
 *  @param parameters   请求参数
 *  @param requestBlock 请求回调
 */
+ (void)POSTWithCache:(NSString *)URLString parameters:(id)parameters  completionBlock:(ResultBlock)requestBlock;

/**
 *  无提示的访问请求(带缓存，带判断网络状态)
 *
 *  @param URLString    请求地址
 *  @param parameters   请求参数
 *  @param requestBlock 请求回调
 */
+(void)POSTWithCacheNormal:(NSString *)URLString parameters:(id)parameters  completionBlock:(ResultBlock)requestBlock cacheBlock:(ResultBlock)cacheBlock;
/**
 *  上传多媒体文件接口
 *
 *  @param URLString    请求地址
 *  @param parameters   请求参数
 *  @param mediaDatas   多媒体数据  图片传 UIImage  语音传url字符串地址
 *  @param requestBlock 请求回调
 */
+(void)POSTWithFormDataURL:(NSString *)URLString parameters:(id)parameters mediaData:(NSMutableArray *)mediaDatas completionBlock:(ResultBlock)requestBlock;




@end

//
//  NSString+MAC.h
//  WeiSchoolTeacher
//
//  Created by MacKun on 15/12/11.
//  Copyright © 2015年 MacKun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(MAC)

/**
 *  判断字符串是否为空
 */
-(BOOL)isBlank;

/**
 *  MD5加密
 */
-(NSString *)md5String;

/**
 *  计算相应字体下指定宽度的字符串高度
 */
- (CGFloat)stringHeightWithFont:(UIFont *)font width:(CGFloat)width;



/**
 *  JSON字符传转化成字典
 *
 *  @return 返回字典
 */
- (NSDictionary *)jsonStringToDictionary;

/**
 *  取出HTML
 *
 *  @return 返回字符串
 */
-(NSString *)htmlToString;




/**
 *  字符串加密为base64
 *
 *  @return 返回String
 */
-(NSString *)base64StringFromText;

/**
 *  加密字符串解析
 *
 *  @return 返回解析后的字符串
 */
- (NSString *)textFromBase64String;
/**
 *  将字符串转化为NSURL
 *
 *  @return  NSURL地址
 */
-(NSURL *)macUrl;
/**
 *  将资源字符串转化为图片资源
 *
 *  @return  图片
 */
-(UIImage *)macImage;


@end

//
//  NSString+Trims.h
//
//
//  Created by MacKun on 14/12/15.
//  Copyright (c) 2014年 MacKun All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Trims)
/**
 *  @brief  清除html标签
 *
 *  @return 清除后的结果
 */
- (NSString *)stringByStrippingHTML;
/**
 *  @brief  清除js脚本
 *
 *  @return 清楚js后的结果
 */
- (NSString *)stringByRemovingScriptsAndStrippingHTML;
/**
 *  @brief  去除空格
 *
 *  @return 去除空格后的字符串
 */
- (NSString *)trimmingWhitespace;
/**
 *  @brief  去除字符串与空行
 *
 *  @return 去除字符串与空行的字符串
 */
- (NSString *)trimmingWhitespaceAndNewlines;
@end

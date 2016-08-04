//
//  NSString+UUID.h
//
//
//  Created by MacKun on 14/12/15.
//  Copyright (c) 2014年 MacKun All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UUID)
/**
 *  @brief  获取随机 UUID 例如 E621E1F8-C36C-495A-93FC-0C247A3E6E5F
 *
 *  @return 随机 UUID
 */
+ (NSString *)UUID;
/**
 *
 *  @brief  毫秒时间戳 例如 1443066826371
 *
 *  @return 毫秒时间戳
 */
+ (NSString *)UUIDTimestamp;
@end

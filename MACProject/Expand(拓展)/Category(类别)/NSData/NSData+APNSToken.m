//
//  NSData+APNSToken.m
//  IOS-Categories
//
//  Created by MacKun on 14/12/15.
//  Copyright (c) 2014年 MacKun All rights reserved.
//

#import "NSData+APNSToken.h"

@implementation NSData (APNSToken)
/**
 *  @brief  将APNS NSData类型token 格式化成字符串
 *
 *  @return 字符串token
 */
- (NSString *)APNSToken {
    return [[[[self description]
              stringByReplacingOccurrencesOfString: @"<" withString: @""]
             stringByReplacingOccurrencesOfString: @">" withString: @""]
            stringByReplacingOccurrencesOfString: @" " withString: @""];
}

@end

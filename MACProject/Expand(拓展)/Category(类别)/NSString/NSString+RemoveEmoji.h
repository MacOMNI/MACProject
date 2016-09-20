//
//  NSString+RemoveEmoji.h
//  NSString+RemoveEmoji
//
//
//  Created by MacKun on 14/12/15.
//  Copyright (c) 2014年 MacKun All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSString (RemoveEmoji)
/**
 *  是否是emoji
 *
 *  @return 
 */
-(BOOL)isEmoji;
/**
 *  @brief  是否包含emoji
 *
 *  @return 是否包含emoji
 */
- (BOOL)isIncludingEmoji;

/**
 *  @brief  删除掉包含的emoji
 *
 *  @return 清除后的string
 */
- (instancetype)removedEmojiString;

@end

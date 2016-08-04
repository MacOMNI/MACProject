//
//  UINavigationItem+Lock.h
//
//  Created by MacKun on 14/12/15.
//  Copyright (c) 2014年 MacKun All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (Lock)
/**
 *  @brief  锁定RightItem
 *
 *  @param lock 是否锁定
 */
- (void)lockRightItem:(BOOL)lock;
/**
 *  @brief  锁定LeftItem
 *
 *  @param lock 是否锁定
 */
- (void)lockLeftItem:(BOOL)lock;
@end

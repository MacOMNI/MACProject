//
//  UIView+UIView_BlockGesture.h
//  Created by MacKun on 15/4/25.
//  Copyright (c) 2015年 MacKun All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (BlockGesture)
/**
 *  @brief  添加tap手势
 *
 *  @param block 代码块
 */
- (void)addTapActionWithBlock:(GestureActionBlock)block;
/**
 *  @brief  添加长按手势
 *
 *  @param block 代码块
 */
- (void)addLongPressActionWithBlock:(GestureActionBlock)block;
@end

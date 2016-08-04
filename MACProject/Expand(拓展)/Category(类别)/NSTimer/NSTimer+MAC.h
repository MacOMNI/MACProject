//
//  NSTimer+MAC.h
//  
//
//  Created by MacKun on 15/11/11.
//  Copyright © 2015年 MacKun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer(MAC)


/**
 *  开启一个当前线程内可重复执行的NSTimer对象
 *
 *  @param inTimeInterval 重复时间
 *  @param inBlock        操作内容
 *  @param inRepeats      是否重复
 *
 *  @return NSTimer对象
 */
+(id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;
/**
 *  开启一个需添加到线程的可重复执行的NSTimer对象
 *
 *  @param inTimeInterval 重复时间
 *  @param inBlock        操作内容
 *  @param inRepeats      是否重复
 *
 *  @return NSTimer对象
 */
+(id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;
/**
 *  暂停NSTimer
 */
- (void)pauseTimer;
/**
 *   开始NSTimer
 */
- (void)resumeTimer;
/**
 *  延迟开始NSTimer
 */
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end

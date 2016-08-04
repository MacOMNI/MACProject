//
//  NSObject+Blocks.h
//  PSFoundation
//
//
//  Created by MacKun on 14/12/15.
//  Copyright (c) 2014年 MacKun All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSObject (Blocks)
+ (id)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
+ (id)performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay;
- (id)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
- (id)performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay;
+ (void)cancelBlock:(id)block;
+ (void)cancelPreviousPerformBlock:(id)aWrappingBlockHandle __attribute__ ((deprecated));

@end

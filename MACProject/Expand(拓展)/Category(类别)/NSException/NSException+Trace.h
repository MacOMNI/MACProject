//
//  NSException+Trace.h
//
//
//  Created by MacKun on 14/12/15.
//  Copyright (c) 2014年 MacKun All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSException (Trace)
- (NSArray *)backtrace;
@end

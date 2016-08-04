
//
//  NSNumber+CGFloat.h
//
//
//  Created by MacKun on 14/12/15.
//  Copyright (c) 2014年 MacKun All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSNumber (CGFloat)

- (CGFloat)CGFloatValue;

- (id)initWithCGFloat:(CGFloat)value;

+ (NSNumber *)numberWithCGFloat:(CGFloat)value;

@end
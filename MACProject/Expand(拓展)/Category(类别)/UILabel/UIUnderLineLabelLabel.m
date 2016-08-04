//
//  UIUnderLineLabelLabel.m
//  Component
//
//  Created by MacKun on 15/7/9.
//  Copyright (c) 2015年 MacKun. All rights reserved.
//

#import "UIUnderLineLabelLabel.h"

@implementation UIUnderLineLabelLabel

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor appLineColor].CGColor);  // set as the text's color
    CGContextSetLineWidth(ctx, 1.0f);
    
    CGPoint leftPoint = CGPointMake(0,
                                    self.frame.size.height);
    CGPoint rightPoint = CGPointMake(self.frame.size.width,
                                     self.frame.size.height);
    CGContextMoveToPoint(ctx, leftPoint.x, leftPoint.y);
    CGContextAddLineToPoint(ctx, rightPoint.x, rightPoint.y);
    CGContextStrokePath(ctx);
}

@end

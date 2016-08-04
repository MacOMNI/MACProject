//
//  UIView+MAC.m
//  WeiSchoolTeacher
//
//  Created by MacKun on 15/12/11.
//  Copyright © 2015年 MacKun. All rights reserved.
//

#import "UIView+MAC.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

static char BAViewCookieKey;

@implementation UIView(MAC)
/**
 *  @brief  找到当前view所在的viewcontroler
 */
- (UIViewController *)viewController
{
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    return nil;
}

- cookie
{
    return objc_getAssociatedObject(self, &BAViewCookieKey);
}

- (void)setCookie:cookie
{
    objc_setAssociatedObject(self, &BAViewCookieKey, cookie, OBJC_ASSOCIATION_RETAIN);
}


- (void)setSize:(CGSize)size;
{
    CGPoint origin = [self frame].origin;
    
    [self setFrame:CGRectMake(origin.x, origin.y, size.width, size.height)];
}

- (CGSize)size;
{
    return [self frame].size;
}

- (CGFloat)left;
{
    return CGRectGetMinX([self frame]);
}

- (void)setLeft:(CGFloat)x;
{
    CGRect frame = [self frame];
    frame.origin.x = x;
    [self setFrame:frame];
}

- (CGFloat)top;
{
    return CGRectGetMinY([self frame]);
}

- (void)setTop:(CGFloat)y;
{
    CGRect frame = [self frame];
    frame.origin.y = y;
    [self setFrame:frame];
}

- (CGFloat)right;
{
    return CGRectGetMaxX([self frame]);
}

- (void)setRight:(CGFloat)right;
{
    CGRect frame = [self frame];
    frame.origin.x = right - frame.size.width;
    
    [self setFrame:frame];
}

- (CGFloat)bottom;
{
    return CGRectGetMaxY([self frame]);
}

- (void)setBottom:(CGFloat)bottom;
{
    CGRect frame = [self frame];
    frame.origin.y = bottom - frame.size.height;
    
    [self setFrame:frame];
}

- (CGFloat)centerX;
{
    return [self center].x;
}

- (void)setCenterX:(CGFloat)centerX;
{
    [self setCenter:CGPointMake(centerX, self.center.y)];
}

- (CGFloat)centerY;
{
    return [self center].y;
}

- (void)setCenterY:(CGFloat)centerY;
{
    [self setCenter:CGPointMake(self.center.x, centerY)];
}

- (CGFloat)width;
{
    return CGRectGetWidth([self frame]);
}

- (void)setWidth:(CGFloat)width;
{
    CGRect frame = [self frame];
    frame.size.width = width;
    
    [self setFrame:CGRectStandardize(frame)];
}

- (CGFloat)height;
{
    return CGRectGetHeight([self frame]);
}

- (void)setHeight:(CGFloat)height;
{
    CGRect frame = [self frame];
    frame.size.height = height;
    [self setFrame:CGRectStandardize(frame)];
}

-(void)addShadowonBottom
{
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 0.7;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint p1 = CGPointMake(0.0, 0.0+self.frame.size.height);
    CGPoint p2 = CGPointMake(0.0+self.frame.size.width, p1.y);
    CGPoint c1 = CGPointMake((p1.x+p2.x)/256 , p1.y+1.50);
    CGPoint c2 = CGPointMake(c1.x*255, c1.y);
    
    [path moveToPoint:p1];
    [path addCurveToPoint:p2 controlPoint1:c1 controlPoint2:c2];
    
    self.layer.shadowPath = path.CGPath;
}

-(void)addShadowonTop
{
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 0.7;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint p1 = CGPointMake(0.0, 0.0);
    CGPoint p2 = CGPointMake(0.0+self.frame.size.width, p1.y);
    CGPoint c1 = CGPointMake((p1.x+p2.x)/4 , p1.y-2.5);
    CGPoint c2 = CGPointMake(c1.x*3, c1.y);
    
    [path moveToPoint:p1];
    [path addCurveToPoint:p2 controlPoint1:c1 controlPoint2:c2];
    
    self.layer.shadowPath = path.CGPath;
}

-(void)addGrayGradientShadow
{
    self.layer.shadowOpacity = 0.4;
    
    CGFloat rectWidth = 10.0;
    CGFloat rectHeight = self.frame.size.height;
    
    CGMutablePathRef shadowPath = CGPathCreateMutable();
    CGPathMoveToPoint(shadowPath, NULL, 0.0, 0.0);
    CGPathAddRect(shadowPath, NULL, CGRectMake(0.0-rectWidth, 0.0, rectWidth, rectHeight));
    CGPathAddRect(shadowPath, NULL, CGRectMake(self.frame.size.width, 0.0, rectWidth, rectHeight));
    
    self.layer.shadowPath = shadowPath;
    CGPathRelease(shadowPath);
    
    self.layer.shadowOffset = CGSizeMake(0, 0);
    
    self.layer.shadowRadius = 10.0;
}

-(void)addMovingShadow
{
    static float step = 0.0;
    if (step>20.0) {
        step = 0.0;
    }
    
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 1.5;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint p1 = CGPointMake(0.0, 0.0+self.frame.size.height);
    CGPoint p2 = CGPointMake(0.0+self.frame.size.width, p1.y);
    CGPoint c1 = CGPointMake((p1.x+p2.x)/4 , p1.y+step);
    CGPoint c2 = CGPointMake(c1.x*3, c1.y);
    
    [path moveToPoint:p1];
    [path addCurveToPoint:p2 controlPoint1:c1 controlPoint2:c2];
    
    self.layer.shadowPath = path.CGPath;
    step += 0.1;
    [self performSelector:@selector(addMovingShadow) withObject:nil afterDelay:1.0/30.0];
}

-(void)removeShadow
{
    self.layer.shadowOpacity =0;
    self.layer.shadowRadius = 0;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint p1 = CGPointMake(0.0, 0.0);
    CGPoint p2 = CGPointMake(0.0+self.frame.size.width, p1.y);
    CGPoint c1 = CGPointMake(0 , 0);
    CGPoint c2 = CGPointMake(0, 0);
    
    [path moveToPoint:p1];
    [path addCurveToPoint:p2 controlPoint1:c1 controlPoint2:c2];
    
    self.layer.shadowPath = path.CGPath;
}

//针对给定的坐标系居中
- (void)centerInRect:(CGRect)rect;
{
    //如果参数是小数，则求最大的整数但不大于本身.
    //CGRectGetMidX获取中心点的X轴坐标
    [self setCenter:CGPointMake(floorf(CGRectGetMidX(rect)) + ((int)floorf([self width]) % 2 ? .5 : 0) , floorf(CGRectGetMidY(rect)) + ((int)floorf([self height]) % 2 ? .5 : 0))];
}

//针对给定的坐标系纵向居中
- (void)centerVerticallyInRect:(CGRect)rect;
{
    [self setCenter:CGPointMake([self center].x, floorf(CGRectGetMidY(rect)) + ((int)floorf([self height]) % 2 ? .5 : 0))];
}

//针对给定的坐标系横向居中
- (void)centerHorizontallyInRect:(CGRect)rect;
{
    [self setCenter:CGPointMake(floorf(CGRectGetMidX(rect)) + ((int)floorf([self width]) % 2 ? .5 : 0), [self center].y)];
}

//相对父视图居中
- (void)centerInSuperView;
{
    [self centerInRect:[[self superview] bounds]];
}

- (void)centerVerticallyInSuperView;
{
    [self centerVerticallyInRect:[[self superview] bounds]];
}

- (void)centerHorizontallyInSuperView;
{
    [self centerHorizontallyInRect:[[self superview] bounds]];
}

//同一父视图的兄弟视图水平居中
- (void)centerHorizontallyBelow:(UIView *)view padding:(CGFloat)padding;
{
    // for now, could use screen relative positions.
    NSAssert([self superview] == [view superview], @"views must have the same parent");
    
    [self setCenter:CGPointMake([view center].x,
                                floorf(padding + CGRectGetMaxY([view frame]) + ([self height] / 2)))];
}

- (void)centerHorizontallyBelow:(UIView *)view;
{
    [self centerHorizontallyBelow:view padding:0];
}

- (void)setFrameSize:(CGSize)newSize
{
    CGRect f = self.frame;
    f.size = newSize;
    self.frame = f;
}

- (void)setFrameWidth:(CGFloat)newWidth {
    CGRect f = self.frame;
    f.size.width = newWidth;
    self.frame = f;
}

- (void)setFrameHeight:(CGFloat)newHeight {
    CGRect f = self.frame;
    f.size.height = newHeight;
    self.frame = f;
}

- (void)setFrameOrigin:(CGPoint)newOrigin
{
    CGRect f = self.frame;
    f.origin = newOrigin;
    self.frame = f;
}

- (void)setFrameOriginX:(CGFloat)newX {
    CGRect f = self.frame;
    f.origin.x = newX;
    self.frame = f;
}

- (void)setFrameOriginY:(CGFloat)newY {
    CGRect f = self.frame;
    f.origin.y = newY;
    self.frame = f;
}

- (void)addSizeWidth:(CGFloat)newWidth {
    CGRect f = self.frame;
    f.size.width += newWidth;
    self.frame = f;
}

- (void)addSizeHeight:(CGFloat)newHeight {
    CGRect f = self.frame;
    f.size.height += newHeight;
    self.frame = f;
}

- (void)addOriginX:(CGFloat)newX {
    CGRect f = self.frame;
    f.origin.x += newX;
    self.frame = f;
}

- (void)addOriginY:(CGFloat)newY {
    CGRect f = self.frame;
    f.origin.y += newY;
    self.frame = f;
}


@end

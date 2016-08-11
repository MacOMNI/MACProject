//
//  UIButton+MAC.m
//  MACProject
//
//  Created by MacKun on 16/8/8.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "UIButton+MAC.h"

@implementation UIButton(MAC)

/**
 *  @brief  使用颜色设置按钮背景
 *
 *  @param backgroundColor 背景颜色
 *  @param state           按钮状态
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}
+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title tag:(NSInteger)tag target:(id)target action:(SEL)selector {
    
    UIButton *button          = [[UIButton alloc] initWithFrame:frame];
    button.titleLabel.font    = [UIFont fontWithName:@"Avenir-Book" size:16.f];
    button.layer.borderWidth  = 1.f;
    button.layer.cornerRadius = 3.f;
    button.tag                = tag;
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame
                         buttonType:(EButtonType)type
                              title:(NSString *)title
                                tag:(NSInteger)tag
                             target:(id)target
                             action:(SEL)selector {
    
    UIButton *button          = [[UIButton alloc] initWithFrame:frame];
    button.titleLabel.font    = [UIFont fontWithName:@"Avenir-Book" size:16.f];
    button.layer.borderWidth  = 1.f;
    button.layer.cornerRadius = 3.f;
    button.tag                = tag;
    
    if (type == kButtonNormal) {
        
        button.layer.borderColor = [UIColor blackColor].CGColor;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
    } else if (type == kButtonRed) {
        
        button.layer.borderColor = [UIColor redColor].CGColor;
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
    } else {
        
        button.layer.borderColor = [UIColor blackColor].CGColor;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
    }
    
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)setHighlightedImage:(UIImage *)image {
    
    [self setImage:image forState:UIControlStateHighlighted];
}

- (UIImage *)highlightedImage {
    
    return [self imageForState:UIControlStateHighlighted];
}

- (void)setSelectedImage:(UIImage *)image {
    
    [self setImage:image forState:UIControlStateSelected];
}

- (UIImage *)selectedImage {
    
    return [self imageForState:UIControlStateSelected];
}

- (void)setNormalImage:(UIImage *)image {
    
    [self setImage:image forState:UIControlStateNormal];
}

- (UIImage *)normalImage {
    
    return [self imageForState:UIControlStateNormal];
}


+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

- (void)lf_setEnlargeEdge:(CGFloat) size {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)lf_setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect {
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else {
        return self.bounds;
    }
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? YES : NO;
}

@end

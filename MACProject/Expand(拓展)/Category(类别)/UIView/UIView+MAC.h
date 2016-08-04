//
//  UIView+MAC.h
//  WeiSchoolTeacher
//
//  Created by MacKun on 15/12/11.
//  Copyright © 2015年 MacKun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(MAC)

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property(retain) id cookie;
/**
 *  @brief  找到当前view所在的viewcontroler
 */
@property (readonly) UIViewController *viewController;

/**
 *  底部加阴影
 */
-(void)addShadowonBottom;
/**
 *  加灰色阴影
 */
-(void)addGrayGradientShadow;
/**
 *  顶部加阴影
 */
-(void)addShadowonTop;
/**
 *  移动加阴影
 */
-(void)addMovingShadow;
/**
 *  移除阴影
 */
-(void)removeShadow;


/**
 *  相对Rect居中
 */
- (void)centerInRect:(CGRect)rect;
/**
 *  相对Rect垂直居中
 */
- (void)centerVerticallyInRect:(CGRect)rect;
/**
 *  相对Rect水平居中
 */
- (void)centerHorizontallyInRect:(CGRect)rect;
/**
 *  相对父视图居中
 */
- (void)centerInSuperView;
/**
 *  相对父视图垂直居中
 */
- (void)centerVerticallyInSuperView;
/**
 *  相对父视图水平居中
 */
- (void)centerHorizontallyInSuperView;
/**
 *  同一父视图的兄弟视图水平居中
 */
- (void)centerHorizontallyBelow:(UIView *)view padding:(CGFloat)padding;
/**
 *  同一父视图的兄弟视图水平居中
 */
- (void)centerHorizontallyBelow:(UIView *)view;


/*
 * 设置窗体大小
 */
- (void)setFrameSize:(CGSize)newSize;

/*
 * 设置窗体宽度
 */
- (void)setFrameWidth:(CGFloat)newWidth;

/*
 * 设置窗体高度
 */
- (void)setFrameHeight:(CGFloat)newHeight;

/*
 * 设置窗体起始位置
 */
 - (void)setFrameOrigin:(CGPoint)newOrigin;

/*
 * 设置窗体起始X
 */
- (void)setFrameOriginX:(CGFloat)newX;

/*
 * 设置窗体起始Y
 */
- (void)setFrameOriginY:(CGFloat)newY;

/*
 * 增加窗体宽度
 */
- (void)addSizeWidth:(CGFloat)newWidth;

/*
 * 增加窗体高度
 */
- (void)addSizeHeight:(CGFloat)newHeight;

/*
 * 移动窗体起始X位置
 */
- (void)addOriginX:(CGFloat)newX;

/*
 * 移动窗体起始Y位置
 */
- (void)addOriginY:(CGFloat)newY;




@end

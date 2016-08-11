//
//  UIViewController+MAC.h
//  WeiSchoolTeacher
//
//  Created by MacKun on 15/12/16.
//  Copyright © 2015年 MacKun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMAlertView.h"
#import "MMSheetView.h"

@interface UIViewController(MAC)
#pragma mark 设置 展示AlertView or SheetView
/**
 *  展示Alert提示信息
 */
-(void)showAlertMessage:(NSString*)message;

/**
 *  展示Alert提示信息
 */
-(void)showAlertMessage:(NSString*)message titile:(NSString *)title;
/**
 *  展示Alert提示信息
 *
 *  @param message    提示内容
 *  @param title      提示标题
*   @param clickArr   按钮信息数组
 *  @param clickIndex 点击的下标
 */
-(void)showAlertMessage:(NSString *)message title:(NSString *)title clickArr:(NSArray *)arr click:(MMPopupItemHandler) clickIndex;
/**
 *  展示SheetView提示信息
 *
 *  @param title      提示标题
 *   @param clickArr   按钮信息数组
 *  @param clickIndex 点击的下标
 */
-(void)showSheetTitle:(NSString *)title clickArr:(NSArray *)arr click:(MMPopupItemHandler) clickIndex;
#pragma mark 设置navBar Item
/**
 *  设置左侧文字形式的BarItem
 */
- (void)setLeftBarItemWithString:(NSString*)string;
/**
 *  设置左侧图片形式的BarItem
 */
- (void)setLeftBarItemWithImage:(NSString *)imageName;
/**
 *  设置右侧文字形式的BarItem
 */
- (void)setRightBarItemWithString:(NSString*)string;
/**
 *  设置右侧图片形式的BarItem
 */
- (void)setRightBarItemWithImage:(NSString *)imageName;
/**
 *  设置右侧文字形式的BarItem
 */
- (void)setRightBarItemImage:(UIImage *)imgage title:(NSString *)str;




#pragma mark - 导航栏左右两侧点击事件
/**
 *  已内部实现常规左侧点击返回,如有必要请重写此方法
 */
- (void)leftBarItemAction:(UITapGestureRecognizer *)gesture;
/**
 *  需继承实现右侧点击事件
 */
- (void)rightBarItemAction:(UITapGestureRecognizer *)gesture;

#pragma mark - TabBarItem
/**
 *  设置TabBarItemImage
 *
 *  @param imageName       默认图片名称
 *  @param selectImageName 选中图片名称
 *  @param titleString 标题
 */
-(void)setTabBarItemImage:(NSString *)imageName selectedImage:(NSString *)selectImageName title:(NSString *)titleString;

@end

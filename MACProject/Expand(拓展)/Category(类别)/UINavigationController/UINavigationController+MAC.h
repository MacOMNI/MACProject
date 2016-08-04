//
//  UINavigationController+MAC.h
//  WeiSchoolTeacher
//
//  Created by MacKun on 15/12/18.
//  Copyright © 2015年 MacKun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UINavigationController(MAC)
/**
 *  @brief  寻找Navigation中的某个viewcontroler对象
 *
 *  @param className viewcontroler名称
 *
 *  @return viewcontroler对象
 */
- (id)findViewController:(NSString*)className;
/**
 *  @brief  判断是否只有一个RootViewController
 *
 *  @return 是否只有一个RootViewController
 */
- (BOOL)isOnlyContainRootViewController;
/**
 *  @brief  RootViewController
 *
 *  @return RootViewController
 */
- (UIViewController *)rootViewController;
/**
 *  @brief  返回指定的viewcontroler
 *
 *  @param className 指定viewcontroler类名
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (NSArray *)popToViewControllerWithClassName:(NSString*)className animated:(BOOL)animated;
/**
 *  @brief  pop n层
 *
 *  @param level  n层
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (NSArray *)popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated;
/**
 *  push 一个不包含TabBar的控制器
 *
 *  @param viewController 控制器
 *  @param animated       动画
 */
-(void)pushViewControllerHideTabBar:(UIViewController *)viewController animated:(BOOL)animated;

@end

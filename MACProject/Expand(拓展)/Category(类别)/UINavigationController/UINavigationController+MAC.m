//
//  UINavigationController+MAC.m
//  WeiSchoolTeacher
//
//  Created by MacKun on 15/12/18.
//  Copyright © 2015年 MacKun. All rights reserved.
//

#import "UINavigationController+MAC.h"

@implementation UINavigationController(MAC)

/**
 *  @brief  寻找Navigation中的某个viewcontroler对象
 *
 *  @param className viewcontroler名称
 *
 *  @return viewcontroler对象
 */
- (id)findViewController:(NSString*)className
{
    for (UIViewController *viewController in self.viewControllers) {
        if ([viewController isKindOfClass:NSClassFromString(className)]) {
            return viewController;
        }
    }
    return nil;
}
/**
 *  @brief  判断是否只有一个RootViewController
 *
 *  @return 是否只有一个RootViewController
 */
- (BOOL)isOnlyContainRootViewController
{
    if (self.viewControllers &&
        self.viewControllers.count == 1) {
        return YES;
    }
    return NO;
}
/**
 *  @brief  RootViewController
 *
 *  @return RootViewController
 */
- (UIViewController *)rootViewController
{
    if (self.viewControllers && [self.viewControllers count] >0) {
        return [self.viewControllers firstObject];
    }
    return nil;
}
/**
 *  @brief  返回指定的viewcontroler
 *
 *  @param className 指定viewcontroler类名
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (NSArray *)popToViewControllerWithClassName:(NSString*)className animated:(BOOL)animated;
{
    return [self popToViewController:[self findViewController:className] animated:YES];
}
/**
 *  @brief  pop n层
 *
 *  @param level  n层
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (NSArray *)popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated
{
    NSInteger viewControllersCount = self.viewControllers.count;
    if (viewControllersCount > level) {
        NSInteger idx = viewControllersCount - level - 1;
        UIViewController *viewController = self.viewControllers[idx];
        return [self popToViewController:viewController animated:animated];
    } else {
        return [self popToRootViewControllerAnimated:animated];
    }
}
-(void)pushViewControllerHideTabBar:(UIViewController *)viewController animated:(BOOL)animated{
    viewController.hidesBottomBarWhenPushed=YES;
    [self pushViewController: viewController animated:YES];
}
@end

//
//  UIView+ViewController.h
//  Created by MacKun on 15/4/25.
//  Copyright (c) 2015年 MacKun All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewController)
/**
 *  @brief  找到当前view所在的viewcontroler
 */
@property (readonly) UIViewController *viewController;

@end

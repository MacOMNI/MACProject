//
//  UIView+ViewController.m
//  Created by MacKun on 15/4/25.
//  Copyright (c) 2015年 MacKun All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)
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

@end

//
//  MMAnimationController.h
//  MACProject
//
//  Created by MacKun on 16/9/1.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTweenFunction.h"

@interface MMAnimationController : UIViewController
@property (nonatomic, assign) MMTweenFunctionType functionType;
@property (nonatomic, assign) MMTweenEasingType   easingType;
@end

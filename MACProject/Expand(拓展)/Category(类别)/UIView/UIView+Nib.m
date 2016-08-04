//
//  UIView+Nib.m
//  Created by MacKun on 15/4/25.
//  Copyright (c) 2015年 MacKun All rights reserved.
//

#import "UIView+Nib.h"

@implementation UIView (Nib)
#pragma mark - Nibs

+ (UINib *)loadNib
{
    return [self loadNibNamed:NSStringFromClass([self class])];
}

+ (instancetype)loadNibView{
       return  [[[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil]instantiateWithOwner:nil options:nil] objectAtIndex:0];
}

+ (UINib *)loadNibNamed:(NSString*)nibName
{
    return [self loadNibNamed:nibName bundle:[NSBundle mainBundle]];
}
+ (UINib *)loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle
{
    return [UINib nibWithNibName:nibName bundle:bundle];
}
+ (instancetype)loadInstanceFromNib
{
    return [self loadInstanceFromNibWithName:NSStringFromClass([self class])];
}
+ (instancetype)loadInstanceFromNibWithName:(NSString *)nibName
{
    return [self loadInstanceFromNibWithName:nibName owner:nil];
}
+ (instancetype)loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner
{
    return [self loadInstanceFromNibWithName:nibName owner:owner bundle:[NSBundle mainBundle]];
}
+ (instancetype)loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle
{
    UIView *result = nil;
    NSArray* elements = [bundle loadNibNamed:nibName owner:owner options:nil];
    for (id object in elements)
    {
        if ([object isKindOfClass:[self class]])
        {
            result = object;
            break;
        }
    }
    return result;
}

@end

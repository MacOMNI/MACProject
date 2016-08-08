//
//  UIFont+Fonts.m
//  MACProject
//
//  modify by MacKun on 15/9/10.
//  Copyright (c) 2015年 MacKun. All rights reserved.

#import "UIFont+Fonts.h"

@implementation UIFont (Fonts)

#pragma mark - Added font.

+ (UIFont *)HYQiHeiWithFontSize:(CGFloat)size {

    return [UIFont fontWithName:@"HYQiHei-BEJF" size:size];
}

#pragma mark - System font.

+ (UIFont *)AppleSDGothicNeoThinWithFontSize:(CGFloat)size {

    return [UIFont fontWithName:@"AppleSDGothicNeo-Thin" size:size];
}

+ (UIFont *)AvenirWithFontSize:(CGFloat)size {

    return [UIFont fontWithName:@"Avenir" size:size];
}

+ (UIFont *)AvenirLightWithFontSize:(CGFloat)size {

    return [UIFont fontWithName:@"Avenir-Light" size:size];
}

+ (UIFont *)HeitiSCWithFontSize:(CGFloat)size {

    return [UIFont fontWithName:@"Heiti SC" size:size];
}

+ (UIFont *)HelveticaNeueFontSize:(CGFloat)size {

    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

+ (UIFont *)HelveticaNeueBoldFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
}

@end

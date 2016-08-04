//
//  NSString+HLHanZiToPinYin.m
//  HLHanZiToPinYinDemo
//
//  Created by lhl on 15/4/20.
//  Copyright (c) 2015年 LHL. All rights reserved.
//

#import "NSString+HLHanZiToPinYin.h"

@implementation NSString (HLHanZiToPinYin)

- (NSString*)pinYin
{
    //方式一
    //先转换为带声调的拼音
    NSMutableString*str = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)str,NULL,kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL,kCFStringTransformStripDiacritics,NO);
    return str;
}


//补充:
//获取拼音首字母
- (NSString*)firstCharactor
{
    //1.先传化为拼音
    NSString*pinYin = [self.pinYin uppercaseString];
    //2.获取首字母
    if (!pinYin||[pinYin isBlank]) {
        return @"#";
    }
    return[pinYin substringToIndex:1];
}

- (NSString*)firstPingYin
{
    //1.先传化为拼音
    NSString*pinYin = [self.pinYin uppercaseString];
    //2.获取首字母
    if (!pinYin||[pinYin isBlank]) {
        return @"#";
    }
    pinYin=[pinYin substringToIndex:1];
    if ([pinYin compare:@"A"]==NSOrderedAscending||[pinYin compare:@"Z"]==NSOrderedDescending) {
        pinYin = @"#";
    }
    return pinYin;

}


@end

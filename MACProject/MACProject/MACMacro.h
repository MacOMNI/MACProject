//
//  MACMacro.h
//
//  Created by MacKun on 15/9/22.
//  Copyright © 2015年 MacKun. All rights reserved.
//

#ifndef MACMacro_h
#define MACMacro_h

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif


#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;
//-------------------系统----------------
#pragma mark - 系统
//当前系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//版本判断语句,是否是version以后的
#define IOS(version) (([[[UIDevice currentDevice] systemVersion] intValue] >= version)?1:0)

//获取当前语言
#define CurrentLanguage [[NSLocale preferredLanguages]objectAtIndex:0]

//检查系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
//-------------------系统----------------

//-------------------设备相关----------------
#pragma mark - 设备相关
//判断是什么大小的机型 4，4s ; 5,5s ; 6,6s ; 6+,6+s
#define iphone4s CGSizeEqualToSize(CGSizeMake(640,960), [[UIScreen mainScreen]currentMode].size)
#define iphone5 CGSizeEqualToSize(CGSizeMake(640,1136), [[UIScreen mainScreen]currentMode].size)
#define iphone6 CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen]currentMode].size)
#define iphone6Plus CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen]currentMode].size)

//获取屏幕宽度、高度

#define appWidth [UIScreen mainScreen].bounds.size.width
#define appHeight [UIScreen mainScreen].bounds.size.height

//获取状态栏和导航栏高度

#define appStatusBarHeight  [UIApplication sharedApplication].statusBarFrame.size.height

#define appNavigationBarHeight  self.navigationController.navigationBar.frame.size.height

//-------------------设备相关----------------

//-----------------警告处理----------------
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)
//-----------------警告处理----------------

#endif /* MACMacro_h */


//
//  AppDelegate.h
//  MACProject
//
//  Created by MacKun on 15/9/10.
//  Copyright (c) 2015年 MacKun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AddressBook/ABAddressBook.h"
#import "EventKit/EventKit.h"
#import "AVFoundation/AVFoundation.h"
#import "AssetsLibrary/AssetsLibrary.h"

typedef void(^grantBlock)(BOOL granted);

@interface UIApplication (AppInfo)


@property (strong, nonatomic) UIWindow *window;


///-------------------------------------
/// @name  app基本信息
///-------------------------------------

/**
 当前app名称
 */
- (NSString *)appName;

/*
 当前app版本号
 */
- (NSString *)appVersion;

/**
 build 版本号
 */
- (NSString *)appBuild;

/**
  apps 证书编号 (例如MacKun.az.com)
 */
- (NSString *)appBundleID;

///--------------------------------------------------------------
/// @name  沙盒缓存大小
///--------------------------------------------------------------

/**
 *  沙盒的路径
 */
- (NSString *)documentsDirectoryPath;
/**
  沙盒的内容大小 (例如5 MB)
 */
- (NSString *)documentsFolderSizeAsString;

/**
  沙盒内的字节大小
 */
- (int)documentsFolderSizeInBytes;
/**
 *  程序的大小 包括文件 缓冲 以及 下载
 *
 *  @return  所有文件大小
 */
- (NSString *)applicationSize;


/////---------------------------------------------------------------
///// @name  app 隐私权限
/////---------------------------------------------------------------

/**
  定位权限是否开启
 */
- (BOOL)applicationHasAccessToLocationData;

/**
  通讯录访问权限是否开启
 */
- (BOOL)applicationhasAccessToAddressBook;

/**
  相机权限是否开启
 */
- (BOOL)applicationHasAccessToCalendar;

/**
  推送功能是否开启
 */
- (BOOL)applicationHasAccessToReminders;

/**
 相册权限是否开启
 */
- (BOOL)applicationHasAccessToPhotosLibrary;

/**
 *  麦克风开启
 *
 *  @warning
 */
- (void)applicationHasAccessToMicrophone:(grantBlock)flag;

///-------------------------------------
/// @name  app 相关事件
///-------------------------------------

/**
 *  注册推送(兼容iOS8)
 */
-(void)registerNotifications;
///**
// *  获取当前视图
// *
// */
-(UIViewController*)getCurrentViewConttoller;


@end

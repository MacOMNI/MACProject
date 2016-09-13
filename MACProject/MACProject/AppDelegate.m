//
//  AppDelegate.m
//  MACProject
//
//  Created by MacKun on 16/7/28.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    MainTabBarController *nav = [[MainTabBarController alloc]init];
    self.window.rootViewController = nav;
    self.window.backgroundColor    = [UIColor whiteColor];
    [self appConfig];
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)appConfig{
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithWhite:0.0f alpha:1.0f];
    shadow.shadowOffset = CGSizeMake(0, 0);
    [[UIApplication sharedApplication]registerNotifications];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           NSShadowAttributeName: shadow,
                                                           NSFontAttributeName: [UIFont fontWithName:@"Arial-BoldMT" size:17.0f]
                                                           }];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor appNavigationBarColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}


- (void)statusBarOrientationChange:(NSNotification *)notification
{
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

    if (orientation == UIInterfaceOrientationLandscapeRight) // home键靠右
    {
        //
    }
    
    if (
        orientation ==UIInterfaceOrientationLandscapeLeft) // home键靠左
    {
        //
    }
    
    if (orientation == UIInterfaceOrientationPortrait)
    {
        //
    }
    
    if (orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        //
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

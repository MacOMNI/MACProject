//
//  MainTabBarController.m
//  MACProject
//
//  Created by MacKun on 16/8/11.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "MainTabBarController.h"
#import "UIImage+Additions.h"
#import "FindViewController.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI{
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor appTextColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor appRedColor]} forState:UIControlStateHighlighted];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor appRedColor]} forState:UIControlStateSelected];
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor appNavigationBarColor]]];

    NSArray *titleArr = @[@"闲鱼",@"朋友圈",@"云周边",@"发现"];
    NSArray *iconArr = @[@"chaweizhang_gray",@"cheyouquan_gray",@"chazhoubian_gray",@"faxian_gray"];
    NSArray *selectIconArr = @[@"chaweizhang_red",@"cheyouquan_red",@"chazhoubian_red",@"faxian_red"];
    NSArray *controllerArr = @[@"HomeViewController",@"FriendsViewController",@"NearViewController",@"FindViewController"];
    for(NSInteger i = 0;i < controllerArr.count;i++)
    {

      
            UIViewController *viewController = [[NSClassFromString(controllerArr[i]) alloc]init];

            [viewController setTabBarItemImage:iconArr[i] selectedImage:selectIconArr[i] title:titleArr[i]];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
            [self addChildViewController:nav];
       
    }
    self.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"bottom_bg"];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end

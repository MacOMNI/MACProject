//
//  ParallaxHeaderViewCell.m
//  MACProject
//
//  Created by MacKun on 16/8/12.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "ParallaxHeaderViewCell.h"
#import "UIButton+LXMImagePosition.h"
#import "CitysViewController.h"
@implementation ParallaxHeaderViewCell
- (IBAction)cityAction:(id)sender {
    DLog(@"点击城市选择！");
    
    CitysViewController *citysVC = [[CitysViewController alloc]init];
    [_btnCity.viewController.navigationController pushViewControllerHideTabBar:citysVC animated:YES];
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];

    [_btnCity setImagePosition:LXMImagePositionRight spacing:5.0f];
}

@end

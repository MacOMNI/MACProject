//
//  ParallaxHeaderViewCell.m
//  MACProject
//
//  Created by MacKun on 16/8/12.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "ParallaxHeaderViewCell.h"
#import "UIButton+LXMImagePosition.h"
@implementation ParallaxHeaderViewCell
- (IBAction)cityAction:(id)sender {
    DLog(@"点击城市选择！");
}

- (void)awakeFromNib {
    // Initialization code
    [_btnCity setImagePosition:LXMImagePositionRight spacing:5.0f];
}

@end

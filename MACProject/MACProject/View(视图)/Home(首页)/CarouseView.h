//
//  CarouseView.h
//  MACProject
//
//  Created by MacKun on 16/8/15.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarouseView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property(nonatomic ,strong)NSArray *imgNameArr;
-(void)randomCoreAnimation;
@end

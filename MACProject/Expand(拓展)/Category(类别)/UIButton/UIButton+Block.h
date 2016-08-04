//
//  UIButton+Block.h
//
//
//  Created by MacKun on 14/12/15.
//  Copyright (c) 2014年 MacKun All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TouchedBlock)(NSInteger tag);

@interface UIButton (Block)
-(void)addActionHandler:(TouchedBlock)touchHandler;
@end

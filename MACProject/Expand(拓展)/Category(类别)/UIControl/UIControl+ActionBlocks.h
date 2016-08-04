//
//  UIControl+ActionBlocks.h
//
//  Created by MacKun on 14/12/15.
//  Copyright (c) 2014年 MacKun All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^UIControlActionBlock)(id weakSender);


@interface UIControlActionBlockWrapper : NSObject
@property (nonatomic, copy) UIControlActionBlock actionBlock;
@property (nonatomic, assign) UIControlEvents controlEvents;
- (void)invokeBlock:(id)sender;
@end



@interface UIControl (ActionBlocks)
- (void)handleControlEvents:(UIControlEvents)controlEvents withBlock:(UIControlActionBlock)actionBlock;
- (void)removeActionBlocksForControlEvents:(UIControlEvents)controlEvents;
@end

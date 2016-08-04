//
//  UIControl+ActionBlocks.m
//
//  Created by MacKun on 14/12/15.
//  Copyright (c) 2014年 MacKun All rights reserved.
//

#import "UIControl+ActionBlocks.h"
#import <objc/runtime.h>

static const void *UIControlActionBlockArray = &UIControlActionBlockArray;

@implementation UIControlActionBlockWrapper

- (void)invokeBlock:(id)sender {
    if (self.actionBlock) {
        self.actionBlock(sender);
    }
}
@end


@implementation UIControl (ActionBlocks)
-(void)handleControlEvents:(UIControlEvents)controlEvents withBlock:(UIControlActionBlock)actionBlock {
    NSMutableArray *actionBlocksArray = [self actionBlocksArray];
    
    UIControlActionBlockWrapper *blockActionWrapper = [[UIControlActionBlockWrapper alloc] init];
    blockActionWrapper.actionBlock = actionBlock;
    blockActionWrapper.controlEvents = controlEvents;
    [actionBlocksArray addObject:blockActionWrapper];
    
    [self addTarget:blockActionWrapper action:@selector(invokeBlock:) forControlEvents:controlEvents];
}


- (void)removeActionBlocksForControlEvents:(UIControlEvents)controlEvents {
    NSMutableArray *actionBlocksArray = [self actionBlocksArray];
    NSMutableArray *wrappersToRemove = [NSMutableArray arrayWithCapacity:[actionBlocksArray count]];
    
    [actionBlocksArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIControlActionBlockWrapper *wrapperTmp = obj;
        if (wrapperTmp.controlEvents == controlEvents) {
            [wrappersToRemove addObject:wrapperTmp];
            [self removeTarget:wrapperTmp action:@selector(invokeBlock:) forControlEvents:controlEvents];
        }
    }];
    
    [actionBlocksArray removeObjectsInArray:wrappersToRemove];
}


- (NSMutableArray *)actionBlocksArray {
    NSMutableArray *actionBlocksArray = objc_getAssociatedObject(self, UIControlActionBlockArray);
    if (!actionBlocksArray) {
        actionBlocksArray = [NSMutableArray array];
        objc_setAssociatedObject(self, UIControlActionBlockArray, actionBlocksArray, OBJC_ASSOCIATION_RETAIN);
    }
    return actionBlocksArray;
}
@end

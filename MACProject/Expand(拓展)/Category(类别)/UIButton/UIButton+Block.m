//
//  UIButton+Block.m
//
//  Created by MacKun on 14/12/15.
//  Copyright (c) 2014年 MacKun All rights reserved.
//

#import "UIButton+Block.h"
#import <objc/runtime.h>
static const void *UIButtonBlockKey = &UIButtonBlockKey;

@implementation UIButton (Block)
-(void)addActionHandler:(TouchedBlock)touchHandler{
    objc_setAssociatedObject(self, UIButtonBlockKey, touchHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(actionTouched:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)actionTouched:(UIButton *)btn{
    TouchedBlock block = objc_getAssociatedObject(self, UIButtonBlockKey);
    if (block) {
        block(btn.tag);
    }
}
@end


//
//  CopyLabel.m
//
//  Copyright © 2016年 solloun. All rights reserved.
//

#import "CopyLabel.h"

@implementation CopyLabel


//为了能接收到事件（能成为第一响应者），我们需要覆盖一个方法：

-(BOOL)canBecomeFirstResponder

{
    
    return YES;
    
}

//还需要针对复制的操作覆盖两个方法：

// 可以响应的方法

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender

{
    
    return (action == @selector(copy:));
    
}

//针对于响应方法的实现

-(void)copy:(id)sender

{
    
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    
    pboard.string = self.text;
    
}

//有了以上三个方法，我们就能处理copy了，当然，在能接收到事件的情况下：



//UILabel默认是不接收事件的，我们需要自己添加touch事件

-(void)attachTapHandler

{
    
    self.userInteractionEnabled = YES;  //用户交互的总开关
    
    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    touch.numberOfTapsRequired = 1;
    
    [self addGestureRecognizer:touch];
   
    
    
}

//绑定事件

- (id)initWithFrame:(CGRect)frame

{
    
    self = [super initWithFrame:frame];
    
    if (self)
        
    {
        
        [self attachTapHandler];
        
    }
    
    return self;
    
}

//同上

-(void)awakeFromNib

{
    
    [super awakeFromNib];
    
    [self attachTapHandler];
    
}

//我们已经可以接收到事件了！由于我在上方将tap数设为2，所以需要双击才能捕获，

//接下来，我们需要处理这个tap，以便让菜单栏弹出来：

-(void)handleTap:(UIGestureRecognizer*) recognizer

{
    
    [self becomeFirstResponder];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:self.frame inView:self.superview];
    [menu setMenuVisible:YES animated:YES];
    
}
@end

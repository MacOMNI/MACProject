/*
 * MGSwipeTableCell is licensed under MIT license. See LICENSE.md file for more information.
 * Copyright (c) 2014 Imanol Fernandez @MortimerGoro
 */

#import "MGSwipeButton.h"

@class MGSwipeTableCell;

@implementation MGSwipeButton

+(instancetype) buttonWithTitle:(NSString *) title backgroundColor:(UIColor *) color
{
    return [self buttonWithTitle:title icon:nil backgroundColor:color];
}

+(instancetype) buttonWithTitle:(NSString *) title backgroundColor:(UIColor *) color padding:(NSInteger) padding
{
    return [self buttonWithTitle:title icon:nil backgroundColor:color insets:UIEdgeInsetsMake(0, padding, 0, padding)];
}

+(instancetype) buttonWithTitle:(NSString *) title backgroundColor:(UIColor *) color insets:(UIEdgeInsets) insets
{
    return [self buttonWithTitle:title icon:nil backgroundColor:color insets:insets];
}

+(instancetype) buttonWithTitle:(NSString *) title backgroundColor:(UIColor *) color callback:(MGSwipeButtonCallback) callback
{
    return [self buttonWithTitle:title icon:nil backgroundColor:color callback:callback];
}

+(instancetype) buttonWithTitle:(NSString *) title backgroundColor:(UIColor *) color padding:(NSInteger) padding callback:(MGSwipeButtonCallback) callback
{
    return [self buttonWithTitle:title icon:nil backgroundColor:color insets:UIEdgeInsetsMake(0, padding, 0, padding) callback:callback];
}

+(instancetype) buttonWithTitle:(NSString *) title backgroundColor:(UIColor *) color insets:(UIEdgeInsets) insets callback:(MGSwipeButtonCallback) callback
{
    return [self buttonWithTitle:title icon:nil backgroundColor:color insets:insets callback:callback];
}

+(instancetype) buttonWithTitle:(NSString *) title icon:(UIImage*) icon backgroundColor:(UIColor *) color
{
    return [self buttonWithTitle:title icon:icon backgroundColor:color callback:nil];
}

+(instancetype) buttonWithTitle:(NSString *) title icon:(UIImage*) icon backgroundColor:(UIColor *) color padding:(NSInteger) padding
{
    return [self buttonWithTitle:title icon:icon backgroundColor:color insets:UIEdgeInsetsMake(0, padding, 0, padding) callback:nil];
}

+(instancetype) buttonWithTitle:(NSString *) title icon:(UIImage*) icon backgroundColor:(UIColor *) color insets:(UIEdgeInsets) insets
{
    return [self buttonWithTitle:title icon:icon backgroundColor:color insets:insets callback:nil];
}

+(instancetype) buttonWithTitle:(NSString *) title icon:(UIImage*) icon backgroundColor:(UIColor *) color callback:(MGSwipeButtonCallback) callback
{
    return [self buttonWithTitle:title icon:icon backgroundColor:color padding:10 callback:callback];
}

+(instancetype) buttonWithTitle:(NSString *) title icon:(UIImage*) icon backgroundColor:(UIColor *) color padding:(NSInteger) padding callback:(MGSwipeButtonCallback) callback
{
    return [self buttonWithTitle:title icon:icon backgroundColor:color insets:UIEdgeInsetsMake(0, padding, 0, padding) callback:callback];
}

+(instancetype) buttonWithTitle:(NSString *) title icon:(UIImage*) icon backgroundColor:(UIColor *) color insets:(UIEdgeInsets) insets callback:(MGSwipeButtonCallback) callback
{
    MGSwipeButton * button = [self buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = color;
    button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:icon forState:UIControlStateNormal];
    button.callback = callback;
    [button setEdgeInsets:insets];
    return button;
}

-(BOOL) callMGSwipeConvenienceCallback: (MGSwipeTableCell *) sender
{
    if (_callback) {
        return _callback(sender);
    }
    return NO;
}

-(void) centerIconOverText {
	const CGFloat spacing = 3.0;
	CGSize size = self.imageView.image.size;
	self.titleEdgeInsets = UIEdgeInsetsMake(0.0,
											-size.width,
											-(size.height + spacing),
											0.0);
	size = [self.titleLabel.text sizeWithAttributes:@{ NSFontAttributeName: self.titleLabel.font }];
	self.imageEdgeInsets = UIEdgeInsetsMake(-(size.height + spacing),
											0.0,
											0.0,
											-size.width);
}

-(void) setPadding:(CGFloat) padding
{
    self.contentEdgeInsets = UIEdgeInsetsMake(0, padding, 0, padding);
    [self sizeToFit];
}

- (void)setButtonWidth:(CGFloat)buttonWidth
{
    _buttonWidth = buttonWidth;
    if (_buttonWidth > 0)
    {
        CGRect frame = self.frame;
        frame.size.width = _buttonWidth;
        self.frame = frame;
    }
    else
    {
        [self sizeToFit];
    }
}

-(void) setEdgeInsets:(UIEdgeInsets)insets
{
    self.contentEdgeInsets = insets;
    [self sizeToFit];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    // Center image
   // [self setWidth:self.frame.size.width+20];
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.imageView.frame.size.height/2+10;
    self.imageView.center = center;
    if (!self.imageView.image) {
        //self.titleLabel.frame=self.frame;
    }
    else {
    //Center text
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = self.imageView.frame.size.height + 5;
    newFrame.size.width = self.frame.size.width;
    self.titleLabel.frame = newFrame;
    }
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end

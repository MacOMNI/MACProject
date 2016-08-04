//
//  MACLabel.m
//  WeiSchoolTeacher
//
//  Created by MacKun on 16/1/15.
//  Copyright © 2016年 MacKun. All rights reserved.
//

#import "MACLabel.h"

@implementation MACLabel
-(void)setLabelText:(NSString *)labelText{
  NSMutableAttributedString *str=[[NSMutableAttributedString alloc] initWithString:labelText attributes:nil];
     [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor]  range:NSMakeRange(0, 5)];
    self.attributedText=str;
}
-(void)setRichTextFont:(UIFont*)font color:(UIColor *)textColor atRange:(NSRange)range NS_AVAILABLE_IOS(6_0){
    NSMutableAttributedString *str=(NSMutableAttributedString*)self.attributedText;
    if(!font){
        [str setAttributes:@{NSFontAttributeName:font} range:range];
    }
    if(!textColor){
         [str setAttributes:@{NSForegroundColorAttributeName:textColor} range:range];
    }
    self.attributedText=str;
}
-(void)addLineAtRange:(NSRange)range NS_AVAILABLE_IOS(6_0){
    NSMutableAttributedString *str=(NSMutableAttributedString*)self.attributedText;
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
     self.attributedText=str;
}


- (UIImage *)grabImage {
    // Create a "canvas" (image context) to draw in.
    UIGraphicsBeginImageContext([self bounds].size);
    
    // Make the CALayer to draw in our "canvas".
    [[self layer] renderInContext: UIGraphicsGetCurrentContext()];
    
    // Fetch an UIImage of our "canvas".
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Stop the "canvas" from accepting any input.
    UIGraphicsEndImageContext();
    
    // Return the image.
    return image;
}

@end

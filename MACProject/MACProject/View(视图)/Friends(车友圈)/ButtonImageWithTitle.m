//
//  ButtonImageWithTitle.m
//  WeiSchoolTeacher
//
//  Created by MacKun on 16/1/13.
//  Copyright © 2016年 MacKun. All rights reserved.
//

#import "ButtonImageWithTitle.h"

@implementation ButtonImageWithTitle
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        CGSize imageSize = self.imageView.frame.size;
        CGSize titleSize = self.titleLabel.frame.size;
      //  DLog(@"height %f",self.height);
        // get the height they will take up as a unit
        CGFloat totalHeight = (imageSize.height + titleSize.height + 3);
        
        // raise the image and push it right to center it
        self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
        
        // lower the text and push it left to center it
        self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height),0.0);

    }
    return self;
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    //DLog(@"height %f",self.height);
    // get the height they will take up as a unit
    CGFloat totalHeight = (imageSize.height + titleSize.height );
    
    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    
    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(10.0,- imageSize.width, - (totalHeight - titleSize.height),0.0);
}


@end

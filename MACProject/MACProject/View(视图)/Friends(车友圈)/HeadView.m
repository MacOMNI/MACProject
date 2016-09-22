//
//  HeadView.m
//  WeiSchoolTeacher
//
//  Created by MacKun on 16/1/12.
//  Copyright © 2016年 MacKun. All rights reserved.
//

#import "HeadView.h"

@interface HeadView()
{
    UIButton *bgButton;
}

@end

@implementation HeadView
+ (instancetype)headViewWithTableView:(UITableView *)tableView
{
    static NSString *headIdentifier = @"header";
    
    HeadView *headView = (HeadView *)[tableView dequeueReusableCellWithIdentifier:headIdentifier];
    
    if (headView == nil) {
        headView = [[HeadView alloc] initWithReuseIdentifier:headIdentifier];
    }
    
    return headView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        bgButton                         = [UIButton buttonWithType:UIButtonTypeCustom];
        // [bgButton setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        // [bgButton setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        [bgButton setImage:[UIImage imageNamed:@"contacts_rocket"] forState:UIControlStateNormal];
        [bgButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bgButton.imageView.contentMode      = UIViewContentModeCenter;
        bgButton.imageView.clipsToBounds    = NO;
        bgButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        bgButton.contentEdgeInsets          = UIEdgeInsetsMake(0, 10, 0, 0);
        bgButton.titleEdgeInsets            = UIEdgeInsetsMake(0, 10, 0, 0);
        [bgButton addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgButton];
    }
    return self;
}
- (void)headBtnClick
{
    self.opened=!self.isExend;
    bgButton.imageView.transform = self.isExend ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformMakeRotation(0);
    if (_headViewDelegate &&[_headViewDelegate respondsToSelector:@selector(clickHeadView:)]) {
        [_headViewDelegate clickHeadView:self.section];
    }
}
#pragma mark datasource methods

-(void)setName:(NSString *)name
{
    _name = name;
    [bgButton setTitle:name forState:UIControlStateNormal];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    bgButton.frame = self.bounds;
   // _numLabel.frame = CGRectMake(self.frame.size.width - 70, 0, 60, self.frame.size.height);
}

@end

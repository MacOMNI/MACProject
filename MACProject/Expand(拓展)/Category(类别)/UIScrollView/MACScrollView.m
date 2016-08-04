//
//  MACScrollView.m
//  WeSchoolTeacher
//
//  Created by MacKun on 16/3/28.
//  Copyright © 2016年 com.soullon.WeSchoolTeacher. All rights reserved.
//

#import "MACScrollView.h"

@implementation MACScrollView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        [self initUI];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    //self.firstShowEmpty=YES;
    self.emptyDataSetDelegate=self;
    self.emptyDataSetSource=self;
    self.titleForEmpty= @"您的请求数据为空";
    self.descriptionForEmpty=@"亲，咋没有数据呢，刷新试试~~";
    self.imageNameForEmpty=@"placehoder_none";
}
-(void)setIsShowEmpty:(BOOL)isShowEmpty{
    _isShowEmpty=isShowEmpty;
    //先移除后添加      removeFromSuperview 方法：把当前view从它的父view和窗口中移除，同时也把它从响应事件操作的响应者链中移除。
    [[self subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (isShowEmpty) {
        [self reloadEmptyDataSet];
    }
    
}

#pragma mark - DZNEmptyDataSetSource Methods
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text =self.titleForEmpty;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = self.descriptionForEmpty;
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (!self.imageNameForEmpty||[self.imageNameForEmpty isBlank]) {
        return nil;
    }
    return [UIImage imageNamed:self.imageNameForEmpty];
}
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -20.0f;
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 0.0f;
}
#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
//    if (self.firstShowEmpty) {
//        self.firstShowEmpty=NO;
//        return NO;
//    }
    if (self.isShowEmpty) {
        return YES;
    }
    return NO;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

@end

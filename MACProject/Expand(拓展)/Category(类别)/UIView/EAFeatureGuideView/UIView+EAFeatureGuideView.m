//
//  UIView+EAFeatureGuideView.m
//  EAFeatureGuide
//
//  Created by zhiyun.huang on 4/27/16.
//  Copyright © 2016 EAH. All rights reserved.
//

#import "UIView+EAFeatureGuideView.h"

typedef NS_ENUM(NSUInteger, EAFeatureItemLocation) {
    EAFeatureItemLocationDefault = 0,
    EAFeatureItemLocationUp = 1 << 1,
    EAFeatureItemLocationLeft = 1 << 2,
    EAFeatureItemLocationDown = 1 << 3,
    EAFeatureItemLocationRight = 1 << 4
};

@import ObjectiveC.runtime;

@implementation UIView (EAFeatureGuideView)

- (void)showWithFeatureItems:(NSArray<EAFeatureItem *> *)featureItems saveKeyName:(NSString *)keyName inVersion:(NSString *)version
{
    if([UIView hasShowFeatureGuideWithKey:keyName version:version])
        return;
    //
    [self dismissFeatureGuideView];
    
    [self setKeyName:[NSString stringWithFormat:@"%@%@",keyName,version]];
    
    [self layoutSubviewsWithFeatureItems:featureItems];
    
}

- (void)layoutSubviewsWithFeatureItems:(NSArray<EAFeatureItem *> *)featureItems
{
    if(featureItems.count <= 0)
        return;
    
    UIView *containerView = [[UIView alloc] initWithFrame:self.bounds];
    containerView.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedEvent:)];
    [containerView addGestureRecognizer:tap];
    
    
    [self setContainerView:containerView];
    
    [self addSubview :containerView];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0,0,self.bounds.size.width, self.bounds.size.height)cornerRadius:0];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.path = path.CGPath;
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    shapeLayer.fillColor = [UIColor blackColor].CGColor;
    shapeLayer.opacity =0.8;
    
    [containerView.layer addSublayer:shapeLayer];
    
    
    NSMutableDictionary *actionDict = [NSMutableDictionary dictionary];
    [self setButtonActionsDictionary:actionDict];
    
    [featureItems enumerateObjectsUsingBlock:^(EAFeatureItem * featureItem, NSUInteger idx, BOOL * _Nonnull stop) {
        
        actionDict[@(idx)] = [featureItem.action copy];
        
        [self layoutWithFeatureItem:featureItem];
        
    }];
    
}

/**
 *  计算EAFeatureItem所处的位置
 *
 *  @param featureItem featureItem
 *
 *  @return return EAFeatureItemLocation
 */
- (EAFeatureItemLocation)getLocationForFeatureItem:(EAFeatureItem *)featureItem
{
    
    EAFeatureItemLocation location = EAFeatureItemLocationDefault;
    
    
    CGRect frame = featureItem.focusView ? [featureItem.focusView convertRect:featureItem.focusView.bounds toView:[self getContainerView]] : featureItem.focusRect;
    
    const NSInteger split = 16;
    
    //将展示区域分割成16*16的区域
    CGFloat squareWidth = self.bounds.size.width / split;
    CGFloat squareHeight = self.bounds.size.height / split;
    
    CGFloat leftSpace = frame.origin.x;
    CGFloat rightSpace = self.bounds.size.width - (frame.origin.x + frame.size.width);
    CGFloat topSpace = frame.origin.y;
    CGFloat bottomSpace = self.bounds.size.height - (frame.origin.y + frame.size.height);
    
    //如果focusView的x轴上的宽占据了绝大部分则认为是横向居中的
    if(frame.size.width <= squareWidth * (split - 1))
    {
        //左边
        if((leftSpace - rightSpace) >= squareWidth)
        {
            location |= EAFeatureItemLocationRight;
        }
        //右边
        else if((rightSpace - leftSpace) >= squareWidth)
        {
            location |= EAFeatureItemLocationLeft;
        }
    }
    
    //上边
    if((topSpace - bottomSpace) > squareHeight)
    {
        location |= EAFeatureItemLocationDown;
    }
    //下边
    else if((bottomSpace - topSpace) > squareHeight)
    {
        location |= EAFeatureItemLocationUp;
    }
    else if(featureItem.introduceAlignmentPriority == EAFeatureItemAlignmentBottomFirst)
    {
        location |= EAFeatureItemLocationUp;
    }
    else
    {
        location |= EAFeatureItemLocationDown;
    }
    
    return location;
    
}

- (void)layoutWithFeatureItem:(EAFeatureItem *)featureItem
{
    UIView *containerView = [self getContainerView];
    UIImageView *indicatorImageView = nil;
    UIView *introduceView = nil;
    UIButton *button = nil;
    
    //绘制镂空的区域
    CGRect featureItemFrame = featureItem.focusView ? [featureItem.focusView convertRect:featureItem.focusView.bounds toView:[self getContainerView]] : featureItem.focusRect;
    
    CAShapeLayer *shapeLayer = (CAShapeLayer *)[containerView.layer.sublayers firstObject];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithCGPath:shapeLayer.path];
    
    featureItemFrame.origin.x += featureItem.focusInsets.left;
    featureItemFrame.origin.y += featureItem.focusInsets.top;
    featureItemFrame.size.width += featureItem.focusInsets.right - featureItem.focusInsets.left;
    featureItemFrame.size.height += featureItem.focusInsets.bottom - featureItem.focusInsets.top;
    
    [bezierPath appendPath:[UIBezierPath bezierPathWithRoundedRect:featureItemFrame cornerRadius:featureItem.focusCornerRadius]];
    
    shapeLayer.path = bezierPath.CGPath;
    
    //添加箭头
    if(featureItem.action || featureItem.introduce)
    {
        NSString *imageName = featureItem.indicatorImageName ?: @"icon_ea_indicator";
        
        UIImage *indicatorImage = [UIImage imageNamed:imageName];
        
        
        CGSize imageSize = CGSizeMake(indicatorImage.size.width, indicatorImage.size.height);
        
        indicatorImageView = [[UIImageView alloc] initWithImage:indicatorImage];
        indicatorImageView.clipsToBounds = YES;
        indicatorImageView.contentMode = UIViewContentModeScaleAspectFit;
        indicatorImageView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        [containerView addSubview :indicatorImageView];
        
        
        //布局介绍文案
        if(featureItem.introduce)
        {
            NSString *typeString = [[[featureItem.introduce componentsSeparatedByString:@"."] lastObject] lowercaseString];
            
            if([typeString isEqualToString:@"png"] || [typeString isEqualToString:@"jpg"] || [typeString isEqualToString:@"jpeg"])
            {
                UIImage *introduceImage = [UIImage imageNamed:featureItem.introduce];
                
                imageSize = CGSizeMake(introduceImage.size.width, introduceImage.size.height);
                
                UIImageView *imageView = [[UIImageView alloc] initWithImage:introduceImage];
                
                imageView.clipsToBounds = YES;
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
                
                introduceView = imageView;
            }
            else
            {
                UILabel *introduceLabel = [[UILabel alloc] init];
                introduceLabel.backgroundColor = [UIColor clearColor];
                introduceLabel.numberOfLines = 0;
                introduceLabel.text = featureItem.introduce;
                
                introduceLabel.font = featureItem.introduceFont ?: [UIFont systemFontOfSize:13];
                
                introduceLabel.textColor = featureItem.introduceTextColor ?: [UIColor whiteColor];
                
                introduceView = introduceLabel;
            }
            
            [containerView addSubview :introduceView];
        }
        
        //布局按钮
        if(featureItem.action || featureItem.actionTitle)
        {
            button = [[UIButton alloc] init];
            [button setBackgroundImage:[[UIImage imageNamed:featureItem.buttonBackgroundImageName ?:  @"icon_ea_background"] resizableImageWithCapInsets:UIEdgeInsetsMake(4, 4, 4, 4)] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            
            if(featureItem.actionTitle.length <= 0)
            {
                featureItem.actionTitle = @"知道了";
            }
            
            [button setTitle:featureItem.actionTitle forState:UIControlStateNormal];
            [button sizeToFit];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame = button.frame;
            frame.size.width += 20;
            frame.size.height += 10;
            button.frame = frame;
            [containerView addSubview :button];
        }
    }
    
    EAFeatureItemLocation location = [self getLocationForFeatureItem:featureItem];
    
    CGRect introduceFrame = introduceView.frame;
    const CGFloat verticalSpacing = 10;
    
    //箭头方向向上
    if(location & EAFeatureItemLocationUp || location == EAFeatureItemLocationDefault)
    {
        //将箭头的锚点移动到顶部中间
        indicatorImageView.layer.anchorPoint = CGPointMake(.5f, 0);
        
        indicatorImageView.center = CGPointMake(CGRectGetMinX(featureItemFrame) + CGRectGetWidth(featureItemFrame) / 2, CGRectGetMinY(featureItemFrame) + CGRectGetHeight(featureItemFrame) + verticalSpacing);
        
        //箭头方向左上
        if(location & EAFeatureItemLocationLeft)
        {
            CGAffineTransform transform = indicatorImageView.transform;
            indicatorImageView.transform = CGAffineTransformRotate(transform, - M_PI / 4);
            //计算介绍的位置
            if([introduceView isKindOfClass:[UIImageView class]])
            {
                introduceFrame.origin.x = indicatorImageView.frame.origin.x;
                introduceFrame.origin.y = CGRectGetMaxY(indicatorImageView.frame) + verticalSpacing;
                introduceView.frame = introduceFrame;
            }
            else if([introduceView isKindOfClass:[UILabel class]])
            {
                CGRect rect = [featureItem.introduce boundingRectWithSize:CGSizeMake(containerView.bounds.size.width - indicatorImageView.frame.origin.x * 2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: ((UILabel *)introduceView).font} context:nil];
                
                introduceView.frame = CGRectMake(indicatorImageView.frame.origin.x, CGRectGetMaxY(indicatorImageView.frame) + verticalSpacing, rect.size.width, rect.size.height);
            }
            
            //如果文案的宽度小于箭头指示器的宽度,则将文案的中心设置成指示器的右端
            if(introduceView.frame.size.width < indicatorImageView.frame.size.width)
            {
                CGPoint center = introduceView.center;
                center.x = indicatorImageView.frame.origin.x + indicatorImageView.frame.size.width;
                introduceView.center = center;
            }
            
        }
        //箭头方向右上
        else if(location & EAFeatureItemLocationRight)
        {
            CGAffineTransform transform = indicatorImageView.transform;
            indicatorImageView.transform = CGAffineTransformRotate(transform,M_PI / 4);
            
            //计算介绍的位置
            if([introduceView isKindOfClass:[UIImageView class]])
            {
                introduceFrame.origin.x = indicatorImageView.frame.origin.x + indicatorImageView.frame.size.width - introduceFrame.size.width;
                
                introduceFrame.origin.y = CGRectGetMaxY(indicatorImageView.frame) + verticalSpacing;
                
                introduceView.frame = introduceFrame;
            }
            else if([introduceView isKindOfClass:[UILabel class]])
            {
                CGRect rect = [featureItem.introduce boundingRectWithSize:CGSizeMake( containerView.bounds.size.width - (containerView.bounds.size.width - indicatorImageView.frame.origin.x - indicatorImageView.frame.size.width) * 2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: ((UILabel *)introduceView).font} context:nil];
                
                introduceView.frame = CGRectMake(indicatorImageView.frame.origin.x + indicatorImageView.frame.size.width - rect.size.width, CGRectGetMaxY(indicatorImageView.frame) + verticalSpacing, rect.size.width, rect.size.height);
            }
            
            //如果文案的宽度小于箭头指示器的宽度,则将文案的中心设置成指示器的右端
            if(introduceView.frame.size.width < indicatorImageView.frame.size.width)
            {
                CGPoint center = introduceView.center;
                center.x = indicatorImageView.frame.origin.x;
                introduceView.center = center;
            }
        }
        else //垂直向上
        {
            //计算介绍的位置
            if([introduceView isKindOfClass:[UIImageView class]])
            {
                introduceView.center = CGPointMake(indicatorImageView.center.x, CGRectGetMaxY(indicatorImageView.frame) + verticalSpacing + introduceFrame.size.height / 2);
            }
            else if([introduceView isKindOfClass:[UILabel class]])
            {
                UILabel *label = (UILabel *)introduceView;
                label.textAlignment = NSTextAlignmentCenter;
                
                CGRect rect = [featureItem.introduce boundingRectWithSize:CGSizeMake(containerView.bounds.size.width * 3 / 4, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: ((UILabel *)introduceView).font} context:nil];
                introduceView.frame = CGRectMake((containerView.bounds.size.width - rect.size.width) / 2, CGRectGetMaxY(indicatorImageView.frame) + verticalSpacing, rect.size.width, rect.size.height);
            }
        }
    }
    //箭头方向下,布局方式是先布局介绍文案->布局按钮
    else if(location & EAFeatureItemLocationDown)
    {
        //是否需要布局按钮
        CGFloat buttonVerticalOccupySpace = button ? CGRectGetHeight(button.frame) + verticalSpacing : 0;
        
        //箭头方向左下
        if(location & EAFeatureItemLocationLeft)
        {
            //将箭头的锚点移动到低部中间
            indicatorImageView.layer.anchorPoint = CGPointMake(.5f, 1.f);
            //计算箭头的位置
            indicatorImageView.center = CGPointMake(CGRectGetMinX(featureItemFrame) + CGRectGetWidth(featureItemFrame) / 2, CGRectGetMinY(featureItemFrame) - CGRectGetHeight(indicatorImageView.frame));
            
            CGAffineTransform transform = indicatorImageView.transform;
            transform = CGAffineTransformTranslate(transform, CGRectGetHeight(indicatorImageView.frame) * sinf(M_PI / 4), 0);
            
            indicatorImageView.transform = CGAffineTransformRotate(transform,  - M_PI * 3 / 4);
            
            //计算介绍的位置
            if([introduceView isKindOfClass:[UIImageView class]])
            {
                introduceFrame.origin.x = indicatorImageView.frame.origin.x;
                introduceFrame.origin.y = CGRectGetMinY(indicatorImageView.frame) - verticalSpacing - buttonVerticalOccupySpace - CGRectGetHeight(introduceView.frame);
                introduceView.frame = introduceFrame;
            }
            else if([introduceView isKindOfClass:[UILabel class]])
            {
                CGRect rect = [featureItem.introduce boundingRectWithSize:CGSizeMake(containerView.bounds.size.width - indicatorImageView.frame.origin.x * 2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: ((UILabel *)introduceView).font} context:nil];
                
                introduceView.frame = CGRectMake(indicatorImageView.frame.origin.x, CGRectGetMinY(indicatorImageView.frame) - verticalSpacing - buttonVerticalOccupySpace - rect.size.height, rect.size.width, rect.size.height);
            }
            
            //如果文案的宽度小于箭头指示器的宽度,则将文案的中心设置成指示器的右端
            if(introduceView.frame.size.width < indicatorImageView.frame.size.width)
            {
                CGPoint center = introduceView.center;
                center.x = indicatorImageView.frame.origin.x + indicatorImageView.frame.size.width;
                introduceView.center = center;
            }
        }
        //箭头方向右下
        else if(location & EAFeatureItemLocationRight)
        {
            //将箭头的锚点移动到低部中间
            indicatorImageView.layer.anchorPoint = CGPointMake(.5f, 1.f);
            //计算箭头的位置
            indicatorImageView.center = CGPointMake(CGRectGetMinX(featureItemFrame) + CGRectGetWidth(featureItemFrame) / 2, CGRectGetMinY(featureItemFrame) - CGRectGetHeight(indicatorImageView.frame));
            
            CGAffineTransform transform = indicatorImageView.transform;
            transform = CGAffineTransformTranslate(transform, - CGRectGetHeight(indicatorImageView.frame) * sinf(M_PI / 4), 0);
            indicatorImageView.transform = CGAffineTransformRotate(transform, M_PI * 3 / 4);
            
            //计算介绍的位置
            if([introduceView isKindOfClass:[UIImageView class]])
            {
                introduceFrame.origin.x = indicatorImageView.frame.origin.x + indicatorImageView.frame.size.width - introduceFrame.size.width;
                
                introduceFrame.origin.y = CGRectGetMinY(indicatorImageView.frame) - verticalSpacing - buttonVerticalOccupySpace - CGRectGetHeight(introduceView.frame);
                
                introduceView.frame = introduceFrame;
            }
            else if([introduceView isKindOfClass:[UILabel class]])
            {
                CGRect rect = [featureItem.introduce boundingRectWithSize:CGSizeMake(containerView.bounds.size.width - (containerView.bounds.size.width - indicatorImageView.frame.origin.x - indicatorImageView.frame.size.width) * 2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: ((UILabel *)introduceView).font} context:nil];
                
                introduceView.frame = CGRectMake(indicatorImageView.frame.origin.x + indicatorImageView.frame.size.width - rect.size.width, CGRectGetMinY(indicatorImageView.frame) - verticalSpacing - buttonVerticalOccupySpace - rect.size.height, rect.size.width, rect.size.height);
            }
            
            //如果文案的宽度小于箭头指示器的宽度,则将文案的中心设置成指示器的左端
            if(introduceView.frame.size.width < indicatorImageView.frame.size.width)
            {
                CGPoint center = introduceView.center;
                center.x = indicatorImageView.frame.origin.x;
                introduceView.center = center;
            }
            
        }
        else //垂直向下
        {
            //将箭头的锚点移动到顶部中间
            //            indicatorImageView.layer.anchorPoint = CGPointMake(.5f, 0.f);
            
            indicatorImageView.center = CGPointMake(CGRectGetMinX(featureItemFrame) + CGRectGetWidth(featureItemFrame) / 2, CGRectGetMinY(featureItemFrame) - verticalSpacing - CGRectGetHeight(indicatorImageView.bounds) / 2);
            
            CGAffineTransform transform = indicatorImageView.transform;
            indicatorImageView.transform = CGAffineTransformRotate(transform, M_PI);
            
            //计算介绍的位置
            if([introduceView isKindOfClass:[UIImageView class]])
            {
                introduceView.center = CGPointMake(indicatorImageView.center.x, CGRectGetMinY(indicatorImageView.frame) - buttonVerticalOccupySpace - verticalSpacing - introduceFrame.size.height / 2);
            }
            else if([introduceView isKindOfClass:[UILabel class]])
            {
                UILabel *label = (UILabel *)introduceView;
                label.textAlignment = NSTextAlignmentCenter;
                
                CGRect rect = [featureItem.introduce boundingRectWithSize:CGSizeMake(containerView.bounds.size.width * 3 / 4, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: ((UILabel *)introduceView).font} context:nil];
                introduceView.frame = CGRectMake((containerView.bounds.size.width - rect.size.width) / 2, CGRectGetMinY(indicatorImageView.frame)  - buttonVerticalOccupySpace - verticalSpacing - rect.size.height, rect.size.width, rect.size.height);
            }
        }
    }
    
    button.center = CGPointMake(introduceView.center.x, CGRectGetMaxY(introduceView.frame) + verticalSpacing + button.frame.size.height / 2);
    
}

- (void)buttonAction:(UIButton *) sender
{
    NSMutableDictionary *actionDict = [self getButtonActionsDictionary];
    void (^action)(id sendr)  = actionDict[@(sender.tag)];
    if(action)
    {
        action(sender);
    }
    
    [self dismissFeatureGuideView];
}

- (void)dismissFeatureGuideView
{
    if(![self getContainerView])
        return;
    
    [UIView setShowStatusWithKey:[self getKeyName] status:YES];
    [[self getContainerView] removeFromSuperview];
    [self setContainerView:nil];
}

- (void)touchedEvent:(UITapGestureRecognizer *)tap
{
    if (tap.state == UIGestureRecognizerStateEnded)
    {
        [self dismissFeatureGuideView];
    }
}

+ (BOOL)hasShowFeatureGuideWithKey:(NSString *)keyName version:(NSString *)version
{
    if(!keyName)
        return NO;
    
    //如果version不为空，并且version跟当前项目版本号不一致则表示在当前版本不需要展示该提示
    if(![version isEqualToString:[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]] && version)
    {
        return YES;
    }
    
    id result = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",keyName,version]];
    
    if(result)
    {
        return [result boolValue];
    }
    return NO;
}

+ (void)setShowStatusWithKey:(NSString *)keyName status:(BOOL) hasShow
{
    if(!keyName)
        return;
    [[NSUserDefaults standardUserDefaults] setBool:hasShow forKey:keyName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setKeyName:(NSString *)keyName
{
    objc_setAssociatedObject(self, @selector(getKeyName), keyName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)getKeyName
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setContainerView:(UIView *)containerView
{
    objc_setAssociatedObject(self, @selector(getContainerView), containerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)getContainerView
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setButtonActionsDictionary:(NSMutableDictionary *)actionsDictionary
{
    objc_setAssociatedObject(self, @selector(getButtonActionsDictionary), actionsDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)getButtonActionsDictionary
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
//
//  EAFeatureItem.m
//  EAFeatureGuide
//layoutWithFeatureItem
//

#import "EAFeatureItem.h"

@interface EAFeatureItem ()

@end

@implementation EAFeatureItem

- (instancetype)initWithFocusView:(UIView *)focusView focusCornerRadius:(CGFloat) focusCornerRadius  focusInsets:(UIEdgeInsets) focusInsets
{
    self = [super init];
    if (self) {
        _focusView = focusView;
        self.focusCornerRadius = focusCornerRadius;
        self.focusInsets = focusInsets;
    }
    
    return self;
}

- (instancetype)initWithFocusRect:(CGRect)rect focusCornerRadius:(CGFloat) focusCornerRadius  focusInsets:(UIEdgeInsets) focusInsets
{
    self = [super init];
    if (self) {
        _focusRect = rect;
        self.focusCornerRadius = focusCornerRadius;
        self.focusInsets = focusInsets;
    }
    return self;
}


@end

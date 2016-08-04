
//
#import <objc/runtime.h>
#import "UIView+Blur.h"

NSString const *blurBackgroundKey = @"blurBackgroundKey";
NSString const *blurTintColorKey = @"blurTintColorKey";
NSString const *blurTintColorIntensityKey = @"blurTintColorIntensityKey";
NSString const *blurTintColorLayerKey = @"blurTintColorLayerKey";
NSString const *blurStyleKey = @"blurStyleKey";

@implementation UIView (Blur)

@dynamic blurBackground;
@dynamic blurTintColor;
@dynamic blurTintColorIntensity;
@dynamic isBlurred;
@dynamic blurStyle;

#pragma mark - category methods
-(void)enableBlur:(BOOL) enable
{
    if(enable) {
        UIToolbar* view = (UIToolbar*)self.blurBackground;
        if(!view) {
            // use UIToolbar
            view = [[UIToolbar alloc] initWithFrame:self.bounds];
            objc_setAssociatedObject(self, &blurBackgroundKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        view.clipsToBounds = YES;
        view.translucent = YES;

        // add the toolbar layer as sublayer
        [self.layer insertSublayer:view.layer atIndex:0];
//        view.barTintColor = [self.blurTintColor colorWithAlphaComponent:0.4f];
    } else {
        if(self.blurBackground) {
            [self.blurBackground.layer removeFromSuperlayer];
        }
    }
}

#pragma mark - getters/setters
-(UIColor*) blurTintColor
{
    return objc_getAssociatedObject(self, &blurTintColorKey);
}
-(void) setBlurTintColor:(UIColor *)blurTintColor
{
    objc_setAssociatedObject(self, &blurTintColorKey, blurTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(self.blurBackground) {
        UIToolbar *toolbar = ((UIToolbar*)self.blurBackground);
        CALayer *colorLayer = objc_getAssociatedObject(self, &blurTintColorLayerKey);
        if(colorLayer==nil) {
            colorLayer = [CALayer layer];
        } else {
            [colorLayer removeFromSuperlayer];
        }
        
        if(self.blurStyle == UIViewBlurDarkStyle) {
            toolbar.barStyle = UIBarStyleBlackTranslucent;
        } else {
            toolbar.barStyle = UIBarStyleDefault;
        }
        colorLayer.frame = toolbar.frame;
        colorLayer.opacity = 0.5f*self.blurTintColorIntensity;
        colorLayer.opaque = NO;
        [toolbar.layer insertSublayer:colorLayer atIndex:1];
        colorLayer.backgroundColor = blurTintColor.CGColor;
        
        objc_setAssociatedObject(self, &blurTintColorLayerKey, colorLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

-(UIView*)blurBackground
{
    return objc_getAssociatedObject(self, &blurBackgroundKey);
}

-(UIViewBlurStyle) blurStyle
{
    NSNumber* style = objc_getAssociatedObject(self, &blurStyleKey);
    if(!style) {
        style = @0;
    }
    return  [style intValue];
}

-(void)setBlurStyle:(UIViewBlurStyle)viewBlurStyle
{
    NSNumber *style = [NSNumber numberWithInteger:viewBlurStyle];
    objc_setAssociatedObject(self, &blurStyleKey, style, OBJC_ASSOCIATION_RETAIN);
    
    if(self.blurBackground) {
        if(viewBlurStyle == UIViewBlurDarkStyle) {
            ((UIToolbar*)self.blurBackground).barStyle = UIBarStyleBlackTranslucent;
        } else {
            ((UIToolbar*)self.blurBackground).barStyle = UIBarStyleDefault;
        }
    }
}

-(void)setBlurTintColorIntensity:(CGFloat)blurTintColorIntensity
{
    NSNumber *intensity = [NSNumber numberWithFloat:blurTintColorIntensity];
    objc_setAssociatedObject(self, &blurTintColorIntensityKey, intensity, OBJC_ASSOCIATION_RETAIN);
    
    if(self.blurBackground) {
        CALayer *colorLayer = objc_getAssociatedObject(self, &blurTintColorLayerKey);
        if(colorLayer) {
            colorLayer.opacity = 0.5f*intensity.floatValue;
        }
    }
}

-(CGFloat)blurTintColorIntensity
{
    NSNumber *intensity = objc_getAssociatedObject(self, &blurTintColorIntensityKey);
    if(!intensity) {
        intensity = @0.6;
    }
    return intensity.floatValue;
}
@end

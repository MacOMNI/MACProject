

#import <UIKit/UIKit.h>

typedef enum {
    UIViewBlurLightStyle,
    UIViewBlurDarkStyle
} UIViewBlurStyle;

@interface UIView (Blur)

/* The UIToolbar that has been put on the current view, use it to do your bidding */
@property (strong,nonatomic,readonly) UIView* blurBackground;

/* tint color of the blurred view */
@property (strong,nonatomic) UIColor* blurTintColor;

/* intensity of blurTintColor applied on the blur 0.0-1.0, default 0.6f */
@property (assign,nonatomic) CGFloat blurTintColorIntensity;

/* returns if blurring is enabled */
@property (readonly,nonatomic) BOOL isBlurred;

/* Style of Toolbar, remapped to UIViewBlurStyle typedef above */
@property (assign,nonatomic) UIViewBlurStyle blurStyle;

/* method to enable Blur on current UIView */
-(void)enableBlur:(BOOL) enable;

@end

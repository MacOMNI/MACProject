//
//  MACSideMenuController.h
//  MacKun
//

#import <UIKit/UIKit.h>

static NSString *const kMACSideMenuControllerWillShowLeftViewNotification    = @"kMACSideMenuControllerWillShowLeftViewNotification";
static NSString *const kMACSideMenuControllerWillDismissLeftViewNotification = @"kMACSideMenuControllerWillDismissLeftViewNotification";
static NSString *const kMACSideMenuControllerDidShowLeftViewNotification     = @"kMACSideMenuControllerDidShowLeftViewNotification";
static NSString *const kMACSideMenuControllerDidDismissLeftViewNotification  = @"kMACSideMenuControllerDidDismissLeftViewNotification";

static NSString *const kMACSideMenuControllerWillShowRightViewNotification    = @"kMACSideMenuControllerWillShowRightViewNotification";
static NSString *const kMACSideMenuControllerWillDismissRightViewNotification = @"kMACSideMenuControllerWillDismissRightViewNotification";
static NSString *const kMACSideMenuControllerDidShowRightViewNotification     = @"kMACSideMenuControllerDidShowRightViewNotification";
static NSString *const kMACSideMenuControllerDidDismissRightViewNotification  = @"kMACSideMenuControllerDidDismissRightViewNotification";

@interface MACSideMenuController : UIViewController

typedef enum
{
    MACSideMenuAlwaysVisibleOnNone           = 0,
    MACSideMenuAlwaysVisibleOnPadLandscape   = 1 << 0,
    MACSideMenuAlwaysVisibleOnPadPortrait    = 1 << 1,
    MACSideMenuAlwaysVisibleOnPhoneLandscape = 1 << 2,
    MACSideMenuAlwaysVisibleOnPhonePortrait  = 1 << 3,
}
MACSideMenuAlwaysVisibleOptions;//默认设置成0即可

typedef enum
{
    MACSideMenuStatusBarVisibleOnNone           = 0,
    MACSideMenuStatusBarVisibleOnPadLandscape   = 1 << 0,
    MACSideMenuStatusBarVisibleOnPadPortrait    = 1 << 1,
    MACSideMenuStatusBarVisibleOnPhoneLandscape = 1 << 2,
    MACSideMenuStatusBarVisibleOnPhonePortrait  = 1 << 3,
}
MACSideMenuStatusBarVisibleOptions;//默认设置成0即可

typedef enum
{
    MACSideMenuPresentationStyleSlideAbove      = 0,//覆盖地层mainVC 遮挡显示
    MACSideMenuPresentationStyleSlideBelow      = 1,//并列显示
    MACSideMenuPresentationStyleScaleFromBig    = 2,//QQ侧滑抽屉原理大部分侧滑
    MACSideMenuPresentationStyleScaleFromLittle = 3//QQ侧滑小部分侧滑效果
}
MACSideMenuPresentationStyle;//以上类型左右VC可以互斥

@property (assign, nonatomic, readonly) CGFloat leftViewWidth;
@property (assign, nonatomic, readonly) CGFloat rightViewWidth;

@property (assign, nonatomic, readonly) MACSideMenuPresentationStyle leftViewPresentationStyle;
@property (assign, nonatomic, readonly) MACSideMenuPresentationStyle rightViewPresentationStyle;

@property (assign, nonatomic, readonly) MACSideMenuAlwaysVisibleOptions leftViewAlwaysVisibleOptions;
@property (assign, nonatomic, readonly) MACSideMenuAlwaysVisibleOptions rightViewAlwaysVisibleOptions;

@property (assign, nonatomic) IBInspectable MACSideMenuStatusBarVisibleOptions leftViewStatusBarVisibleOptions;
@property (assign, nonatomic) IBInspectable MACSideMenuStatusBarVisibleOptions rightViewStatusBarVisibleOptions;

@property (assign, nonatomic, getter=isLeftViewShowing)  BOOL leftViewShowing;
@property (assign, nonatomic, getter=isRightViewShowing) BOOL rightViewShowing;

/** Default is YES */
@property (assign, nonatomic, getter=isLeftViewHidesOnTouch)  IBInspectable BOOL leftViewHidesOnTouch;
/** Default is YES */
@property (assign, nonatomic, getter=isRightViewHidesOnTouch) IBInspectable BOOL rightViewHidesOnTouch;

/** Default is YES */
@property (assign, nonatomic, getter=isLeftViewSwipeGestureEnabled)  IBInspectable BOOL leftViewSwipeGestureEnabled;
/** Default is YES */
@property (assign, nonatomic, getter=isRightViewSwipeGestureEnabled) IBInspectable BOOL rightViewSwipeGestureEnabled;
/** Default is YES */
@property (assign, nonatomic, getter=isGesturesCancelsTouchesInView) IBInspectable BOOL gesturesCancelsTouchesInView;

/**
 Color that hides root view, when left view is showing
 For MACSideMenuPresentationStyleSlideAbove default is [UIColor colorWithWhite:0.f alpha:0.5]
 */
@property (strong, nonatomic) IBInspectable UIColor *rootViewCoverColorForLeftView;
/**
 Color that hides root view, when right view is showing
 For MACSideMenuPresentationStyleSlideAbove default is [UIColor colorWithWhite:0.f alpha:0.5]
 */
@property (strong, nonatomic) IBInspectable UIColor *rootViewCoverColorForRightView;

/**
 Only if (presentationStyle == MACSideMenuPresentationStyleSlideBelow || MACSideMenuPresentationStyleScaleFromBig || MACSideMenuPresentationStyleScaleFromLittle).
 For MACSideMenuPresentationStyleSlideBelow default is 1.
 For MACSideMenuPresentationStyleScaleFromBig default is 0.8.
 For MACSideMenuPresentationStyleScaleFromLittle default is 0.8.
 */
@property (assign, nonatomic) IBInspectable CGFloat rootViewScaleForLeftView;
/**
 Only if (presentationStyle == MACSideMenuPresentationStyleSlideBelow || MACSideMenuPresentationStyleScaleFromBig || MACSideMenuPresentationStyleScaleFromLittle).
 For MACSideMenuPresentationStyleSlideBelow default is 1.
 For MACSideMenuPresentationStyleScaleFromBig default is 0.8.
 For MACSideMenuPresentationStyleScaleFromLittle default is 0.8.
 */
@property (assign, nonatomic) IBInspectable CGFloat rootViewScaleForRightView;

/**
 Color that hides left view, when if is not showing.
 Only if (presentationStyle == MACSideMenuPresentationStyleSlideBelow || MACSideMenuPresentationStyleScaleFromBig || MACSideMenuPresentationStyleScaleFromLittle)
 Default is [UIColor colorWithWhite:0.f alpha:0.5]
 */
@property (strong, nonatomic) IBInspectable UIColor *leftViewCoverColor;
/**
 Color that hides right view, when if is not showing.
 Only if (presentationStyle == MACSideMenuPresentationStyleSlideBelow || MACSideMenuPresentationStyleScaleFromBig || MACSideMenuPresentationStyleScaleFromLittle)
 Default is [UIColor colorWithWhite:0.f alpha:0.5]
 */
@property (strong, nonatomic)IBInspectable  UIColor *rightViewCoverColor;

/** Only if (presentationStyle == MACSideMenuPresentationStyleSlideBelow || MACSideMenuPresentationStyleScaleFromBig || MACSideMenuPresentationStyleScaleFromLittle) */
@property (strong, nonatomic) IBInspectable UIImage *leftViewBackgroundImage;
/** Only if (presentationStyle == MACSideMenuPresentationStyleSlideBelow || MACSideMenuPresentationStyleScaleFromBig || MACSideMenuPresentationStyleScaleFromLittle) */
@property (strong, nonatomic) IBInspectable UIImage *rightViewBackgroundImage;

/**
 Only if (presentationStyle == MACSideMenuPresentationStyleSlideBelow || MACSideMenuPresentationStyleScaleFromBig || MACSideMenuPresentationStyleScaleFromLittle).
 For MACSideMenuPresentationStyleSlideBelow default is 1.
 For MACSideMenuPresentationStyleScaleFromBig and MACSideMenuPresentationStyleScaleFromLittle default is 1.4.
 */
@property (assign, nonatomic) IBInspectable CGFloat leftViewBackgroundImageInitialScale;
/**
 Only if (presentationStyle == MACSideMenuPresentationStyleSlideBelow || MACSideMenuPresentationStyleScaleFromBig || MACSideMenuPresentationStyleScaleFromLittle).
 For MACSideMenuPresentationStyleSlideBelow default is 1.
 For MACSideMenuPresentationStyleScaleFromBig and MACSideMenuPresentationStyleScaleFromLittle default is 1.4.
 */
@property (assign, nonatomic) IBInspectable CGFloat rightViewBackgroundImageInitialScale;

/**
 Only if (presentationStyle == MACSideMenuPresentationStyleSlideBelow || MACSideMenuPresentationStyleScaleFromBig || MACSideMenuPresentationStyleScaleFromLittle).
 For MACSideMenuPresentationStyleSlideBelow default is 1.
 For MACSideMenuPresentationStyleScaleFromBig default is 1.2.
 For MACSideMenuPresentationStyleScaleFromLittle default is 0.8.
 */
@property (assign, nonatomic) IBInspectable CGFloat leftViewInititialScale;
/**
 Only if (presentationStyle == MACSideMenuPresentationStyleSlideBelow || MACSideMenuPresentationStyleScaleFromBig || MACSideMenuPresentationStyleScaleFromLittle).
 For MACSideMenuPresentationStyleSlideBelow default is 1.
 For MACSideMenuPresentationStyleScaleFromBig default is 1.2.
 For MACSideMenuPresentationStyleScaleFromLittle default is 0.8.
 */
@property (assign, nonatomic) IBInspectable CGFloat rightViewInititialScale;

/**
 Only if (presentationStyle == MACSideMenuPresentationStyleSlideBelow || MACSideMenuPresentationStyleScaleFromBig || MACSideMenuPresentationStyleScaleFromLittle).
 For MACSideMenuPresentationStyleSlideBelow default is -width/2.
 For MACSideMenuPresentationStyleScaleFromBig default is 0.
 For MACSideMenuPresentationStyleScaleFromLittle default is 0.
 */
@property (assign, nonatomic) IBInspectable CGFloat leftViewInititialOffsetX;
/**
 Only if (presentationStyle == MACSideMenuPresentationStyleSlideBelow || MACSideMenuPresentationStyleScaleFromBig || MACSideMenuPresentationStyleScaleFromLittle).
 For MACSideMenuPresentationStyleSlideBelow default is width/2.
 For MACSideMenuPresentationStyleScaleFromBig default is 0.
 For MACSideMenuPresentationStyleScaleFromLittle default is 0.
 */
@property (assign, nonatomic) IBInspectable CGFloat rightViewInititialOffsetX;

@property (strong, nonatomic) IBInspectable UIColor *rootViewLayerBorderColor;
@property (assign, nonatomic) IBInspectable CGFloat rootViewLayerBorderWidth;
/** For (presentationStyle == MACSideMenuPresentationStyleSlideBelow || MACSideMenuPresentationStyleScaleFromBig || MACSideMenuPresentationStyleScaleFromLittle) default is [UIColor colorWithWhite:0.f alpha:0.5] */
@property (strong, nonatomic) IBInspectable UIColor *rootViewLayerShadowColor;
/** For (presentationStyle == MACSideMenuPresentationStyleSlideBelow || MACSideMenuPresentationStyleScaleFromBig || MACSideMenuPresentationStyleScaleFromLittle) default is 5.f */
@property (assign, nonatomic) IBInspectable CGFloat rootViewLayerShadowRadius;

@property (strong, nonatomic) IBInspectable UIColor *leftViewBackgroundColor;
@property (strong, nonatomic) IBInspectable UIColor *leftViewLayerBorderColor;
@property (assign, nonatomic) IBInspectable CGFloat leftViewLayerBorderWidth;
/** For MACSideMenuPresentationStyleSlideAbove default is [UIColor colorWithWhite:0.f alpha:0.5] */
@property (strong, nonatomic) IBInspectable UIColor *leftViewLayerShadowColor;
/** For MACSideMenuPresentationStyleSlideAbove default is 5.f */
@property (assign, nonatomic) IBInspectable CGFloat leftViewLayerShadowRadius;

@property (strong, nonatomic) IBInspectable UIColor *rightViewBackgroundColor;
@property (strong, nonatomic) IBInspectable UIColor *rightViewLayerBorderColor;
@property (assign, nonatomic) IBInspectable CGFloat rightViewLayerBorderWidth;
/** For MACSideMenuPresentationStyleSlideAbove default is [UIColor colorWithWhite:0.f alpha:0.5] */
@property (strong, nonatomic) IBInspectable UIColor *rightViewLayerShadowColor;
/** For MACSideMenuPresentationStyleSlideAbove default is 5.f */
@property (assign, nonatomic) IBInspectable CGFloat rightViewLayerShadowRadius;
/**
 *  初始化RootVC
 */
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController;

- (void)setRootViewController:(UIViewController *)rootViewController;

- (UIViewController *)rootViewController;
- (UIView *)leftView;
- (UIView *)rightView;

- (BOOL)isLeftViewAlwaysVisible;
- (BOOL)isRightViewAlwaysVisible;

- (BOOL)isLeftViewAlwaysVisibleForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
- (BOOL)isRightViewAlwaysVisibleForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
/**
 *  设置左视图
 *  @param width                宽度
 *  @param presentationStyle    展现形式
 *  @param alwaysVisibleOptions 被查看的形式
 */
- (void)setLeftViewEnabledWithWidth:(CGFloat)width
                  presentationStyle:(MACSideMenuPresentationStyle)presentationStyle
               alwaysVisibleOptions:(MACSideMenuAlwaysVisibleOptions)alwaysVisibleOptions;
/**
 *  设置右视图
 *  @param width                宽度
 *  @param presentationStyle    展现形式
 *  @param alwaysVisibleOptions 被查看的形式
 */
- (void)setRightViewEnabledWithWidth:(CGFloat)width
                   presentationStyle:(MACSideMenuPresentationStyle)presentationStyle
                alwaysVisibleOptions:(MACSideMenuAlwaysVisibleOptions)alwaysVisibleOptions;

- (void)leftViewWillLayoutSubviewsWithSize:(CGSize)size;
- (void)rightViewWillLayoutSubviewsWithSize:(CGSize)size;

- (void)showLeftViewAnimated:(BOOL)animated completionHandler:(void(^)())completionHandler;
- (void)hideLeftViewAnimated:(BOOL)animated completionHandler:(void(^)())completionHandler;
- (void)showHideLeftViewAnimated:(BOOL)animated completionHandler:(void(^)())completionHandler;

- (void)showRightViewAnimated:(BOOL)animated completionHandler:(void(^)())completionHandler;
- (void)hideRightViewAnimated:(BOOL)animated completionHandler:(void(^)())completionHandler;
- (void)showHideRightViewAnimated:(BOOL)animated completionHandler:(void(^)())completionHandler;

@end

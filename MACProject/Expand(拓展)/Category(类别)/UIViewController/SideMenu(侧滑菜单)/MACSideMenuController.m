
//
//  MACSideMenuController.m
//  MacKun
//

#import "MACSideMenuController.h"


#define kMACSideMenuStatusBarOrientationIsPortrait   UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)
#define kMACSideMenuStatusBarOrientationIsLandscape  UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
#define kMACSideMenuStatusBarHidden                  UIApplication.sharedApplication.statusBarHidden

#define kMACSideMenuDeviceIsPad                      (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kMACSideMenuDeviceIsPhone                    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kMACSideMenuSystemVersion                    UIDevice.currentDevice.systemVersion.floatValue
#define kMACSideMenuCoverColor                       [UIColor colorWithWhite:0.f alpha:0.5]

#define kMACSideMenuIsLeftViewAlwaysVisible \
((kMACSideMenuDeviceIsPhone && \
((kMACSideMenuStatusBarOrientationIsPortrait && (_leftViewAlwaysVisibleOptions & MACSideMenuAlwaysVisibleOnPhonePortrait)) || \
(kMACSideMenuStatusBarOrientationIsLandscape && (_leftViewAlwaysVisibleOptions & MACSideMenuAlwaysVisibleOnPhoneLandscape)))) || \
(kMACSideMenuDeviceIsPad && \
((kMACSideMenuStatusBarOrientationIsPortrait && (_leftViewAlwaysVisibleOptions & MACSideMenuAlwaysVisibleOnPadPortrait)) || \
(kMACSideMenuStatusBarOrientationIsLandscape && (_leftViewAlwaysVisibleOptions & MACSideMenuAlwaysVisibleOnPadLandscape)))))

#define kMACSideMenuIsRightViewAlwaysVisible \
((kMACSideMenuDeviceIsPhone && \
((kMACSideMenuStatusBarOrientationIsPortrait && (_rightViewAlwaysVisibleOptions & MACSideMenuAlwaysVisibleOnPhonePortrait)) || \
(kMACSideMenuStatusBarOrientationIsLandscape && (_rightViewAlwaysVisibleOptions & MACSideMenuAlwaysVisibleOnPhoneLandscape)))) || \
(kMACSideMenuDeviceIsPad && \
((kMACSideMenuStatusBarOrientationIsPortrait && (_rightViewAlwaysVisibleOptions & MACSideMenuAlwaysVisibleOnPadPortrait)) || \
(kMACSideMenuStatusBarOrientationIsLandscape && (_rightViewAlwaysVisibleOptions & MACSideMenuAlwaysVisibleOnPadLandscape)))))

#define kMACSideMenuIsLeftViewAlwaysVisibleForInterfaceOrientation(interfaceOrientation) \
((kMACSideMenuDeviceIsPhone && \
((UIInterfaceOrientationIsPortrait(interfaceOrientation) && (_leftViewAlwaysVisibleOptions & MACSideMenuAlwaysVisibleOnPhonePortrait)) || \
(UIInterfaceOrientationIsLandscape(interfaceOrientation) && (_leftViewAlwaysVisibleOptions & MACSideMenuAlwaysVisibleOnPhoneLandscape)))) || \
(kMACSideMenuDeviceIsPad && \
((UIInterfaceOrientationIsPortrait(interfaceOrientation) && (_leftViewAlwaysVisibleOptions & MACSideMenuAlwaysVisibleOnPadPortrait)) || \
(UIInterfaceOrientationIsLandscape(interfaceOrientation) && (_leftViewAlwaysVisibleOptions & MACSideMenuAlwaysVisibleOnPadLandscape)))))

#define kMACSideMenuIsRightViewAlwaysVisibleForInterfaceOrientation(interfaceOrientation) \
((kMACSideMenuDeviceIsPhone && \
((UIInterfaceOrientationIsPortrait(interfaceOrientation) && (_rightViewAlwaysVisibleOptions & MACSideMenuAlwaysVisibleOnPhonePortrait)) || \
(UIInterfaceOrientationIsLandscape(interfaceOrientation) && (_rightViewAlwaysVisibleOptions & MACSideMenuAlwaysVisibleOnPhoneLandscape)))) || \
(kMACSideMenuDeviceIsPad && \
((UIInterfaceOrientationIsPortrait(interfaceOrientation) && (_rightViewAlwaysVisibleOptions & MACSideMenuAlwaysVisibleOnPadPortrait)) || \
(UIInterfaceOrientationIsLandscape(interfaceOrientation) && (_rightViewAlwaysVisibleOptions & MACSideMenuAlwaysVisibleOnPadLandscape)))))

#define kMACSideMenuIsLeftViewStatusBarVisible \
((kMACSideMenuDeviceIsPhone && \
((kMACSideMenuStatusBarOrientationIsPortrait && (_leftViewStatusBarVisibleOptions & MACSideMenuStatusBarVisibleOnPhonePortrait)) || \
(kMACSideMenuStatusBarOrientationIsLandscape && (_leftViewStatusBarVisibleOptions & MACSideMenuStatusBarVisibleOnPhoneLandscape)))) || \
(kMACSideMenuDeviceIsPad && \
((kMACSideMenuStatusBarOrientationIsPortrait && (_leftViewStatusBarVisibleOptions & MACSideMenuStatusBarVisibleOnPadPortrait)) || \
(kMACSideMenuStatusBarOrientationIsLandscape && (_leftViewStatusBarVisibleOptions & MACSideMenuStatusBarVisibleOnPadLandscape)))))

#define kMACSideMenuIsRightViewStatusBarVisible \
((kMACSideMenuDeviceIsPhone && \
((kMACSideMenuStatusBarOrientationIsPortrait && (_rightViewStatusBarVisibleOptions & MACSideMenuStatusBarVisibleOnPhonePortrait)) || \
(kMACSideMenuStatusBarOrientationIsLandscape && (_rightViewStatusBarVisibleOptions & MACSideMenuStatusBarVisibleOnPhoneLandscape)))) || \
(kMACSideMenuDeviceIsPad && \
((kMACSideMenuStatusBarOrientationIsPortrait && (_rightViewStatusBarVisibleOptions & MACSideMenuStatusBarVisibleOnPadPortrait)) || \
(kMACSideMenuStatusBarOrientationIsLandscape && (_rightViewStatusBarVisibleOptions & MACSideMenuStatusBarVisibleOnPadLandscape)))))

@interface MACSideMenuView : UIView

@property (strong, nonatomic) void (^layoutSubviewsHandler)();

@end

@implementation MACSideMenuView

- (instancetype)initWithLayoutSubviewsHandler:(void(^)())layoutSubviewsHandler
{
    self = [super init];
    if (self)
    {
        _layoutSubviewsHandler = layoutSubviewsHandler;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_layoutSubviewsHandler) _layoutSubviewsHandler();
}

@end

#pragma mark - SideMenuController

@interface MACSideMenuController () <UIGestureRecognizerDelegate>

@property (assign, nonatomic) CGSize savedSize;

@property (strong, nonatomic) UIViewController *rootVC;
@property (strong, nonatomic) MACSideMenuView *leftView;
@property (strong, nonatomic) MACSideMenuView *rightView;

@property (strong, nonatomic) UIView *rootViewCoverViewForLeftView;
@property (strong, nonatomic) UIView *rootViewCoverViewForRightView;

@property (strong, nonatomic) UIView *leftViewCoverView;
@property (strong, nonatomic) UIView *rightViewCoverView;

@property (strong, nonatomic) UIImageView *backgroundImageView;

@property (strong, nonatomic) UIView *rootViewStyleView;
@property (strong, nonatomic) UIView *leftViewStyleView;
@property (strong, nonatomic) UIView *rightViewStyleView;

@property (assign, nonatomic) BOOL savedStatusBarHidden;
@property (assign, nonatomic) BOOL currentStatusBarHidden;

@property (strong, nonatomic) NSNumber *leftViewGestireStartX;
@property (strong, nonatomic) NSNumber *rightViewGestireStartX;

@property (assign, nonatomic, getter=isLeftViewShowingBeforeGesture) BOOL leftViewShowingBeforeGesture;
@property (assign, nonatomic, getter=isRightViewShowingBeforeGesture) BOOL rightViewShowingBeforeGesture;

@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;

@end

@implementation MACSideMenuController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setupDefaultProperties];
        [self setupDefaults];
    }
    return self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super init];
    if (self)
    {
        _rootVC = rootViewController;
        
        [self setupDefaultProperties];
        [self setupDefaults];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setupDefaultProperties];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupDefaults];
}

- (void)setupDefaultProperties
{
    _leftViewHidesOnTouch = YES;
    _rightViewHidesOnTouch = YES;
    
    _leftViewSwipeGestureEnabled = YES;
    _rightViewSwipeGestureEnabled = YES;
    
    _rootViewLayerShadowColor = [UIColor colorWithWhite:0.f alpha:0.5];
    _rootViewLayerShadowRadius = 5.f;
    
    _leftViewLayerShadowColor = [UIColor colorWithWhite:0.f alpha:0.5];
    _leftViewLayerShadowRadius = 5.f;
    
    _rightViewLayerShadowColor = [UIColor colorWithWhite:0.f alpha:0.5];
    _rightViewLayerShadowRadius = 5.f;
    
    _leftViewCoverColor = kMACSideMenuCoverColor;
    _rightViewCoverColor = kMACSideMenuCoverColor;
}

- (void)setupDefaults
{
    self.view.clipsToBounds = YES;
    
    // -----
    
    _backgroundImageView = [UIImageView new];
    _backgroundImageView.hidden = YES;
    _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    _backgroundImageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_backgroundImageView];
    
    // -----
    
    _rootViewStyleView = [UIView new];
    _rootViewStyleView.hidden = YES;
    _rootViewStyleView.backgroundColor = [UIColor blackColor];
    _rootViewStyleView.layer.masksToBounds = NO;
    _rootViewStyleView.layer.shadowOffset = CGSizeZero;
    _rootViewStyleView.layer.shadowOpacity = 1.f;
    _rootViewStyleView.layer.shouldRasterize = YES;
    [self.view addSubview:_rootViewStyleView];
    
    if (_rootVC)
    {
        [self addChildViewController:_rootVC];
        [self.view addSubview:_rootVC.view];
    }
    
    // -----
    
    _gesturesCancelsTouchesInView = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.delegate = self;
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
    
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    _panGesture.minimumNumberOfTouches = 1;
    _panGesture.maximumNumberOfTouches = 1;
    _panGesture.cancelsTouchesInView = YES;
    [self.view addGestureRecognizer:_panGesture];
}

#pragma mark - Dealloc

- (void)dealloc
{
    //
}

#pragma mark - Appearing

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGSize size = self.view.frame.size;
    
    if (kMACSideMenuSystemVersion < 8.0)
    {
        if (kMACSideMenuStatusBarOrientationIsPortrait)
            size = CGSizeMake(MIN(size.width, size.height), MAX(size.width, size.height));
        else
            size = CGSizeMake(MAX(size.width, size.height), MIN(size.width, size.height));
    }
    
    if (!CGSizeEqualToSize(_savedSize, size))
    {
        BOOL appeared = !CGSizeEqualToSize(_savedSize, CGSizeZero);
        
        _savedSize = size;
        
        // -----
        
        [self colorsInvalidate];
        [self rootViewLayoutInvalidateWithPercentage:(self.isLeftViewShowing || self.isRightViewShowing ? 1.f : 0.f)];
        [self leftViewLayoutInvalidateWithPercentage:(self.isLeftViewShowing ? 1.f : 0.f)];
        [self rightViewLayoutInvalidateWithPercentage:(self.isRightViewShowing ? 1.f : 0.f)];
        [self hiddensInvalidateWithDelay:(appeared ? 0.25 : 0.0)];
    }
}

#pragma mark -

- (BOOL)shouldAutorotate
{
    return !(self.isLeftViewShowing || self.isRightViewShowing);
}

- (BOOL)prefersStatusBarHidden
{
    return _currentStatusBarHidden;
}

#pragma mark - Setters and Getters

- (void)setRootViewController:(UIViewController *)rootViewController
{
    if (rootViewController)
    {
        if (_rootVC)
        {
            [_rootVC.view removeFromSuperview];
            [_rootVC removeFromParentViewController];
        }
        
        _rootVC = rootViewController;
        
        [self addChildViewController:_rootVC];
        [self.view addSubview:_rootVC.view];
        
        if (_leftView)
        {
            [_leftView removeFromSuperview];
            [_rootViewCoverViewForLeftView removeFromSuperview];
            
            [self.view addSubview:_rootViewCoverViewForLeftView];
            
            if (_leftViewPresentationStyle == MACSideMenuPresentationStyleSlideAbove)
                [self.view addSubview:_leftView];
            else
                [self.view insertSubview:_leftView belowSubview:_rootVC.view];
            
        }
        
        if (_rightView)
        {
            [_rightView removeFromSuperview];
            [_rootViewCoverViewForRightView removeFromSuperview];
            
            [self.view insertSubview:_rootViewCoverViewForRightView aboveSubview:_rootViewCoverViewForLeftView];
            
            if (_rightViewPresentationStyle == MACSideMenuPresentationStyleSlideAbove)
                [self.view addSubview:_rightView];
            else
                [self.view insertSubview:_rightView belowSubview:_rootVC.view];
        }
        
        // -----
        
        [self rootViewLayoutInvalidateWithPercentage:(self.isLeftViewShowing || self.isRightViewShowing ? 1.f : 0.f)];
    }
}

- (UIViewController *)rootViewController
{
    return _rootVC;
}

- (UIView *)leftView
{
    return _leftView;
}

- (UIView *)rightView
{
    return _rightView;
}

- (void)setRootViewCoverColorForLeftView:(UIColor *)rootViewCoverColorForLeftView
{
    _rootViewCoverColorForLeftView = rootViewCoverColorForLeftView;
    
    if (_leftView)
        _rootViewCoverViewForLeftView.backgroundColor = _rootViewCoverColorForLeftView;
}

- (void)setRootViewCoverColorForRightView:(UIColor *)rootViewCoverColorForRightView
{
    _rootViewCoverColorForRightView = rootViewCoverColorForRightView;
    
    if (_rightView)
        _rootViewCoverViewForRightView.backgroundColor = _rootViewCoverColorForRightView;
}

- (BOOL)isLeftViewAlwaysVisible
{
    return kMACSideMenuIsLeftViewAlwaysVisible;
}

- (BOOL)isRightViewAlwaysVisible
{
    return kMACSideMenuIsRightViewAlwaysVisible;
}

- (BOOL)isLeftViewAlwaysVisibleForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return kMACSideMenuIsLeftViewAlwaysVisibleForInterfaceOrientation(interfaceOrientation);
}

- (BOOL)isRightViewAlwaysVisibleForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return kMACSideMenuIsRightViewAlwaysVisibleForInterfaceOrientation(interfaceOrientation);
}

- (void)setGesturesCancelsTouchesInView:(BOOL)gesturesCancelsTouchesInView
{
    _gesturesCancelsTouchesInView = gesturesCancelsTouchesInView;
    
    _panGesture.cancelsTouchesInView = gesturesCancelsTouchesInView;
}

#pragma mark - Layout Subviews

- (void)leftViewWillLayoutSubviewsWithSize:(CGSize)size
{
    //
}

- (void)rightViewWillLayoutSubviewsWithSize:(CGSize)size
{
    //
}

#pragma mark -

- (void)rootViewLayoutInvalidateWithPercentage:(CGFloat)percentage
{
    _rootVC.view.transform = CGAffineTransformIdentity;
    _rootViewStyleView.transform = CGAffineTransformIdentity;
    
    if (_leftView)
        _rootViewCoverViewForLeftView.transform = CGAffineTransformIdentity;
    
    if (_rightView)
        _rootViewCoverViewForRightView.transform = CGAffineTransformIdentity;
    
    // -----
    
    CGSize size = self.view.frame.size;
    
    if (kMACSideMenuSystemVersion < 8.0)
    {
        if (kMACSideMenuStatusBarOrientationIsPortrait)
            size = CGSizeMake(MIN(size.width, size.height), MAX(size.width, size.height));
        else
            size = CGSizeMake(MAX(size.width, size.height), MIN(size.width, size.height));
    }
    
    // -----
    
    CGRect rootViewViewFrame = CGRectMake(0.f, 0.f, size.width, size.height);
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    BOOL leftViewAlwaysVisible = NO;
    BOOL rightViewAlwaysVisible = NO;
    
    if (kMACSideMenuIsLeftViewAlwaysVisible)
    {
        leftViewAlwaysVisible = YES;
        
        rootViewViewFrame.origin.x += _leftViewWidth;
        rootViewViewFrame.size.width -= _leftViewWidth;
    }
    
    if (kMACSideMenuIsRightViewAlwaysVisible)
    {
        rightViewAlwaysVisible = YES;
        
        rootViewViewFrame.size.width -= _rightViewWidth;
    }
    
    if (!leftViewAlwaysVisible && !rightViewAlwaysVisible)
    {
        if (self.isLeftViewShowing && _leftViewPresentationStyle != MACSideMenuPresentationStyleSlideAbove)
        {
            CGFloat rootViewScale = 1.f+(_rootViewScaleForLeftView-1.f)*percentage;
            
            transform = CGAffineTransformMakeScale(rootViewScale, rootViewScale);
            
            CGFloat shift = size.width*(1.f-rootViewScale)/2;
            
            rootViewViewFrame = CGRectMake((_leftViewWidth-shift)*percentage, 0.f, size.width, size.height);
            if ([UIScreen mainScreen].scale == 1.f)
                rootViewViewFrame = CGRectIntegral(rootViewViewFrame);
        }
        else if (self.isRightViewShowing && _rightViewPresentationStyle != MACSideMenuPresentationStyleSlideAbove)
        {
            CGFloat rootViewScale = 1.f+(_rootViewScaleForRightView-1.f)*percentage;
            
            transform = CGAffineTransformMakeScale(rootViewScale, rootViewScale);
            
            CGFloat shift = size.width*(1.f-rootViewScale)/2;
            
            rootViewViewFrame = CGRectMake(-(_rightViewWidth-shift)*percentage, 0.f, size.width, size.height);
            if ([UIScreen mainScreen].scale == 1.f)
                rootViewViewFrame = CGRectIntegral(rootViewViewFrame);
        }
    }
    
    _rootVC.view.frame = rootViewViewFrame;
    _rootVC.view.transform = transform;
    
    // -----
    
    CGFloat borderWidth = _rootViewStyleView.layer.borderWidth;
    _rootViewStyleView.frame = CGRectMake(rootViewViewFrame.origin.x-borderWidth, rootViewViewFrame.origin.y-borderWidth, rootViewViewFrame.size.width+borderWidth*2, rootViewViewFrame.size.height+borderWidth*2);
    _rootViewStyleView.transform = transform;
    
    // -----
    
    if (_leftView)
    {
        _rootViewCoverViewForLeftView.frame = rootViewViewFrame;
        _rootViewCoverViewForLeftView.transform = transform;
    }
    
    if (_rightView)
    {
        _rootViewCoverViewForRightView.frame = rootViewViewFrame;
        _rootViewCoverViewForRightView.transform = transform;
    }
}

- (void)leftViewLayoutInvalidateWithPercentage:(CGFloat)percentage
{
    if (_leftView)
    {
        CGSize size = self.view.frame.size;
        
        if (kMACSideMenuSystemVersion < 8.0)
        {
            if (kMACSideMenuStatusBarOrientationIsPortrait)
                size = CGSizeMake(MIN(size.width, size.height), MAX(size.width, size.height));
            else
                size = CGSizeMake(MAX(size.width, size.height), MIN(size.width, size.height));
        }
        
        // -----
        
        _leftView.transform = CGAffineTransformIdentity;
        _backgroundImageView.transform = CGAffineTransformIdentity;
        _leftViewStyleView.transform = CGAffineTransformIdentity;
        
        // -----
        
        CGFloat originX = 0.f;
        CGAffineTransform leftViewTransform = CGAffineTransformIdentity;
        CGAffineTransform backgroundViewTransform = CGAffineTransformIdentity;
        
        if (!kMACSideMenuIsLeftViewAlwaysVisible)
        {
            _rootViewCoverViewForLeftView.alpha = percentage;
            _leftViewCoverView.alpha = 1.f-percentage;
            
            if (_leftViewPresentationStyle == MACSideMenuPresentationStyleSlideAbove)
                originX = -(_leftViewWidth+_leftViewStyleView.layer.shadowRadius*2)*(1.f-percentage);
            else
            {
                CGFloat leftViewScale = 1.f+(_leftViewInititialScale-1.f)*(1.f-percentage);
                CGFloat backgroundViewScale = 1.f+(_leftViewBackgroundImageInitialScale-1.f)*(1.f-percentage);
                
                leftViewTransform = CGAffineTransformMakeScale(leftViewScale, leftViewScale);
                backgroundViewTransform = CGAffineTransformMakeScale(backgroundViewScale, backgroundViewScale);
                
                originX = (-(_leftViewWidth*(1.f-leftViewScale)/2)+(_leftViewInititialOffsetX*leftViewScale))*(1.f-percentage);
            }
        }
        
        // -----
        
        CGRect leftViewFrame = CGRectMake(originX, 0.f, _leftViewWidth, size.height);
        if ([UIScreen mainScreen].scale == 1.f)
            leftViewFrame = CGRectIntegral(leftViewFrame);
        _leftView.frame = leftViewFrame;
        
        _leftView.transform = leftViewTransform;
        
        // -----
        
        if (_leftViewPresentationStyle != MACSideMenuPresentationStyleSlideAbove)
        {
            CGRect backgroundViewFrame = CGRectMake(0.f, 0.f, size.width, size.height);
            if ([UIScreen mainScreen].scale == 1.f)
                backgroundViewFrame = CGRectIntegral(backgroundViewFrame);
            _backgroundImageView.frame = backgroundViewFrame;
            
            _backgroundImageView.transform = backgroundViewTransform;
            
            // -----
            
            if (_leftViewCoverView)
            {
                CGRect leftViewCoverViewFrame = CGRectMake(0.f, 0.f, size.width, size.height);
                if ([UIScreen mainScreen].scale == 1.f)
                    leftViewCoverViewFrame = CGRectIntegral(leftViewCoverViewFrame);
                _leftViewCoverView.frame = leftViewCoverViewFrame;
            }
        }
        else
        {
            CGFloat borderWidth = _leftViewStyleView.layer.borderWidth;
            _leftViewStyleView.frame = CGRectMake(leftViewFrame.origin.x-borderWidth, leftViewFrame.origin.y-borderWidth, leftViewFrame.size.width+borderWidth*2, leftViewFrame.size.height+borderWidth*2);
            _leftViewStyleView.transform = leftViewTransform;
        }
    }
}

- (void)rightViewLayoutInvalidateWithPercentage:(CGFloat)percentage
{
    if (_rightView)
    {
        CGSize size = self.view.frame.size;
        
        if (kMACSideMenuSystemVersion < 8.0)
        {
            if (kMACSideMenuStatusBarOrientationIsPortrait)
                size = CGSizeMake(MIN(size.width, size.height), MAX(size.width, size.height));
            else
                size = CGSizeMake(MAX(size.width, size.height), MIN(size.width, size.height));
        }
        
        // -----
        
        _rightView.transform = CGAffineTransformIdentity;
        _backgroundImageView.transform = CGAffineTransformIdentity;
        _rightViewStyleView.transform = CGAffineTransformIdentity;
        
        // -----
        
        CGFloat originX = size.width-_rightViewWidth;
        CGAffineTransform rightViewTransform = CGAffineTransformIdentity;
        CGAffineTransform backgroundViewTransform = CGAffineTransformIdentity;
        
        if (!kMACSideMenuIsRightViewAlwaysVisible)
        {
            _rootViewCoverViewForRightView.alpha = percentage;
            _rightViewCoverView.alpha = 1.f-percentage;
            
            if (_rightViewPresentationStyle == MACSideMenuPresentationStyleSlideAbove)
                originX = size.width-_rightViewWidth+(_rightViewWidth+_rightViewStyleView.layer.shadowRadius*2)*(1.f-percentage);
            else
            {
                CGFloat rightViewScale = 1.f+(_rightViewInititialScale-1.f)*(1.f-percentage);
                CGFloat backgroundViewScale = 1.f+(_rightViewBackgroundImageInitialScale-1.f)*(1.f-percentage);
                
                rightViewTransform = CGAffineTransformMakeScale(rightViewScale, rightViewScale);
                backgroundViewTransform = CGAffineTransformMakeScale(backgroundViewScale, backgroundViewScale);
                
                originX = size.width-_rightViewWidth+((_rightViewWidth*(1.f-rightViewScale)/2)+(_rightViewInititialOffsetX*rightViewScale))*(1.f-percentage);
            }
        }
        
        // -----
        
        CGRect rightViewFrame = CGRectMake(originX, 0.f, _rightViewWidth, size.height);
        if ([UIScreen mainScreen].scale == 1.f)
            rightViewFrame = CGRectIntegral(rightViewFrame);
        _rightView.frame = rightViewFrame;
        
        _rightView.transform = rightViewTransform;
        
        // -----
        
        if (_rightViewPresentationStyle != MACSideMenuPresentationStyleSlideAbove)
        {
            CGRect backgroundViewFrame = CGRectMake(0.f, 0.f, size.width, size.height);
            if ([UIScreen mainScreen].scale == 1.f)
                backgroundViewFrame = CGRectIntegral(backgroundViewFrame);
            _backgroundImageView.frame = backgroundViewFrame;
            
            _backgroundImageView.transform = backgroundViewTransform;
            
            // -----
            
            if (_rightViewCoverView)
            {
                CGRect rightViewCoverViewFrame = CGRectMake(0.f, 0.f, size.width, size.height);
                if ([UIScreen mainScreen].scale == 1.f)
                    rightViewCoverViewFrame = CGRectIntegral(rightViewCoverViewFrame);
                _rightViewCoverView.frame = rightViewCoverViewFrame;
            }
        }
        else
        {
            CGFloat borderWidth = _rightViewStyleView.layer.borderWidth;
            _rightViewStyleView.frame = CGRectMake(rightViewFrame.origin.x-borderWidth, rightViewFrame.origin.y-borderWidth, rightViewFrame.size.width+borderWidth*2, rightViewFrame.size.height+borderWidth*2);
            _rightViewStyleView.transform = rightViewTransform;
        }
    }
}

- (void)colorsInvalidate
{
    _rootVC.view.layer.cornerRadius = 0.f;
    _rootVC.view.layer.borderWidth = 0.f;
    _rootVC.view.layer.borderColor = nil;
    _rootVC.view.layer.shadowColor = nil;
    _rootVC.view.layer.shadowOpacity = 0.f;
    _rootVC.view.layer.shadowRadius = 0.f;
    _rootVC.view.layer.shadowOffset = CGSizeZero;
    
    if (_rootViewStyleView)
    {
        _rootViewStyleView.layer.borderWidth = _rootViewLayerBorderWidth;
        _rootViewStyleView.layer.borderColor = _rootViewLayerBorderColor.CGColor;
        _rootViewStyleView.layer.shadowColor = _rootViewLayerShadowColor.CGColor;
        _rootViewStyleView.layer.shadowRadius = _rootViewLayerShadowRadius;
    }
    
    if (kMACSideMenuIsLeftViewAlwaysVisible || self.isLeftViewShowing)
    {
        _leftView.backgroundColor = [UIColor clearColor];
        _leftView.layer.cornerRadius = 0.f;
        _leftView.layer.borderWidth = 0.f;
        _leftView.layer.borderColor = nil;
        _leftView.layer.shadowColor = nil;
        _leftView.layer.shadowOpacity = 0.f;
        _leftView.layer.shadowRadius = 0.f;
        _leftView.layer.shadowOffset = CGSizeZero;
        
        self.view.backgroundColor = [_leftViewBackgroundColor colorWithAlphaComponent:1.f];
        
        _rootViewCoverViewForLeftView.backgroundColor = _rootViewCoverColorForLeftView;
        
        if (_leftViewCoverView)
            _leftViewCoverView.backgroundColor = _leftViewCoverColor;
        
        if (_leftViewStyleView)
        {
            _leftViewStyleView.backgroundColor = (kMACSideMenuIsLeftViewAlwaysVisible ? [_leftViewBackgroundColor colorWithAlphaComponent:1.f] : _leftViewBackgroundColor);
            _leftViewStyleView.layer.borderWidth = _leftViewLayerBorderWidth;
            _leftViewStyleView.layer.borderColor = _leftViewLayerBorderColor.CGColor;
            _leftViewStyleView.layer.shadowColor = _leftViewLayerShadowColor.CGColor;
            _leftViewStyleView.layer.shadowRadius = _leftViewLayerShadowRadius;
        }
        
        if (_leftViewBackgroundImage)
            _backgroundImageView.image = _leftViewBackgroundImage;
    }
    
    if (kMACSideMenuIsRightViewAlwaysVisible || self.isRightViewShowing)
    {
        _rightView.backgroundColor = [UIColor clearColor];
        _rightView.layer.cornerRadius = 0.f;
        _rightView.layer.borderWidth = 0.f;
        _rightView.layer.borderColor = nil;
        _rightView.layer.shadowColor = nil;
        _rightView.layer.shadowOpacity = 0.f;
        _rightView.layer.shadowRadius = 0.f;
        _rightView.layer.shadowOffset = CGSizeZero;
        
        self.view.backgroundColor = [_rightViewBackgroundColor colorWithAlphaComponent:1.f];
        
        _rootViewCoverViewForRightView.backgroundColor = _rootViewCoverColorForRightView;
        
        if (_rightViewCoverView)
            _rightViewCoverView.backgroundColor = (_rightViewCoverColor ? _rightViewCoverColor : kMACSideMenuCoverColor);
        
        if (_rightViewStyleView)
        {
            _rightViewStyleView.backgroundColor = (kMACSideMenuIsRightViewAlwaysVisible ? [_rightViewBackgroundColor colorWithAlphaComponent:1.f] : _rightViewBackgroundColor);
            _rightViewStyleView.layer.borderWidth = _rightViewLayerBorderWidth;
            _rightViewStyleView.layer.borderColor = _rightViewLayerBorderColor.CGColor;
            _rightViewStyleView.layer.shadowColor = _rightViewLayerShadowColor.CGColor;
            _rightViewStyleView.layer.shadowRadius = _rightViewLayerShadowRadius;
        }
        
        if (_rightViewBackgroundImage)
            _backgroundImageView.image = _rightViewBackgroundImage;
    }
}

- (void)hiddensInvalidate
{
    [self hiddensInvalidateWithDelay:0.0];
}

- (void)hiddensInvalidateWithDelay:(NSTimeInterval)delay
{
    BOOL rootViewStyleViewHiddenForLeftView = YES;
    BOOL rootViewStyleViewHiddenForRightView = YES;
    
    BOOL backgroundImageViewHiddenForLeftView = YES;
    BOOL backgroundImageViewHiddenForRightView = YES;
    
    // -----
    
    if (kMACSideMenuIsLeftViewAlwaysVisible)
    {
        _rootViewCoverViewForLeftView.hidden = YES;
        _leftViewCoverView.hidden = YES;
        
        _leftView.hidden = NO;
        _leftViewStyleView.hidden = NO;
        rootViewStyleViewHiddenForLeftView = NO;
        
        if (_leftViewBackgroundImage)
            backgroundImageViewHiddenForLeftView = NO;
    }
    else if (!self.isLeftViewShowing)
    {
        if (delay)
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void)
                           {
                               _rootViewCoverViewForLeftView.hidden = YES;
                               _leftViewCoverView.hidden = YES;
                               _leftView.hidden = YES;
                               _leftViewStyleView.hidden = YES;
                           });
        }
        else
        {
            _rootViewCoverViewForLeftView.hidden = YES;
            _leftViewCoverView.hidden = YES;
            _leftView.hidden = YES;
            _leftViewStyleView.hidden = YES;
        }
        
        rootViewStyleViewHiddenForLeftView = YES;
        backgroundImageViewHiddenForLeftView = YES;
    }
    else if (self.isLeftViewShowing)
    {
        _rootViewCoverViewForLeftView.hidden = NO;
        _leftViewCoverView.hidden = NO;
        _leftView.hidden = NO;
        _leftViewStyleView.hidden = NO;
        rootViewStyleViewHiddenForLeftView = NO;
        
        if (_leftViewBackgroundImage)
            backgroundImageViewHiddenForLeftView = NO;
    }
    
    // -----
    
    if (kMACSideMenuIsRightViewAlwaysVisible)
    {
        _rootViewCoverViewForRightView.hidden = YES;
        _rightViewCoverView.hidden = YES;
        
        _rightView.hidden = NO;
        _rightViewStyleView.hidden = NO;
        rootViewStyleViewHiddenForRightView = NO;
        
        if (_rightViewBackgroundImage)
            backgroundImageViewHiddenForRightView = NO;
    }
    else if (!self.isRightViewShowing)
    {
        if (delay)
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void)
                           {
                               _rootViewCoverViewForRightView.hidden = YES;
                               _rightViewCoverView.hidden = YES;
                               _rightView.hidden = YES;
                               _rightViewStyleView.hidden = YES;
                           });
        }
        else
        {
            _rootViewCoverViewForRightView.hidden = YES;
            _rightViewCoverView.hidden = YES;
            _rightView.hidden = YES;
            _rightViewStyleView.hidden = YES;
        }
        
        rootViewStyleViewHiddenForRightView = YES;
        backgroundImageViewHiddenForRightView = YES;
    }
    else if (self.isRightViewShowing)
    {
        _rootViewCoverViewForRightView.hidden = NO;
        _rightViewCoverView.hidden = NO;
        _rightView.hidden = NO;
        _rightViewStyleView.hidden = NO;
        rootViewStyleViewHiddenForRightView = NO;
        
        if (_rightViewBackgroundImage)
            backgroundImageViewHiddenForRightView = NO;
    }
    
    // -----
    
    if (rootViewStyleViewHiddenForLeftView && rootViewStyleViewHiddenForRightView)
    {
        if (delay)
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void)
                           {
                               _rootViewStyleView.hidden = YES;
                           });
        }
        else _rootViewStyleView.hidden = (rootViewStyleViewHiddenForLeftView && rootViewStyleViewHiddenForRightView);
    }
    else _rootViewStyleView.hidden = NO;
    
    if (backgroundImageViewHiddenForLeftView && backgroundImageViewHiddenForRightView)
    {
        if (delay)
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void)
                           {
                               _backgroundImageView.hidden = YES;
                           });
        }
        else _backgroundImageView.hidden = YES;
    }
    else _backgroundImageView.hidden = NO;
}

#pragma mark - Side Views

- (void)setLeftViewEnabledWithWidth:(CGFloat)width
                  presentationStyle:(MACSideMenuPresentationStyle)presentationStyle
               alwaysVisibleOptions:(MACSideMenuAlwaysVisibleOptions)alwaysVisibleOptions
{
    if (!_leftView)
    {
        _rootViewCoverViewForLeftView = [UIView new];
        _rootViewCoverViewForLeftView.hidden = YES;
        if (_rootVC)
        {
            if (_rootViewCoverViewForRightView)
                [self.view insertSubview:_rootViewCoverViewForLeftView aboveSubview:_rootViewCoverViewForRightView];
            else
                [self.view addSubview:_rootViewCoverViewForLeftView];
        }
        
        // -----
        
        __weak typeof(self) wself = self;
        
        _leftView = [[MACSideMenuView alloc] initWithLayoutSubviewsHandler:^(void)
                     {
                         if (wself)
                         {
                             __strong typeof(wself) self = wself;
                             
                             CGSize size = self.view.frame.size;
                             
                             if (kMACSideMenuSystemVersion < 8.0)
                             {
                                 if (kMACSideMenuStatusBarOrientationIsPortrait)
                                     size = CGSizeMake(MIN(size.width, size.height), MAX(size.width, size.height));
                                 else
                                     size = CGSizeMake(MAX(size.width, size.height), MIN(size.width, size.height));
                             }
                             
                             [self leftViewWillLayoutSubviewsWithSize:CGSizeMake(_leftViewWidth, size.height)];
                         }
                     }];
        _leftView.backgroundColor = [UIColor clearColor];
        _leftView.hidden = YES;
        if (_rootVC)
        {
            if (presentationStyle == MACSideMenuPresentationStyleSlideAbove)
                [self.view addSubview:_leftView];
            else
                [self.view insertSubview:_leftView belowSubview:_rootVC.view];
        }
        
        // -----
        
        _leftViewWidth = width;
        
        _leftViewPresentationStyle = presentationStyle;
        
        _leftViewAlwaysVisibleOptions = alwaysVisibleOptions;
        
        // -----
        
        if (presentationStyle != MACSideMenuPresentationStyleSlideAbove)
        {
            _leftViewCoverView = [UIView new];
            _leftViewCoverView.hidden = YES;
            [self.view insertSubview:_leftViewCoverView aboveSubview:_leftView];
        }
        else
        {
            _leftViewStyleView = [UIView new];
            _leftViewStyleView.hidden = YES;
            _leftViewStyleView.layer.masksToBounds = NO;
            _leftViewStyleView.layer.shadowOffset = CGSizeZero;
            _leftViewStyleView.layer.shadowOpacity = 1.f;
            _leftViewStyleView.layer.shouldRasterize = YES;
            [self.view insertSubview:_leftViewStyleView belowSubview:_leftView];
        }
        
        // -----
        
        [_rootViewStyleView removeFromSuperview];
        [self.view insertSubview:_rootViewStyleView belowSubview:_rootVC.view];
        
        // -----
        
        if (_leftViewPresentationStyle == MACSideMenuPresentationStyleSlideAbove || _leftViewPresentationStyle == MACSideMenuPresentationStyleSlideBelow)
            _rootViewScaleForLeftView = 1.f;
        else
            _rootViewScaleForLeftView = 0.8;
        
        // -----
        
        if (_leftViewPresentationStyle == MACSideMenuPresentationStyleSlideAbove)
            _rootViewCoverColorForLeftView = kMACSideMenuCoverColor;
        else
            _leftViewCoverColor = kMACSideMenuCoverColor;
        
        // -----
        
        if (_leftViewPresentationStyle == MACSideMenuPresentationStyleSlideBelow || _leftViewPresentationStyle == MACSideMenuPresentationStyleSlideAbove)
            _leftViewBackgroundImageInitialScale = 1.f;
        else
            _leftViewBackgroundImageInitialScale = 1.4;
        
        // -----
        
        if (_leftViewPresentationStyle == MACSideMenuPresentationStyleSlideBelow || _leftViewPresentationStyle == MACSideMenuPresentationStyleSlideAbove)
            _leftViewInititialScale = 1.f;
        else if (_leftViewPresentationStyle == MACSideMenuPresentationStyleScaleFromBig)
            _leftViewInititialScale = 1.2;
        else
            _leftViewInititialScale = 0.8;
        
        // -----
        
        if (_leftViewPresentationStyle == MACSideMenuPresentationStyleSlideBelow)
            _leftViewInititialOffsetX = -_leftViewWidth/2;
        
        // -----
        
        [self leftViewLayoutInvalidateWithPercentage:0.f];
    }
    else NSLog(@"MACSideMenuController WARNING: Left view is already enabled");
}

- (void)setRightViewEnabledWithWidth:(CGFloat)width
                   presentationStyle:(MACSideMenuPresentationStyle)presentationStyle
                alwaysVisibleOptions:(MACSideMenuAlwaysVisibleOptions)alwaysVisibleOptions
{
    if (!_rightView)
    {
        _rootViewCoverViewForRightView = [UIView new];
        _rootViewCoverViewForRightView.hidden = YES;
        if (_rootVC)
        {
            if (_rootViewCoverViewForLeftView)
                [self.view insertSubview:_rootViewCoverViewForRightView aboveSubview:_rootViewCoverViewForLeftView];
            else
                [self.view addSubview:_rootViewCoverViewForRightView];
        }
        
        // -----
        
        __weak typeof(self) wself = self;
        
        _rightView = [[MACSideMenuView alloc] initWithLayoutSubviewsHandler:^(void)
                      {
                          if (wself)
                          {
                              __strong typeof(wself) self = wself;
                              
                              CGSize size = self.view.frame.size;
                              
                              if (kMACSideMenuSystemVersion < 8.0)
                              {
                                  if (kMACSideMenuStatusBarOrientationIsPortrait)
                                      size = CGSizeMake(MIN(size.width, size.height), MAX(size.width, size.height));
                                  else
                                      size = CGSizeMake(MAX(size.width, size.height), MIN(size.width, size.height));
                              }
                              
                              [self rightViewWillLayoutSubviewsWithSize:CGSizeMake(_rightViewWidth, size.height)];
                          }
                      }];
        _rightView.backgroundColor = [UIColor clearColor];
        _rightView.hidden = YES;
        if (_rootVC)
        {
            if (presentationStyle == MACSideMenuPresentationStyleSlideAbove)
                [self.view addSubview:_rightView];
            else
                [self.view insertSubview:_rightView belowSubview:_rootVC.view];
        }
        
        // -----
        
        _rightViewWidth = width;
        
        _rightViewPresentationStyle = presentationStyle;
        
        _rightViewAlwaysVisibleOptions = alwaysVisibleOptions;
        
        // -----
        
        if (presentationStyle != MACSideMenuPresentationStyleSlideAbove)
        {
            _rightViewCoverView = [UIView new];
            _rightViewCoverView.hidden = YES;
            [self.view insertSubview:_rightViewCoverView aboveSubview:_rightView];
        }
        else
        {
            _rightViewStyleView = [UIView new];
            _rightViewStyleView.hidden = YES;
            _rightViewStyleView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.9];
            _rightViewStyleView.layer.masksToBounds = NO;
            _rightViewStyleView.layer.borderWidth = 2.f;
            _rightViewStyleView.layer.borderColor = [UIColor colorWithRed:0.f green:0.5 blue:1.f alpha:1.f].CGColor;
            _rightViewStyleView.layer.shadowColor = [UIColor colorWithWhite:0.f alpha:0.5].CGColor;
            _rightViewStyleView.layer.shadowOffset = CGSizeZero;
            _rightViewStyleView.layer.shadowOpacity = 1.f;
            _rightViewStyleView.layer.shadowRadius = 5.f;
            _rightViewStyleView.layer.shouldRasterize = YES;
            [self.view insertSubview:_rightViewStyleView belowSubview:_rightView];
        }
        
        // -----
        
        [_rootViewStyleView removeFromSuperview];
        [self.view insertSubview:_rootViewStyleView belowSubview:_rootVC.view];
        
        // -----
        
        if (_rightViewPresentationStyle == MACSideMenuPresentationStyleSlideAbove || _rightViewPresentationStyle == MACSideMenuPresentationStyleSlideBelow)
            _rootViewScaleForRightView = 1.f;
        else
            _rootViewScaleForRightView = 0.8;
        
        // -----
        
        if (_rightViewPresentationStyle == MACSideMenuPresentationStyleSlideAbove)
            _rootViewCoverColorForRightView = kMACSideMenuCoverColor;
        else
            _rightViewCoverColor = kMACSideMenuCoverColor;
        
        // -----
        
        if (_rightViewPresentationStyle == MACSideMenuPresentationStyleSlideBelow || _rightViewPresentationStyle == MACSideMenuPresentationStyleSlideAbove)
            _rightViewBackgroundImageInitialScale = 1.f;
        else
            _rightViewBackgroundImageInitialScale = 1.4;
        
        // -----
        
        if (_rightViewPresentationStyle == MACSideMenuPresentationStyleSlideBelow || _rightViewPresentationStyle == MACSideMenuPresentationStyleSlideAbove)
            _rightViewInititialScale = 1.f;
        else if (_rightViewPresentationStyle == MACSideMenuPresentationStyleScaleFromBig)
            _rightViewInititialScale = 1.2;
        else
            _rightViewInititialScale = 0.8;
        
        // -----
        
        if (_rightViewPresentationStyle == MACSideMenuPresentationStyleSlideBelow)
            _rightViewInititialOffsetX = _rightViewWidth/2;
        
        // -----
        
        [self rightViewLayoutInvalidateWithPercentage:0.f];
    }
    else NSLog(@"MACSideMenuController WARNING: Right view is already enabled");
}

#pragma mark - Show Hide

- (void)showLeftViewPrepare
{
    [self.view endEditing:YES];
    
    // -----
    
    if (kMACSideMenuSystemVersion >= 7.0 && !self.isRightViewShowing)
    {
        _savedStatusBarHidden = kMACSideMenuStatusBarHidden;
        
        if (!kMACSideMenuStatusBarHidden && !kMACSideMenuIsLeftViewStatusBarVisible)
        {
            [_rootVC removeFromParentViewController];
            
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_9_0
            if (kMACSideMenuSystemVersion < 9.0)
                [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
#endif
            _currentStatusBarHidden = YES;
            [self setNeedsStatusBarAppearanceUpdate];
        }
    }
    
    // -----
    
    [self leftViewLayoutInvalidateWithPercentage:0.f];
    
    _leftViewShowing = YES;
    
    [self colorsInvalidate];
    [self hiddensInvalidate];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMACSideMenuControllerWillShowLeftViewNotification object:self userInfo:nil];
}

- (void)showLeftViewAnimated:(BOOL)animated completionHandler:(void(^)())completionHandler
{
    if (!kMACSideMenuIsLeftViewAlwaysVisible && !self.isLeftViewShowing)
    {
        [self showLeftViewPrepare];
        
        [self showLeftViewAnimated:animated fromPercentage:0.f completionHandler:completionHandler];
    }
}

- (void)showLeftViewAnimated:(BOOL)animated fromPercentage:(CGFloat)percentage completionHandler:(void(^)())completionHandler
{
    if (animated)
    {
        [MACSideMenuController animateStandardWithDuration:0.5//*(1.f-percentage)
                                                animations:^(void)
         {
             [self rootViewLayoutInvalidateWithPercentage:1.f];
             [self leftViewLayoutInvalidateWithPercentage:1.f];
         }
                                                completion:^(BOOL finished)
         {
             if (finished)
                 [self hiddensInvalidate];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kMACSideMenuControllerDidShowLeftViewNotification object:self userInfo:nil];
             
             if (completionHandler) completionHandler();
         }];
    }
    else
    {
        [self rootViewLayoutInvalidateWithPercentage:1.f];
        [self leftViewLayoutInvalidateWithPercentage:1.f];
        
        [self hiddensInvalidate];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kMACSideMenuControllerDidShowLeftViewNotification object:self userInfo:nil];
        
        if (completionHandler) completionHandler();
    }
}

- (void)hideLeftViewDone
{
    if (kMACSideMenuSystemVersion >= 7.0 && !_savedStatusBarHidden && kMACSideMenuStatusBarHidden && !self.isRightViewShowing)
    {
        [self addChildViewController:_rootVC];
        
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_9_0
        if (kMACSideMenuSystemVersion < 9.0)
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
#endif
        _currentStatusBarHidden = NO;
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)hideLeftViewAnimated:(BOOL)animated completionHandler:(void(^)())completionHandler
{
    if (!kMACSideMenuIsLeftViewAlwaysVisible && self.isLeftViewShowing)
        [self hideLeftViewAnimated:animated fromPercentage:1.f completionHandler:completionHandler];
}

- (void)hideLeftViewAnimated:(BOOL)animated fromPercentage:(CGFloat)percentage completionHandler:(void(^)())completionHandler
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kMACSideMenuControllerWillDismissLeftViewNotification object:self userInfo:nil];
    
    if (animated)
    {
        [MACSideMenuController animateStandardWithDuration:0.5//*percentage
                                                animations:^(void)
         {
             [self rootViewLayoutInvalidateWithPercentage:0.f];
             [self leftViewLayoutInvalidateWithPercentage:0.f];
         }
                                                completion:^(BOOL finished)
         {
             [self hideLeftViewDone];
             
             _leftViewShowing = NO;
             
             if (finished)
                 [self hiddensInvalidate];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kMACSideMenuControllerDidDismissLeftViewNotification object:self userInfo:nil];
             
             if (completionHandler) completionHandler();
         }];
    }
    else
    {
        [self rootViewLayoutInvalidateWithPercentage:0.f];
        [self leftViewLayoutInvalidateWithPercentage:0.f];
        
        [self hideLeftViewDone];
        
        _leftViewShowing = NO;
        
        [self hiddensInvalidate];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kMACSideMenuControllerDidDismissLeftViewNotification object:self userInfo:nil];
        
        if (completionHandler) completionHandler();
    }
}

- (void)hideLeftViewComleteAfterGesture
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kMACSideMenuControllerWillDismissLeftViewNotification object:self userInfo:nil];
    
    [self hideLeftViewDone];
    
    _leftViewShowing = NO;
    
    [self hiddensInvalidate];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMACSideMenuControllerDidDismissLeftViewNotification object:self userInfo:nil];
}

- (void)showHideLeftViewAnimated:(BOOL)animated completionHandler:(void (^)())completionHandler
{
    if (!kMACSideMenuIsLeftViewAlwaysVisible)
    {
        if (self.isLeftViewShowing)
            [self hideLeftViewAnimated:animated completionHandler:completionHandler];
        else
            [self showLeftViewAnimated:animated completionHandler:completionHandler];
    }
}

#pragma mark -

- (void)showRightViewPrepare
{
    [self.view endEditing:YES];
    
    // -----
    
    if (kMACSideMenuSystemVersion >= 7.0 && !self.isLeftViewShowing)
    {
        _savedStatusBarHidden = kMACSideMenuStatusBarHidden;
        
        if (!kMACSideMenuStatusBarHidden && !kMACSideMenuIsRightViewStatusBarVisible)
        {
            [_rootVC removeFromParentViewController];
            
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_9_0
            if (kMACSideMenuSystemVersion < 9.0)
                [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
#endif
            _currentStatusBarHidden = YES;
            [self setNeedsStatusBarAppearanceUpdate];
        }
    }
    
    // -----
    
    [self rightViewLayoutInvalidateWithPercentage:0.f];
    
    _rightViewShowing = YES;
    
    [self colorsInvalidate];
    [self hiddensInvalidate];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMACSideMenuControllerWillShowRightViewNotification object:self userInfo:nil];
}

- (void)showRightViewAnimated:(BOOL)animated completionHandler:(void(^)())completionHandler
{
    if (!kMACSideMenuIsRightViewAlwaysVisible && !self.isRightViewShowing)
    {
        [self showRightViewPrepare];
        
        [self showRightViewAnimated:animated fromPercentage:0.f completionHandler:completionHandler];
    }
}

- (void)showRightViewAnimated:(BOOL)animated fromPercentage:(CGFloat)percentage completionHandler:(void(^)())completionHandler
{
    if (animated)
    {
        [MACSideMenuController animateStandardWithDuration:0.5//*(1.f-percentage)
                                                animations:^(void)
         {
             [self rootViewLayoutInvalidateWithPercentage:1.f];
             [self rightViewLayoutInvalidateWithPercentage:1.f];
         }
                                                completion:^(BOOL finished)
         {
             if (finished)
                 [self hiddensInvalidate];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kMACSideMenuControllerDidShowRightViewNotification object:self userInfo:nil];
             
             if (completionHandler) completionHandler();
         }];
    }
    else
    {
        [self rootViewLayoutInvalidateWithPercentage:1.f];
        [self rightViewLayoutInvalidateWithPercentage:1.f];
        
        [self hiddensInvalidate];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kMACSideMenuControllerDidShowRightViewNotification object:self userInfo:nil];
        
        if (completionHandler) completionHandler();
    }
}

- (void)hideRightViewDone
{
    if (kMACSideMenuSystemVersion >= 7.0 && !_savedStatusBarHidden && kMACSideMenuStatusBarHidden && !self.isLeftViewShowing)
    {
        [self addChildViewController:_rootVC];
        
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_9_0
        if (kMACSideMenuSystemVersion < 9.0)
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
#endif
        _currentStatusBarHidden = NO;
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)hideRightViewAnimated:(BOOL)animated completionHandler:(void(^)())completionHandler
{
    if (!kMACSideMenuIsRightViewAlwaysVisible && self.isRightViewShowing)
        [self hideRightViewAnimated:animated fromPercentage:1.f completionHandler:completionHandler];
}

- (void)hideRightViewAnimated:(BOOL)animated fromPercentage:(CGFloat)percentage completionHandler:(void(^)())completionHandler
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kMACSideMenuControllerWillDismissRightViewNotification object:self userInfo:nil];
    
    if (animated)
    {
        [MACSideMenuController animateStandardWithDuration:0.5//*percentage
                                                animations:^(void)
         {
             [self rootViewLayoutInvalidateWithPercentage:0.f];
             [self rightViewLayoutInvalidateWithPercentage:0.f];
         }
                                                completion:^(BOOL finished)
         {
             [self hideRightViewDone];
             
             _rightViewShowing = NO;
             
             if (finished)
                 [self hiddensInvalidate];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kMACSideMenuControllerDidDismissRightViewNotification object:self userInfo:nil];
             
             if (completionHandler) completionHandler();
         }];
    }
    else
    {
        [self rootViewLayoutInvalidateWithPercentage:0.f];
        [self rightViewLayoutInvalidateWithPercentage:0.f];
        
        [self hideRightViewDone];
        
        _rightViewShowing = NO;
        
        [self hiddensInvalidate];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kMACSideMenuControllerDidDismissRightViewNotification object:self userInfo:nil];
        
        if (completionHandler) completionHandler();
    }
}

- (void)hideRightViewComleteAfterGesture
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kMACSideMenuControllerWillDismissRightViewNotification object:self userInfo:nil];
    
    [self hideRightViewDone];
    
    [self hiddensInvalidate];
    
    _rightViewShowing = NO;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMACSideMenuControllerDidDismissRightViewNotification object:self userInfo:nil];
}

- (void)showHideRightViewAnimated:(BOOL)animated completionHandler:(void (^)())completionHandler
{
    if (!kMACSideMenuIsRightViewAlwaysVisible)
    {
        if (self.isRightViewShowing)
            [self hideRightViewAnimated:animated completionHandler:completionHandler];
        else
            [self showRightViewAnimated:animated completionHandler:completionHandler];
    }
}

#pragma mark - UIGestureRecognizers

- (void)tapGesture:(UITapGestureRecognizer *)gesture
{
    [self hideLeftViewAnimated:YES completionHandler:nil];
    [self hideRightViewAnimated:YES completionHandler:nil];
}

- (void)panGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint location = [gestureRecognizer locationInView:self.view];
    CGPoint velocity = [gestureRecognizer velocityInView:self.view];
    
    // -----
    
    CGSize size = self.view.frame.size;
    
    if (kMACSideMenuSystemVersion < 8.0)
    {
        if (kMACSideMenuStatusBarOrientationIsPortrait)
            size = CGSizeMake(MIN(size.width, size.height), MAX(size.width, size.height));
        else
            size = CGSizeMake(MAX(size.width, size.height), MIN(size.width, size.height));
    }
    
    // -----
    
    if (_leftView && self.isLeftViewSwipeGestureEnabled && !kMACSideMenuIsLeftViewAlwaysVisible && !_rightViewGestireStartX && !self.isRightViewShowing)
    {
        if (!_leftViewGestireStartX && (gestureRecognizer.state == UIGestureRecognizerStateBegan || gestureRecognizer.state == UIGestureRecognizerStateChanged))
        {
            CGFloat interactiveX = (self.isLeftViewShowing ? _leftViewWidth : 0.f);
            BOOL velocityDone = (self.isLeftViewShowing ? velocity.x < 0.f : velocity.x > 0.f);
            CGFloat shift = (self.isLeftViewShowing ? 22.f : 44.f);
            
            if (velocityDone && location.x >= interactiveX-44.f && location.x <= interactiveX+shift)
            {
                _leftViewGestireStartX = [NSNumber numberWithFloat:location.x];
                _leftViewShowingBeforeGesture = _leftViewShowing;
                
                if (!self.isLeftViewShowing)
                    [self showLeftViewPrepare];
            }
        }
        else if (_leftViewGestireStartX)
        {
            CGFloat firstVar = (self.isLeftViewShowingBeforeGesture ?
                                location.x+(_leftViewWidth-_leftViewGestireStartX.floatValue) :
                                location.x-_leftViewGestireStartX.floatValue);
            CGFloat percentage = firstVar/_leftViewWidth;
            
            if (percentage < 0.f) percentage = 0.f;
            else if (percentage > 1.f) percentage = 1.f;
            
            if (gestureRecognizer.state == UIGestureRecognizerStateChanged)
            {
                [self rootViewLayoutInvalidateWithPercentage:percentage];
                [self leftViewLayoutInvalidateWithPercentage:percentage];
            }
            else if (gestureRecognizer.state == UIGestureRecognizerStateEnded && _leftViewGestireStartX)
            {
                if ((percentage < 1.f && velocity.x > 0.f) || (velocity.x == 0.f && percentage >= 0.5))
                    [self showLeftViewAnimated:YES fromPercentage:percentage completionHandler:nil];
                else if ((percentage > 0.f && velocity.x < 0.f) || (velocity.x == 0.f && percentage < 0.5))
                    [self hideLeftViewAnimated:YES fromPercentage:percentage completionHandler:nil];
                else if (percentage == 0.f)
                    [self hideLeftViewComleteAfterGesture];
                else if (percentage == 1.f)
                    [[NSNotificationCenter defaultCenter] postNotificationName:kMACSideMenuControllerDidShowLeftViewNotification object:self userInfo:nil];
                
                _leftViewGestireStartX = nil;
            }
        }
    }
    
    // -----
    
    if (_rightView && self.isRightViewSwipeGestureEnabled && !kMACSideMenuIsRightViewAlwaysVisible && !_leftViewGestireStartX && !self.isLeftViewShowing)
    {
        if (!_rightViewGestireStartX && (gestureRecognizer.state == UIGestureRecognizerStateBegan || gestureRecognizer.state == UIGestureRecognizerStateChanged))
        {
            CGFloat interactiveX = (self.isRightViewShowing ? size.width-_rightViewWidth : size.width);
            BOOL velocityDone = (self.isRightViewShowing ? velocity.x > 0.f : velocity.x < 0.f);
            CGFloat shift = (self.isRightViewShowing ? 22.f : 44.f);
            
            if (velocityDone && location.x >= interactiveX-shift && location.x <= interactiveX+44.f)
            {
                _rightViewGestireStartX = [NSNumber numberWithFloat:location.x];
                _rightViewShowingBeforeGesture = _rightViewShowing;
                
                if (!self.isRightViewShowing)
                    [self showRightViewPrepare];
            }
        }
        else if (_rightViewGestireStartX)
        {
            CGFloat firstVar = (self.isRightViewShowingBeforeGesture ?
                                (location.x-(size.width-_rightViewWidth))-(_rightViewWidth-(size.width-_rightViewGestireStartX.floatValue)) :
                                (location.x-(size.width-_rightViewWidth))+(size.width-_rightViewGestireStartX.floatValue));
            CGFloat percentage = 1.f-firstVar/_rightViewWidth;
            
            if (percentage < 0.f) percentage = 0.f;
            else if (percentage > 1.f) percentage = 1.f;
            
            if (gestureRecognizer.state == UIGestureRecognizerStateChanged)
            {
                [self rootViewLayoutInvalidateWithPercentage:percentage];
                [self rightViewLayoutInvalidateWithPercentage:percentage];
            }
            else if (gestureRecognizer.state == UIGestureRecognizerStateEnded && _rightViewGestireStartX)
            {
                if ((percentage < 1.f && velocity.x < 0.f) || (velocity.x == 0.f && percentage >= 0.5))
                    [self showRightViewAnimated:YES fromPercentage:percentage completionHandler:nil];
                else if ((percentage > 0.f && velocity.x > 0.f) || (velocity.x == 0.f && percentage < 0.5))
                    [self hideRightViewAnimated:YES fromPercentage:percentage completionHandler:nil];
                else if (percentage == 0.f)
                    [self hideRightViewComleteAfterGesture];
                else if (percentage == 1.f)
                    [[NSNotificationCenter defaultCenter] postNotificationName:kMACSideMenuControllerDidShowRightViewNotification object:self userInfo:nil];
                
                _rightViewGestireStartX = nil;
            }
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return ([touch.view isEqual:_rootViewCoverViewForLeftView] || [touch.view isEqual:_rootViewCoverViewForRightView]);
}

#pragma mark - Support

+ (void)animateStandardWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion
{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
    {
        [UIView animateWithDuration:duration
                              delay:0.0
             usingSpringWithDamping:1.f
              initialSpringVelocity:0.5
                            options:0
                         animations:animations
                         completion:completion];
    }
    else
    {
        [UIView animateWithDuration:duration*0.66
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:animations
                         completion:completion];
    }
}

@end


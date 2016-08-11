

#import <UIKit/UIKit.h>

/**
 Provides extensions for `UIScrollView`.
 */
@interface UIScrollView (Additions)

/**
 Scroll content to top with animation.
 */
- (void)lf_scrollToTop;

/**
 Scroll content to bottom with animation.
 */
- (void)lf_scrollToBottom;

/**
 Scroll content to left with animation.
 */
- (void)lf_scrollToLeft;

/**
 Scroll content to right with animation.
 */
- (void)lf_scrollToRight;

/**
 Scroll content to top.
 
 @param animated  Use animation.
 */
- (void)lf_scrollToTopAnimated:(BOOL)animated;

/**
 Scroll content to bottom.
 
 @param animated  Use animation.
 */
- (void)lf_scrollToBottomAnimated:(BOOL)animated;

/**
 Scroll content to left.
 
 @param animated  Use animation.
 */
- (void)lf_scrollToLeftAnimated:(BOOL)animated;

/**
 Scroll content to right.
 
 @param animated  Use animation.
 */
- (void)lf_scrollToRightAnimated:(BOOL)animated;

@end

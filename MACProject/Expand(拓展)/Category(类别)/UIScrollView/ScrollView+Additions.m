
#import "ScrollView+Additions.h"


@implementation UIScrollView (Additions)

- (void)lf_scrollToTop {
    [self lf_scrollToTopAnimated:YES];
}

- (void)lf_scrollToBottom {
    [self lf_scrollToBottomAnimated:YES];
}

- (void)lf_scrollToLeft {
    [self lf_scrollToLeftAnimated:YES];
}

- (void)lf_scrollToRight {
    [self lf_scrollToRightAnimated:YES];
}

- (void)lf_scrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

- (void)lf_scrollToBottomAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

- (void)lf_scrollToLeftAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = 0 - self.contentInset.left;
    [self setContentOffset:off animated:animated];
}

- (void)lf_scrollToRightAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:off animated:animated];
}

@end

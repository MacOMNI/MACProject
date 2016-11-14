//
//  NewCarouselListCell.m
//  MACProject
//
//  Created by MacKun on 16/8/15.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "NewCarouselListCell.h"
#import "CarouseView.h"
#import "NSTimer+MAC.h"

@interface NewCarouselListCell(){
    NSTimer *_timer;
}
@end
@implementation NewCarouselListCell
-(void)dealloc{
    _carousel.dataSource = nil;
    _carousel.delegate = nil;
}
- (void)awakeFromNib {
    [super awakeFromNib];

    // Initialization code
   // DLog(@"NewCarouselListCell");
    _carousel.type = iCarouselTypeLinear;
    _carousel.dataSource = self;
    _carousel.delegate = self;
    _carousel.backgroundColor = [UIColor groupTableViewBackgroundColor];
  //  [_carousel scrollToItemAtIndex:1 animated:NO];
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
//    _timer = timer;
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 block:^{
        if (_carousel.numberOfVisibleItems) {
            CarouseView *view = _carousel.visibleItemViews[rand()%_carousel.numberOfVisibleItems];
            [view randomCoreAnimation];
        }
    } repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];

}
-(void)willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) {
        [_timer invalidate];
        _timer = nil;
    }
}
-(void)setDataArr:(NSArray *)dataArr{
    
}
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return 10;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
   // if (!view) {//复用性
       view = [CarouseView loadNibView];
       view.frame = CGRectMake(5, 10, self.width/3.0-5, self.height-20);
   // }
    //[view setBackgroundColor:[UIColor RandomColor]];
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.1;
    }
    return value;
}
- (NSInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel{
    return 0;
}
//- (CGFloat)carouselItemWidth:(iCarousel *)carousel{
//    return carousel.width/3.0;
//}

@end

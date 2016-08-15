//
//  NewCarouselListCell.m
//  MACProject
//
//  Created by MacKun on 16/8/15.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "NewCarouselListCell.h"
#import "CarouseView.h"
@implementation NewCarouselListCell

- (void)awakeFromNib {
    // Initialization code
    _carousel.type = iCarouselTypeLinear;
    _carousel.dataSource=self;
    _carousel.delegate=self;
    _carousel.backgroundColor=[UIColor appBackGroundColor];
  //  [_carousel scrollToItemAtIndex:1 animated:NO];
    
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
    if (!view) {
       view = [CarouseView loadNibView];
       view.frame=CGRectMake(5, 10, self.width/3.0-5, self.height-20);
    }
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

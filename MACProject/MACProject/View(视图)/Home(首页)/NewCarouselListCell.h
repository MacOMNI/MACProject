//
//  NewCarouselListCell.h
//  MACProject
//
//  Created by MacKun on 16/8/15.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
@interface NewCarouselListCell : UICollectionViewCell<iCarouselDataSource,iCarouselDelegate>

@property (weak, nonatomic) IBOutlet iCarousel *carousel;

@property(nonatomic,strong) NSArray *dataArr;

@end

//
//  BannerCell.h
//  MACProject
//
//  Created by MacKun on 16/8/18.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerCell : UICollectionViewCell<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView *bannerView;

@property(nonatomic,strong) UIPageControl *pageControl;


@end

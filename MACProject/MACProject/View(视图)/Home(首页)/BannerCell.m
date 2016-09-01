//
//  BannerCell.m
//  MACProject
//
//  Created by MacKun on 16/8/18.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "BannerCell.h"

@implementation BannerCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        //bannerView
        self.bannerView = [[UIScrollView alloc]init];
        self.bannerView.delegate = self;
        self.bannerView.pagingEnabled = YES;
        
        self.bannerView.showsHorizontalScrollIndicator = NO;
        self.bannerView.showsVerticalScrollIndicator = NO;
        self.bannerView.contentSize = CGSizeMake(self.width*2, 0);
        [self addSubview:self.bannerView];

        [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self);
        }];
        UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        img1.image = [UIImage imageNamed:@"dl_toppic"];
        UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.width, 0, self.width, self.height)];
        img2.image = [UIImage imageNamed:@"sy_banner"];
        [self.bannerView addSubview:img1];
        [self.bannerView addSubview:img2];
       //pageControl
        self.pageControl = [[UIPageControl alloc]init];
        self.pageControl.numberOfPages = 2;
        self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor appBlueColor];
        [self addSubview:self.pageControl];

        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self);
            make.height.mas_equalTo(@37);
        }];
    }
    return self;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    DLog(@"ScrollView offsetX = %f",offsetX/self.width);
    //  CGFloat alpha=0;
    self.pageControl.currentPage=(NSInteger)(offsetX/self.width);
}
@end

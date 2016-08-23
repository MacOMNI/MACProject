//
//  CarLightViewCell.h
//  MACProject
//
//  Created by MacKun on 16/8/17.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CarLightViewDelegate <NSObject>

@optional

-(void)carLightViewCellSelectIndexPath:(NSIndexPath *)indexPath;

@end

@interface CarLightViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageControlHeight;
@property(weak,nonatomic) id<CarLightViewDelegate> delegate;
@end

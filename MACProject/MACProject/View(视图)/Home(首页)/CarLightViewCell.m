//
//  CarLightViewCell.m
//  MACProject
//
//  Created by MacKun on 16/8/17.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "CarLightViewCell.h"
#include "CSStickyHeaderFlowLayout.h"
#import "LightCell.h"
@interface CarLightViewCell()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>{
    NSArray<NSString *> *_titlesArray;
    NSArray<NSString *> *_imagesArray;
}

@end

@implementation CarLightViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    // Initialization code
   // CSStickyHeaderFlowLayout *flowLayout=(CSStickyHeaderFlowLayout *)_collectionView.collectionViewLayout;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    //self.collectionView.backgroundView.backgroundColor=[UIColor whiteColor];
    
    [self.collectionView registerClass:[LightCell class] forCellWithReuseIdentifier:@"lightCell"];
    _titlesArray = @[@"安全带",@"车门提示",@"驱车制动",@"手刹",@"机油压力",@"左车门",@"主动转向",@"车盖没关",@"防滑",@"后雾灯",@"预热",@"轮胎失压",@"清洗液",@"油量低",@"蓄电池",@"时速表"];
    _imagesArray = @[@"light_anquan",@"light_chemen",@"light_quche",@"light_shousha",@"light_jiyou",@"light_zuoche",@"light_zhudong",@"light_chegai",@"light_fanghua",@"light_houwu",@"light_yure",@"light_luntai",@"light_qingxi",@"light_youliang",@"light_xudianchi",@"light_shisu",@"light_yuanguang",@"light_zhuanxiang"];

}
#pragma mark UICollectionView

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titlesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
            LightCell   *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"lightCell" forIndexPath:indexPath];
    
            // Configure the cell
    cell.imageView.image  = _imagesArray[indexPath.row].macImage;
    cell.textLabel.text = _titlesArray[indexPath.row];
           // cell.backgroundColor=[UIColor RandomColor];
            return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (_delegate && [_delegate respondsToSelector:@selector(carLightViewCellSelectIndexPath:)]) {
        [_delegate carLightViewCellSelectIndexPath:indexPath];
    }
}

#pragma  mark UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
            return CGSizeMake(self.width/4.0, (self.height-self.pageControl.height)/2.0-0.1);
}
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
  //  DLog(@"ScrollView offsetX = %f",offsetX/self.width);
  //  CGFloat alpha=0;
    self.pageControl.currentPage=(NSInteger)(offsetX/self.width);
}

@end

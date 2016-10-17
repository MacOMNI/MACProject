//
//  MACImageGroupView.m
//  MACProject
//
//  Created by MacKun on 16/9/21.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "MACImageGroupView.h"
#import "HZPhotoBrowser.h"

#import "UIImageView+YYWebImage.h"
static NSInteger picNum = 3;//最多支持几张图片
@interface MACImageGroupView()<HZPhotoBrowserDelegate>
@property (nonatomic ,strong) NSMutableArray<UIImageView *> *imageViewArr;
@end

@implementation MACImageGroupView
-(instancetype)init{
    self = [super init];
    if ( self ) {
        _imageViewArr = [NSMutableArray array];
        CGFloat imageHeight=(appWidth-2*8-2*5)/3.0;
        CGFloat imageWidth=(appWidth-2*8-2*5)/3.0;
        for (NSUInteger i=0; i<picNum; i++) {
            UIImageView *iv = [UIImageView new];
            iv.hidden = YES;
            iv.userInteractionEnabled = YES;//默认关闭NO，打开就可以接受点击事件
            iv.tag = i;
            [self addSubview:iv];
            CGFloat  Direction_X = ((imageWidth+5)*(i%3));
            CGFloat  Direction_Y  = (floorf(i/3.0)*(imageHeight+5));

            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self).offset(Direction_X);
                make.top.mas_equalTo(self).offset(Direction_Y);
                make.size.mas_equalTo(CGSizeMake(imageWidth, imageHeight));
            }];

            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAction:)];
            [iv addGestureRecognizer:singleTap];
            [_imageViewArr addObject:iv];
        }
    }
    return self;
}
-(void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
   // [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat imageHeight = (appWidth-2*8-2*5)/3.0;
    CGFloat gridHeight  =imageHeight*((NSInteger)((dataSource.count+2)/3));
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(gridHeight);
    }];
    for (NSUInteger i = 0; i < dataSource.count; i++) {
        UIImageView *iv = [_imageViewArr objectAtIndex:i];
        iv.hidden = NO;
        if ([dataSource[i] isKindOfClass:[UIImage class]]) {
            iv.image = dataSource[i];
        }else if ([dataSource[i] isKindOfClass:[NSString class]]){
            [iv mac_setImageWithURL:[NSURL URLWithString:dataSource[i]] placeholderImage:[UIImage imageNamed:@"placeholder_dropbox"]];
        }else if ([dataSource[i] isKindOfClass:[NSURL class]]){
            [ iv mac_setImageWithURL:dataSource[i] placeholderImage:[UIImage imageNamed:@"placeholder_dropbox"]];
        }
    }
    for (NSUInteger i = dataSource.count; i<picNum; i++) {
        UIImageView *iv = [_imageViewArr objectAtIndex:i];
        iv.hidden = YES;
    }
}


-(void)TapAction:(UITapGestureRecognizer   *)gesture
{
    NSInteger indx= gesture.view.tag;
    HZPhotoBrowser *browserVc = [[HZPhotoBrowser alloc] init];
    browserVc.sourceImagesContainerView = self; // 原图的父控件
    browserVc.imageCount = self.dataSource.count; // 图片总数
    browserVc.currentImageIndex = (int)indx;
    browserVc.delegate = self;
    [browserVc show];
    
}

#pragma mark - photobrowser代理方法
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return [(UIImageView *)self.subviews[index] image];
}

- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = self.dataSource[index];
    return [NSURL URLWithString:urlStr];
}

@end

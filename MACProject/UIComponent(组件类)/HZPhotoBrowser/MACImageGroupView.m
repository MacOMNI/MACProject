//
//  MACImageGroupView.m
//  MACProject
//
//  Created by MacKun on 16/9/21.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "MACImageGroupView.h"
#import "HZPhotoBrowser.h"
#define kJGG_GAP 5

@interface MACImageGroupView()<HZPhotoBrowserDelegate>

@end

@implementation MACImageGroupView

-(void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (NSUInteger i=0; i<dataSource.count; i++) {
        UIImageView *iv = [UIImageView new];
        if ([dataSource[i] isKindOfClass:[UIImage class]]) {
            iv.image = dataSource[i];
        }else if ([dataSource[i] isKindOfClass:[NSString class]]){
            [iv sd_setImageWithURL:[NSURL URLWithString:dataSource[i]] placeholderImage:[UIImage imageNamed:@"placeholder_dropbox"]];
        }else if ([dataSource[i] isKindOfClass:[NSURL class]]){
            [iv sd_setImageWithURL:dataSource[i] placeholderImage:[UIImage imageNamed:@"placeholder_dropbox"]];
        }
        iv.userInteractionEnabled = YES;//默认关闭NO，打开就可以接受点击事件
        iv.tag = i;
        [self addSubview:iv];
        BOOL isBottom = NO;
        if (i+3>=dataSource.count) {
            isBottom =YES;
        }
        //九宫格的布局
        CGFloat  Direction_X = (([self imageWidth]+5)*(i%3));
        CGFloat  Direction_Y  = (floorf(i/3.0)*([self imageHeight]+5));
        
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(Direction_X);
            make.top.mas_equalTo(self).offset(Direction_Y);
            make.size.mas_equalTo(CGSizeMake([self imageWidth], [self imageHeight]));
            if (isBottom) {
                make.bottom.equalTo(self.mas_bottom);
            }
        }];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAction:)];
        [iv addGestureRecognizer:singleTap];
    }
}

#pragma mark
#pragma mark 配置图片的宽高
-(CGFloat)imageWidth{
    return (appWidth-2*8-2*5)/3.0;
}
-(CGFloat)imageHeight{
    return  (appWidth-2*8-2*5)/3.0;
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

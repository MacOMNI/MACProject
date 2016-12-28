//
//  CarouseView.m
//  MACProject
//
//  Created by MacKun on 16/8/15.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "CarouseView.h"

@interface CarouseView(){
    NSArray *randomAnimationArr;
}

@end

@implementation CarouseView

-(void)awakeFromNib{
    [super awakeFromNib];

    _imgNameArr = @[@"sy_bg",@"dl_toppic",@"sy_banner"];
    randomAnimationArr = @[kCATransitionFromRight,kCATransitionFromLeft,kCATransitionFromTop,kCATransitionFromBottom];
    /** type
     *
     *  kCATransitionFade            交叉淡化过渡
     *  kCATransitionMoveIn          新视图移到旧视图上面
     *  kCATransitionPush            新视图把旧视图推出去
     *  kCATransitionReveal          将旧视图移开,显示下面的新视图
     */
    /** type
     *
     *  各种动画效果  其中除了'fade', `moveIn', `push' , `reveal' ,其他属于似有的API(我是这么认为的,可以点进去看下注释).
     *  ↑↑↑上面四个可以分别使用'kCATransitionFade', 'kCATransitionMoveIn', 'kCATransitionPush', 'kCATransitionReveal'来调用.
     *  @"cube"                     立方体翻滚效果
     *  @"moveIn"                   新视图移到旧视图上面
     *  @"reveal"                   显露效果(将旧视图移开,显示下面的新视图)
     *  @"fade"                     交叉淡化过渡(不支持过渡方向)             (默认为此效果)
     *  @"pageCurl"                 向上翻一页
     *  @"pageUnCurl"               向下翻一页
     *  @"suckEffect"               收缩效果，类似系统最小化窗口时的神奇效果(不支持过渡方向)
     *  @"rippleEffect"             滴水效果,(不支持过渡方向)
     *  @"oglFlip"                  上下左右翻转效果
     *  @"rotate"                   旋转效果
     *  @"push"
     *  @"cameraIrisHollowOpen"     相机镜头打开效果(不支持过渡方向)
     *  @"cameraIrisHollowClose"    相机镜头关上效果(不支持过渡方向)
     */



    /** subtype
     *
     *  各种动画方向
     *
     *  kCATransitionFromRight;      同字面意思(下同)
     *  kCATransitionFromLeft;
     *  kCATransitionFromTop;
     *  kCATransitionFromBottom;
     */
    
    

    _imageView.image = [UIImage imageNamed:_imgNameArr[rand()%_imgNameArr.count]];

}
-(void)randomCoreAnimation{
    //开始动画
//    [UIView beginAnimations:@"test" context:nil];
//    //动画时长
//    [UIView setAnimationDuration:2];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:_imageView cache:YES];
//    /*
//     *要进行动画设置的地方
//     */
//    _imageView.image=[UIImage imageNamed:_imgNameArr[rand()%_imgNameArr.count]];
//    
//    //动画结束
//    [UIView commitAnimations];
       [GCDQueue executeInMainQueue:^{

        _imageView.image = [UIImage imageNamed:_imgNameArr[rand()%_imgNameArr.count]];

        
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

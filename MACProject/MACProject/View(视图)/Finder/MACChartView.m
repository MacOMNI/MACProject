//
//  MACChartView.m
//  MACChartView
//
//  Created by MacKun on 2017/1/13.
//  Copyright © 2017年 com.soullon. All rights reserved.
//

#import "MACChartView.h"

@interface MACChartView(){
    
}
@property(nonatomic,strong) CABasicAnimation *animation;
@end

@implementation MACChartView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    
    return self;
}
-(void)commonInit{
    self.backgroundColor = [self randomColor];
}
-(UIColor *)randomColor{
    
    NSInteger randRed = arc4random()%255;
    NSInteger randBlue = arc4random()%255;
    NSInteger randGreen = arc4random()%255;
    return [UIColor colorWithRed:randRed/255.0 green:randBlue/255.0 blue:randGreen/255.0 alpha:1.0];
}
-(void)setPercentArr:(NSMutableArray *)percentArr{
    _percentArr = percentArr;
    NSUInteger count = _percentArr.count;
    CGFloat startAngle = 0;
    CGFloat endAngle = 0;
    CGFloat angleDis = M_PI*2.0/count;
    CGFloat centerX = self.frame.size.width/2.0;
    CGFloat centerY = self.frame.size.height/2.0;
    CGPoint center = CGPointMake(centerX, centerY);
    CGFloat circleR =  MIN(self.bounds.size.height, self.bounds.size.width)/2.0;
    for (NSUInteger i = 0; i < count; i++) {
        startAngle = i*angleDis;
        endAngle = (i+1)*angleDis;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:center];
        [path addArcWithCenter:center radius:circleR startAngle:startAngle endAngle:endAngle clockwise:YES];
        [path closePath];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.backgroundColor = [UIColor clearColor].CGColor;
        layer.fillColor = [UIColor clearColor].CGColor;

       layer.strokeColor = layer.fillColor = [self randomColor].CGColor;
       layer.path = path.CGPath;
       // [layer addAnimation:self.animation forKey:nil];
        [self.layer addSublayer:layer];
    }
}
-(CABasicAnimation *)animation{
    if (!_animation) {
        _animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _animation.fromValue = @0.0;
        _animation.toValue = @1.0;
        _animation.duration = 0.5;
    }
    
    return _animation;
}
@end

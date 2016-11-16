//
//  LoadingView.m
//  LoadingAnimationDemo
//
//  Created by MacKun on 2016/11/14.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "LoadingView.h"
#import "UIColor+Mac.h"
#import "UIColor+MACProject.h"
#import "UIView+MAC.h"
#import <math.h>
@interface LoadingView(){
    CGFloat _turnR;//旋转半径
    CGPoint _pointA;
    CGPoint _pointB;
    CGPoint _pointC;
}
@property (nonatomic,strong)     CAShapeLayer *bgLayer;
@property (nonatomic,strong)     CAShapeLayer *circleLayer;
@property (nonatomic,strong)     CAShapeLayer *leftLayer;
@property (nonatomic,strong)     CAShapeLayer *rightLayer;

@property (nonatomic,strong)     CAShapeLayer *bottomLayer;
@property (nonatomic,strong)     CABasicAnimation *animation;
@property (nonatomic,strong)     CABasicAnimation *turnAnimation;

@end

@implementation LoadingView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor gradientFromColor:[UIColor colorWithRed:250/255.f green:25/255.f blue:100/255.f alpha:1] toColor:[UIColor colorWithRed:240/255.f green:20/255.f blue:50/255.f alpha:1] withHeight:frame.size.height];
        [self setUp];
    }
    return self;
}
-(void)setUp{
    _turnR = 30.0f;
    _pointA = CGPointMake(self.centerX-_turnR*cos(M_PI_2/3.0), self.centerY+_turnR*sin(M_PI_2/3.0));//A点
    _pointB = CGPointMake(self.centerX, self.centerY-_turnR);//B点
    _pointC = CGPointMake(self.centerX+_turnR*cos(M_PI_2/3.0), self.centerY+_turnR*sin(M_PI_2/3.0));//C点
    
    [self.layer addSublayer:self.bgLayer];
    
    [self.bgLayer addSublayer:self.circleLayer];
    [self.bgLayer addSublayer:self.leftLayer];
    [self.bgLayer addSublayer:self.rightLayer];
    [self.bgLayer addSublayer:self.bottomLayer];
    [self.bgLayer addAnimation:self.turnAnimation forKey:nil];
}
-(CAShapeLayer *)bgLayer{
    if (!_bgLayer) {
        _bgLayer = [CAShapeLayer layer];
        _bgLayer.frame = self.frame;
        _bgLayer.backgroundColor = [UIColor clearColor].CGColor;
    }
    return _bgLayer;
}
-(CAShapeLayer *)circleLayer{
    if (!_circleLayer) {
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:self.center radius:80.0f startAngle:0 endAngle:M_PI*2 clockwise:YES];
        [circlePath closePath];
        _circleLayer = [CAShapeLayer layer];
        _circleLayer.path = circlePath.CGPath;
        _circleLayer.backgroundColor = [UIColor clearColor].CGColor;
        _circleLayer.fillColor       = [UIColor clearColor].CGColor;
        _circleLayer.strokeColor = [UIColor whiteColor].CGColor;
        _circleLayer.lineWidth   = 5.0f;
        _circleLayer.lineCap = kCALineCapRound;
        _circleLayer.lineJoin = kCALineJoinRound;
        [_circleLayer addAnimation:self.animation forKey:nil];

    }
    return _circleLayer;
}

-(CABasicAnimation *)animation{
    if (!_animation) {
        _animation  = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _animation.fromValue = @0.0;
        _animation.toValue = @1.0;
        _animation.autoreverses = NO;//default
        _animation.duration = 1.5;
    }
    return _animation;
}
-(CABasicAnimation *)turnAnimation{//开始旋转
    if (!_turnAnimation) {
        _turnAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        _turnAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        _turnAnimation.duration = 1.5;
        _turnAnimation.cumulative = YES;
       // _turnAnimation.delegate = self;
        _turnAnimation.repeatCount = MAXFLOAT;
    }
    return _turnAnimation;
}

-(CAShapeLayer *)leftLayer{
    if (!_leftLayer) {
        CGPoint controlPoint = CGPointMake(self.centerX - _turnR/cos(M_PI_2/3.0), self.centerY-_turnR*sin(M_PI_2/3.0)) ;
        UIBezierPath *leftPath = [UIBezierPath bezierPath];
        [leftPath moveToPoint:CGPointMake(_pointA.x-5.0, _pointA.y+25.0)];
        [leftPath addQuadCurveToPoint:_pointB controlPoint:controlPoint];
        _leftLayer = [CAShapeLayer layer];
        _leftLayer.path = leftPath.CGPath;
        _leftLayer.backgroundColor = [UIColor clearColor].CGColor;
        _leftLayer.fillColor       = [UIColor clearColor].CGColor;
        _leftLayer.strokeColor = [UIColor whiteColor].CGColor;
        _leftLayer.lineWidth   = 20.0f;
        [_leftLayer addAnimation:self.animation forKey:nil];
    }
    return _leftLayer;
}
-(CAShapeLayer *)rightLayer{
    if (!_rightLayer) {
        CGPoint controlPoint = CGPointMake(self.centerX, self.centerY+_turnR) ;
        UIBezierPath *rightPath = [UIBezierPath bezierPath];
        [rightPath moveToPoint:CGPointMake(_pointC.x+25.0, _pointC.y-5.0)];
        [rightPath addQuadCurveToPoint:_pointA controlPoint:controlPoint];
        _rightLayer = [CAShapeLayer layer];
        _rightLayer.path = rightPath.CGPath;
        _rightLayer.backgroundColor = [UIColor clearColor].CGColor;
        _rightLayer.fillColor       = [UIColor clearColor].CGColor;
        _rightLayer.strokeColor = [UIColor whiteColor].CGColor;
        _rightLayer.lineWidth   = 20.0f;
        [_rightLayer addAnimation:self.animation forKey:nil];
    }
    return _rightLayer;
}

-(CAShapeLayer *)bottomLayer{
    if (!_bottomLayer) {
        CGPoint controlPoint = CGPointMake(self.centerX + _turnR/cos(M_PI_2/3.0), self.centerY-_turnR*sin(M_PI_2/3.0)) ;
        UIBezierPath *bottomPath = [UIBezierPath bezierPath];
        [bottomPath moveToPoint:CGPointMake(_pointB.x-20.0, _pointB.y-20.0)];
        [bottomPath addQuadCurveToPoint:_pointC controlPoint:controlPoint];
        
        _bottomLayer = [CAShapeLayer layer];
        _bottomLayer.path = bottomPath.CGPath;
        _bottomLayer.backgroundColor = [UIColor clearColor].CGColor;
        _bottomLayer.fillColor       = [UIColor clearColor].CGColor;
        _bottomLayer.strokeColor = [UIColor whiteColor].CGColor;
        _bottomLayer.lineWidth   = 20.0f;
        [_bottomLayer addAnimation:self.animation forKey:nil];
        
    }
    return _bottomLayer;
}

@end

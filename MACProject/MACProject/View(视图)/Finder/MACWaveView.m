//
//  MACWaveView.m
//  MACWaveView
//
//  Created by MacKun on 2016/12/27.
//  Copyright © 2016年 com.soullon. All rights reserved.
//

#import "MACWaveView.h"

@interface MACWaveView (){
    
}
//波纹的曲线基本都是在正玄曲线和余弦曲线的基础上变幻而来的。
//以正弦函数y=Asin（ωx+φ）+h为例，通过修改φ来实现水平位移，
//通过修改h来实现垂直位移，而且为了更贴近真实波浪效果，
//一般都会是振幅即A随时间在小范围内波动
@property (nonatomic,strong) CADisplayLink *displayLink;//http://www.jianshu.com/p/c35a81c3b9eb
@property (nonatomic,strong) CAShapeLayer *layerWaveUp;
@property (nonatomic,strong) CAShapeLayer *layerWaveDown;
@property (nonatomic,strong) UIColor *layerPathColor;
@property (nonatomic,assign) CGFloat waveOffsetφ;//位移距离

@property (nonatomic,assign) CGFloat waveAmplitudeUp;//Up振幅
@property (nonatomic,assign) CGFloat waveAmplitudeDown;//Down振幅


@end

@implementation MACWaveView
//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [_displayLink invalidate];
        _displayLink = nil;
    }
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self configAndStartWave];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configAndStartWave];
    }
    return self;
}
#pragma mark privete methods

-(CAShapeLayer *)layerWaveUp{
    if (!_layerWaveUp) {
        _layerWaveUp  = [CAShapeLayer layer];
        _layerWaveUp.fillColor = [UIColor colorWithRed:110/255.0 green:190/255.0 blue:250/255.0 alpha:0.3].CGColor;
        
    }
    
    return _layerWaveUp;
}
-(CAShapeLayer *)layerWaveDown{
    if (!_layerWaveDown) {
        _layerWaveDown = [CAShapeLayer layer];
        _layerWaveDown.fillColor =  [UIColor colorWithRed:110/255.0 green:190/255.0 blue:250/255.0 alpha:0.3].CGColor;
    }
    return _layerWaveDown;
}
-(UIColor *)layerPathColor{
    if (!_layerPathColor) {
    }
    return _layerPathColor;
}
-(CADisplayLink *)displayLink{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWaveLayer)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    
    return _displayLink;
}
/**更新 WaveLayer 展示情况*/
-(void)updateWaveLayer{
    CGFloat waveA = 20.0f;//振幅
    CGFloat width = self.frame.size.width;
    _waveOffsetφ = _waveOffsetφ+waveA/2.0/width;//位移
    [self updateUpWaveLayer];
    [self updateDownWaveLayer];
}
-(void)updateUpWaveLayer{
    UIBezierPath *pathUp = [UIBezierPath bezierPath];
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    
    CGFloat waveA = 20.0f;//振幅
    CGFloat waveω = 2.0*M_PI/width;//周期
    
    CGFloat waveHeight = 100.0f;//Y 位置
    if (_waveAmplitudeUp >= waveA) {
        _waveAmplitudeUp -= 1/waveHeight;
    }else if(_waveAmplitudeUp <= waveA/2.0){
        _waveAmplitudeUp += 1/waveHeight;
    }else {
        _waveAmplitudeUp = _waveAmplitudeUp + (rand()%2==0?1:-1)*(1/waveHeight);
    }
    [pathUp moveToPoint:CGPointMake(0, waveA)];
    
    for (CGFloat x = 0.0; x <= width; x++) {
        CGFloat offsetY = _waveAmplitudeUp*sin(waveω*x+_waveOffsetφ)+waveHeight;
        [pathUp addLineToPoint:CGPointMake(x, offsetY)];
    }
    [pathUp addLineToPoint:CGPointMake(width,height)];
    [pathUp addLineToPoint:CGPointMake(0, height)];
    [pathUp closePath];
    
    
    self.layerWaveUp.path = pathUp.CGPath;
    
}
-(void)updateDownWaveLayer{
    UIBezierPath *pathDown = [UIBezierPath bezierPath];
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    
    CGFloat waveA = 25.0f;//振幅
    CGFloat waveω = 1.5*M_PI/width;//周期
    
    CGFloat waveHeight = 100.0f;//Y 位置
    if (_waveAmplitudeDown >= waveA) {
        _waveAmplitudeDown -= 1/waveHeight;
    }else if(_waveAmplitudeDown <= waveA/2.0){
        _waveAmplitudeDown += 1/waveHeight;
    }else {
        _waveAmplitudeDown = _waveAmplitudeDown + (rand()%2==0?1:-1)*(1/waveHeight);
    }
    [pathDown moveToPoint:CGPointMake(0, waveA+50.f)];
    
    for (CGFloat x = 0.0; x <= width; x++) {
        CGFloat offsetY = _waveAmplitudeDown*cos(waveω*x+_waveOffsetφ+10.0)+waveHeight;
        [pathDown addLineToPoint:CGPointMake(x, offsetY)];
    }
    [pathDown addLineToPoint:CGPointMake(width,height)];
    [pathDown addLineToPoint:CGPointMake(0, height)];
    [pathDown closePath];
    self.layerWaveDown.path = pathDown.CGPath;
    
}
/**开始生成波浪*/
-(void)configAndStartWave{
    _waveAmplitudeUp = 10;
    _waveAmplitudeDown = 15;
    [self.layer addSublayer:self.layerWaveUp];
    [self.layer addSublayer:self.layerWaveDown];
    
    self.displayLink.paused = false;
}
@end

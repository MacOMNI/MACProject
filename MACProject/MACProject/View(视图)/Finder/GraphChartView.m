//
//  GraphChartView.m
//  MACChartView
//
//  Created by MacKun on 2017/1/16.
//  Copyright © 2017年 com.soullon. All rights reserved.
//

#import "GraphChartView.h"

@interface GraphChartView (){
    CGFloat _disX;
    CGFloat _disY;
    CGFloat _height;
    CGFloat _width;
    NSInteger _selectedIndex;
}
@property (nonatomic,strong) CAShapeLayer *xLineLayer;
@property (nonatomic,strong) CAShapeLayer *yLineLayer;
@property (nonatomic,strong) NSMutableArray<CATextLayer *> *valueTextArray;
@property (nonatomic,strong) NSMutableArray<CAShapeLayer *> *valueLayerArray;


@end

@implementation GraphChartView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    
    return self;
}
-(void)draw{
    //drawArrayX
    
    //drawArrayY
    
    //drawGraphicView
    
    //drawArrayValue
    
}
-(void)setArrayX:(NSArray *)arrayX{
    _arrayX = arrayX;
    _disX = (_width-30.0-12.5)/_arrayX.count;
    CGFloat drawY = _xLineLayer.frame.size.height + _xLineLayer.frame.origin.y;
    
    for (NSUInteger i = 0; i < _arrayX.count; i++ ) {
        //draw text arrayX
        CATextLayer *xLayer = [CATextLayer layer];
        xLayer.foregroundColor = [UIColor whiteColor].CGColor;
        xLayer.string = _arrayX[i];
        xLayer.fontSize = 11;
        xLayer.alignmentMode = kCAAlignmentCenter;

        xLayer.frame = CGRectMake(_disX*(i+1)+12.5, drawY+2.5, 20, 25.0);
        
        [self.layer addSublayer:xLayer];
    }
}

-(void)setArrayY:(NSArray *)arrayY{
    _arrayY = arrayY;
    NSUInteger count = _arrayY.count;
    
    _disY = (_height-30-15)/count;

    for (NSUInteger i = 0; i < count; i++ ) {
        //draw text arrayY
        CATextLayer *yLayer = [CATextLayer layer];
        yLayer.foregroundColor = [UIColor whiteColor].CGColor;
        yLayer.alignmentMode = kCAAlignmentRight;
        yLayer.fontSize = 11;
        
        yLayer.string = _arrayY[i];
        yLayer.frame = CGRectMake(2.5, _disY*(count - i-1)+7.5, 20, 15.0);
        [self.layer addSublayer:yLayer];
        //draw dashLine arrayY
        CGRect lineFrame = CGRectMake(30.0,  _disY*(count - i-1)+14.0, _width-30.0, 0.3);
        [self drawDashLineFrame:lineFrame lineLength:8 lineSpacing:6 lineColor:[UIColor whiteColor]];
    }
}
-(void)setArrayValue:(NSArray *)arrayValue{
    _arrayValue = arrayValue;
    NSUInteger count = _arrayValue.count;
    
    for (NSUInteger i = 0; i < count; i++ ) {
        //draw graphic view
        CAShapeLayer *valueLayer = [CAShapeLayer layer];
        valueLayer.backgroundColor = [self randomColor].CGColor;
        CGFloat height = [_arrayValue[i] floatValue]/100.0*(_height-42.5);
        CGFloat y = _height-30.0-height;
        valueLayer.frame = CGRectMake(_disX*(i+1)+12.5, y, 20, height);
        [self.layer addSublayer:valueLayer];
        [_valueLayerArray addObject:valueLayer];
        //draw text
        CGRect textFrame = CGRectMake(_disX*(i+1)+12.5,  y-15, 20, 15);
        [_valueTextArray addObject:[self drawValueTextFrame:textFrame value:_arrayValue[i]]];
    }
    // 默认设置 2 显示
    _selectedIndex = 2;
    _valueTextArray[2].hidden = NO;

}
-(CATextLayer *)drawValueTextFrame:(CGRect)textFrame value:(NSString *)value{
    CATextLayer *layer = [CATextLayer layer];
   // layer.backgroundColor = [self randomColor].CGColor;
    layer.foregroundColor = [UIColor whiteColor].CGColor;
    layer.string = value;
    layer.hidden = YES;
    layer.fontSize = 11;
    layer.alignmentMode = kCAAlignmentCenter;
    layer.frame = textFrame;
    [self.layer addSublayer:layer];
    
    return layer;
}
- (void)drawDashLineFrame:(CGRect)lineFrame lineLength:(NSInteger)lineLength lineSpacing:(NSInteger)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = lineFrame;
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInteger:lineLength], [NSNumber numberWithInteger:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineFrame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

#pragma mark -Touch Handle
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchesMoved:touches withEvent:event];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self getCurrentSelectedLayerOnTouch:point];
    
}
//-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self touchesCancelled:touches withEvent:event];
//}
//-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//}
-(NSUInteger )getCurrentSelectedLayerOnTouch:(CGPoint )point{
    
    NSInteger selectIndex = -1;
    for (NSInteger i = _valueLayerArray.count - 1; i >= 0; i--) {
        CAShapeLayer *obj = _valueLayerArray[i];
        if (CGRectContainsPoint(obj.frame, point)) {
            selectIndex  = i;
            break;
        }
    }
    
    if (selectIndex != -1 && selectIndex != _selectedIndex) {
        if (_selectedIndex >= 0) {
            _valueTextArray[_selectedIndex].hidden = YES;
        }
        _valueTextArray[selectIndex].hidden = NO;
        _selectedIndex = selectIndex;
    }
    
    return selectIndex;
}
#pragma mark private methods
-(void)commonInit{
    _selectedIndex = -1;
    _width = self.frame.size.width;
    _height = self.frame.size.height;
    _valueTextArray = [NSMutableArray new];
    _valueLayerArray = [NSMutableArray new];
    
    self.backgroundColor = [UIColor colorWithRed:236/255.0 green:97.0/255 blue:73.0/255 alpha:1.0];

    //drawXLine
    
    CAShapeLayer *xLineLayer = [CAShapeLayer layer];
    xLineLayer.frame = CGRectMake(30, _height - 30, _width - 30, 1.5);
    xLineLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:xLineLayer];
    _xLineLayer = xLineLayer;
    
    //drawYLine
    
    CAShapeLayer *yLineLayer = [CAShapeLayer layer];
    yLineLayer.frame = CGRectMake(30 , 0 , 1.5 , _height - 30);
    yLineLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:yLineLayer];
    _yLineLayer  = yLineLayer;
    
    
}

-(UIColor *)randomColor{
    
    NSUInteger randRed = arc4random()%255;
    NSUInteger randBlue = arc4random()%255;
    NSUInteger randGreen = arc4random()%255;
    return [UIColor colorWithRed:randRed/255.0 green:randBlue/255.0 blue:randGreen/255.0 alpha:1.0];
}

@end

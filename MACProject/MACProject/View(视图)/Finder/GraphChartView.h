//
//  GraphChartView.h
//  MACChartView
//
//  Created by MacKun on 2017/1/16.
//  Copyright © 2017年 com.soullon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphChartView : UIView

@property (nonatomic,strong) NSArray *arrayX;//横坐标
@property (nonatomic,strong) NSArray *arrayY;//纵坐标
@property (nonatomic,strong) NSArray *arrayValue;//数据
//-(void)draw;
@end

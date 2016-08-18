//
//  CityModel.h
//  MainProject
//
//  Created by MacKun on 16/5/16.
//  Copyright © 2016年 com.soullon.EnjoyLearning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject
//<CITY_CODE>654300</CITY_CODE>
//<CITY_NAME>阿勒泰地区</CITY_NAME>
/**
 *  城市编码
 */
@property(nonatomic,assign)NSInteger CITY_CODE;
/**
 *  城市名称
 */
@property(nonatomic,copy) NSString *CITY_NAME;
@end

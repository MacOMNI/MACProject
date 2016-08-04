//
//  BaseModel.h
//  WeiSchoolTeacher
//
//  Created by MacKun on 16/1/19.
//  Copyright © 2016年 MacKun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
/**
 *  状态码
 */
@property(nonatomic,assign)NSInteger State;
/**
 *  返回的Result参数集合
 */
@property(nonatomic,strong) NSObject *Result;


@end

//
//  CitysXMLParser.h
//  MainProject
//
//  Created by MacKun on 16/5/16.
//  Copyright © 2016年 com.soullon.EnjoyLearning. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface CitysXMLParser : NSObject 
// 解析出的数据内部是字典类型
@property (strong, nonatomic) NSMutableArray *cityArr;





// 开始解析
- (void)start;
@end

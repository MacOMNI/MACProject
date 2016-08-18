//
//  CitysXMLParser.m
//  MainProject
//
//  Created by MacKun on 16/5/16.
//  Copyright © 2016年 com.soullon.EnjoyLearning. All rights reserved.
//

#import "CitysXMLParser.h"
#import "XMLDictionary.h"
#import "CityModel.h"
@implementation CitysXMLParser

- (void)start {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"citys" ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSString *xmlString = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:NULL];
    NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLString:xmlString];
    
    NSDictionary *cityDic=[xmlDoc objectForKey:@"City"];
    self.cityArr=[CityModel mj_objectArrayWithKeyValuesArray:cityDic];
}


@end

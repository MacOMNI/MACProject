//
//  NSObjcet+MAC.m
//  WeiSchoolTeacher
//
//  Created by MacKun on 15/12/14.
//  Copyright © 2015年 MacKun. All rights reserved.
//

#import "NSObjcet+MAC.h"

@implementation NSObject(MAC)


- (id)jsonBase64Value{
    NSMutableArray *resultArray = [NSMutableArray array];
    @try {
//        for (NSDictionary *base64Dic in (NSDictionary *)self) {
//           
//            NSDictionary *decodeDic = [self decodeBase64Dictionary:base64Dic];
//            [resultArray addObject:decodeDic];
//        }
        if ([self isKindOfClass:[NSDictionary class]]) {
             NSDictionary *decodeDic = [self decodeBase64Dictionary:(NSDictionary *)self];
             [resultArray addObject:decodeDic];
        }else if ([self isKindOfClass:[NSArray class]]) {
            for (NSDictionary *base64Dic in (NSDictionary *)self) {
                NSDictionary *decodeDic = [self decodeBase64Dictionary:base64Dic];
                [resultArray addObject:decodeDic];
            }
        }else{
            [resultArray addObject:(NSString *)self];
        }
    }
    @catch (NSException *exception) {
        [resultArray removeAllObjects];
        [resultArray addObject:(NSString *)self];
    }
    @finally {
        return resultArray;
    }
    
}

+(NSMutableArray *)macObjectToArray{
    NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:(NSArray *)self];
    return arr;
}

#pragma mark private methods
- (NSMutableDictionary *)decodeBase64Dictionary:(NSDictionary *)base64Dictionary{
    NSArray *keyArray = [base64Dictionary allKeys];
    NSMutableDictionary *decodeDic = [[NSMutableDictionary alloc]init];
    for (NSString *key in keyArray) {
        id object=[base64Dictionary objectForKey:key];
        if ([object isKindOfClass:[NSDictionary class]]) {
            [decodeDic setValue:[self decodeBase64Dictionary:object] forKey:key];
        }else if([object isKindOfClass:[NSArray class]]){
            NSMutableArray *arr = [NSMutableArray array];
            for(id obj in object){
                [arr addObject:[self decodeBase64Dictionary:obj]];
            }
            [decodeDic setValue:arr forKey:key];
        }else{
            NSData *decodeData = [[NSData alloc]initWithBase64EncodedString:[base64Dictionary objectForKey:key] options:0];
            NSString *decodeString = [[NSString alloc]initWithData:decodeData encoding:NSUTF8StringEncoding];
            [decodeDic setValue:decodeString forKey:key];
         }
    }
    return decodeDic;
}





@end

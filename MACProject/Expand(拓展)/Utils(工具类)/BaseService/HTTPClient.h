//
//  HTTPClient.h
//  WeSchool
//
//  Created by MacKun on 15/8/26.
//  Copyright (c) 2015年 MacKun. All rights reserved.
//


#import "AFNetworking.h"

@interface HTTPClient : AFHTTPSessionManager

+(instancetype)sharedHTTPClient;

/**
 *  是否连接网络
 * */
-(BOOL)isReachable;
@end

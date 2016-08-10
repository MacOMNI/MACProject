//
//  BaseService.m
//  WeiSchoolTeacher
//
//  Created by MacKun on 15/12/11.
//  Copyright © 2015年 MacKun. All rights reserved.
//

#import "BaseService.h"
#import "HttpClient.h"
#import "EGOCache.h"
#import "BaseModel.h"
#import "NSObjcet+MAC.h"
#import "NSDictionary+MAC.h"
#import "TSMessage.h"
#define REQUEST_ERROR(aCode)    (aCode==-1009?@"亲，咋没连接网络呢~~~":@"亲，服务器在偷懒哦~~~")
#define DATA_ERROR     @"亲，服务器正在打瞌睡哦，稍后重试吧"

/**
 *  接口回调
 *
 *  @param result    返回数据
 *  @param errorCode 错误码
 *  @param messgae   错误代码
 */
typedef void(^ServerBlock)(id result, NSInteger errorCode, NSString *message);

@interface BaseService(){
}

@end

@implementation BaseService

+(void)POST:(NSString *)URLString  parameters:( id)parameters result:(ResultBlock)requestBlock{
    if ([HTTPClient sharedHTTPClient].isReachable) {//有网络
        
        
        [[HTTPClient sharedHTTPClient] POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (requestBlock) {
                //     NSDictionary *dic=(NSDictionary *)responseObject;
                BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:responseObject];
                requestBlock(baseModel.State,[baseModel.Result jsonBase64Value],nil);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self showMessage:[error code]];
            if (requestBlock) {
                requestBlock(0,nil,error);
            }
        }];
    }
    else
    {
        [self showMessage:0];
        if (requestBlock) {
            requestBlock(0,nil,nil);
        }
        
    }
}
+(void)POSTWithNormal:(NSString *)URLString parameters:(id)parameters result:(ResultBlock)requestBlock{
    
    [[HTTPClient sharedHTTPClient] POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (requestBlock) {
            //     NSDictionary *dic=(NSDictionary *)responseObject;
            BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:responseObject];
            requestBlock(baseModel.State,[baseModel.Result jsonBase64Value],nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (requestBlock) {
            requestBlock(0,nil,error);
        }
    }];
    
}
+(void)POSTWithCache:(NSString *)URLString parameters:(id)parameters  completionBlock:(ResultBlock)requestBlock
{
    NSString *urlStr =[URLString stringByAppendingString: [parameters urlQueryString]];
    if ([HTTPClient sharedHTTPClient].isReachable) {//有网络
        [[HTTPClient sharedHTTPClient] POST:URLString parameters:parameters progress:nil
                                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                        if (responseObject) {
                                            [[EGOCache globalCache] setObject:responseObject forKey:urlStr];
                                        }
                                        else
                                        {
                                            responseObject=[[EGOCache globalCache] objectForKey:urlStr];
                                        }
                                        if (requestBlock) {
                                            BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:responseObject];
                                            requestBlock(baseModel.State,[baseModel.Result jsonBase64Value],nil);
                                        }
                                        
                                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                        id responseObject=[[EGOCache globalCache] objectForKey:urlStr];
                                        [self showMessage:[error code]];
                                        if (requestBlock) {
                                            if (responseObject) {
                                                BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:responseObject];
                                                requestBlock(baseModel.State,[baseModel.Result jsonBase64Value],nil);
                                                
                                            }else{
                                                requestBlock(0,nil,nil);
                                            }
                                        }
                                        
                                    }];
    }
    else
    {
        id responseObject=[[EGOCache globalCache] objectForKey:urlStr];
        [self showMessage:0];
        if (requestBlock) {
            if (responseObject) {
                BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:responseObject];
                requestBlock(baseModel.State,[baseModel.Result jsonBase64Value],nil);
            }else{
                requestBlock(0,nil,nil);
            }
        }
    }
}
+(void)POSTWithCacheNormal:(NSString *)URLString parameters:(id)parameters  completionBlock:(ResultBlock)requestBlock cacheBlock:(ResultBlock)cacheBlock
{
    NSString *urlStr =[URLString stringByAppendingString: [parameters urlQueryString]];
    id responseObject=[[EGOCache globalCache] objectForKey:urlStr];
    //[self showMessage:[error code]];
    if (cacheBlock) {
        if (responseObject) {
            BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:responseObject];
            cacheBlock(baseModel.State,[baseModel.Result jsonBase64Value],nil);
            
        }else{
            cacheBlock(0,nil,nil);
        }
        
    }
    
    //  if ([HTTPClient sharedHTTPClient].isReachable) {//有网络
    [[HTTPClient sharedHTTPClient]  POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            [[EGOCache globalCache] setObject:responseObject forKey:urlStr];
        }
        else
        {
            if (requestBlock) {
                requestBlock(0,nil,nil);
                return ;
            }
            //responseObject=[[EGOCache globalCache] objectForKey:urlStr];
        }
        if (requestBlock) {
            BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:responseObject];
            requestBlock(baseModel.State,[baseModel.Result jsonBase64Value],nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        requestBlock(0,nil,nil);
    }];
    //    }else{
    //        requestBlock(0,nil,nil);
    //    }
    
}

/**
 *  展示网络状态信息
 */
+(void)showMessage:(NSInteger)code
{
    NSString *subTitle=@"尝试连接网络,并重试";
    if (code !=-1009) {
        subTitle=@"您的服务器被程序猿搬走了,稍后重试吧";
    }
    [TSMessage showNotificationInViewController:[UIApplication sharedApplication].getCurrentViewConttoller
                                          title:REQUEST_ERROR(code)
                                       subtitle:subTitle
                                           type:TSMessageNotificationTypeWarning];
}
+(void)POSTWithFormDataURL:(NSString *)URLString parameters:(id)parameters mediaData:(NSMutableArray *)mediaDatas
           completionBlock:(ResultBlock)requestBlock{
    [[HTTPClient sharedHTTPClient] POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (mediaDatas.count > 0) {
            for(NSInteger i=0; i<mediaDatas.count; i++) {
                NSObject *firstObj = [mediaDatas objectAtIndex:i];
                if ([firstObj isKindOfClass:[UIImage class]]) { // 图片
                    UIImage *eachImg = [mediaDatas objectAtIndex:i];
                    
                    NSData *eachImgData = UIImageJPEGRepresentation(eachImg, 0.5);
                    [formData appendPartWithFileData:eachImgData name:@"file" fileName:[NSString stringWithFormat:@"img%d.jpg", (int)i+1] mimeType:@"image/jpeg"];
                }else if ([firstObj isKindOfClass:[NSString class]])
                {
                    NSURL *mediaUrl =[NSURL URLWithString:[mediaDatas objectAtIndex:i]];
                    //                    [formData appendPartWithFileURL:mediaUrl name:@"file" error:nil];
                    NSData *mediaData=[[NSData alloc]initWithContentsOfFile:mediaUrl.absoluteString];
                    [formData appendPartWithFileData:mediaData name:@"file" fileName:[NSString stringWithFormat:@"%d.mp3", (int)i+1] mimeType:@"audio/mpeg3"];
                }
            }
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if (requestBlock) {
            BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:responseObject];
            requestBlock(baseModel.State,[baseModel.Result jsonBase64Value],nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (requestBlock) {
            requestBlock(0,nil,error);
        }
        
    }];
}






@end

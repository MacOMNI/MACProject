//
//  CommentModel.h
//  MACProject
//
//  Created by MacKun on 16/9/22.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
/**
 *  评论者
 */
@property (nonatomic,copy) NSString *userName;
/**
 *  被评论者
 */
@property (nonatomic,copy) NSString *toUserName;

/**
 *  评论内容
 */
@property (nonatomic,copy) NSString *contentMessage;


@end

//
//  FriendsMessageModel.h
//  MACProject
//
//  Created by MacKun on 16/9/21.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendsMessageModel : NSObject


/**
 *  评论者
 */
@property (nonatomic,copy) NSString *userName;
/**
 *  评论者
 */
@property (nonatomic,copy) NSString *avactor;
/**
 *  被评论者
 */
@property (nonatomic,copy) NSString *toUserName;

/**
 *  评论内容
 */
@property (nonatomic,copy) NSString *contentMessage;
/**
 *  图片数组
 */
@property (nonatomic,strong) NSMutableArray *picArray;

/**
 *  高度
 */
@property (nonatomic,assign) CGFloat commentHeight;
@end

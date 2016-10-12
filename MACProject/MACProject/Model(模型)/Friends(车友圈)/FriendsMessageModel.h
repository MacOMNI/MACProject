//
//  FriendsMessageModel.h
//  MACProject
//
//  Created by MacKun on 16/9/21.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentModel.h"
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
 *  时间
 */
@property (nonatomic,copy) NSString *time;
/**
 *  浏览次数
 */
@property (nonatomic,assign) NSInteger browseNum;
/**
 *  浏览次数
 */
@property (nonatomic,assign) NSInteger goodNum;

/**
 *  评论内容
 */
@property (nonatomic,copy) NSString *contentMessage;
/**
 *  图片数组
 */
@property (nonatomic,strong) NSMutableArray<NSString *> *picArray;
/**
 *  评论数组
 */
@property (nonatomic,strong) NSMutableArray<CommentModel*> *conmentArray;

/**
 *  高度
 */
@property (nonatomic,assign) CGFloat commentHeight;
@end

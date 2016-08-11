//
//  UITableViewCell+MAC.h
//  WeiSchoolTeacher
//
//  Created by MacKun on 15/12/18.
//  Copyright © 2015年 MacKun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UITableViewCell(MAC)
/**
 *  @brief  加载同类名的nib
 *
 *  @return nib
 */
+(id)nibCell;
/**
 *  用代码创建Cell时候设置的cellIdentifier
 *
 *  @return cellIdentifier;
 */
+(NSString*)cellIdentifier;
/**
 *  用代码创建Cell
 *
 *  @return self;
 */

+(id)loadFromCellStyle:(UITableViewCellStyle)cellStyle;

@end

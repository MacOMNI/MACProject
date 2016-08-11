//
//  UITableViewCell+MAC.m
//  WeiSchoolTeacher
//
//  Created by MacKun on 15/12/18.
//  Copyright © 2015年 MacKun. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "UITableViewCell+MAC.h"

@implementation UITableViewCell(MAC)



/**
 *  @brief  加载同类名的nib
 *
 *  @return cell
 */
+(id)nibCell{
//    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
//    
//    return  [nib objectAtIndex:0];

    return  [[[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil]instantiateWithOwner:nil options:nil] objectAtIndex:0];
}
+ (NSString*)cellIdentifier {
    
    return NSStringFromClass(self);
}

+ (id)loadFromCellStyle:(UITableViewCellStyle)cellStyle {
    
    return [[self alloc] initWithStyle:cellStyle reuseIdentifier:NSStringFromClass(self)];
}

@end

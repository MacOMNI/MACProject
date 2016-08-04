 //
//  MACLabel.h
//  WeiSchoolTeacher
//
//  Created by MacKun on 16/1/15.
//  Copyright © 2016年 MacKun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MACLabel : UILabel
/**
 *  label的显示文本
 */
@property(nonatomic,copy)NSString *labelText;
/**
 *  设置label显示的属性
 *
 *  @param font      修改区域字体 nil表示不修改
 *  @param textColor 修改区域颜色 nil表示不修改
 *  @param range     区域位置
 */
-(void)setRichTextFont:(UIFont*)font color:(UIColor *)textColor atRange:(NSRange)range NS_AVAILABLE_IOS(6_0);
/**
 *  新增label的下划线
 *  @param range     区域位置
 */
-(void)addLineAtRange:(NSRange)range NS_AVAILABLE_IOS(6_0);

/**
 *  lable转IMG
 *
 *  @return img
 */
- (UIImage *)grabImage;
@end

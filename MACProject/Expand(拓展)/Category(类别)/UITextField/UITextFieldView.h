//
//  UITextFieldView.h
//  
//
//  Created by MacKun on 15/7/15.
//  Copyright (c) 2015年 MacKun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextFieldView : UIView

@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) UIColor *placeholderColor;

@end

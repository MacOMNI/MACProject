//
//  UITextField+PhoneOrBank.h
//  MainProject
//
//  Created by XuYuCheng on 16/6/2.
//  Copyright © 2016年 com.soullon.EnjoyLearning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (PhoneOrBank)
@property (readwrite) BOOL isAddHideBtn;

/**
 *  手机号码格式化
 *  参数 textField UITextField控件
 *  参数 range 文本范围
 *  参数 string 字符串
 */
+ (BOOL)phoneNumberFormatTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;


/**
 *  银行卡格式化
 *  参数 textField UITextField控件
 *  参数 range 文本范围
 *  参数 string 字符串
 */
+ (BOOL)bankNumberFormatTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

/**
 *  银行卡 和 手机号 格式化（合并）
 *  格式说明 银行卡 XXXX XXXX XXXX XXXX XXX 或 XXXX XXXX XXXX XXXX  手机号 XXX XXXX XXXX
 *  参数 textField UITextField控件
 *  参数 range 字符范围
 *  参数 string 字符串
 *  参数 bankCodeOrPhoneCodeFlag 标记是银行卡 还是 手机号  银行卡 24  手机号 14
 *
 */
+ (BOOL)bankCardOrPhoneNumberFormatTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string bankCodeOrPhoneCodeFlag:(NSInteger )bankCodeOrPhoneCodeFlag;

/**
 *  格式化后的号码转正常数字
 *  参数 textField UITextField控件
 */
+ (NSString *)numberToNormalNumTextField:(UITextField *)textField;

/**
 *  验证码判断 只能是数字
 *  参数 digits 只能输入的位数
 */
+ (BOOL)codeNumberFormatTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string digits:(NSInteger)digits;


@end

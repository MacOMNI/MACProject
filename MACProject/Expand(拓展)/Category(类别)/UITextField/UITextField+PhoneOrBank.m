//
//  UITextField+PhoneOrBank.m
//  MainProject
//
//  Created by XuYuCheng on 16/6/2.
//  Copyright © 2016年 com.soullon.EnjoyLearning. All rights reserved.
//

#import "UITextField+PhoneOrBank.h"
#import <objc/runtime.h>
@implementation UITextField (PhoneOrBank)

//Property
@dynamic isAddHideBtn;

/**
 *  手机号码格式化
 *  参数 textField UITextField控件
 *  参数 range 文本范围
 *  参数 string 字符串
 */
+ (BOOL)phoneNumberFormatTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = [textField text];
    // 只能输入数字
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound)
    {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // 如果是电话号码格式化，需要添加这三行代码
    NSMutableString *temString = [NSMutableString stringWithString:text];
    [temString insertString:@" " atIndex:0];
    text = temString;
    
    
    NSString *newString = @"";
    
    while (text.length > 0)
    {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4)
        {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    // 号码14 银行卡 24
    if (newString.length >= 14)
    {
        return NO;
    }
    
    [textField setText:newString];
    
    return NO;
}

/**
 *  银行卡格式化
 *  参数 textField UITextField控件
 *  参数 range 文本范围
 *  参数 string 字符串
 */
+ (BOOL)bankNumberFormatTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = [textField text];
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *newString = @"";
    while (text.length > 0) {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    if (newString.length >= 24) {
        return NO;
    }
    
    [textField setText:newString];
    
    return NO;
}

/**
 *  银行卡 手机号 格式化
 *  格式说明 银行卡 XXXX XXXX XXXX XXXX XXX 或 XXXX XXXX XXXX XXXX  手机号 XXX XXXX XXXX
 *  参数 textField UITextField控件
 *  参数 range 文本范围
 *  参数 string 字符串
 *  参数 bankCodeOrPhoneCodeFlag 标记是银行卡 还是 手机号  银行卡 24(kBankCardFlag)  手机号 14(kPhoneFlag)
 *
 */
+ (BOOL)bankCardOrPhoneNumberFormatTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string bankCodeOrPhoneCodeFlag:(NSInteger )bankCodeOrPhoneCodeFlag
{
    NSString *text = [textField text];
    // 只能输入数字
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound)
    {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // 电话号码 传14 银行卡 传24
    if (bankCodeOrPhoneCodeFlag == 14)
    {
        // 如果是电话号码格式化，需要添加这三行代码
        NSMutableString *temString = [NSMutableString stringWithString:text];
        [temString insertString:@" " atIndex:0];
        text = temString;
    }
    
    NSString *newString = @"";
    
    while (text.length > 0)
    {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4)
        {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    // 号码14 银行卡 24
    if (newString.length >= bankCodeOrPhoneCodeFlag)
    {
        
        return NO;
    }
    
    [textField setText:newString];
    
    return NO;
}


/**
 *  验证码判断 只能是数字
 *  参数 digits 只能输入的位数
 */
+ (BOOL)codeNumberFormatTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string digits:(NSInteger)digits
{
    if(range.location <= digits - 1)
    {
        if ([string length]>0)
        {
            unichar single=[string characterAtIndex:0];//当前输入的字符
            if ((single >='0' && single<='9'))//数据格式正确
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
        else
        {
            return YES;
        }
    }
    else
    {
        return NO;
    }
}


/**
 *  格式化后的号码转正常数字
 *  参数 textField UITextField控件
 */
+ (NSString *)numberToNormalNumTextField:(UITextField *)textField
{
    return [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end

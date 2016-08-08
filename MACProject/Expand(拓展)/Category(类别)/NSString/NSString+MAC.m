//
//  NSString+MAC.m
//  WeiSchoolTeacher
//
//  Created by MacKun on 15/12/11.
//  Copyright © 2015年 MacKun. All rights reserved.
//

#import "NSString+MAC.h"
#import <CommonCrypto/CommonDigest.h>
#import "MF_Base64Additions.h"
@implementation NSString(MAC)

- (BOOL)isBlank{
    if (self == nil || self == NULL || [self isKindOfClass:[NSNull class]] || [self length] == 0 || [self isEqualToString: @"(null)"]) {
        return YES;
    }
    return NO;
}
- (NSString *)md5String
{
    const char *ptr = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", md5Buffer[i]];
    }
    
    return [output copy];
}

- (CGFloat)stringHeightWithFont:(UIFont *)font width:(CGFloat)width{
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    

        NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
        size =[self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size.height;
}

-(NSDictionary *)jsonStringToDictionary
{
    if (self == nil) {
        return nil;
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
//    BOOL  isJson=[NSJSONSerialization isValidJSONObject:self];
//    NSArray *arr=[NSArray arrayWithObject:jsonData];
//    id json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&err];

    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
           return nil;
    }
    return dic;
}

//去除字符串
-(NSString *)htmlToString
{
    if (self == nil) {
        return nil;
    }
    NSString *html=self;
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
    
}


-(NSString *)base64StringFromText
{
    NSData *nsdata = [self
                      dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    // Print the Base64 encoded string
    return  base64Encoded;
}

-(NSString *)textFromBase64String
{
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:self options:0];
    
    // Decoded NSString from the NSData
    NSString *base64Decoded = [[NSString alloc]
                               initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
    return base64Decoded;
   
}
-(NSURL *)macUrl{
  return  [NSURL URLWithString:self];
}
-(UIImage *)macImage{
    return [UIImage imageNamed:self];
}


@end

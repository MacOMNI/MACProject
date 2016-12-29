//
//  MACArchiveObject.m
//  MACProject
//
//  Created by MacKun on 2016/12/29.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "MACArchiveObject.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation MACArchiveObject
-(instancetype)initWithCoder:(NSCoder *)aDecoder{//解档
    
    if (self = [super init]) {
        
        unsigned int ivarCount = 0;
        Ivar *ivarList = class_copyIvarList(self.class, &ivarCount);
        
        for (int i = 0; i < ivarCount; i++) {
            
            const char *key = ivar_getName(ivarList[i]);
            NSString *_key = [NSString stringWithUTF8String:key];
            
            if (_key) {
                id value = [aDecoder decodeObjectForKey:_key];//解档取值
                [self setValue:value forKey:_key];
            }
        }
        
        free(ivarList);
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{//归档
    
    unsigned int ivarCount = 0;
    Ivar *ivarList = class_copyIvarList(self.class, &ivarCount);
    
    for (int i = 0; i < ivarCount; i++) {
        
        const char *key = ivar_getName(ivarList[i]);
        NSString *_key = [NSString stringWithUTF8String:key];
        
        if (_key) {
            id value = [self valueForKey:_key];
            [aCoder encodeObject:value forKey:_key];
            
        }
    }
    free(ivarList);
    
}

@end

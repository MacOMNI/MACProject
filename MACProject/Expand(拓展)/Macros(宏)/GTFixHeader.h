//
//  GTFixHeader.h
//  MainProject
//
//  Created by MacKun on 16/5/18.
//  Copyright © 2016年 com.soullon.EnjoyLearning. All rights reserved.
//

#ifndef GTFixHeader_h
#define GTFixHeader_h
CG_INLINE CGFloat GTFixHeightFlaot(CGFloat height) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    if (mainFrme.size.height/1096*2 < 1) {
        return height;
    }
    height = height*mainFrme.size.height/1096*2;
    return height;
}

CG_INLINE CGFloat GTReHeightFlaot(CGFloat height) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    if (mainFrme.size.height/1096*2 < 1) {
        return height;
    }
    height = height*1096/(mainFrme.size.height*2);
    return height;
}

CG_INLINE CGFloat GTFixWidthFlaot(CGFloat width) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    if (mainFrme.size.height/1096*2 < 1) {
        return width;
    }
    width = width*mainFrme.size.width/640*2;
    return width;
}

CG_INLINE CGFloat GTReWidthFlaot(CGFloat width) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    if (mainFrme.size.height/1096*2 < 1) {
        return width;
    }
    width = width*640/mainFrme.size.width/2;
    return width;
}

// 经过测试了, 以iphone5屏幕为适配基础
CG_INLINE CGRect
GTRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = x; rect.origin.y = y;
    rect.size.width = GTFixWidthFlaot(width); rect.size.height = GTFixWidthFlaot(height);
    return rect;
}

#endif /* GTFixHeader_h */

//
//  UIView+EAFeatureGuideView.h
//  EAFeatureGuide
//
//  Created by zhiyun.huang on 4/27/16.
//  Copyright © 2016 EAH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EAFeatureItem.h"

@interface UIView (EAFeatureGuideView)

/**
 *  展示提示页面
 *
 *  @param featureItems 需要展示的UI元素
 *  @param keyName 提示的标识
 *  @param version 提示应该在什么版本出现版本
 */
- (void)showWithFeatureItems:(NSArray<EAFeatureItem *> *)featureItems saveKeyName:(NSString *)keyName inVersion:(NSString *)version;

/**
 *  是否已经展示过提示了
 *
 *  @param keyName 提示的标识
 *  @param version 提示应该在什么版本出现版本
 *
 *  @return <#return value description#>
 */
+ (BOOL)hasShowFeatureGuideWithKey:(NSString *)keyName version:(NSString *)version;

/**
 *  关闭提示页面
 */
- (void)dismissFeatureGuideView;

@end

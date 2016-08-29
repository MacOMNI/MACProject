//
//  EAFeatureItem.h
//  EAFeatureGuide
//
//  Created by zhiyun.huang on 4/27/16.
//  Copyright © 2016 EAH. All rights reserved.
//

#import <UIKit/UIKit.h>


//单布局元素在界面上垂直居中时，是将介绍文案布局顶部，还是底部
typedef NS_ENUM(NSUInteger, EAFeatureItemAlignmentPriority) {
    EAFeatureItemAlignmentBottomFirst, //底部优先
    EAFeatureItemAlignmentTopFirst, //顶部优先
};

@interface EAFeatureItem : NSObject


//需要高亮的UI元素，与focusRect二者直选其一，如果设置了focusView，focusRect无效
@property (nonatomic, strong ,readonly) UIView *focusView;
//需要高亮的区域
@property (nonatomic, assign ,readonly) CGRect focusRect;

//如果高亮元素需要添加圆角效果，需要设置相应的圆角半径
@property (nonatomic, assign) CGFloat focusCornerRadius;

//高亮区域相对于focusView的frame的偏移
@property (nonatomic, assign) UIEdgeInsets focusInsets;

//一段对该区域的文字介绍，也可以是一张本地图的名称，必须是png或者jpg图片
@property (nonatomic, strong) NSString *introduce;
//介绍的字体
@property (nonatomic, strong) UIFont *introduceFont;
//介绍文字的颜色
@property (nonatomic, strong) UIColor *introduceTextColor;

//单布局元素在界面上垂直居中时，是将介绍文案布局顶部，还是底部
@property (nonatomic ,assign) EAFeatureItemAlignmentPriority introduceAlignmentPriority;

//当action不为nil的时候，会在介绍的下方生成一个按钮，按钮的响应事件就是action
@property (nonatomic, copy) void(^action)(id sender);

//按钮的标题，默认是“知道了”，只有在action不为nil的才有效
@property (nonatomic, copy) NSString *actionTitle;

//指示符号的图片名称
@property (nonatomic, copy) NSString *indicatorImageName;
//生成的按钮的背景图片名称
@property (nonatomic, copy) NSString *buttonBackgroundImageName;

- (instancetype)initWithFocusView:(UIView *)focusView focusCornerRadius:(CGFloat) focusCornerRadius  focusInsets:(UIEdgeInsets) focusInsets;

- (instancetype)initWithFocusRect:(CGRect)rect focusCornerRadius:(CGFloat) focusCornerRadius  focusInsets:(UIEdgeInsets) focusInsets;

@end

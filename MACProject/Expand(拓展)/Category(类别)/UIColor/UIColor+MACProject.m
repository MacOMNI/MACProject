//
//  UIColor+MACProject
//  MACProject
//
//  Created by MacKun on 15/12/14.
//  Copyright © 2015年 MacKun. All rights reserved.
//

#import "UIColor+MACProject.h"
#import "UIColor+Mac.h"

@implementation UIColor(MACProject)

+(UIColor *)appMainColor{

    return [UIColor colorWithMacHexString:@"#ff5353"];
}
//导航条颜色
+ (UIColor *)appNavigationBarColor{
    return [UIColor colorWithMacHexString:@"#ff5353"];//#1aa7f2 2da4f6
}

//app蓝色
+ (UIColor *)appBlueColor{
    return [UIColor colorWithMacHexString:@"#099fde"];//099fde
}

//app红色
+ (UIColor *)appRedColor{
    return [UIColor colorWithMacHexString:@"#cc3333"];
}

//app黄色
+ (UIColor *)appYellowColor{
    return [UIColor colorWithMacHexString:@"#ffb400"];
}


//app橙色
+ (UIColor *)appOrangeColor{
    return [UIColor colorWithMacHexString:@"#ea6644"];
}

//app绿色
+ (UIColor *)appGreenColor{
    return [UIColor colorWithMacHexString:@"#1ec8c0"];
}

//app背景色
+ (UIColor *)appBackGroundColor{
    return [UIColor colorWithMacHexString:@"#f8f8f8"];
}

//app直线色
+ (UIColor *)appLineColor{
//    return [UIColor colorWithMacHexString:@"#c8c8c8"];
    return [UIColor colorWithMacHexString:@"#dddddd"];
}
//app导航栏文字颜色
+ (UIColor *)appNavTitleColor{
    return [UIColor colorWithMacHexString:@"#013e5d"];
}
//app标题颜色
+ (UIColor *)appTitleColor{
    return [UIColor colorWithMacHexString:@"#474747"];
}

//app文字颜色
+ (UIColor *)appTextColor{
    return [UIColor colorWithMacHexString:@"#A0A0A0"];
}

//app浅红颜色
+ (UIColor *)appLightRedColor{
    return [UIColor colorWithMacHexString:@"#FFB7C1"];
}

//app输入框颜色
+ (UIColor *)appTextFieldColor{
    return [UIColor colorWithMacHexString:@"#FFFFFF"];
}

//app黑色色
+ (UIColor *)appBlackColor{
    return [UIColor colorWithMacHexString:@"#333d47" ];
}
/**
 *  app次分割线
 */
+ (UIColor *)appSecondLineColor{
     return [UIColor colorWithMacHexString:@"#e5e5e5"];
}

@end

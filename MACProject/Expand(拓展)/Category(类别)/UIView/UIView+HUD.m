//
//  UIView+HUD.m
//  MacKun
//

#import "UIView+HUD.h"
//#import "UIImage+GIF.h"
#import "MBProgressHUD.h"
#import "UIColor+Mac.h"
@implementation UIView (HUD)

-(void)showMessage:(NSString *)message
{
    [self showSuccess:message];
}
-(void)showLoading:(NSString *)message {
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
}
-(void)showWaitingWithBackGround
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    [hud setFrameWidth:appWidth];
    [hud setFrameHeight:appHeight];
    hud.backgroundColor=[UIColor appBackGroundColor];
    hud.color=[UIColor clearColor];
    hud.labelFont=[UIFont boldSystemFontOfSize:14];
    hud.animationType=MBProgressHUDAnimationFade;
    
    MONActivityIndicatorView *indicatorView = [[MONActivityIndicatorView alloc] init];
    indicatorView.delegate = self;
    indicatorView.numberOfCircles = 5;
    indicatorView.radius = 12;
    indicatorView.internalSpacing = 8;
    
    [indicatorView startAnimating];
    hud.customView=indicatorView;
    //    hud.customView=[[UIImageView alloc]initWithImage:[UIImage sd_animatedGIFNamed:@"loading"]];
    hud.labelColor=[UIColor orangeColor];
    hud.labelText = nil;
    hud.yOffset=-44;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
}

-(void)showWaiting
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.backgroundColor=[UIColor clearColor];
    hud.color=[UIColor clearColor];
    hud.labelFont=[UIFont boldSystemFontOfSize:14];
    hud.animationType=MBProgressHUDAnimationFade;
    
    MONActivityIndicatorView *indicatorView = [[MONActivityIndicatorView alloc] init];
    indicatorView.delegate = self;
    indicatorView.numberOfCircles = 5;
    indicatorView.radius = 12;
    indicatorView.internalSpacing = 8;

    [indicatorView startAnimating];
    hud.customView=indicatorView;
//    hud.customView=[[UIImageView alloc]initWithImage:[UIImage sd_animatedGIFNamed:@"loading"]];
    hud.labelColor=[UIColor orangeColor];
    hud.labelText = nil;
    hud.yOffset=-44;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
}


-(void)hideHUD
{
    [MBProgressHUD hideHUDForView:self animated:YES];
}

-(void)showError:(NSString *)error
{
    [self hideHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.labelFont=[UIFont boldSystemFontOfSize:14];
    hud.labelText = error;
    hud.animationType=MBProgressHUDAnimationFade;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBProgressHUD.bundle/error"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

-(void)showSuccess:(NSString *)success
{
   [self hideHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.labelFont=[UIFont boldSystemFontOfSize:14];
    hud.animationType=MBProgressHUDAnimationFade;
    hud.labelText = success;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBProgressHUD.bundle/success"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2.0f];
}
-(void)showLoadFinish{
    [self hideHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.labelFont=[UIFont boldSystemFontOfSize:14];
    hud.animationType=MBProgressHUDAnimationFade;
    hud.labelText = @"您已加载全部数据";
    hud.mode = MBProgressHUDModeText;
    hud.yOffset=appHeight/2.0-80;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2.0f];
}
- (UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView
      circleBackgroundColorAtIndex:(NSUInteger)index {
    
     NSArray*array=@[@"#38d2ec",@"#0ce2c6",@"#da4ceb",@"#ff811b",@"#b3d465",@"#ea6644"];
    
    return [UIColor colorWithMacHexString:array[index]];
}

- (NSString*)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView circleTextAtIndex:(NSUInteger)index
{
    NSArray*array=@[@"拼",@"命",@"加",@"载",@"中"];
    return array[index];
}
@end

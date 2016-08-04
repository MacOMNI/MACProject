//
//  UIView+HUD.h
//  MacKun
//

#import <UIKit/UIKit.h>
#import "MONActivityIndicatorView.h"

@interface UIView (HUD)<MONActivityIndicatorViewDelegate>
/**
 *  普通展示提示信息 (1.5秒后消失)
 */
-(void)showMessage:(NSString *)message;
/**
 *  展示程序的错误或者警告信息
 */
-(void)showError:(NSString *)error;
/**
 *  展示成功信息
 */
-(void)showSuccess:(NSString *)success;




/**
 *  默认加载进度动画
 */
-(void)showLoading:(NSString*)message;
/**
 *   提示您已加载全部数据
 */
-(void)showLoadFinish;
/**
 *  加载动画 请求数据 (常用)
 */
-(void)showWaiting;
/**
 *  加载请求数据带默认背景
 */
-(void)showWaitingWithBackGround;
/**
 *  隐藏HUD
 */
-(void)hideHUD;

@end

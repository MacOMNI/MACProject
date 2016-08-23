//
//  QRScanViewController.h
//  WeiSchoolTeacher
//
//  Created by MacKun on 15/12/16.
//  Copyright © 2015年 MacKun. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QRScanViewController : UIViewController

typedef void  (^ScanBlock) (id assetDicArray);
/**
 *  完成扫描后的block
 *
 *  @param bl 返回的结果集
 */
-(void)doneScanBlock:(ScanBlock)bl;
@property (nonatomic, strong) AVCaptureSession *session;

@end

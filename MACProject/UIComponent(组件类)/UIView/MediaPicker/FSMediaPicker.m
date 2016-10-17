//
//  FSMediaPicker.m
//

#import "FSMediaPicker.h"
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <objc/runtime.h>

#import "MMAlertView.h"
#import "MMSheetView.h"
#define LocalizedString(key) \
NSLocalizedStringWithDefaultValue(key, @"FSMediaPicker", [NSBundle bundleWithPath:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"FSMediaPicker.bundle"]], key, nil)

#define kTakePhotoString @"拍照"
#define kSelectPhotoFromLibraryString @"从相册中选取"
#define kRecordVideoString @"摄像机"
#define kSelectVideoFromLibraryString @"本地视频"
#define kCancelString @"取消"

NSString const * UIImagePickerControllerCircularEditedImage = @" UIImagePickerControllerCircularEditedImage;";

@interface FSMediaPicker ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (UIWindow *)currentVisibleWindow;
- (UIViewController *)currentVisibleController;

- (void)delegatePerformFinishWithMediaInfo:(NSDictionary *)mediaInfo;
- (void)delegatePerformWillPresentImagePicker:(UIImagePickerController *)imagePicker;
- (void)delegatePerformCancel;

- (void)showAlertController:(UIView *)view;
//- (void)showActionSheet:(UIView *)view;

- (void)takePhotoFromCamera;
- (void)takePhotoFromPhotoLibrary;
- (void)takeVideoFromCamera;
- (void)takeVideoFromPhotoLibrary;

@end

@implementation FSMediaPicker

#pragma mark - Life Cycle

- (instancetype)initWithDelegate:(id<FSMediaPickerDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

#pragma mark - Public

- (void)show
{
    [self showFromView:self.currentVisibleController.view];
}

- (void)showFromView:(UIView *)view
{
    self.mediaType = FSMediaTypePhoto ;
//    #if __IPHONE_8_0
//       [self showAlertController:view];
//    #else
//       [self showActionSheet:view];
//    #endif
    MMPopupItemHandler block = ^(NSInteger index){
        NSLog(@"clickd %@ button",@(index));
        switch (index) {
            case 0:
            {
                [self takePhotoFromCamera];
            }
                break;
            case 1:
            {
                [self takePhotoFromPhotoLibrary];
            }
            default:
                break;
        }
    };
    

    NSArray *items =
    @[MMItemMake(kTakePhotoString, MMItemTypeNormal, block),
      MMItemMake(kSelectPhotoFromLibraryString, MMItemTypeNormal, block)];
 
  [[[MMSheetView alloc] initWithTitle:@"头像选择"
                                  items:items] show];
    
}

#pragma mark - UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    switch (buttonIndex) {
        case 0:
        {
            if (self.mediaType == FSMediaTypePhoto || self.mediaType == FSMediaTypeAll) {
                [self takePhotoFromCamera];
            } else if (self.mediaType == FSMediaTypeVideo) {
                [self takeVideoFromCamera];
            }
            break;
        }
        case 1:
        {
            if (self.mediaType == FSMediaTypePhoto || self.mediaType == FSMediaTypeAll) {
                [self takePhotoFromPhotoLibrary];
            } else if (self.mediaType == FSMediaTypeVideo) {
                [self takeVideoFromPhotoLibrary];
            }
            break;
        }
        case 2:
        {
            if (self.mediaType == FSMediaTypeAll) {
                [self takeVideoFromCamera];
            }
            break;
        }
        case 3:
        {
            if (self.mediaType == FSMediaTypeAll) {
                [self takeVideoFromPhotoLibrary];
            }
            break;
        }
        default:
            break;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        [self delegatePerformCancel];
    }
}

#pragma mark - UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [self delegatePerformFinishWithMediaInfo:info];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [self delegatePerformCancel];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:NSClassFromString(@"PLUIImageViewController")] && self.editMode && [navigationController.viewControllers count] == 3) {
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        
        UIView *plCropOverlay = [[viewController.view.subviews objectAtIndex:1] subviews][0];
        
        plCropOverlay.hidden = YES;
        
        int position = 0;
        
        if (screenHeight == 568){
            position = 124;
        } else {
            position = 80;
        }
        
        BOOL isIpad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
        
        CAShapeLayer *circleLayer = [CAShapeLayer layer];
        
        CGFloat diameter = isIpad ? MAX(plCropOverlay.frame.size.width, plCropOverlay.frame.size.height) : MIN(plCropOverlay.frame.size.width, plCropOverlay.frame.size.height);
        
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:
                                    CGRectMake(0.0f, position, diameter, diameter)];
        [circlePath setUsesEvenOddFillRule:YES];
        [circleLayer setPath:[circlePath CGPath]];
        [circleLayer setFillColor:[[UIColor clearColor] CGColor]];
        
        CGFloat bottomBarHeight = isIpad ? 51 : 72;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, diameter, screenHeight - bottomBarHeight) cornerRadius:0];
        [path appendPath:circlePath];
        [path setUsesEvenOddFillRule:YES];
        
        CAShapeLayer *fillLayer = [CAShapeLayer layer];
        fillLayer.name = @"fillLayer";
        fillLayer.path = path.CGPath;
        fillLayer.fillRule = kCAFillRuleEvenOdd;
        fillLayer.fillColor = [UIColor blackColor].CGColor;
        fillLayer.opacity = 0.5;
        [viewController.view.layer addSublayer:fillLayer];
        
        
        if (!isIpad) {
            UILabel *moveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 320, 50)];
            [moveLabel setText:@"Move and Scale"];
            [moveLabel setTextAlignment:NSTextAlignmentCenter];
            [moveLabel setTextColor:[UIColor whiteColor]];
            [viewController.view addSubview:moveLabel];
        }
        
    }
}

#pragma mark - Setter & Getter

- (UIWindow *)currentVisibleWindow
{
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows){
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            return window;
        }
    }
    return [[[UIApplication sharedApplication] delegate] window];
}

- (UIViewController *)currentVisibleController
{
    UIViewController *topController = self.currentVisibleWindow.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    return topController;
}

#pragma mark - Private

- (void)delegatePerformFinishWithMediaInfo:(NSDictionary *)mediaInfo
{
    if ([[mediaInfo allKeys] containsObject:UIImagePickerControllerEditedImage]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:mediaInfo];
        dic[UIImagePickerControllerCircularEditedImage] = [dic[UIImagePickerControllerEditedImage] circularImage];
        mediaInfo = [NSDictionary dictionaryWithDictionary:dic];
    }
    if (_finishBlock) {
        _finishBlock(self,mediaInfo);
    } else if (_delegate && [_delegate respondsToSelector:@selector(mediaPicker:didFinishWithMediaInfo:)]) {
        [_delegate mediaPicker:self didFinishWithMediaInfo:mediaInfo];
    }
}

- (void)delegatePerformWillPresentImagePicker:(UIImagePickerController *)imagePicker
{
    if (_willPresentImagePickerBlock) {
        _willPresentImagePickerBlock(self,imagePicker);
    } else if (_delegate && [_delegate respondsToSelector:@selector(mediaPicker:willPresentImagePickerController:)]) {
        [_delegate mediaPicker:self willPresentImagePickerController:imagePicker];
    }
}

- (void)delegatePerformCancel
{
    if (_cancelBlock) {
        _cancelBlock(self);
    } else if (_delegate && [_delegate respondsToSelector:@selector(mediaPickerDidCancel:)]) {
        [_delegate mediaPickerDidCancel:self];
    }
}

- (void)showActionSheet:(UIView *)view
{
    #if __IPHONE_8_0
    #else
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    actionSheet.mediaPicker = self;
    switch (self.mediaType) {
        case FSMediaTypePhoto:
        {
            [actionSheet addButtonWithTitle:kTakePhotoString];
            [actionSheet addButtonWithTitle:kSelectPhotoFromLibraryString];
            [actionSheet addButtonWithTitle:kCancelString];
            actionSheet.cancelButtonIndex = 2;
            break;
        }
        case FSMediaTypeVideo:
        {
            [actionSheet addButtonWithTitle:kRecordVideoString];
            [actionSheet addButtonWithTitle:kSelectVideoFromLibraryString];
            [actionSheet addButtonWithTitle:kCancelString];
            actionSheet.cancelButtonIndex = 2;
            break;
        }
        case FSMediaTypeAll:
        {
            [actionSheet addButtonWithTitle:kTakePhotoString];
            [actionSheet addButtonWithTitle:kSelectPhotoFromLibraryString];
            [actionSheet addButtonWithTitle:kRecordVideoString];
            [actionSheet addButtonWithTitle:kSelectVideoFromLibraryString];
            [actionSheet addButtonWithTitle:kCancelString];
            actionSheet.cancelButtonIndex = 4;
            break;
        }
        default:
            break;
    }
    actionSheet.delegate = self;
    [actionSheet showFromRect:view.bounds inView:view animated:YES];
    #endif
}

- (void)showAlertController:(UIView *)view
{
    UIAlertController *alertController = [[UIAlertController alloc] init];
    alertController.mediaPicker = self;
    switch (self.mediaType) {
        case FSMediaTypePhoto:
        {
            [alertController addAction:[UIAlertAction actionWithTitle:kTakePhotoString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self takePhotoFromCamera];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:kSelectPhotoFromLibraryString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self takePhotoFromPhotoLibrary];
            }]];
            break;
        }
        case FSMediaTypeVideo:
        {
            [alertController addAction:[UIAlertAction actionWithTitle:kRecordVideoString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self takeVideoFromCamera];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:kSelectVideoFromLibraryString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self takeVideoFromPhotoLibrary];
            }]];
            break;
        }
        case FSMediaTypeAll:
        {
            [alertController addAction:[UIAlertAction actionWithTitle:kTakePhotoString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self takePhotoFromCamera];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:kSelectPhotoFromLibraryString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self takePhotoFromPhotoLibrary];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:kRecordVideoString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self takeVideoFromCamera];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:kSelectVideoFromLibraryString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self takeVideoFromPhotoLibrary];
            }]];
            break;
        }
        default:
            break;
    }
    [alertController addAction:[UIAlertAction actionWithTitle:kCancelString style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self delegatePerformCancel];
    }]];
    alertController.popoverPresentationController.sourceView = view;
    alertController.popoverPresentationController.sourceRect = view.bounds;
    [self.currentVisibleController presentViewController:alertController animated:YES completion:nil];
}

- (void)takePhotoFromCamera
{
    //    iOS 8 判断应用是否有使用相机的权限
    
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        [self.currentVisibleController showAlertMessage:@"请在设置->隐私->相机中，允许双师网访问" titile:@"照相机被禁用"];
        return;
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [UIImagePickerController new];
        imagePicker.allowsEditing = _editMode != FSEditModeNone;
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
        imagePicker.mediaPicker = self;
        [self delegatePerformWillPresentImagePicker:imagePicker];
        [self.currentVisibleController presentViewController:imagePicker animated:YES completion:nil];
    }else{
        [self.currentVisibleController showAlertMessage:@"请在设置->隐私->相机中，允许双师网访问" titile:@"照相机被禁用"];
    }
}

- (void)takePhotoFromPhotoLibrary
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePicker = [UIImagePickerController new];
        imagePicker.allowsEditing = _editMode != FSEditModeNone;
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
        imagePicker.mediaPicker = self;
        [self delegatePerformWillPresentImagePicker:imagePicker];
        [self.currentVisibleController presentViewController:imagePicker animated:YES completion:nil];
    }else{
        [self.currentVisibleController showAlertMessage:@"请在设置->隐私->照片中，允许双师网访问" titile:@"照片被禁用"];
    }
}

- (void)takeVideoFromCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [UIImagePickerController new];
        imagePicker.allowsEditing = _editMode != FSEditModeNone;
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie];
        imagePicker.mediaPicker = self;
        [self delegatePerformWillPresentImagePicker:imagePicker];
        [self.currentVisibleController presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)takeVideoFromPhotoLibrary
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePicker = [UIImagePickerController new];
        imagePicker.allowsEditing = _editMode != FSEditModeNone;
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie];
        imagePicker.mediaPicker = self;
        [self delegatePerformWillPresentImagePicker:imagePicker];
        [self.currentVisibleController presentViewController:imagePicker animated:YES completion:nil];
    }
}

@end

@implementation NSDictionary (FSMediaPicker)

- (UIImage *)originalImage
{
    if ([self.allKeys containsObject:UIImagePickerControllerOriginalImage]) {
        return self[UIImagePickerControllerOriginalImage];
    }
    return nil;
}

- (UIImage *)editedImage
{
    if ([self.allKeys containsObject:UIImagePickerControllerEditedImage]) {
        return self[UIImagePickerControllerEditedImage];
    }
    return nil;
}

- (UIImage *)circularEditedImage
{
    if ([self.allKeys containsObject:UIImagePickerControllerCircularEditedImage]) {
        return self[UIImagePickerControllerCircularEditedImage];
    }
    return nil;
}

- (NSURL *)mediaURL
{
    if ([self.allKeys containsObject:UIImagePickerControllerMediaURL]) {
        return self[UIImagePickerControllerMediaURL];
    }
    return nil;
}

- (NSDictionary *)mediaMetadata
{
    if ([self.allKeys containsObject:UIImagePickerControllerMediaMetadata]) {
        return self[UIImagePickerControllerMediaMetadata];
    }
    return nil;
}

- (FSMediaType)mediaType
{
    if ([self.allKeys containsObject:UIImagePickerControllerMediaType]) {
        NSString *type = self[UIImagePickerControllerMediaType];
        if ([type isEqualToString:(NSString *)kUTTypeImage]) {
            return FSMediaTypePhoto;
        } else if ([type isEqualToString:(NSString *)kUTTypeMovie]) {
            return FSMediaTypeVideo;
        }
    }
    return FSMediaTypePhoto;
}

@end


@implementation UIImage (FSMediaPicker)

- (UIImage *)circularImage
{
    // This function returns a newImage, based on image, that has been:
    // - scaled to fit in (CGRect) rect
    // - and cropped within a circle of radius: rectWidth/2
    
    //Create the bitmap graphics context
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.size.width, self.size.height), NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Get the width and heights
    CGFloat imageWidth = self.size.width;
    CGFloat imageHeight = self.size.height;
    CGFloat rectWidth = self.size.width;
    CGFloat rectHeight = self.size.height;
    
    //Calculate the scale factor
    CGFloat scaleFactorX = rectWidth/imageWidth;
    CGFloat scaleFactorY = rectHeight/imageHeight;
    
    //Calculate the centre of the circle
    CGFloat imageCentreX = rectWidth/2;
    CGFloat imageCentreY = rectHeight/2;
    
    // Create and CLIP to a CIRCULAR Path
    // (This could be replaced with any closed path if you want a different shaped clip)
    CGFloat radius = rectWidth/2;
    CGContextBeginPath (context);
    CGContextAddArc (context, imageCentreX, imageCentreY, radius, 0, 2*M_PI, 0);
    CGContextClosePath (context);
    CGContextClip (context);
    
    //Set the SCALE factor for the graphics context
    //All future draw calls will be scaled by this factor
    CGContextScaleCTM (context, scaleFactorX, scaleFactorY);
    
    // Draw the IMAGE
    CGRect myRect = CGRectMake(0, 0, imageWidth, imageHeight);
    [self drawInRect:myRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end

const char * mediaPickerKey;

//@implementation UIActionSheet (FSMediaPicker)
//
//- (void)setMediaPicker:(FSMediaPicker *)mediaPicker
//{
//    objc_setAssociatedObject(self, &mediaPickerKey, mediaPicker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (FSMediaPicker *)mediaPicker
//{
//    return objc_getAssociatedObject(self, &mediaPickerKey);
//}
//
//@end

@implementation UIAlertController (FSMediaPicker)

- (void)setMediaPicker:(FSMediaPicker *)mediaPicker
{
    objc_setAssociatedObject(self, &mediaPickerKey, mediaPicker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (FSMediaPicker *)mediaPicker
{
    return objc_getAssociatedObject(self, &mediaPickerKey);
}


@end

@implementation UIImagePickerController (FSMediaPicker)

- (void)setMediaPicker:(FSMediaPicker *)mediaPicker
{
    objc_setAssociatedObject(self, &mediaPickerKey, mediaPicker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (FSMediaPicker *)mediaPicker
{
    return objc_getAssociatedObject(self, &mediaPickerKey);
}


@end


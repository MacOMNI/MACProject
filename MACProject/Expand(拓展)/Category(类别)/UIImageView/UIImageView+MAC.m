//
//  UIImageView+MAC.m
//  MACProject
//
//  Created by MacKun on 16/8/9.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "UIImageView+MAC.h"
#import "objc/runtime.h"
#import "UIView+WebCacheOperation.h"
#import "UIView+AnimationProperty.h"

static char imageURLKey;

@implementation UIImageView(MAC)

- (void)mac_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    [self mac_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:nil];
}
- (void)mac_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock {
    [self sd_cancelCurrentImageLoad];
    objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  
    if (!(options & SDWebImageDelayPlaceholder)) {
        dispatch_main_async_safe(^{
            self.image = placeholder;
        });
    }
    
    if (url) {
        

        __weak __typeof(self)wself = self;
       // wself.alpha = 0;
        id <SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadImageWithURL:url options:options progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            if (!wself) return;
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!wself) return;
            dispatch_main_sync_safe(^{
                if (!wself) return;
                if (image && (options & SDWebImageAvoidAutoSetImage) && completedBlock)
                {
                    completedBlock(image, error, cacheType, url);
                    return;
                }
                else if (image) {
                    wself.image = image;
                    [wself setNeedsLayout];
                   
                  } else {
                    if ((options & SDWebImageDelayPlaceholder)) {
                        wself.image = placeholder;
                        [wself setNeedsLayout];
                    }
                }
                wself.scale = 0.95f;
                wself.alpha = 0.3f;
                [UIView animateWithDuration:0.6f animations:^{
                    wself.scale = 1.0f;
                    wself.alpha = 1.0f;
                }];
                if (completedBlock && finished) {
                    completedBlock(image, error, cacheType, url);
                }
            });
        }];
        [self sd_setImageLoadOperation:operation forKey:@"UIImageViewImageLoad"];

    } else {
        dispatch_main_async_safe(^{
            if (completedBlock) {
                NSError *error = [NSError errorWithDomain:SDWebImageErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
                completedBlock(nil, error, SDImageCacheTypeNone, url);
            }
        });
    }
}


@end

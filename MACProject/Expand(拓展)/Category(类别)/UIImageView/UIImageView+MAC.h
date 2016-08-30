//
//  UIImageView+MAC.h
//  MACProject
//
//  Created by MacKun on 16/8/9.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDWebImageCompat.h"
#import "SDWebImageManager.h"
@interface UIImageView(MAC)



/**
 * Set the imageView `image` with an `url` and a placeholder.
 *
 *  加载图片带有alpha虚影
 *
 * @param url         The url for the image.
 * @param placeholder The image to be set initially, until the image request finishes.
 * @see sd_setImageWithURL:placeholderImage:options:
 */
- (void)mac_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
@end

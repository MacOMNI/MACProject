

#import "UIImage+Additions.h"
#import <float.h>
@import Accelerate;
@implementation UIImage (Additions)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size andRoundSize:(CGFloat)roundSize {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (roundSize > 0) {
        UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius: roundSize];
        [color setFill];
        [roundedRectanglePath fill];
    } else {
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

static CGFloat edgeSizeFromCornerRadius(CGFloat cornerRadius) {
    return cornerRadius * 2 + 1;
}

+ (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius {
    CGFloat minEdgeSize = edgeSizeFromCornerRadius(cornerRadius);
    CGRect rect = CGRectMake(0, 0, minEdgeSize, minEdgeSize);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = 0;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}

+ (UIImage *) buttonImageWithColor:(UIColor *)color
                      cornerRadius:(CGFloat)cornerRadius
                       shadowColor:(UIColor *)shadowColor
                      shadowInsets:(UIEdgeInsets)shadowInsets {
    
    UIImage *topImage = [self imageWithColor:color cornerRadius:cornerRadius];
    UIImage *bottomImage = [self imageWithColor:shadowColor cornerRadius:cornerRadius];
    CGFloat totalHeight = edgeSizeFromCornerRadius(cornerRadius) + shadowInsets.top + shadowInsets.bottom;
    CGFloat totalWidth = edgeSizeFromCornerRadius(cornerRadius) + shadowInsets.left + shadowInsets.right;
    CGFloat topWidth = edgeSizeFromCornerRadius(cornerRadius);
    CGFloat topHeight = edgeSizeFromCornerRadius(cornerRadius);
    CGRect topRect = CGRectMake(shadowInsets.left, shadowInsets.top, topWidth, topHeight);
    CGRect bottomRect = CGRectMake(0, 0, totalWidth, totalHeight);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(totalWidth, totalHeight), NO, 0.0f);
    if (!CGRectEqualToRect(bottomRect, topRect)) {
        [bottomImage drawInRect:bottomRect];
    }
    [topImage drawInRect:topRect];
    UIImage *buttonImage = UIGraphicsGetImageFromCurrentImageContext();
    UIEdgeInsets resizeableInsets = UIEdgeInsetsMake(cornerRadius + shadowInsets.top,
                                                     cornerRadius + shadowInsets.left,
                                                     cornerRadius + shadowInsets.bottom,
                                                     cornerRadius + shadowInsets.right);
    return [buttonImage resizableImageWithCapInsets:resizeableInsets];
    
}

+ (UIImage *) circularImageWithColor:(UIColor *)color
                                size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:rect];
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [color setStroke];
    [circle addClip];
    [circle fill];
    [circle stroke];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *) imageWithMinimumSize:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), NO, 0.0f);
    [self drawInRect:rect];
    UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
    return [resized resizableImageWithCapInsets:UIEdgeInsetsMake(size.height/2, size.width/2, size.height/2, size.width/2)];
}

+ (UIImage *) stepperPlusImageWithColor:(UIColor *)color {
    CGFloat iconEdgeSize = 15;
    CGFloat iconInternalEdgeSize = 3;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(iconEdgeSize, iconEdgeSize), NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];
    CGFloat padding = (iconEdgeSize - iconInternalEdgeSize) / 2;
    CGContextFillRect(context, CGRectMake(padding, 0, iconInternalEdgeSize, iconEdgeSize));
    CGContextFillRect(context, CGRectMake(0, padding, iconEdgeSize, iconInternalEdgeSize));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *) stepperMinusImageWithColor:(UIColor *)color {
    CGFloat iconEdgeSize = 15;
    CGFloat iconInternalEdgeSize = 3;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(iconEdgeSize, iconEdgeSize), NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];
    CGFloat padding = (iconEdgeSize - iconInternalEdgeSize) / 2;
    CGContextFillRect(context, CGRectMake(0, padding, iconEdgeSize, iconInternalEdgeSize));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *) backButtonImageWithColor:(UIColor *)color
                            barMetrics:(UIBarMetrics) metrics
                          cornerRadius:(CGFloat)cornerRadius {
    
    CGSize size;
    if (metrics == UIBarMetricsDefault) {
        size = CGSizeMake(50, 30);
    }
    else {
        size = CGSizeMake(60, 23);
    }
    UIBezierPath *path = [self bezierPathForBackButtonInRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:cornerRadius];
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    [color setFill];
    [path addClip];
    [path fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, 15, cornerRadius, cornerRadius)];
    
}

+ (UIBezierPath *) bezierPathForBackButtonInRect:(CGRect)rect cornerRadius:(CGFloat)radius {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint mPoint = CGPointMake(CGRectGetMaxX(rect) - radius, rect.origin.y);
    CGPoint ctrlPoint = mPoint;
    [path moveToPoint:mPoint];
    
    ctrlPoint.y += radius;
    mPoint.x += radius;
    mPoint.y += radius;
    if (radius > 0) [path addArcWithCenter:ctrlPoint radius:radius startAngle:M_PI + M_PI_2 endAngle:0 clockwise:YES];
    
    mPoint.y = CGRectGetMaxY(rect) - radius;
    [path addLineToPoint:mPoint];
    
    ctrlPoint = mPoint;
    mPoint.y += radius;
    mPoint.x -= radius;
    ctrlPoint.x -= radius;
    if (radius > 0) [path addArcWithCenter:ctrlPoint radius:radius startAngle:0 endAngle:M_PI_2 clockwise:YES];
    
    mPoint.x = rect.origin.x + (10.0f);
    [path addLineToPoint:mPoint];
    
    [path addLineToPoint:CGPointMake(rect.origin.x, CGRectGetMidY(rect))];
    
    mPoint.y = rect.origin.y;
    [path addLineToPoint:mPoint];
    
    [path closePath];
    return path;
}

- (UIImage *)imageTintedWithColor:(UIColor *)color
{
	// This method is designed for use with template images, i.e. solid-coloured mask-like images.
	return [self imageTintedWithColor:color fraction:0.0]; // default to a fully tinted mask of the image.
}


- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction
{
	if (color) {
		// Construct new image the same size as this one.
		UIImage *image;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
		if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
			UIGraphicsBeginImageContextWithOptions([self size], NO, 0.f); // 0.f for scale means "scale for device's main screen".
		} else {
			UIGraphicsBeginImageContext([self size]);
		}
#else
		UIGraphicsBeginImageContext([self size]);
#endif
		CGRect rect = CGRectZero;
		rect.size = [self size];
		
		// Composite tint color at its own opacity.
		[color set];
		UIRectFill(rect);
		
		// Mask tint color-swatch to this image's opaque mask.
		// We want behaviour like NSCompositeDestinationIn on Mac OS X.
		[self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0];
		
		// Finally, composite this image over the tinted mask at desired opacity.
		if (fraction > 0.0) {
			// We want behaviour like NSCompositeSourceOver on Mac OS X.
			[self drawInRect:rect blendMode:kCGBlendModeSourceAtop alpha:fraction];
		}
		image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
		return image;
	}
	
	return self;
}

+(UIImage*)imageWithFrame:(CGSize)size Colors:(NSArray*)colors GradientType:(GradientType)gradientType
{
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case 0:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, size.height);
            break;
        case 1:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, 0.0);
            break;
        case 2:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, size.height);
            break;
        case 3:
            start = CGPointMake(size.width, 0.0);
            end = CGPointMake(0.0,size.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}


static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
                                 float ovalHeight)
{
    float fw, fh;
    
    if (ovalWidth == 0 || ovalHeight == 0)
    {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

- (id)roundedSize:(CGSize)size radius:(NSInteger)r
{
    // the size of CGContextRef
    int w = size.width;
    int h = size.height;
    
    UIImage *img = self;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace,(CGBitmapInfo) kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, r, r);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    
    return img;
}

- (UIColor *) getPixelColorAtLocation:(CGPoint)point {
    
    UIColor* color = nil;
    
    CGImageRef inImage = self.CGImage;
    
    // Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
    
    CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
    
    if (cgctx == NULL) {
        
        return nil; /* error */
        
    }
    
    
    
    size_t w = CGImageGetWidth(inImage);
    
    size_t h = CGImageGetHeight(inImage);
    
    CGRect rect = {{0,0},{w,h}};
    
    
    
    // Draw the image to the bitmap context. Once we draw, the memory
    
    // allocated for the context for rendering will then contain the
    
    // raw image data in the specified color space.
    
    CGContextDrawImage(cgctx, rect, inImage);
    
    
    
    // Now we can get a pointer to the image data associated with the bitmap
    
    // context.
    
    unsigned char* data = CGBitmapContextGetData (cgctx);
    
    if (data != NULL) {
        
        //offset locates the pixel in the data from x,y.
        
        //4 for 4 bytes of data per pixel, w is width of one row of data.
        
        int offset = 4*((w*round(point.y))+round(point.x));
        
        int alpha =  data[offset];
        
        int red = data[offset+1];
        
        int green = data[offset+2];
        
        int blue = data[offset+3];
        
        //NSLog(@"offset: %i colors: RGB A %i %i %i  %i",offset,red,green,blue,alpha);
        
        color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
        
        
        
    }
    
    
    
    // When finished, release the context
    
    CGContextRelease(cgctx);
    
    // Free image data memory for the context
    
    if (data) { free(data); }
    
    return color;
    
}



- (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef) inImage {
    
    
    
    CGContextRef    context = NULL;
    
    CGColorSpaceRef colorSpace;
    
    void *          bitmapData;
    
    unsigned long             bitmapByteCount;
    
    unsigned long           bitmapBytesPerRow;
    
    
    
    // Get image width, height. We'll use the entire image.
    
    size_t pixelsWide = CGImageGetWidth(inImage);
    
    size_t pixelsHigh = CGImageGetHeight(inImage);
    
    
    
    // Declare the number of bytes per row. Each pixel in the bitmap in this
    
    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
    
    // alpha.
    
    bitmapBytesPerRow   = (pixelsWide * 4);
    
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    
    
    // Use the generic RGB color space.
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    
    
    if (colorSpace == NULL)
        
    {
        
        fprintf(stderr, "Error allocating color space\n");
        
        return NULL;
        
    }
    
    
    
    // Allocate memory for image data. This is the destination in memory
    
    // where any drawing to the bitmap context will be rendered.
    
    bitmapData = malloc( bitmapByteCount );
    
    if (bitmapData == NULL)
        
    {
        
        fprintf (stderr, "Memory not allocated!");
        
        CGColorSpaceRelease( colorSpace );
        
        return NULL;
        
    }
    
    
    
    // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
    
    // per component. Regardless of what the source image format is
    
    // (CMYK, Grayscale, and so on) it will be converted over to the format
    
    // specified here by CGBitmapContextCreate.
    
    context = CGBitmapContextCreate (bitmapData,
                                     
                                     pixelsWide,
                                     
                                     pixelsHigh,
                                     
                                     8,      // bits per component
                                     
                                     bitmapBytesPerRow,
                                     
                                     colorSpace,
                                     
                                     (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    
    if (context == NULL)
        
    {
        
        free (bitmapData);
        
        fprintf (stderr, "Context not created!");
        
    }
    
    
    
    // Make sure and release colorspace before returning
    
    CGColorSpaceRelease( colorSpace );
    
    
    
    return context;
    
}

- (instancetype)imageWithOverlayColor:(UIColor *)overlayColor
{
    UIImage *image = self;
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, [overlayColor CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:1.0 orientation: UIImageOrientationDownMirrored];
    
    return flippedImage;
}

//根据颜色创建一个图片
+ (UIImage *)createImageWithColor:(UIColor *)color rect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

-(void)imageWriteToSavedPhotosAlbum:(UIImage *)image result:(CompletionBlock)completionBlock{
    void *blockAsContext = (__bridge_retained void *)[completionBlock copy];
    
    UIImageWriteToSavedPhotosAlbum(image, UIImage.class, @selector(bk_image:didFinishSavingWithError:contextInfo:),blockAsContext);
    
}
- (void)bk_image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    CompletionBlock block = (__bridge_transfer id)contextInfo;
    if (!block) { return; }
    block(error);
}

- (UIImage *)applyLightEffect{
    
    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    return [self applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)applyExtraLightEffect {
    
    UIColor *tintColor = [UIColor colorWithWhite:0.97 alpha:0.82];
    return [self applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)applyDarkEffect {
    
    UIColor *tintColor = [UIColor colorWithWhite:0.11 alpha:0.73];
    return [self applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor {
    
    const CGFloat EffectColorAlpha = 0.6;
    UIColor      *effectColor      = tintColor;
    int           componentCount   = (int)CGColorGetNumberOfComponents(tintColor.CGColor);
    
    if (componentCount == 2) {
        
        CGFloat b;
        if ([tintColor getWhite:&b alpha:NULL]) {
            
            effectColor = [UIColor colorWithWhite:b alpha:EffectColorAlpha];
        }
        
    } else {
        
        CGFloat r, g, b;
        if ([tintColor getRed:&r green:&g blue:&b alpha:NULL]) {
            
            effectColor = [UIColor colorWithRed:r green:g blue:b alpha:EffectColorAlpha];
        }
    }
    
    return [self applyBlurWithRadius:20 tintColor:effectColor saturationDeltaFactor:1.4 maskImage:nil];
}

- (UIImage *)blurImage {
    
    return [self applyBlurWithRadius:20
                           tintColor:[UIColor colorWithWhite:0 alpha:0.0]
               saturationDeltaFactor:1.4
                           maskImage:nil];
}

- (UIImage *)blurImageWithRadius:(CGFloat)radius {
    
    return [self applyBlurWithRadius:radius
                           tintColor:[UIColor colorWithWhite:0 alpha:0.0]
               saturationDeltaFactor:1.4
                           maskImage:nil];
}

- (UIImage *)blurImageWithMask:(UIImage *)maskImage {
    
    return [self applyBlurWithRadius:20
                           tintColor:[UIColor colorWithWhite:0 alpha:0.0]
               saturationDeltaFactor:1.4
                           maskImage:maskImage];
}

- (UIImage *)blurImageAtFrame:(CGRect)frame {
    
    return [self applyBlurWithRadius:20
                           tintColor:[UIColor colorWithWhite:0 alpha:0.0]
               saturationDeltaFactor:1.4
                           maskImage:nil
                             atFrame:frame];
}

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage {
    
    // Check pre-conditions.
    if (self.size.width < 1 || self.size.height < 1) {
        
        NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
        return nil;
    }
    
    if (!self.CGImage) {
        
        NSLog (@"*** error: image must be backed by a CGImage: %@", self);
        return nil;
    }
    
    if (maskImage && !maskImage.CGImage) {
        
        NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    CGRect   imageRect   = { CGPointZero, self.size };
    UIImage *effectImage = self;
    
    BOOL hasBlur             = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            NSUInteger radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
        }
        
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            
            if (hasBlur) {
                
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
                
            } else {
                
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        
        if (!effectImageBuffersAreSwapped) {
            
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        }
        
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped) {
            
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        }
        
        UIGraphicsEndImageContext();
    }
    
    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // Draw effect image.
    if (hasBlur) {
        
        CGContextSaveGState(outputContext);
        
        if (maskImage) {
            
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // Add in color tint.
    if (tintColor) {
        
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

- (UIImage *)grayScale {
    
    int width  = self.size.width;
    int height = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    CGContextRef context = CGBitmapContextCreate(nil,
                                                 width,
                                                 height,
                                                 8, // bits per component
                                                 0,
                                                 colorSpace,
                                                 kCGBitmapByteOrderDefault);
    
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        
        return nil;
    }
    
    CGContextDrawImage(context,
                       CGRectMake(0, 0, width, height), self.CGImage);
    CGImageRef image   = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:image];
    CFRelease(image);
    CGContextRelease(context);
    
    return grayImage;
}

- (UIImage *)scaleWithFixedWidth:(CGFloat)width {
    
    float newHeight = self.size.height * (width / self.size.width);
    CGSize size     = CGSizeMake(width, newHeight);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);
    
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageOut;
}

- (UIImage *)scaleWithFixedHeight:(CGFloat)height {
    
    float newWidth = self.size.width * (height / self.size.height);
    CGSize size    = CGSizeMake(newWidth, height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);
    
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageOut;
}

- (UIColor *)averageColor {
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), self.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    if(rgba[3] > 0) {
        CGFloat alpha = ((CGFloat)rgba[3])/255.0;
        CGFloat multiplier = alpha/255.0;
        return [UIColor colorWithRed:((CGFloat)rgba[0])*multiplier
                               green:((CGFloat)rgba[1])*multiplier
                                blue:((CGFloat)rgba[2])*multiplier
                               alpha:alpha];
    }
    else {
        return [UIColor colorWithRed:((CGFloat)rgba[0])/255.0
                               green:((CGFloat)rgba[1])/255.0
                                blue:((CGFloat)rgba[2])/255.0
                               alpha:((CGFloat)rgba[3])/255.0];
    }
}

- (UIImage *)croppedImageAtFrame:(CGRect)frame {
    
    frame = CGRectMake(frame.origin.x * self.scale,
                       frame.origin.y * self.scale,
                       frame.size.width * self.scale,
                       frame.size.height * self.scale);
    
    CGImageRef sourceImageRef = [self CGImage];
    CGImageRef newImageRef    = CGImageCreateWithImageInRect(sourceImageRef, frame);
    UIImage   *newImage       = [UIImage imageWithCGImage:newImageRef scale:[self scale] orientation:[self imageOrientation]];
    CGImageRelease(newImageRef);
    return newImage;
}

- (UIImage *)addImageToImage:(UIImage *)img atRect:(CGRect)cropRect {
    
    CGSize size = CGSizeMake(self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    
    CGPoint pointImg1 = CGPointMake(0,0);
    [self drawAtPoint:pointImg1];
    
    CGPoint pointImg2 = cropRect.origin;
    [img drawAtPoint: pointImg2];
    
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage
                         atFrame:(CGRect)frame
{
    UIImage *blurredFrame = \
    [[self croppedImageAtFrame:frame] applyBlurWithRadius:blurRadius
                                                tintColor:tintColor
                                    saturationDeltaFactor:saturationDeltaFactor
                                                maskImage:maskImage];
    
    return [self addImageToImage:blurredFrame atRect:frame];
}


@end


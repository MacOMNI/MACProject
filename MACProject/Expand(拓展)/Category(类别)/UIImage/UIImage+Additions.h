

#import <UIKit/UIKit.h>
typedef void(^CompletionBlock)( NSError *error);

typedef enum  {
    topToBottom = 0,//从上到小
    leftToRight = 1,//从左到右
    upleftTolowRight = 2,//左上到右下
    uprightTolowLeft = 3,//右上到左下
}GradientType;

@interface UIColor(Additions)
- (BOOL)isBlackOrWhite;
@end

@interface UIImage (Additions)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size andRoundSize:(CGFloat)roundSize;

+ (UIImage *)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;
+ (UIImage *) buttonImageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius shadowColor:(UIColor *)shadowColor shadowInsets:(UIEdgeInsets)shadowInsets;
+ (UIImage *) circularImageWithColor:(UIColor *)color size:(CGSize)size;
- (UIImage *) imageWithMinimumSize:(CGSize)size;
+ (UIImage *) stepperPlusImageWithColor:(UIColor *)color;
+ (UIImage *) stepperMinusImageWithColor:(UIColor *)color;
+ (UIImage *) backButtonImageWithColor:(UIColor *)color barMetrics:(UIBarMetrics) metrics cornerRadius:(CGFloat)cornerRadius;

- (UIImage *)imageTintedWithColor:(UIColor *)color;
- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction;

//渐变
+(UIImage*)imageWithFrame:(CGSize)size Colors:(NSArray*)colors GradientType:(GradientType)gradientType;

- (id)roundedSize:(CGSize)size radius:(NSInteger)r;

- (UIColor *) getPixelColorAtLocation:(CGPoint)point;

- (instancetype)imageWithOverlayColor:(UIColor *)overlayColor;


/**
 *  根据颜色返回一张图片
 *
 *  @param color 颜色
 *  @param rect  大小
 *
 *  @return 背景图片
 */
+ (UIImage *)createImageWithColor:(UIColor *)color rect:(CGRect)rect;
/**
 *  保存图片到相册
 */
-(void)imageWriteToSavedPhotosAlbum:(UIImage *)image result:(CompletionBlock) completionBlock;
@end


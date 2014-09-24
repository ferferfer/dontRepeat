// Created by Alexey Kopytko in 2013
// Public domain with no warranty whatsoever.

#import "UIImage+Scale.h"

@implementation UIImage (Scale)

- (UIImage *)imageScaledToQuarter
{
    return [self imageScaledToScale:0.25f withInterpolationQuality:kCGInterpolationHigh];
}

- (UIImage *)imageScaledToHalf
{
    return [self imageScaledToScale:0.5f withInterpolationQuality:kCGInterpolationHigh];
}

- (UIImage *)imageScaledToScale:(CGFloat)scale
{
    return [self imageScaledToScale:scale withInterpolationQuality:kCGInterpolationHigh];
}

- (UIImage *)imageScaledToScale:(CGFloat)scale withInterpolationQuality:(CGInterpolationQuality)quality
{
    UIGraphicsBeginImageContextWithOptions(self.size, YES, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, quality);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end

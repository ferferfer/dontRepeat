// Created by Alexey Kopytko in 2013.
// Public domain with no warranty whatsoever.

// Extends the UIImage class to support scaling

@interface UIImage (Scale)
- (UIImage *)imageScaledToQuarter;
- (UIImage *)imageScaledToHalf;
- (UIImage *)imageScaledToScale:(CGFloat)scale;
- (UIImage *)imageScaledToScale:(CGFloat)scale
       withInterpolationQuality:(CGInterpolationQuality)quality;
@end


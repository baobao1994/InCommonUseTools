//
//  UIImage+ImageCache.h
//  91Market
//
//  Created by lory qing on 3/26/12.
//  Copyright (c) 2012 wanglong. All rights reserved.
//

@interface UIImage (ImageCache)

+ (UIImage *)imageCacheWithName:(NSString *)imageName;
- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

@end

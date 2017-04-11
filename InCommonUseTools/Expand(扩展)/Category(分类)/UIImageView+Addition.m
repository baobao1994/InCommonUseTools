//
//  UIImageView+Addition.m
//  AppTalk
//
//  Created by huaiqing xie on 12-1-26.
//  Copyright (c) 2012年 ND. All rights reserved.
//

#import "UIImageView+Addition.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"

@implementation UIImageView (Addition)

- (void)setCornerRadius:(float)cornerRadius {
    CALayer *layer = [self layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:cornerRadius];
}

- (void)setShadowOffset:(CGSize)size radius:(CGFloat)radius color:(UIColor *)color opacity:(CGFloat)opacity {
    self.layer.shadowOffset = size;
    self.layer.shadowRadius = radius;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOpacity = opacity;
    self.layer.masksToBounds = YES;
}

- (void)setCornerRadius:(float)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor = [borderColor CGColor];
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
}

@end

//
//  UIButton+RoundCorner.m
//  NWApp
//
//  Created by apple on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UIButton+Addition.h"
#import <QuartzCore/QuartzCore.h>
#import "UIButton+WebCache.h"

@implementation UIButton(Addition)

- (void)setRoundCorner:(float)radius {
    CALayer * layer = [self layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:radius];
}

- (void)setCornerRadius:(float)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor = [borderColor CGColor];
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
}

@end

//
//  UIButton+RoundCorner.m
//  NWApp
//
//  Created by apple on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIButton(Addition)

- (void)setRoundCorner:(float)radius;
- (void)setCornerRadius:(float)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end

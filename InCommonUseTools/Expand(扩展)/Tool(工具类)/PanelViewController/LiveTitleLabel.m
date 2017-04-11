//
//  LiveTitleLabel.m
//  TigerLottery
//
//  Created by 郭伟文 on 16/8/19.
//  Copyright © 2016年 adcocoa. All rights reserved.
//

#import "LiveTitleLabel.h"

@implementation LiveTitleLabel

- (void)setScale:(CGFloat)scale {
    _scale = scale;
//    self.textColor = [UIColor colorWithRed:scale *254 green:254 blue:254 alpha:1];渐变色
    if (scale == 0) {
        self.textColor = self.norColor;
    } else if (scale == 1) {
        self.textColor = self.selColor;
    }
    CGFloat minScale = 0.8;
    CGFloat trueScale = minScale + (1-minScale)*scale;
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
}

@end

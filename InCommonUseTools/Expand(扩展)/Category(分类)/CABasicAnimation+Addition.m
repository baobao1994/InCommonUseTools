//
//  CABasicAnimation+Addition.m
//  TigerLottery
//
//  Created by 郭伟文 on 17/1/16.
//  Copyright © 2017年 adcocoa. All rights reserved.
//

#import "CABasicAnimation+Addition.h"

@implementation CABasicAnimation (Addition)

+(CABasicAnimation *)opacityForever_Animation:(float)time {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = GID_MAX;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return animation;
}

@end

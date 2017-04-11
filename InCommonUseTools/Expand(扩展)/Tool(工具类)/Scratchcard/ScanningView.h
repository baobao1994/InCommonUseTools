//
//  ScaningView.h
//  InCommonUseTools
//
//  Created by 郭伟文 on 2017/4/11.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScaningConfig.h"
#import <QuartzCore/QuartzCore.h>

@protocol ScanningViewDelegate <NSObject>

- (void)view:(UIView*)view didCatchGesture:(UIGestureRecognizer *)gesture;

@end

@interface ScanningView : UIView

@property (weak, nonatomic) id<ScanningViewDelegate> delegate;
+ (NSInteger)width;
+ (NSInteger)height;

@end

//
//  CustomAlertView.h
//  TigerLottery
//
//  Created by Legolas on 15/1/7.
//  Copyright (c) 2015年 adcocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DirectionType) {
    DirectionTypeOfTop = 1,
    DirectionTypeOfDown,
    DirectionTypeOfLeft,
    DirectionTypeOfRight,
    DirectionTypeOfOrgin
};

@interface CustomAlertView : UIView

@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, assign) DirectionType directionType;

- (void)show;
- (void)hide;
- (void)setCustomContentView:(UIView *)customConentView backGroundColor:(UIColor *)bgColor Alpha:(CGFloat)alpha;
- (void)showDirection:(DirectionType)directionType animateWithDuration:(CGFloat)animateWithDuration;
- (void)hideDirection:(DirectionType)directionType animateWithDuration:(CGFloat)animateWithDuration;
- (void)hideKeyWindow;
- (void)showKeyWindow;

@end

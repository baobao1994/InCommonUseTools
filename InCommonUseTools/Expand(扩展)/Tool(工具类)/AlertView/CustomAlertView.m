//
//  CustomAlertView.m
//  TigerLottery
//
//  Created by Legolas on 15/1/7.
//  Copyright (c) 2015年 adcocoa. All rights reserved.
//

#import "CustomAlertView.h"
#import "UIView+Addtion.h"

@interface CustomAlertView () <CAAnimationDelegate>

@property (nonatomic, retain) UIWindow *keyWindow;
@property (nonatomic, strong) UIView *bgView;
@end

@implementation CustomAlertView

- (id)init {
    if (self = [super init]) {
        _keyWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _keyWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _keyWindow.windowLevel = UIWindowLevelAlert;
        //        window.rootViewController = viewController;
        
        //        BaseWebViewController *baseWebVC = [[BaseWebViewController alloc] initWithNibName:@"BaseWebViewController" bundle:nil url:kTigerNewsUrl title:@"资讯"];
        //        _keyWindow.rootViewController = baseWebVC;
        _bgView = [[UIView alloc] initWithFrame:_keyWindow.frame];
        _bgView.backgroundColor = [UIColor blackColor];
        [_keyWindow addSubview:_bgView];
        _bgView.alpha = 0.5;
        
//        _payPasswordView = [PayPasswordView loadFromNIB];
//        _payPasswordView.delegate = self;
//        [_payPasswordView setCornerRadius:10.0];
//        _payPasswordView.center = CGPointMake(_keyWindow.frame.size.width / 2, 100 + _payPasswordView.center.y);
//        [_payPasswordView.closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
//        [_keyWindow addSubview:_payPasswordView];
    }
    return self;
}

- (void)setContentView:(UIView *)contentView {
    _contentView = contentView;
    [_contentView setCornerRadius:10.0];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    _contentView.center = CGPointMake(screenSize.width / 2, screenSize.height / 2);
    [_keyWindow addSubview:contentView];
}

#pragma mark - Public Method

- (void)setCustomContentView:(UIView *)customConentView backGroundColor:(UIColor *)bgColor Alpha:(CGFloat)alpha{
    _bgView.backgroundColor = bgColor;
    _bgView.alpha = alpha;
    _contentView = customConentView;
    _contentView.frame = customConentView.frame;
    [_keyWindow addSubview:_contentView];
}

- (void)show {
    if (_keyWindow.hidden) {
        [_keyWindow makeKeyAndVisible];
        _keyWindow.hidden = NO;
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        animation.values = @[@(0.01), @(1.1), @(0.9), @(1)];
        animation.keyTimes = @[@(0), @(0.4), @(0.6), @(1)];
        animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        animation.duration = 0.5;
        //    animation.delegate = self;
        //    [animation setValue:completion forKey:@"handler"];
        [_contentView.layer addAnimation:animation forKey:@"bounce"];
        _contentView.transform = CGAffineTransformMakeScale(1, 1);
    }
}

- (void)hide {
    if (!_keyWindow.hidden) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        animation.values = @[@(1), @(1.1), @(0.01)];
        animation.keyTimes = @[@(0), @(0.4), @(1)];
        animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        animation.duration = 0.5;
        animation.delegate = self;
        //    [animation setValue:completion forKey:@"handler"];
        [_contentView.layer addAnimation:animation forKey:@"bounce"];
        _contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    }
}

- (void)showDirection:(DirectionType)directionType animateWithDuration:(CGFloat)animateWithDuration  {
    [_keyWindow makeKeyAndVisible];
    _keyWindow.hidden = NO;
    NSArray *orginArr = [self orginArrWithDirectionType:directionType];
    CGFloat orginX = [orginArr[0] floatValue];
    CGFloat orginY = [orginArr[1] floatValue];
    [UIView animateWithDuration:animateWithDuration animations:^{
        _contentView.frame = CGRectMake(orginX, orginY, UIScreenWidth, UIScreenHeight);
    }];
}

- (void)hideDirection:(DirectionType)directionType animateWithDuration:(CGFloat)animateWithDuration {
    NSArray *orginArr = [self orginArrWithDirectionType:directionType];
    CGFloat orginX = [orginArr[0] floatValue];
    CGFloat orginY = [orginArr[1] floatValue];
    [UIView animateWithDuration:animateWithDuration animations:^{
        _contentView.frame = CGRectMake(orginX, orginY, UIScreenWidth, UIScreenHeight);
    } completion:^(BOOL finished) {
        _keyWindow.hidden = YES;
    }];
}

- (void)hideKeyWindow {
    _keyWindow.hidden = YES;
}

- (void)showKeyWindow {
    _keyWindow.hidden = NO;
}

- (NSArray *)orginArrWithDirectionType:(DirectionType)directionType {
    CGFloat orginX = 0.0f;
    CGFloat orginY = 0.0f;
    switch (directionType) {
        case DirectionTypeOfTop:
            orginX = 0;
            orginY = -UIScreenHeight;
            break;
        case DirectionTypeOfDown:
            orginX = 0;
            orginY = UIScreenHeight;
            break;
        case DirectionTypeOfLeft:
            orginX = -UIScreenWidth;
            orginY = 0;
            break;
        case DirectionTypeOfRight:
            orginX = UIScreenWidth;
            orginY = 0;
            break;
        default:
            break;
    }
    return @[@(orginX),@(orginY)];
}

#pragma mark - CAAnimation delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    _keyWindow.hidden = YES;
    void(^completion)(void) = [anim valueForKey:@"handler"];
    if (completion) {
        completion();
    }
}

@end

//
//  PopNavigationController.m
//  PopViewTest
//
//  Created by Legolas on 15/10/14.
//  Copyright © 2015年 com.tiger. All rights reserved.
//

#import "PopNavigationController.h"

@interface PopNavigationController ()

@end

@implementation PopNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    BOOL isPanGesture = NO;
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint translation = [pan translationInView:self.view];
        if (translation.x > 0) {
            isPanGesture = YES;
        }
    }
    
    if (self.childViewControllers.count > 1 && isPanGesture) {
        return YES;
    }
    return NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

@end

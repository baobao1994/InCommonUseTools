//
//  LaunchView.h
//  Lemon
//
//  Created by Legolas on 13-12-5.
//  Copyright (c) 2013年 Adcocoa. All rights reserved.
//

@class Activity;
@protocol LaunchViewDelegate;

@interface LaunchView : UIView

@property (nonatomic, weak) id<LaunchViewDelegate> delegate;

@end


@protocol LaunchViewDelegate <NSObject>

@optional
- (void)hideLaunchViewDidFinish:(LaunchView *)lauchView;
- (void)didSelectedLaunchViewWithActivity:(Activity *)activity;

@end

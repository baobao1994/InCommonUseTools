//
//  AdPageView.h
//  AdPageView
//
//  Created by Legolas on 14/12/17.
//  Copyright (c) 2014年 adcocoa. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef void (^AdPageCallback)(NSInteger clickIndex);

@protocol AdPageViewDelegate <NSObject>

@optional
- (void)setWebImage:(UIImageView*)imgView imgUrl:(NSString*)imgUrl;

@end

@interface AdPageView : UIView

@property (nonatomic, assign) NSInteger iDisplayTime;
@property (nonatomic, assign) BOOL bWebImage;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) id<AdPageViewDelegate> delegate;

- (void)startAdsWithBlock:(NSArray *)imageArray block:(AdPageCallback)block;
- (void)setupSubviews:(NSArray *)subviews block:(AdPageCallback)block;

@end

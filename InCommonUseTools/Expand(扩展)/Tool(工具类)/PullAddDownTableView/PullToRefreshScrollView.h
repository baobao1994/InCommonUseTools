//
//  PullToRefreshScrollView.h
//  TigerLottery
//
//  Created by Legolas on 16/3/4.
//  Copyright © 2016年 adcocoa. All rights reserved.
//


@protocol PullToRefreshScrollViewDelegate <NSObject>

@optional
- (void)getHeaderDataSoure;

@end


@interface PullToRefreshScrollView : UIScrollView

@property (nonatomic, assign) id<PullToRefreshScrollViewDelegate> refreshDelegate;

- (void)doneLoadingData;

@end

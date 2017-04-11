//
//  RefreshHeaderView.h
//  TigerLottery
//
//  Created by Legolas on 16/11/8.
//  Copyright © 2016年 adcocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RefreshHeaderViewDelegate;

@interface RefreshHeaderView : UIView

@property (nonatomic, assign) id <RefreshHeaderViewDelegate> delegate;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView;

- (void)startRefreshing;
- (void)stopRefreshing;

@end

@protocol RefreshHeaderViewDelegate <NSObject>
@optional

- (void)refreshHeaderViewDidRefreshing:(RefreshHeaderView *)view;

@end

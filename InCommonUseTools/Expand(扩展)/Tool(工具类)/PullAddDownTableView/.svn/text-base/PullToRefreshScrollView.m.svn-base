//
//  PullToRefreshScrollView.m
//  TigerLottery
//
//  Created by Legolas on 16/3/4.
//  Copyright © 2016年 adcocoa. All rights reserved.
//

#import "PullToRefreshScrollView.h"
#import "RefreshHeaderView.h"

@interface PullToRefreshScrollView () <RefreshHeaderViewDelegate>

@property (nonatomic, strong) RefreshHeaderView *refreshHeaderView;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) CGPoint point;

@end


@implementation PullToRefreshScrollView

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self addHeaderRefreshView];
}

#pragma mark - PublicMethod

- (void)doneLoadingData {
    _isLoading = NO;
    [_refreshHeaderView stopRefreshing];
}

#pragma mark - RefreshHeaderViewDelegate

- (void)refreshHeaderViewDidRefreshing:(RefreshHeaderView *)view {
    [self reloadDataSource];
}

#pragma mark - Private Methods

- (void)reloadDataSource{
    _isLoading = YES;
    DELEGATE_CALLBACK(_refreshDelegate, @selector(getHeaderDataSoure));
}

- (void)addHeaderRefreshView {
    if (_refreshHeaderView == nil) {
        _refreshHeaderView = [[RefreshHeaderView alloc] initWithScrollView:self];
        _refreshHeaderView.delegate = self;
    }
}

@end

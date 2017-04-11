//
//  EGORefreshTableHeaderView.h
//  Tmart
//
//  Created by zongteng on 12-1-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

typedef enum{
    EGOOFooterPullRefreshPulling = 0,
    EGOOFooterPullRefreshNormal,
    EGOOFooterPullRefreshLoading
} EGOFooterPullRefreshState;

@protocol EGORefreshTableFooterDelegate;

@interface EGORefreshTableFooterView : UIView {
    
    id _delegate;
    EGOFooterPullRefreshState _state;
    
    UILabel *_lastUpdatedLabel;
    UILabel *_statusLabel;
    UIActivityIndicatorView *_activityView;

}

@property(nonatomic,assign) id <EGORefreshTableFooterDelegate> delegate;

- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end

@protocol EGORefreshTableFooterDelegate

- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView*)view;

@end

//
//  EGORefreshTableHeaderView.m
//  Tmart
//
//  Created by zongteng on 12-1-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EGORefreshTableFooterView.h"
#import <QuartzCore/QuartzCore.h>

#define  RefreshViewHight 65.0f
#define TEXT_COLOR     [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f


@interface EGORefreshTableFooterView (Private)

- (void)setState:(EGOFooterPullRefreshState)aState;

@end

@implementation EGORefreshTableFooterView

@synthesize delegate=_delegate;


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if(self){
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        self.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
        self.backgroundColor = [UIColor clearColor];
       
        _lastUpdatedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, RefreshViewHight - 30.0f, self.frame.size.width, 20.0f)];
        _lastUpdatedLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _lastUpdatedLabel.font = [UIFont systemFontOfSize:12.0f];
        _lastUpdatedLabel.textColor = TEXT_COLOR;
        _lastUpdatedLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        _lastUpdatedLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        _lastUpdatedLabel.backgroundColor = [UIColor clearColor];
        _lastUpdatedLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lastUpdatedLabel];
        
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, RefreshViewHight - 48.0f, self.frame.size.width, 20.0f)];
        _statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _statusLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        _statusLabel.textColor = TEXT_COLOR;
        _statusLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        _statusLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_statusLabel];
        
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.frame = CGRectMake(80.0f, RefreshViewHight - 50.0f, 20.0f, 20.0f);
        [self addSubview:_activityView];
        
        [self setState:EGOOFooterPullRefreshNormal];
        
    }
    
    return self;
    
}

#pragma mark - Setters

- (void)setState:(EGOFooterPullRefreshState)aState{
    
    switch (aState) {
        case EGOOFooterPullRefreshPulling:
            _statusLabel.text = NSLocalizedString(@"松开立即更新...", @"Release to refresh status"); 
            break;
        case EGOOFooterPullRefreshNormal:
            _statusLabel.text = NSLocalizedString(@"上拉即载入更多...", @"Pull up to refresh status");
            [_activityView stopAnimating];
            break;
        case EGOOFooterPullRefreshLoading:
            _statusLabel.text = NSLocalizedString(@"加载中...", @"Loading Status");
            [_activityView startAnimating];
            break;
        default:
            break;
    }
    
    _state = aState;
}


#pragma mark - ScrollView Methods

//手指屏幕上不断拖动调用此方法
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {    
    if (_state == EGOOFooterPullRefreshLoading) {
//        CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
//        offset = MIN(offset, 60);
        scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0f, RefreshViewHight, 0.0f);
    } 
    else if (scrollView.isDragging) {
        
        //BOOL _loading = NO;
       // DELEGATE_CALLBACK_ONE_PARAMETER(_delegate, egoRefreshTableFooterDataSourceIsLoading:, self);
        
        if (/*!_loading &&*/ _state == EGOOFooterPullRefreshPulling && scrollView.contentOffset.y + (scrollView.frame.size.height) < scrollView.contentSize.height + RefreshViewHight && scrollView.contentOffset.y > 0.0f) {
            [self setState:EGOOFooterPullRefreshNormal];
        } else if (/*!_loading && */_state == EGOOFooterPullRefreshNormal && scrollView.contentOffset.y + (scrollView.frame.size.height) > scrollView.contentSize.height + RefreshViewHight) {
            [self setState:EGOOFooterPullRefreshPulling];
        }
        
        if (scrollView.contentInset.bottom != 0) {
            scrollView.contentInset = UIEdgeInsetsZero;
        }
        
    }
    
}

//当用户停止拖动，并且手指从屏幕中拿开的的时候调用此方法
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    
    //BOOL _loading = NO;
   // DELEGATE_CALLBACK_ONE_PARAMETER(_delegate, egoRefreshTableFooterDataSourceIsLoading:, self);

    if (/*!_loading && */scrollView.contentOffset.y + (scrollView.frame.size.height) > scrollView.contentSize.height + RefreshViewHight ) {
        
        [self setState:EGOOFooterPullRefreshLoading];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, RefreshViewHight, 0.0f);
        [UIView commitAnimations];
        
        DELEGATE_CALLBACK_ONE_PARAMETER(_delegate, @selector(egoRefreshTableFooterDidTriggerRefresh:), self);
    
    }
    
}

//当开发者页面页面刷新完毕调用此方法，[delegate egoRefreshScrollViewDataSourceDidFinishedLoading: scrollView];
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    [scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];//////
    [UIView commitAnimations];
    
    [self setState:EGOOFooterPullRefreshNormal];
    
}


#pragma mark - Dealloc

- (void)dealloc {
    _delegate=nil;
    [_activityView release];
    _activityView = nil;
    
    [_statusLabel release];
    _statusLabel = nil;

    [_lastUpdatedLabel release];
    _lastUpdatedLabel = nil;
    [super dealloc];
}


@end

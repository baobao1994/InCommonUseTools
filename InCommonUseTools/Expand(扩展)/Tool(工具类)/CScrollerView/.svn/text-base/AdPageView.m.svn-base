//
//  AdPageView.m
//  AdPageView
//
//  Created by Legolas on 14/12/17.
//  Copyright (c) 2014年 adcocoa. All rights reserved.
//

#import "AdPageView.h"
#import "UIImageView+WebCache.h"

@interface AdPageView() <UIScrollViewDelegate>

@property (nonatomic, assign) int indexShow;
@property (nonatomic, strong) NSArray *contentSource;
@property (nonatomic, strong) UIScrollView *scView;
@property (nonatomic, strong) UIImageView *imgPrev;
@property (nonatomic, strong) UIImageView *imgCurrent;
@property (nonatomic, strong) UIImageView *imgNext;
@property (nonatomic, strong) UIView *previousView;
@property (nonatomic, strong) UIView *currentView;
@property (nonatomic, strong) UIView *nextView;
@property (nonatomic, strong) NSTimer *myTimer;
@property (nonatomic, copy) AdPageCallback myBlock;
@property (nonatomic, assign) BOOL isImagePageView;

@end


@implementation AdPageView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
    }
    return self;
}

#pragma mark - Public Method

- (void)startAdsWithBlock:(NSArray*)imageArray block:(AdPageCallback)block {
    _isImagePageView = YES;
    [self createImageViews];
    _imgPrev.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _imgCurrent.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    _imgNext.frame = CGRectMake(2*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    
    [self setupSubviews:imageArray block:block];
}

- (void)setupSubviews:(NSArray *)subviews block:(AdPageCallback)block {
    if (!_isImagePageView) {
        _previousView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _currentView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        _nextView = [[UIView alloc] initWithFrame:CGRectMake(2*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        
        [_scView addSubview:_previousView];
        [_scView addSubview:_currentView];
        [_scView addSubview:_nextView];
    }
    
    _scView.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
    _pageControl.frame = CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20);
    _pageControl.numberOfPages = subviews.count;
    _contentSource = subviews;
    _myBlock = block;
    if(subviews.count <= 1) {
        _scView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    }
    [self reloadImages];

}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    INVALIDATE_TIMER(_myTimer);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self startTimerPlay];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_myTimer)
        [_myTimer invalidate];
    if (scrollView.contentOffset.x >=self.frame.size.width*2)
        _indexShow++;
    else if (scrollView.contentOffset.x < self.frame.size.width)
        _indexShow--;
    [self reloadImages];
}

#pragma mark - Private Method

- (void)createSubviews {
    _bWebImage = YES;
    _scView = [[UIScrollView alloc] initWithFrame:self.frame];
    _scView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    
    _scView.delegate = self;
    _scView.pagingEnabled = YES;
    _scView.bounces = NO;
    _scView.showsHorizontalScrollIndicator = NO;
    _scView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scView];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAds)];
    [_scView addGestureRecognizer:tap];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20)];
    _pageControl.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:1 alpha:0.3];
    [self addSubview:_pageControl];
}

- (void)createImageViews {
    _imgPrev = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _imgPrev.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _imgPrev.contentMode = UIViewContentModeScaleAspectFill;
    _imgPrev.clipsToBounds = YES;
    
    _imgCurrent = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    _imgCurrent.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _imgCurrent.contentMode = UIViewContentModeScaleAspectFill;
    _imgCurrent.clipsToBounds = YES;
    
    _imgNext = [[UIImageView alloc] initWithFrame:CGRectMake(2*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    _imgNext.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _imgNext.contentMode = UIViewContentModeScaleAspectFill;
    _imgNext.clipsToBounds = YES;
    
    [_scView addSubview:_imgPrev];
    [_scView addSubview:_imgCurrent];
    [_scView addSubview:_imgNext];
}

- (void)tapAds {
    if (_myBlock != NULL) {
        _myBlock(_indexShow);
    }
}

- (void)reloadImages {
    if (_indexShow >= (int)_contentSource.count)
        _indexShow = 0;
    if (_indexShow < 0)
        _indexShow = (int)_contentSource.count - 1;
    int prev = 0;
    int next = 0;
    if (_contentSource.count > 0) {
        prev = _indexShow - 1;
        if (prev < 0)
            prev = (int)_contentSource.count - 1;
        next = _indexShow + 1;
        if (next > _contentSource.count - 1)
            next = 0;
    }

    _pageControl.currentPage = _indexShow;
    if (_isImagePageView) {
        NSString *prevImage;
        NSString *curImage;
        NSString *nextImage;
        if (_contentSource.count > 0) {
            prevImage = [_contentSource objectAtIndex:prev];
            curImage = [_contentSource objectAtIndex:_indexShow];
            nextImage = [_contentSource objectAtIndex:next];
        }
        if(_bWebImage) {
            [_imgPrev sd_setImageWithURL:[NSURL URLWithString:prevImage] placeholderImage:[UIImage imageNamed:@"banner_default.png"]];
            [_imgCurrent sd_setImageWithURL:[NSURL URLWithString:curImage] placeholderImage:[UIImage imageNamed:@"banner_default.png"]];
            [_imgNext sd_setImageWithURL:[NSURL URLWithString:nextImage] placeholderImage:[UIImage imageNamed:@"banner_default.png"]];
        }else {
            _imgPrev.image = [UIImage imageNamed:prevImage];
            _imgCurrent.image = [UIImage imageNamed:curImage];
            _imgNext.image = [UIImage imageNamed:nextImage];
        }
    }else {
        [_previousView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [_previousView addSubview:[_contentSource objectAtIndex:prev]];
        [_currentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [_currentView addSubview:[_contentSource objectAtIndex:_indexShow]];
        [_nextView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [_nextView addSubview:[_contentSource objectAtIndex:next]];
    }

    [_scView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
    [self startTimerPlay];
}

- (void)startTimerPlay {
    if (_iDisplayTime > 0) {
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:_iDisplayTime target:self selector:@selector(doImageGoDisplay) userInfo:nil repeats:NO];
    }
}

- (void)doImageGoDisplay {
    [_scView scrollRectToVisible:CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, self.frame.size.height) animated:YES];
    _indexShow++;
    if (_myTimer)
        [_myTimer invalidate];
    [self performSelector:@selector(reloadImages) withObject:nil afterDelay:0.3];
}

@end

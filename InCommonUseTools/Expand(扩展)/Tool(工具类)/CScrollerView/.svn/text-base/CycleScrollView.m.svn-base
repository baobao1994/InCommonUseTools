//
//  CycleScrollView.m
//  PagedScrollView
//
//  Created by Legolas on 14/12/17.
//  Copyright (c) 2014年 adcocoa. All rights reserved.
//

#import "CycleScrollView.h"
#import "NSTimer+Addition.h"
#import "UIImageView+WebCache.h"

@interface CycleScrollView () <UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *noteTitle;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *animationTimer;
@property (nonatomic, assign) NSTimeInterval animationDuration;

@end


@implementation CycleScrollView

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration {
    self = [self initWithFrame:frame];
    if (animationDuration > 0.0) {
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        [self.animationTimer pauseTimer];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
        self.imageViews = [NSMutableArray arrayWithCapacity:3];
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        [self.scrollView setScrollEnabled:NO];
        [self addSubview:self.scrollView];
        self.currentPageIndex = 0;
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 20, 100, 20)];
        self.pageControl.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        self.pageControl.center = CGPointMake(self.center.x, self.pageControl.center.y);
        self.pageControl.currentPage = 0;
        [self addSubview:self.pageControl];
        
        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width * i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
            [imageView setImage:[UIImage imageNamed:@"slide_def.png"]];
            imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
            [imageView addGestureRecognizer:tapGesture];
            [_imageViews addObject:imageView];
            [self.scrollView addSubview:imageView];
        }
    }
    return self;
}

- (void)setImageUrls:(NSArray *)imageUrls {
    if (imageUrls != _imageUrls) {
        _imageUrls = imageUrls;
        _pageControl.numberOfPages = [imageUrls count];
        
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = [_imageViews objectAtIndex:i];
            imageView.frame = CGRectMake(self.scrollView.frame.size.width * i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        }
        [self configContentViews];
        if (imageUrls.count > 1) {
            [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
        }
    }
}

- (void)setTitles:(NSArray *)titles {
    if (_titles != titles) {
        _titles = titles;
        if ([_titles count] > _currentPageIndex) {
            [_noteTitle setText:[_titles objectAtIndex:_currentPageIndex]];
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
//    [self setupScrollView:targetContentOffset->x];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    float contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    }
    self.pageControl.currentPage = _currentPageIndex;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self setupScrollView:_scrollView.contentOffset.x];
}

- (void)setupScrollView:(float)contentOffsetX {
//    float contentOffsetX = _scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(_scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    }
    self.pageControl.currentPage = _currentPageIndex;
    [self configContentViews];
}

#pragma mark - Event

- (void)animationTimerDidFired:(NSTimer *)timer {
    if ([_imageUrls count] > 1) {
//        NSInteger nextPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGPoint newOffset = CGPointMake(2 * width, self.scrollView.contentOffset.y);
        [self.scrollView setContentOffset:newOffset animated:YES];
        [self configContentViews];
    }
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap {
    if (self.TapActionBlock) {
        self.TapActionBlock(self.currentPageIndex);
    }
}

#pragma mark - Private

- (void)configContentViews {
    if ([_imageUrls count] > 0) {
        NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
        NSInteger nextPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
        NSMutableArray *validUrls = [NSMutableArray arrayWithCapacity:3];
        [validUrls addObject:[_imageUrls objectAtIndex:previousPageIndex]];
        [validUrls addObject:[_imageUrls objectAtIndex:_currentPageIndex]];
        [validUrls addObject:[_imageUrls objectAtIndex:nextPageIndex]];
        
        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = [_imageViews objectAtIndex:i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[validUrls objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"banner_default.png"]];
        }
        if ([_titles count] > _currentPageIndex) {
            [_noteTitle setText:[_titles objectAtIndex:_currentPageIndex]];
        }
        
        if ([_imageUrls count] == 1) {
            [_scrollView setScrollEnabled:NO];
        }else {
            [_scrollView setScrollEnabled:YES];
        }
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
     }
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)pageIndex {
    if(pageIndex <= -1) {
        return [_imageUrls count] - 1;
    } else if (pageIndex >= [_imageUrls count]) {
        return 0;
    } else {
        return pageIndex;
    }
}

@end

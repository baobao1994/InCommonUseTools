//
//  RefreshHeaderView.m
//  TigerLottery
//
//  Created by Legolas on 16/11/8.
//  Copyright © 2016年 adcocoa. All rights reserved.
//

#import "RefreshHeaderView.h"
#import "UIImage+GIF.h"

#define kRefreshViewHeight 153
#define kContentOffset     @"contentOffset"

typedef enum{
    RefreshStateDefault,
    RefreshStateVisible,
    RefreshStateTrigger,
    RefreshStateLoading
} RefreshState;

@interface RefreshHeaderView ()

@property (nonatomic, assign) CGPoint currentOffset;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) UIEdgeInsets originalContentInset;
@property (nonatomic, assign) RefreshState refreshState;
@property (nonatomic, strong) CALayer *rockerImageLayer;
@property (nonatomic, strong) CALayer *rockerBallLayer;
@property (nonatomic, strong) UIImageView *normalImageView;

@end


@implementation RefreshHeaderView

- (instancetype)initWithScrollView:(UIScrollView *)scrollView {
    self = [super initWithFrame:CGRectMake(0, scrollView.contentInset.top, scrollView.frame.size.width, kRefreshViewHeight)];
    if (self) {
        _scrollView = scrollView;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        UIView *bgView = [[UIView alloc] initWithFrame:scrollView.bounds];
        bgView.backgroundColor = scrollView.backgroundColor;
        bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_scrollView insertSubview:bgView atIndex:0];
        _scrollView.backgroundColor = [UIColor clearColor];
        
        [_scrollView addObserver:self forKeyPath:kContentOffset options:NSKeyValueObservingOptionNew context:nil];
        [_scrollView.superview insertSubview:self belowSubview:scrollView];
        NSString *widthVf = @"H:|-0-[refreshView]-0-|";
        [_scrollView.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:widthVf options:0 metrics:nil views:_NSDictionaryOfVariableBindings(@"refreshView", self)]];
        NSString *heightVf = @"V:|-0-[refreshView(==153)]";
        [_scrollView.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:heightVf options:0 metrics:nil views:_NSDictionaryOfVariableBindings(@"refreshView", self)]];
        
        [self loadComponent];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview) {
        [self.scrollView removeObserver:self forKeyPath:kContentOffset];
        self.scrollView = nil;
    }
}

- (void)dealloc {
    [_scrollView removeObserver:self forKeyPath:kContentOffset];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:kContentOffset]) {
        _currentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        self.hidden = (_currentOffset.y > kRefreshViewHeight * 2);
        CGFloat newOffsetThreshold = -40;
        if (_refreshState == RefreshStateLoading || _currentOffset.y > _originalContentInset.top) {return;}
        
        if (!self.scrollView.isDragging && _refreshState == RefreshStateTrigger) {
            self.refreshState = RefreshStateLoading;
        }else if (_currentOffset.y <= newOffsetThreshold * 2 && self.scrollView.isDragging) {
            self.refreshState = RefreshStateTrigger;
        }else if (_currentOffset.y < -_originalContentInset.top && _currentOffset.y > newOffsetThreshold * 2  && _refreshState != RefreshStateLoading) {
            self.refreshState = RefreshStateVisible;
        }else if (_currentOffset.y >= newOffsetThreshold && _refreshState != RefreshStateDefault && _refreshState != RefreshStateLoading) {
            self.refreshState = RefreshStateDefault;
        }
    }
}

#pragma mark - PublicMehtod

- (void)startRefreshing {
    if (_refreshState != RefreshStateLoading) {
        self.refreshState = RefreshStateLoading;
    }
}

- (void)stopRefreshing {
    if (_refreshState != RefreshStateDefault) {
        self.refreshState = RefreshStateDefault;
    }
}

#pragma mark - PrivateMethod

- (void)setScrollView:(UIScrollView *)scrollView {
    _scrollView = scrollView;
    _originalContentInset = _scrollView.contentInset;
    _scrollView.backgroundColor = [UIColor clearColor];
}

- (void)setRefreshState:(RefreshState)refreshState {
    _refreshState = refreshState;
    switch (_refreshState) {
        case RefreshStateDefault:
        {
            [self updateContentInset:_originalContentInset];
            [self changeNormalImageView];
        }
            break;
        case RefreshStateVisible:
        {
            [self updateBallLayerPosition];
        }
            break;
        case RefreshStateTrigger:
        {
            [self updateBallLayerPosition];
        }
            break;
        case RefreshStateLoading:
        {
            UIEdgeInsets ei = _originalContentInset;
            ei.top = ei.top + 78;
            [self updateContentInset:ei];
            [self updateBallLayerPosition];
            [self resetRockerPosition];
            [self changeNormalImageView];
            DELEGATE_CALLBACK_ONE_PARAMETER(_delegate, @selector(refreshHeaderViewDidRefreshing:), self);
        }
            break;
        default:
            break;
    }
}

- (void)updateContentInset:(UIEdgeInsets)ei {
    [UIView animateWithDuration:.25 animations:^{
        _scrollView.contentInset = ei;
    }];
}

- (void)updateBallLayerPosition {
    CGFloat ballLayerMinY = fabs(_currentOffset.y) - _originalContentInset.top - 24;
    CGFloat ballLayerMaxY = 54;
    if (ballLayerMinY >= ballLayerMaxY) {
        ballLayerMinY  = ballLayerMaxY;
    }
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    _rockerImageLayer.position = CGPointMake(self.center.x + 33, ballLayerMinY);
    CGFloat rotation = (M_PI / 180.0) * (ballLayerMinY * 90 / ballLayerMaxY);
    _rockerImageLayer.transform = CATransform3DMakeRotation((M_PI / 180.0) * (ballLayerMinY * 90 / ballLayerMaxY), 1.0f, 0.0f, 0.0f);
    CGFloat a = 13 - cos(rotation) * 13;
    _rockerBallLayer.position = CGPointMake(self.center.x + 33, ballLayerMinY-11 + a);
    [CATransaction commit];
    _normalImageView.center = CGPointMake(self.center.x, ballLayerMinY);

}

- (void)resetRockerPosition {
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    [CATransaction setAnimationDuration:0.2];
    _rockerImageLayer.transform = CATransform3DMakeRotation((M_PI / 180.0), 1.0f, 0.0f, 0.0f);
    _rockerBallLayer.position = CGPointMake(self.center.x + 33, _rockerBallLayer.position.y - 13);
    [CATransaction commit];
}

- (void)changeNormalImageView {
    if (_refreshState == RefreshStateLoading) {
        [_normalImageView startAnimating];
    }else {
        [_normalImageView stopAnimating];
    }
}

- (void)loadComponent {
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refresh_logo"]];
    logoImageView.center = CGPointMake(self.center.x, 90);
    logoImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:logoImageView];
    
    _normalImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refresh_normal_image"]];
    _normalImageView.center = CGPointMake(self.center.x, -_normalImageView.frame.size.height / 2 - 10);
    [self addSubview:_normalImageView];
    
    NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:6];
    for (int i = 1; i < 16; i++) {
        NSString *imageName = [NSString stringWithFormat:@"refreshing_image_%d", i];
        UIImage *image = [UIImage imageNamed:imageName];
        [images addObject:image];
    }
    _normalImageView.animationImages = images;
    _normalImageView.animationRepeatCount = MAXFLOAT;
    _normalImageView.animationDuration = 0.4;
    
    _rockerImageLayer = [CALayer layer];
    _rockerImageLayer.frame = CGRectMake(0, 0, 2.0f, 13.0f);
    _rockerImageLayer.position = CGPointMake(self.center.x + 33, -24);
    _rockerImageLayer.anchorPoint = CGPointMake(0.5, 1);
    _rockerImageLayer.contents = (id)[UIImage imageNamed:@"refresh_rocker"].CGImage;
    [self.layer addSublayer:_rockerImageLayer];
    
    _rockerBallLayer = [CALayer layer];
    _rockerBallLayer.frame = CGRectMake(0, 0, 5.0f, 5.0f);
    _rockerBallLayer.position = CGPointMake(self.center.x + 33, -37);
    
    _rockerBallLayer.contents = (id)[UIImage imageNamed:@"rocker_ball"].CGImage;
    [self.layer addSublayer:_rockerBallLayer];
}

@end

//
//  AutoScrollLabel.m
//  MFun
//
//  Created by Legolas on 4/25/12.
//  Copyright (c) 2012 bodong NetDragon. All rights reserved.
//

#import "AutoScrollLabel.h"
#import <QuartzCore/QuartzCore.h>

#define LABEL_BUFFER_SPACE 40   // pixel buffer space between scrolling label
#define DEFAULT_PIXELS_PER_SECOND 30
#define DEFAULT_PAUSE_TIME 1.0f

@interface AutoScrollLabel()

- (void)commonInit;
- (void)readjustLabels;
- (void)doStart;
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;

@end


@implementation AutoScrollLabel

@synthesize scrollLabelDelegate = _scrollLabelDelegate;
@synthesize autoScrollCount = _autoScrollCount;
@synthesize textColor = _textColor;

#pragma mark -
#pragma mark view lifecycle

- (id)init {
	if (self = [super init]) {
		[self commonInit];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		[self commonInit];
    }
    return self;
}

- (void)dealloc {
    [self.layer removeAllAnimations];
}

#pragma mark -
#pragma mark public func

- (void)setLabelFrame:(CGRect)frame {
	self.frame = frame;
	[self readjustLabels];
}

- (void)start {
    [self performSelector:@selector(doStart) withObject:nil afterDelay:DEFAULT_PAUSE_TIME];
}

- (void)stop {
    if ([self.layer respondsToSelector:@selector(removeAnimationForKey:)]) {
        [self.layer removeAnimationForKey:@"scroll"];
    }
    else {
        [self.layer addAnimation:nil forKey:@"scroll"];
    }
    
    _isScrolling = NO;
    _finishedScrollCount = 0;
    [self readjustLabels];
}

- (void)setLabelTextColor:(UIColor *)color {
    _label.textColor = color;
}

#pragma mark -
#pragma mark members attribute set func

- (void)setText:(NSString *)text {
    if (![text isEqualToString:_label.text]) {
        _label.text = text;
        [self readjustLabels];
    }
}

- (NSString *)text {
    return _label.text;
}

- (void)setTextColor:(UIColor *)color {
    _label.textColor = color;
}

- (UIColor *)textColor {
    return _label.textColor;
}

- (void)setFont:(UIFont *)font {
    _label.font = font;
    [self readjustLabels];
}

- (UIFont *)font {
    return _label.font;
}

- (void)setScrollSpeed:(float)speed {
	_scrollSpeed = speed;
	[self readjustLabels];
}

- (float)scrollSpeed {
	return _scrollSpeed;
}

- (void)setScrollDirection:(AutoScrollDirection)direction {
	_scrollDirection = direction;
	[self readjustLabels];
}

- (AutoScrollDirection)scrollDirection {
	return _scrollDirection;
}

#pragma mark -
#pragma mark private func

- (void)commonInit {	
    _label = [[UILabel alloc] init];
    _label.textAlignment = NSTextAlignmentLeft;
    _label.textColor = [UIColor whiteColor];
    _label.backgroundColor = [UIColor clearColor];
    [self addSubview:_label];
    
	_scrollDirection = kAutomaticRollingLeft;
	_scrollSpeed = DEFAULT_PIXELS_PER_SECOND;
	self.showsVerticalScrollIndicator = NO;
	self.showsHorizontalScrollIndicator = NO;
	self.userInteractionEnabled = NO;
	_isScrolling = NO;
}

- (void)readjustLabels {
	float offset = 0.0f;
	
    [_label sizeToFit];
    CGPoint center;
    center = _label.center;
    center.y = self.center.y - self.frame.origin.y;
    _label.center = center;
    
    CGRect frame;
    frame = _label.frame;
    frame.origin.x = offset;
    _label.frame = frame;
//    offset += _label.frame.size.width + LABEL_BUFFER_SPACE;
	
	CGSize size;
    size.width = _label.frame.size.width + self.frame.size.width + LABEL_BUFFER_SPACE;
	size.height = self.frame.size.height;
	self.contentSize = size;
	
	[self setContentOffset:CGPointMake(0,0) animated:NO];
}

- (void)doStart {
    if (_label.frame.size.width > self.frame.size.width) {
        _isScrolling = YES;
        self.contentOffset = (_scrollDirection == kAutomaticRollingLeft) ? CGPointMake(0, 0) : CGPointMake(_label.frame.size.width+LABEL_BUFFER_SPACE, 0);
        [UIView beginAnimations:@"scroll" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        [UIView setAnimationDuration:_label.frame.size.width/(float)_scrollSpeed];
        self.contentOffset = (_scrollDirection == kAutomaticRollingLeft) ? CGPointMake(_label.frame.size.width+LABEL_BUFFER_SPACE, 0) : CGPointMake(0, 0);
        [UIView commitAnimations];
    }
    else {
        DELEGATE_CALLBACK(_scrollLabelDelegate, @selector(labelNotNeedScroll));
    }
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    _isScrolling = NO;
    if (0 == _autoScrollCount || ++_finishedScrollCount < _autoScrollCount) {
        if ([finished intValue]==1 && _label.frame.size.width>self.frame.size.width) {
            [self start];
        }
    }
    else {
        _finishedScrollCount = 0;
        DELEGATE_CALLBACK(_scrollLabelDelegate, @selector(labelScrollDidFinish));
    }
}

@end

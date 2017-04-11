//
//  AutoScrollLabel.m
//  DianJinOfferPlatform
//
//  Created by Legolas on 12-2-10.
//  Copyright 2012 NetDragon WebSoft Inc.. All rights reserved.
//

#import "AutoLoopScrollLabel.h"

#define LOOP_SCROLL_LABEL_BUFFER_SPACE 40   // pixel buffer space between scrolling label
#define LOOP_SCROLL_DEFAULT_PIXELS_PER_SECOND 30
#define LOOP_SCROLL_DEFAULT_PAUSE_TIME 0.5f

@interface AutoLoopScrollLabel()

- (void)commonInit;
- (void)appBecomeActive;
- (void)readjustLabels;

@end


@implementation AutoLoopScrollLabel

@synthesize pauseInterval = _pauseInterval;
@synthesize bufferSpaceBetweenLabels = _bufferSpaceBetweenLabels;

#pragma mark -
#pragma mark view lifecycle

- (id)init {
	if (self = [super init]) {
        // Initialization code
		[self commonInit];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        // Initialization code
		[self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		[self commonInit];
    }
    return self;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark public func

- (void)setLabelFrame:(CGRect)frame {
	self.frame = frame;
	[self readjustLabels];
}

#if 0
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	[NSThread sleepForTimeInterval:pauseInterval];

	_isScrolling = NO;
	
	if ([finished intValue]==1 && label[0].frame.size.width>self.frame.size.width) {
		[self scroll];
	}	
}
#else
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	_isScrolling = NO;
	if ([finished intValue]==1 && _label[0].frame.size.width>self.frame.size.width) {
//		[NSTimer scheduledTimerWithTimeInterval:_pauseInterval target:self selector:@selector(scroll) userInfo:nil repeats:NO];
		[self performSelector:@selector(scroll) withObject:nil afterDelay:_pauseInterval];
	}
} 
#endif

- (void)scroll {
	// Prevent multiple calls
//	NDLOG(@"isScrolling %d", _isScrolling ? 1: 0);
//	if (_isScrolling) {
//		return;
//	}
	_isScrolling = YES;
	if (_scrollDirection == kAutoRollingLeft) {
		self.contentOffset = CGPointMake(0,0);
	}
	else {
		self.contentOffset = CGPointMake(_label[0].frame.size.width+LOOP_SCROLL_LABEL_BUFFER_SPACE,0);
	}
	[UIView beginAnimations:@"scroll" context:nil];
    [UIView setAnimationDelegate:self];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	[UIView setAnimationDuration:_label[0].frame.size.width/(float)_scrollSpeed];
	
	if (_scrollDirection == kAutoRollingLeft) {
		self.contentOffset = CGPointMake(_label[0].frame.size.width+LOOP_SCROLL_LABEL_BUFFER_SPACE,0);
	}
	else {
		self.contentOffset = CGPointMake(0,0);
	}		
	
	[UIView commitAnimations];
}

- (void)setLabelTextColor:(UIColor *)color {
	for (int i=0; i<LOOP_SCROLL_NUM_LABELS; ++i) {
		_label[i].textColor = color;
	}
}

#pragma mark -
#pragma mark members attribute set func

- (void)setText:(NSString *)text {
	// If the text is identical, don't reset it, otherwise it causes scrolling jitter
	if ([text isEqualToString:_label[0].text]) {
		// But if it isn't scrolling, make it scroll
		// If the label is bigger than the space allocated, then it should scroll
		if (_label[0].frame.size.width > self.frame.size.width) {
			[self scroll];
		}
		return;
	}
	
	for (int i=0; i<LOOP_SCROLL_NUM_LABELS; ++i) {
		_label[i].text = text;
	}
	[self readjustLabels];
}

- (NSString *)text {
	return _label[0].text;
}

- (void)setTextColor:(UIColor *)color {
	for (int i=0; i<LOOP_SCROLL_NUM_LABELS; ++i) {
		_label[i].textColor = color;
	}
}

- (UIColor *)textColor {
	return _label[0].textColor;
}

- (void)setFont:(UIFont *)font {
	for (int i=0; i<LOOP_SCROLL_NUM_LABELS; ++i) {
		_label[i].font = font;
	}
//	[self readjustLabels];
}

- (UIFont *)font {
	return _label[0].font;
}

- (void)setScrollSpeed:(float)speed {
	_scrollSpeed = speed;
	[self readjustLabels];
}

- (float)scrollSpeed {
	return _scrollSpeed;
}

- (void)setScrollDirection:(AutoLoopScrollDirection)direction {
	_scrollDirection = direction;
	[self readjustLabels];
}

- (AutoLoopScrollDirection)scrollDirection {
	return _scrollDirection;
}

#pragma mark -
#pragma mark private func

- (void)commonInit {
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(appBecomeActive)
												 name:UIApplicationDidBecomeActiveNotification
											   object:nil];
	
	for (int i=0; i<LOOP_SCROLL_NUM_LABELS; ++i) {
		_label[i] = [[UILabel alloc] init];
		_label[i].textAlignment = NSTextAlignmentLeft;
		_label[i].textColor = [UIColor whiteColor];
		_label[i].backgroundColor = [UIColor clearColor];
		[self addSubview:_label[i]];
	}
	
	_scrollDirection = kAutoRollingLeft;
	_scrollSpeed = LOOP_SCROLL_DEFAULT_PIXELS_PER_SECOND;
	_pauseInterval = LOOP_SCROLL_DEFAULT_PAUSE_TIME;
	_bufferSpaceBetweenLabels = LOOP_SCROLL_LABEL_BUFFER_SPACE;
	self.showsVerticalScrollIndicator = NO;
	self.showsHorizontalScrollIndicator = NO;
	self.userInteractionEnabled = NO;
	_isScrolling = NO;
}

- (void)appBecomeActive {
	_isScrolling = NO;
	[self readjustLabels];
}

- (void)readjustLabels {
	float offset = 0.0f;
	
	for (int i=0; i<LOOP_SCROLL_NUM_LABELS; ++i) {
		[_label[i] sizeToFit];
//		CGSize size = [_label[i].text sizeWithFont: _label[i].font];
//		_label[i].frame = CGRectMake(0+offset, 0, size.width, size.height);
		
		// Recenter label vertically within the scroll view
		CGPoint center;
		center = _label[i].center;
		center.y = self.center.y - self.frame.origin.y;
		_label[i].center = center;
		
		CGRect frame;
		frame = _label[i].frame;
		frame.origin.x = offset;
		_label[i].frame = frame;
		
		offset += _label[i].frame.size.width + LOOP_SCROLL_LABEL_BUFFER_SPACE;
	}
	
	CGSize size;
	size.width = _label[0].frame.size.width + self.frame.size.width + LOOP_SCROLL_LABEL_BUFFER_SPACE;
	size.height = self.frame.size.height;
	self.contentSize = size;
	
	[self setContentOffset:CGPointMake(0,0) animated:NO];
	
	// If the label is bigger than the space allocated, then it should scroll
	if (_label[0].frame.size.width > self.frame.size.width) {
		for (int i=1; i<LOOP_SCROLL_NUM_LABELS; ++i) {
			_label[i].hidden = NO;
		}
		[self scroll];
	}
	else {
		// Hide the other labels out of view
		for (int i=1; i<LOOP_SCROLL_NUM_LABELS; ++i) {
			_label[i].hidden = YES;
		}
	}
}

@end

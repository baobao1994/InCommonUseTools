//
//  iToast.m
//  iToast
//
//  Created by Diallo Mamadou Bobo on 2/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Toast.h"
#import <QuartzCore/QuartzCore.h>


@interface Toast()

@property (nonatomic, copy) NSString *text;
@property (nonatomic, retain) UIView *view;

- (id)initWithText:(NSString *)text;

@end

@implementation Toast

@synthesize text = _text;
@synthesize view = _view;

#pragma -
#pragma Object lifecycle

- (id)initWithText:(NSString *)text {
	if (self = [super init]) {
		self.text = text;
        _setting = [[ToastSetting alloc] init];
	}
	
	return self;
}

- (void)dealloc {
    RELEASE_SAFELY(_text);
    RELEASE_SAFELY(_setting);
    RELEASE_SAFELY(_view);
    [super dealloc];
}

#pragma -
#pragma public func

+ (Toast *)makeText:(NSString *)text {
	Toast *toast = [[[Toast alloc] initWithText:text] autorelease];
	return toast;
}

- (void)show {
	[self show:kiToastTypeNone];
}

- (void)show:(ToastType)type {
	ToastSetting *theSettings = _setting;
    
	UIImage *image = [theSettings.images valueForKey:[NSString stringWithFormat:@"%i", type]];
	
	UIFont *font = [UIFont systemFontOfSize:14];
	CGSize textSize = [_text sizeWithFont:font constrainedToSize:CGSizeMake(280, 60)];
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width + 5, textSize.height + 5)];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor whiteColor];
	label.font = font;
	label.text = _text;
	label.numberOfLines = 0;
	label.shadowColor = [UIColor darkGrayColor];
	label.shadowOffset = CGSizeMake(1, 1);
	
	UIButton *v = [UIButton buttonWithType:UIButtonTypeCustom];
	if (image) {
		v.frame = CGRectMake(0, 0, image.size.width + textSize.width + 15, MAX(textSize.height, image.size.height) + 10);
		label.center = CGPointMake(image.size.width + 10 + (v.frame.size.width - image.size.width - 10) / 2, v.frame.size.height / 2);
	} else {
		v.frame = CGRectMake(0, 0, textSize.width + 10, textSize.height + 10);
		label.center = CGPointMake(v.frame.size.width / 2, v.frame.size.height / 2);
	}
	[v addSubview:label];
	[label release];
	
	if (image) {
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		imageView.frame = CGRectMake(5, (v.frame.size.height - image.size.height)/2, image.size.width, image.size.height);
		[v addSubview:imageView];
		[imageView release];
	}
	
	v.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
	v.layer.cornerRadius = 5;
	
	UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
	
	CGPoint point = CGPointMake(window.frame.size.width/2, window.frame.size.height/2);
	
	// Set correct orientation/location regarding device orientation
	UIInterfaceOrientation orientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
	switch (orientation) {
		case UIDeviceOrientationPortrait:
		{
			if (theSettings.gravity == kToastGravityTop) {
				point = CGPointMake(window.frame.size.width / 2, 80);
			} else if (theSettings.gravity == kToastGravityBottom) {
				point = CGPointMake(window.frame.size.width / 2, window.frame.size.height - 80);
			} else if (theSettings.gravity == kToastGravityCenter) {
				point = CGPointMake(window.frame.size.width/2, window.frame.size.height/2);
			} else {
				point = theSettings.postition;
			}
			
			point = CGPointMake(point.x + _offsetLeft, point.y + _offsetTop);
			break;
		}
		case UIDeviceOrientationPortraitUpsideDown:
		{
			v.transform = CGAffineTransformMakeRotation(M_PI);
			
			float width = window.frame.size.width;
			float height = window.frame.size.height;
			
			if (theSettings.gravity == kToastGravityTop) {
				point = CGPointMake(width / 2, height - 80);
			} else if (theSettings.gravity == kToastGravityBottom) {
				point = CGPointMake(width / 2, 80);
			} else if (theSettings.gravity == kToastGravityCenter) {
				point = CGPointMake(width/2, height/2);
			} else {
				// TODO : handle this case
				point = theSettings.postition;
			}
			
			point = CGPointMake(point.x - _offsetLeft, point.y - _offsetTop);
			break;
		}
		case UIDeviceOrientationLandscapeLeft:
		{
			v.transform = CGAffineTransformMakeRotation(M_PI/2); //rotation in radians
			
			if (theSettings.gravity == kToastGravityTop) {
				point = CGPointMake(window.frame.size.width - 80, window.frame.size.height / 2);
			} else if (theSettings.gravity == kToastGravityBottom) {
				point = CGPointMake(80, window.frame.size.height / 2);
			} else if (theSettings.gravity == kToastGravityCenter) {
				point = CGPointMake(window.frame.size.width/2, window.frame.size.height/2);
			} else {
				// TODO : handle this case
				point = theSettings.postition;
			}
			
			point = CGPointMake(point.x - _offsetTop, point.y - _offsetLeft);
			break;
		}
		case UIDeviceOrientationLandscapeRight:
		{
			v.transform = CGAffineTransformMakeRotation(-M_PI/2);
			
			if (theSettings.gravity == kToastGravityTop) {
				point = CGPointMake(80, window.frame.size.height / 2);
			} else if (theSettings.gravity == kToastGravityBottom) {
				point = CGPointMake(window.frame.size.width - 80, window.frame.size.height/2);
			} else if (theSettings.gravity == kToastGravityCenter) {
				point = CGPointMake(window.frame.size.width/2, window.frame.size.height/2);
			} else {
				// TODO : handle this case
				point = theSettings.postition;
			}
			
			point = CGPointMake(point.x + _offsetTop, point.y + _offsetLeft);
			break;
		}
		default:
			break;
	}
    
	v.center = point;
	NSTimer *timer1 = [NSTimer timerWithTimeInterval:((float)theSettings.duration)/1000 
                                              target:self selector:@selector(hideToast:) 
                                            userInfo:nil repeats:NO];
	[[NSRunLoop mainRunLoop] addTimer:timer1 forMode:NSDefaultRunLoopMode];
	
	[window addSubview:v];
	self.view = v;
	[v addTarget:self action:@selector(hideToast:) forControlEvents:UIControlEventTouchDown];
}

- (void)setDuration:(NSInteger)duration {
	_setting.duration = duration;
}

- (void)setGravity:(kToastGravity)gravity 
        offsetLeft:(NSInteger)left
         offsetTop:(NSInteger)top {
	_setting.gravity = gravity;
	_offsetLeft = left;
	_offsetTop = top;
}

- (void)setGravity:(kToastGravity)gravity {
	_setting.gravity = gravity;
}

- (void)setPostion:(CGPoint)position {
	_setting.postition = CGPointMake(position.x, position.y);
}

#pragma -
#pragma private func

- (void)hideToast:(NSTimer*)theTimer {
	[UIView beginAnimations:nil context:NULL];
	_view.alpha = 0;
	[UIView commitAnimations];
	
	NSTimer *timer2 = [NSTimer timerWithTimeInterval:500 
											 target:self selector:@selector(hideToast:) 
										   userInfo:nil repeats:NO];
	[[NSRunLoop mainRunLoop] addTimer:timer2 forMode:NSDefaultRunLoopMode];
}

- (void)removeToast:(NSTimer*)theTimer {
	[_view removeFromSuperview];
}

@end


@implementation ToastSetting

@synthesize duration = _duration;
@synthesize gravity = _gravity;
@synthesize postition = _postition;
@synthesize images = _images;

#pragma -
#pragma Object lifecycle

- (id)init {
    if (self = [super init]) {
        self.gravity = kToastGravityBottom;
        self.duration = kToastDurationNormal;
    }
    
    return self;
}

#pragma -
#pragma public func

- (void)setImage:(UIImage *)image forType:(ToastType)type {
	if (type == kiToastTypeNone) {
		// This should not be used, internal use only (to force no image)
		return;
	}
	
	if (!_images) {
		_images = [[NSMutableDictionary alloc] initWithCapacity:4];
	}
	
	if (image) {
		NSString *key = [NSString stringWithFormat:@"%i", type];
		[_images setValue:image forKey:key];
	}
}

@end
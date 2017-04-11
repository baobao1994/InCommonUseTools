//
//  iToast.h
//  iToast
//
//  Created by Diallo Mamadou Bobo on 2/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

typedef enum ToastGravity {
	kToastGravityTop = 1000001,
	kToastGravityBottom,
	kToastGravityCenter
}kToastGravity;

typedef enum ToastDuration {
	kToastDurationLong = 10000,
	kToastDurationShort = 1000,
	kToastDurationNormal = 3000
}ToastDuration;

typedef enum ToastType {
	kToastTypeInfo = -100000,
	kToastTypeNotice,
	kToastTypeWarning,
	kToastTypeError,
	kiToastTypeNone // For internal use only (to force no image)
}ToastType;


@class ToastSetting;

@interface Toast : NSObject {
	ToastSetting *_setting;
	NSInteger _offsetLeft;
	NSInteger _offsetTop;
	NSTimer *_timer;
	UIView *_view;
	NSString *_text;
}

+ (Toast *)makeText:(NSString *)text;

- (void)show;
- (void)show:(ToastType)type;
- (void)setDuration:(NSInteger)duration;
- (void)setGravity:(kToastGravity)gravity 
            offsetLeft:(NSInteger)left
            offsetTop:(NSInteger)top;
- (void)setGravity:(kToastGravity)gravity;
- (void)setPostion:(CGPoint)position;

@end


@interface ToastSetting : NSObject{
	NSInteger _duration;
	kToastGravity _gravity;
	CGPoint _postition;
	ToastType _toastType;
	NSDictionary *_images;
	BOOL _positionIsSet;
}

@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, assign) kToastGravity gravity;
@property (nonatomic, assign) CGPoint postition;
@property (nonatomic, readonly) NSDictionary *images;

- (void)setImage:(UIImage *)image forType:(ToastType)type;
						  
@end

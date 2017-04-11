//
//  FloatButton.m
//  TigerLottery
//
//  Created by Legolas on 16/11/29.
//  Copyright © 2016年 adcocoa. All rights reserved.
//

#import "FloatButton.h"
#import "UIView+Addtion.h"
#import "NSString+Addition.h"

#define kDJLogoWidth 54.0
#define kDJLogoAlphaChangeTimeInterval 5.0
#define kDJLogoLayoutLeft 0
#define kDJLogoLayoutRight 1

NSString * const kDJIsNotFirstLaunch = @"DJIsNotFirstLaunchKey";
NSString * const kDJFloatButtonPosition = @"kDJFloatButtonPositionKey";
NSString * const kDJLogoButtonOriginScale = @"kDJLogoButtonOriginScaleKey";
NSString * const kDJLogoButtonLayout = @"kDJLogoButtonLayoutKey";

@interface FloatButton ()

@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) CGPoint touchBeginOrigin;
@property (nonatomic, assign) CGPoint buttonOrigin;
@property (nonatomic, assign) BOOL isMoving;
@property (nonatomic, strong) UILabel *badgeLabel;

@end


@implementation FloatButton

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"file_icon"] forState:UIControlStateNormal];
        _badgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - 18, 3, 18, 14)];
        _badgeLabel.font = [UIFont systemFontOfSize:11];
        _badgeLabel.textColor = [UIColor whiteColor];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        [_badgeLabel setCornerRadius:7];
        _badgeLabel.backgroundColor = UIColorFromHexColor(0xE73F40);
        _badgeLabel.hidden = YES;
        [self addSubview:_badgeLabel];
        [self performSelector:@selector(changeAlpha) withObject:nil afterDelay:5.0];
        [self moveToEdge];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillChangeStatusBarOrientation:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    _delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - public func

+ (FloatButton *)sharedInstance {
    static FloatButton *kDJLogoButton = nil;
    if (nil == kDJLogoButton) {
        BOOL isNotFirstLaunch = [[NSUserDefaults standardUserDefaults] boolForKey:kDJIsNotFirstLaunch];
        
        if (isNotFirstLaunch) {
            kDJLogoButton = [[FloatButton alloc] initWithFrame:CGRectMake(0, 0, kDJLogoWidth, kDJLogoWidth)];
            UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
            CGFloat statusBarHeight;
            if (UIInterfaceOrientationIsPortrait (orientation)) {
                statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
            }else {
                statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.width;
            }
            
            [kDJLogoButton setLogoButtonFrame:orientation statusBarHeight:statusBarHeight];
            
        }else {
            CGSize screenSize = [UIScreen mainScreen].bounds.size;
            kDJLogoButton = [[FloatButton alloc] initWithFrame:CGRectMake(0, screenSize.height - kDJLogoWidth, kDJLogoWidth, kDJLogoWidth)];
        }
        [kDJLogoButton performSelector:@selector(changeAlpha) withObject:nil afterDelay:5.0];
    }
    return kDJLogoButton;
}

- (void)badgeValue:(NSString *)badgeValue {
    if ([badgeValue isEqualToString:@"0"]) {
        _badgeLabel.hidden = YES;
    }else {
        _badgeLabel.hidden = NO;
        _badgeLabel.text = badgeValue;
        CGFloat width = [badgeValue adaptSizeWithFont:_badgeLabel.font].width + 2;
        width = MAX(width, _badgeLabel.frame.size.height);
        _badgeLabel.frame = CGRectMake(self.frame.size.width - width, _badgeLabel.frame.origin.y, width, _badgeLabel.frame.size.height);
    }
}

- (void)addTarget:(nullable id)target action:(SEL)action {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:singleTap];
}

- (void)setFloatButtonOrigin:(CGPoint)origin {
    NSDictionary *originDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kDJFloatButtonPosition];
    BOOL isFirstLaunch = (originDic == nil);
    if (isFirstLaunch) {
        self.frame = CGRectMake(origin.x, origin.y, kDJLogoWidth, kDJLogoWidth);
    }
    CGPoint checkOrigin = [self adjustOrigin:self.frame.origin];
    self.frame = CGRectMake(checkOrigin.x, checkOrigin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setFloatButtonEnable:(BOOL)enable {
    [self setFloatButtonHidden:!enable];
}

- (void)setFloatButtonHidden:(BOOL)hidden {
//    self.hidden = hidden;
}

- (void)setFloatButtonDelegate:(id)delegate {
    _delegate = delegate;
}

#pragma mark - Private Method

- (void)appWillChangeStatusBarOrientation:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    UIInterfaceOrientation orientation = [[userInfo objectForKey:UIApplicationStatusBarOrientationUserInfoKey] intValue];
    CGFloat statusBarHeight;
    if (UIInterfaceOrientationIsPortrait (orientation)) {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.width;
    }else {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    
    [self setLogoButtonFrame:orientation statusBarHeight:statusBarHeight];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    _touchBeginOrigin = [touch locationInView:self];
    _buttonOrigin = [touch locationInView:self.superview];
    self.alpha = 1.0;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(changeAlpha) object:nil];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    _isMoving = NO;
    [self moveToEdge];
    [self saveFrameProportion:self.frame.origin];
    [self performSelector:@selector(changeAlpha) withObject:nil afterDelay:kDJLogoAlphaChangeTimeInterval];
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.superview];
    self.highlighted = NO;
    CGRect frame = self.frame;
    switch ([UIApplication sharedApplication].statusBarOrientation) {
        case UIInterfaceOrientationPortrait:
        {
            frame.origin = CGPointMake(point.x - _touchBeginOrigin.x, point.y - _touchBeginOrigin.y);
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            frame.origin = CGPointMake(point.x - frame.size.width + _touchBeginOrigin.x, point.y - frame.size.width + _touchBeginOrigin.y);
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        {
            frame.origin = CGPointMake(point.x - _touchBeginOrigin.y, point.y - frame.size.width + _touchBeginOrigin.x);
        }
            break;
        case UIInterfaceOrientationLandscapeRight:
        {
            frame.origin = CGPointMake(point.x - frame.size.height + _touchBeginOrigin.y, point.y - _touchBeginOrigin.x);
        }
            break;
        default:
            break;
    }
    
    frame.origin = [self adjustOrigin:frame.origin];
    if ((fabs(_buttonOrigin.x - point.x) > 5) || (fabs(_buttonOrigin.y - point.y) > 5)) {
        _isMoving = YES;
    }
    self.frame = frame;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (!_isMoving) {
        [self performSelector:@selector(changeAlpha) withObject:nil afterDelay:kDJLogoAlphaChangeTimeInterval];
    }
    return !_isMoving;
}

- (CGPoint)adjustOrigin:(CGPoint)origin {
    CGPoint adjustOrigin;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGSize appSize = [UIScreen mainScreen].applicationFrame.size;
    CGSize superViewSize = self.superview.bounds.size;
    CGRect frame = self.frame;
    switch ([UIApplication sharedApplication].statusBarOrientation) {
        case UIInterfaceOrientationPortrait:
        {
            adjustOrigin.x = MAX(0, origin.x);
            adjustOrigin.x = MIN(screenSize.width - frame.size.width, adjustOrigin.x);
            adjustOrigin.y = MAX(0, origin.y);
            adjustOrigin.y = MIN(superViewSize.height - frame.size.width, adjustOrigin.y);
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            adjustOrigin.x = MAX(0, origin.x);
            adjustOrigin.x = MIN(screenSize.width - frame.size.width, adjustOrigin.x);
            adjustOrigin.y = MAX(0, origin.y);
            adjustOrigin.y = MIN(appSize.height - frame.size.width, adjustOrigin.y);
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        {
            adjustOrigin.x = MAX(screenSize.width - appSize.width, origin.x);
            adjustOrigin.x = MIN(screenSize.width - frame.size.height, adjustOrigin.x);
            adjustOrigin.y = MAX(0, origin.y);
            adjustOrigin.y = MIN(screenSize.height - frame.size.width, adjustOrigin.y);
        }
            break;
        case UIInterfaceOrientationLandscapeRight:
        {
            adjustOrigin.x = MAX(0, origin.x);
            adjustOrigin.x = MIN(appSize.width - frame.size.height, adjustOrigin.x);
            adjustOrigin.y = MAX(0, origin.y);
            adjustOrigin.y = MIN(screenSize.height - frame.size.width, adjustOrigin.y);
        }
            break;
        default:
            break;
    }
    return adjustOrigin;
}

- (void)moveToEdge {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGRect frame = self.frame;
    switch (orientation) {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            frame.origin.y = frame.origin.y < screenSize.height / 2 ? 0 : screenSize.height - frame.size.height;
            break;
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            frame.origin.x = frame.origin.x < screenSize.width / 2 ? 0 : screenSize.width - frame.size.width;
            break;
        default:
            break;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = frame;
    }];
}

- (void)saveFrameProportion:(CGPoint)origin {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    float scale;
    int layout;
    switch (orientation) {
        case UIInterfaceOrientationLandscapeLeft:
            scale = origin.x / screenSize.width;
            layout = origin.y > (screenSize.height / 2) ? kDJLogoLayoutLeft : kDJLogoLayoutRight;
            break;
        case UIInterfaceOrientationLandscapeRight:
            scale = (screenSize.width - origin.x) / screenSize.width;
            layout = origin.y < (screenSize.height / 2) ? kDJLogoLayoutLeft : kDJLogoLayoutRight;
            break;
        case UIInterfaceOrientationPortrait:
            scale = origin.y / screenSize.height;
            layout = origin.x < (screenSize.width / 2) ? kDJLogoLayoutLeft : kDJLogoLayoutRight;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            scale = (screenSize.height - origin.y) / screenSize.height;
            layout = origin.x > (screenSize.width / 2) ? kDJLogoLayoutLeft : kDJLogoLayoutRight;
            break;
        default:
            break;
    }
    NSDictionary *positionInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:scale], kDJLogoButtonOriginScale, [NSNumber numberWithInt:layout], kDJLogoButtonLayout, nil];
    [[NSUserDefaults standardUserDefaults]setObject:positionInfo forKey:kDJFloatButtonPosition];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setLogoButtonFrame:(UIInterfaceOrientation)orientation statusBarHeight:(CGFloat)statusBarHeight {
    NSDictionary *positionInfo = [[NSUserDefaults standardUserDefaults] objectForKey:kDJFloatButtonPosition];
    float scale = [[positionInfo valueForKey:kDJLogoButtonOriginScale] floatValue];
    NSInteger layout = [[positionInfo valueForKey:kDJLogoButtonLayout] integerValue];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    CGRect frame = self.frame;
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
        {
            CGAffineTransform transform = CGAffineTransformMakeRotation(2 * M_PI);
            [self setTransform:transform];
            
            float y = scale * screenSize.height;
            frame.origin.y = MAX(y, statusBarHeight);
            frame.origin.y = MIN(frame.origin.y, screenSize.height - frame.size.height);
            frame.origin.x = (layout == kDJLogoLayoutLeft) ? 0 : screenSize.width - frame.size.width;
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            CGAffineTransform transform = CGAffineTransformMakeRotation(-M_PI);
            [self setTransform:transform];
            
            float y = screenSize.height - scale * screenSize.height - self.frame.size.height;
            frame.origin.y = MAX(y, 0);
            frame.origin.y = MIN(frame.origin.y, screenSize.height - statusBarHeight - frame.size.height);
            
            frame.origin.x = (layout == kDJLogoLayoutLeft) ? screenSize.width - frame.size.width : 0;
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        {
            CGAffineTransform transform = CGAffineTransformMakeRotation(-M_PI_2);
            [self setTransform:transform];
            
            float x = scale * screenSize.width;
            frame.origin.x = MIN(x, screenSize.width - self.frame.size.height);
            frame.origin.x = MAX(frame.origin.x, statusBarHeight);
            frame.origin.y = (layout == kDJLogoLayoutLeft) ? screenSize.height - frame.size.height : 0;
        }
            break;
        case UIInterfaceOrientationLandscapeRight:
        {
            CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2);
            [self setTransform:transform];
            float x = screenSize.width - screenSize.width * scale - self.frame.size.height;
            frame.origin.x = MAX(0, x);
            frame.origin.x = MIN(frame.origin.x, screenSize.width - statusBarHeight - self.frame.size.height);
            frame.origin.y = (layout == kDJLogoLayoutLeft) ? 0 : screenSize.height - frame.size.height;
        }
            break;
        default:
            break;
    }
    self.frame = frame;
}

- (void)changeAlpha {
    self.alpha = 0.5;
}

@end

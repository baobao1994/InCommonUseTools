//
//  BroadcastView.m
//  MFun
//
//  Created by Legolas on 4/25/12.
//  Copyright (c) 2012 bodong NetDragon. All rights reserved.
//

#import "BroadcastView.h"
#import "AutoScrollLabel.h"
#import "WinMessage.h"

#define SCRLL_LABEL_TIMER_INTERVAL 7.0f
#define SCRLL_LABEL_ANIMATION_DURATION 1.25f
#define kPadding 33

@interface BroadcastView() {
    NSInteger _indexOfCurrentLabel;
    AutoScrollLabel *_currentLabel;
    AutoScrollLabel *_nextLabel;
}

@property (nonatomic, retain) AutoScrollLabel *currentLabel;
@property (nonatomic, retain) AutoScrollLabel *nextLabel;
@property (nonatomic, assign) NSTimer *timer;

- (AutoScrollLabel *)buildScrollLabel:(CGRect)frame;
- (void)changeScrollLabel;

@end


@implementation BroadcastView

@synthesize delegate = _delegate;
@synthesize info = _info;
@synthesize isRevolving = _isRevolving;
@synthesize currentLabel = _currentLabel;
@synthesize nextLabel = _nextLabel;
@synthesize timer = _timer;

#pragma mark - View life style

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _indexOfCurrentLabel = 0;
        self.clipsToBounds = YES;
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kPadding, frame.size.height)];
        [iconImageView setImage:[UIImage imageNamed:@"message_icon"]];
        iconImageView.contentMode = UIViewContentModeCenter;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:iconImageView];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelctedMessage)];
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

- (void)dealloc {
    _delegate = nil;
    INVALIDATE_TIMER(_timer);
}

#pragma mark - Public func

- (void)startPlay {
    if (!self.isRevolving && _info.count > 0) {
        _isRevolving = YES;
        if (_indexOfCurrentLabel >= [self.info count]) {
            _indexOfCurrentLabel = 0;
        }
        else {
            if (nil == self.currentLabel) {
                self.currentLabel = [self buildScrollLabel:CGRectMake(kPadding, 0, self.frame.size.width, self.frame.size.height)];
                self.currentLabel.scrollLabelDelegate = self;
                [self addSubview:self.currentLabel];
            }
            self.currentLabel.autoScrollCount = ([self.info count] > 1) ? 1 : 0;
            WinMessage *message = [self.info objectAtIndex:_indexOfCurrentLabel];
            self.currentLabel.text = message.content;
            [self.currentLabel start];
        }
    }
}

- (void)stopPlay {
    if (nil != _timer) {
        INVALIDATE_TIMER(_timer);
    }
    [self.currentLabel stop];
    [self.nextLabel stop];
    _isRevolving = NO;
}

#pragma mark - AutoScrollLabelDelegate

- (void)labelNotNeedScroll {
    if ([self.info count] > 0) {
        if (nil == self.timer) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:SCRLL_LABEL_TIMER_INTERVAL target:self selector:@selector(changeScrollLabel) userInfo:nil repeats:NO];
        }
    }
}

- (void)labelScrollDidFinish {
    if ([self.info count] > 0) {
        [self changeScrollLabel];
    }
}

#pragma mark - Private Method

- (AutoScrollLabel *)buildScrollLabel:(CGRect)frame {
    AutoScrollLabel *scrollLabel = [[AutoScrollLabel alloc] initWithFrame:frame];
    [scrollLabel setLabelTextColor:UIColorFromHexColor(0xa2a2a2)];
    [scrollLabel setFont:[UIFont systemFontOfSize:13.0f]];
    return scrollLabel;
}

- (void)changeScrollLabelAnimationDidStop {
    AutoScrollLabel *tempView = self.currentLabel;
    [self.currentLabel stop];
    self.currentLabel = self.nextLabel;
    [self.currentLabel start];
    self.nextLabel = tempView;
}

- (void)changeScrollLabel {
    int numberInAdvance = [self.info count] >= 10 ? 5 : 1;
    if (_indexOfCurrentLabel == [self.info count] - numberInAdvance) {
        DELEGATE_CALLBACK(self.delegate, @selector(allInfoRevolvingWillFinish));
    }
    _indexOfCurrentLabel += 1;
    if (_indexOfCurrentLabel >= [self.info count]) {
        _indexOfCurrentLabel = 0;
    }

    if (nil == self.nextLabel) {
        self.nextLabel = [self buildScrollLabel:CGRectMake(kPadding, 0, self.frame.size.width, self.frame.size.height)];
        self.nextLabel.scrollLabelDelegate = self;
        [self addSubview:self.nextLabel];
    }
    self.nextLabel.autoScrollCount = ([self.info count] > 1) ? 1 : 0;
    self.nextLabel.frame = CGRectMake(kPadding, self.frame.size.height, self.frame.size.width, self.frame.size.height);
    if (_info.count > 0) {
        WinMessage *message = [self.info objectAtIndex:_indexOfCurrentLabel];
        self.nextLabel.text = message.content;
        [UIView beginAnimations:@"Label Scroll" context:nil];
        [UIView setAnimationDuration:SCRLL_LABEL_ANIMATION_DURATION];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(changeScrollLabelAnimationDidStop)];
        self.currentLabel.frame = CGRectMake(kPadding, -self.currentLabel.frame.size.height, self.currentLabel.frame.size.width, self.currentLabel.frame.size.height);
        self.nextLabel.frame = CGRectMake(kPadding, 0, self.frame.size.width, self.frame.size.height);
        [UIView commitAnimations];
    }

    if (nil != _timer) {
        INVALIDATE_TIMER(_timer);
    }
}

- (void)didSelctedMessage {
    if (self.info.count > _indexOfCurrentLabel) {
       DELEGATE_CALLBACK_ONE_PARAMETER(_delegate, @selector(didSelectedWinMessage:), [self.info objectAtIndex:_indexOfCurrentLabel]);
    }
}

@end

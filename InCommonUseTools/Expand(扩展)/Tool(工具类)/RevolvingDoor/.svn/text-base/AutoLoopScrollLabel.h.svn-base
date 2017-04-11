//
//  AutoScrollLabel.h
//  DianJinOfferPlatform
//
//  Created by Legolas on 12-2-10.
//  Copyright 2012 NetDragon WebSoft Inc.. All rights reserved.
//

#define LOOP_SCROLL_NUM_LABELS 2

typedef enum _AutoLoopScrollDirection {
	kAutoRollingRight,
	kAutoRollingLeft
}AutoLoopScrollDirection;

@interface AutoLoopScrollLabel : UIScrollView <UIScrollViewDelegate>{
	UILabel *_label[LOOP_SCROLL_NUM_LABELS];
	AutoLoopScrollDirection _scrollDirection;
	float _scrollSpeed;
	NSTimeInterval _pauseInterval;
	int _bufferSpaceBetweenLabels;
	bool _isScrolling;
}

@property(nonatomic, assign) NSTimeInterval pauseInterval;
@property(nonatomic, assign) int bufferSpaceBetweenLabels;
// normal UILabel properties
@property(nonatomic, retain) NSString *text;
@property(nonatomic, retain) UIColor *textColor;
@property(nonatomic, retain) UIFont *font;
@property(nonatomic, assign) AutoLoopScrollDirection scrollDirection;
@property(nonatomic, assign) float scrollSpeed;

- (void)setLabelFrame:(CGRect)frame;
- (void)scroll;
- (void)setLabelTextColor:(UIColor *)color;

@end

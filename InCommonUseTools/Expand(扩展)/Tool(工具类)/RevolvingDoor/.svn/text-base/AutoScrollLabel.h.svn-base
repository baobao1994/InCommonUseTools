//
//  AutoScrollLabel.h
//  MFun
//
//  Created by Legolas on 4/25/12.
//  Copyright (c) 2012 bodong NetDragon. All rights reserved.
//

typedef enum AutoScrollDirection {
	kAutomaticRollingRight,
	kAutomaticRollingLeft
}AutoScrollDirection;

@interface AutoScrollLabel : UIScrollView <UIScrollViewDelegate> {
    int _autoScrollCount;
    int _finishedScrollCount;
    UILabel *_label;
	AutoScrollDirection _scrollDirection;
	float _scrollSpeed;
	bool _isScrolling;
}

@property (nonatomic, assign) id scrollLabelDelegate;
@property (nonatomic, assign) int autoScrollCount;
// normal UILabel properties
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic, assign) AutoScrollDirection scrollDirection;
@property (nonatomic, assign) float scrollSpeed;

- (void)start;
- (void)stop;
- (void)setLabelFrame:(CGRect)frame;
- (void)setLabelTextColor:(UIColor *)color;

@end


@protocol AutoScrollLabelDelegate <NSObject>

@optional
- (void)labelNotNeedScroll;
- (void)labelScrollDidFinish;

@end

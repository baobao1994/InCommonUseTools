//
//  CustomeSheetView.m
//  TigerLottery
//
//  Created by Legolas on 15/3/2.
//  Copyright (c) 2015年 adcocoa. All rights reserved.
//

#import "CustomeSheetView.h"

@interface CustomeSheetView ()

@property (nonatomic, retain) UIWindow *keyWindow;
@property (nonatomic, retain) UIView *toolView;
@property (nonatomic, retain) UIButton *cancelBtn;
@property (nonatomic, retain) UIButton *confimBtn;

@end

@implementation CustomeSheetView

- (id)init {
    if (self = [super init]) {
        [self createBackgroundView];
    }
    return self;
}

- (id)initWithDefaultToolBar {
    if (self = [super init]) {
        [self createBackgroundView];
        [self createToolBar];
    }
    return self;
}

- (void)setContentView:(UIView *)contentView {
    _contentView = contentView;
//    _contentView.backgroundColor = [UIColor whiteColor];
    [_keyWindow addSubview:contentView];
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _contentView.frame = CGRectMake(0, _keyWindow.frame.size.height + _toolView.frame.size.height, _keyWindow.frame.size.width, _contentView.frame.size.height);
    _toolView.frame = CGRectMake(0, _keyWindow.frame.size.height, _toolView.frame.size.width, _toolView.frame.size.height);
}

#pragma mark - Public Method

- (void)show {
    if (_keyWindow.hidden) {
        [_keyWindow makeKeyAndVisible];
        _keyWindow.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^(void){
            _toolView.frame = CGRectMake(0, _keyWindow.frame.size.height - _contentView.frame.size.height - _toolView.frame.size.height, _toolView.frame.size.width, _toolView.frame.size.height);
            _contentView.frame = CGRectMake(0, _keyWindow.frame.size.height - _contentView.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [_delegate actionSheet:self clickedButtonAtIndex:_cancelButtonIndex];
    }
}

- (void)hide {
    if (!_keyWindow.hidden) {
        [UIView animateWithDuration:0.3 animations:^(void){
            _toolView.frame = CGRectMake(0, _keyWindow.frame.size.height, _toolView.frame.size.width, _toolView.frame.size.height);
            _contentView.frame = CGRectMake(0, _keyWindow.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
        } completion:^(BOOL finished) {
            _keyWindow.hidden = YES;
        }];
    }
}

- (void)confirmItem {
    if (_delegate && [_delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [_delegate actionSheet:self clickedButtonAtIndex:1];
    }
    [self hide];
}

#pragma mark - CAAnimation delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    _keyWindow.hidden = YES;
    void(^completion)(void) = [anim valueForKey:@"handler"];
    if (completion) {
        completion();
    }
}

#pragma mark - PrivateMethod

- (void)createBackgroundView {
    _cancelButtonIndex = -1;
    _keyWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _keyWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _keyWindow.windowLevel = UIWindowLevelAlert;
    UIControl *bgView = [[UIControl alloc] initWithFrame:_keyWindow.frame];
    bgView.backgroundColor = [UIColor blackColor];
    [_keyWindow addSubview:bgView];
    [bgView addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    bgView.alpha = 0.5;
}

- (void)createToolBar {
    _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _keyWindow.frame.size.width, 40)];
    _toolView.backgroundColor = kRedColor;
    [_keyWindow addSubview:_toolView];
    
    _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_cancelBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:_cancelBtn];
    
    _confimBtn = [[UIButton alloc] initWithFrame:CGRectMake(_toolView.frame.size.width - 60, 0, 60, 40)];
    [_confimBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confimBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_confimBtn addTarget:self action:@selector(confirmItem) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:_confimBtn];
}

@end

//
//  RadioButton.m
//  GameStrategy
//
//  Created by Legolas on 14/9/18.
//  Copyright (c) 2014年 adcocoa. All rights reserved.
//

#import "RadioButton.h"

#define kRadioButtonTag 1000

@interface RadioButton ()

@property (nonatomic, assign) NSInteger buttonCount;

@end


@implementation RadioButton

- (id)initWithFrame:(CGRect)frame buttonCount:(NSInteger)buttonCount {
    self = [super initWithFrame:frame];
    if (self) {
        _buttonCount = buttonCount;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

- (void)setButtonBlock:(UIButton *(^)(NSInteger index))block {
    for (int i = 0; i < _buttonCount; i++) {
        UIButton *btn = block(i);
        btn.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        btn.tag = kRadioButtonTag + i;
        [btn addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

- (void)selectButtonAtIndex:(NSInteger)index {
    for (int i = 0; i < _buttonCount; i++) {
        NSInteger btnTag = kRadioButtonTag + i;
        UIButton *btn = (UIButton *)[self viewWithTag:btnTag];
        btn.userInteractionEnabled = (index != i);
        btn.selected = (index == i);
    }
    if (_didSelectButtonBlock != nil) {
        _didSelectButtonBlock(index);
    }
}

- (void)selectButton:(UIButton *)btn {
    [self selectButtonAtIndex:btn.tag - kRadioButtonTag];
}

- (void)resetRadioButtonTitles:(NSArray *)titles {
    for (int i = 0; i < _buttonCount; i++) {
        NSInteger btnTag = kRadioButtonTag + i;
        UIButton *btn = (UIButton *)[self viewWithTag:btnTag];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
    }
}

- (UIButton *)buttonAtIndex:(NSInteger)index {
    NSInteger btnTag = kRadioButtonTag + index;
    UIButton *btn = (UIButton *)[self viewWithTag:btnTag];
    return btn;
}

@end

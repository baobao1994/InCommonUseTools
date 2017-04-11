//
//  RadioButton.h
//  GameStrategy
//
//  Created by Legolas on 14/9/18.
//  Copyright (c) 2014年 adcocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadioButton : UIView

@property (nonatomic, copy) void (^didSelectButtonBlock)(NSInteger index);

- (id)initWithFrame:(CGRect)frame buttonCount:(NSInteger)buttonCount;
- (void)setButtonBlock:(UIButton *(^)(NSInteger index))block;
- (void)selectButtonAtIndex:(NSInteger)index;
- (void)resetRadioButtonTitles:(NSArray *)titles;
- (UIButton *)buttonAtIndex:(NSInteger)index;

@end

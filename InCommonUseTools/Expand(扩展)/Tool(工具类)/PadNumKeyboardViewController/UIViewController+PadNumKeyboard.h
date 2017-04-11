//
//  UIViewController+PadNumKeyboard.h
//  TigerLottery
//
//  Created by Legolas on 16/1/5.
//  Copyright © 2016年 adcocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController(PadNumKeyboard)

@property (nonatomic, strong) UIButton *doneInKeyboardButton;

- (void)addKeyboardObserver;
- (void)removeKeyboardObserver;
- (void)editingDidBegin;
- (void)resizeWithKeyboardHeight:(float)height;

@end
